# SNPcalling.md

The raw data is available on the High Capacity Storage of Otago University. Contact dutoit.ludovic@gmail.com for access.

We are looking at two lanes with the same individuals across both lanes I believe.

## Quality control

The data is signle-end. *Let's subsample it to see how it looks.*

there are  different lanes with one single  barcode file:



```bash
#!/bin/sh
# in source_files
zcat SQ2427_H33J5DRX5_s_1_fastq.txt.gz | head -n 1000000 > lane427_1.fq # one lane
zcat SQ2427_H33J5DRX5_s_2_fastq.txt.gz | head -n 1000000 > lane427_2.fq # another lane
zcat SQ2428_H33J5DRX5_s_1_fastq.txt.gz | head -n 1000000 > lane428_1.fq
zcat SQ2428_H33J5DRX5_s_2_fastq.txt.gz | head -n 1000000 > lane428_2.fq
```

Now let's run fastQC quality control on those files.

```
module load FastQC
fastqc *fq

```
There is lots of adapter contamination; we'll remove it, but we won't trim reads to a common length since we are working with a reference-based approach.

We are using cutadapt.  -a is the adapter -m is sequence minimum length, we'll discard anything shorter than 30bp
```
module load cutadapt
cutadapt  -a AGATCGGAAGAGC  -m 30    -o lane427_1_cleaned.fq lane427_1.fq
````
it wasn't necessary to run this on all four of them becuase they actually all use the same adapter
**CCGAGATCGGAAGAGC**

 I run fastqc again on those trimmed files to confirm that no adapter is left.


```
##I think the first line here for the correct document:
fastqc lane427_1_cleaned.fq
```
then I did the cleaning process with cutadapt for the entire document (took 29 minutes 3 only took like 8 mins but i was sitting somewhere else?)
```
cutadapt  -a CCGAGATCGGAAGAGC  -m 30    -o entire_lane427_1_cleaned.fq  SQ2427_H33J5DRX5_s_1_fastq.txt.gz
cutadapt  -a CCGAGATCGGAAGAGC  -m 30    -o entire_lane427_2_cleaned.fq  SQ2427_H33J5DRX5_s_2_fastq.txt.gz
cutadapt  -a CCGAGATCGGAAGAGC  -m 30    -o entire_lane428_1_cleaned.fq  SQ2428_H33J5DRX5_s_1_fastq.txt.gz
cutadapt  -a CCGAGATCGGAAGAGC  -m 30    -o entire_lane428_2_cleaned.fq  SQ2428_H33J5DRX5_s_2_fastq.txt.gz
```


## SNP calling

### Demultiplexing

barcodes are different for both lanes. They should look as specified a bit under [this section  in the manual](https://catchenlab.life.illinois.edu/stacks/manual/index.php#clean), in section 4.1.2

 
I then create two folders to do the demultiplexing of the two lanes, and copy the files for each lane. The two files for a single lane can be demultiplexed together. 

mkdir creating the two folders 1) where we'll put the raw data, what's cleaned from the adapter just now 2) sample file output, one file per sample
cd: going into the file 
ln -s copying over data that is cleaned from the adapters, making a link
goal is have the two files from the lane cleaned in that raw folder 
```
**Redo line for correct source file name here**

#!/bin/sh
mkdir raw427 samples427
cd raw427
ln -s ../source_files/SQ0890_CD*cleaned* .
cd ..
```

and add barcode file into the main source_files folder

I am now ready to run process_radtags to demultiplex, once for each lane.         

```
**The following  notes are almost the same but one has NIRObarcodes and one is just barcodes. Investigate which was actually used/how the two are different**

#!/bin/sh
module load Stacks
process_radtags   -p raw427/ -o samples427/ -b NIRObarcodes427.txt -e pstI -r -c -q --inline-null
process_radtags   -p raw428/ -o samples428/ -b NIRObarcodes428.txt -e pstI -r -c -q --inline-null



process_radtags   -p raw427/ -o samples427/ -b barcodes427.txt -e pstI -r -c -q --inline-null
process_radtags   -p raw428/ -o samples428/ -b barcodes428.txt -e pstI -r -c -q --inline-null

```


We now have one file per sample per lane. Some samples are on both lanes, they need to combined together, by simply adding all the reads from both lanes. 

```
mkdir samples_concat
# for each file in the first lane, put all the reads in a file in samples_concat
for file in samples427/*
do
filenodir=$(basename $file)
zcat samples427/$filenodir > samples_concat/$filenodir
done

```


For second lane, but the `>>` means it will append reads if a file with the same name already exist, or create a new one if the file does not exist
```
for file in samples428/*
do
filenodir=$(basename $file)
zcat samples428/$filenodir >> samples_concat/$filenodir
done
```



### Alignment and variant calling

First alignment for every sample using BWA. 
```
module load BWA
src=../locmetsamples_concat
# bwa index GCA_025920805.1_Ptraversi_NRM_v1_genomic.fna
bwa_db=GCA_025920805.1_Ptraversi_NRM_v1_genomic.fna
for sample in $files
do echo $sample
    bwa mem -t 2 $bwa_db $src/${sample}.fq.gz  |   samtools view -b | samtools sort --threads 4 > ${sample}.bam
done
```

```
mkdir alignment #Create an alignment folder where the bam files go
cd alignment #from inside there run align.sh
COPY IN THE REFERENCE GENOME. then unzip it using gunzip

**I tried to compare it with both the black robin and the eastern yellow robin (EYR). Aligning with the black robin wasn't ideal becuase their genome doesn't have sex chromosomes specifically marked. The alignment with the EYR was interesting at first because they have the sex chromosomes specifically marked but the reason they're known is because the sex chromosomes are strange in that species**
**So when it comes to sexing how should I move forward with this? Which species should I use for my alignment for the rest of my project? I really value sexing them because it will 
be helpful to Kevin (as well as add a level of data to my dataset), but maybe it isn't absolutely required? I could always try to work strictly off of the field sexing that Kevin did if this falls through but I need the sex data.**
```


The complete list of commands is in [align.sh](align.sh).
**I need to post my specific align.sh document to my repository. This document has all of the sample names and a code to index them with a reference genome**

Then, SNP calling can be done with Stacks using a popmap file ([example](example))
popmap file is made from an excel document; all sample names in the first column, "pop" in the second column, then save as a txt 

```
#!/bin/sh
#not from alignment folder
module load Stacks
mkdir output_refmap
ref_map.pl --samples alignment --popmap popmap.txt -T 8  -o output_refmap
```
```
12March25 12:00 2 cores 6 or 8 GB
in sourcefiles
module load Stacks
mkdir newoutput_refmap
ref_map.pl --samples alignment --popmap 429popmap.txt -T 8  -o newoutput_refmap
I think it worked?
```


Let's run populations alone to obtain a vcf and explore data quality:

populations -P output_refmap/ -M popmap.txt  --vcf 
```
12march25 populations -P newoutput_refmap/ -M 429popmap.txt  --vcf

Removed 0 loci that did not pass sample/population constraints from 637698 loci.
Kept 637698 loci, composed of 54051543 sites; 0 of those sites were filtered, 759419 variant sites remained.
    46376676 genomic sites, of which 7027407 were covered by multiple loci (15.2%).
Mean genotyped sites per locus: 84.62bp (stderr 0.02).

Population summary statistics (more detail in populations.sumstats_summary.tsv):
  pop: 185.43 samples per locus; pi: 0.14946; all/variant/polymorphic sites: 53961185/759419/759419; private alleles: 0

populations -P newoutput_refmap/ -M 429popmap.txt  --vcf  -r 0.8

Removed 576294 loci that did not pass sample/population constraints from 637698 loci.
Kept 61404 loci, composed of 4928235 sites; 784935 of those sites were filtered, 196806 variant sites remained.
    4155965 genomic sites, of which 27439 were covered by multiple loci (0.7%).
Mean genotyped sites per locus: 68.13bp (stderr 0.08).
```

Obtained >100k SNPs. Let's explore sample quality.

### Filtering

I will re-run populations keeping only good SNPs found in more than 80% of individuals.

```
populations -P eyr_output_refmap/ -M 40popmap.txt  --vcf  -r 0.4
**I believe this was done at 0.4 based on an email from Ludo on 7October24**
```

"Removed 127319 loci that did not pass sample/population constraints from 160266 loci.
Kept 32947 loci, composed of 2512449 sites; 216237 of those sites were filtered, 32768 variant sites remained.
    2290254 genomic sites, of which 12331 were covered by multiple loci (0.5%).
Mean genotyped sites per locus: 69.89bp (stderr 0.10)."

Let's see if some individuals are really poor or not.


```
Ludo's code:
cd output_refmap
module load VCFtools
vcftools --vcf populations.snps.vcf --missing-indv ## google vcftools
sort -k 4n out.imiss | less # it will show you all the individuals sorted by missing data
higher number is worse. Of my 423 samples I have six that are above 0.6
HA13273, TA114678, KA16441, PU16217, MA13724, BP16299


my code that I think this is relevant to:
vcftools --vcf blackrobinoutput.vcf   --chr JAHLSL010000009.1  --out z2  --geno-depth --minDP 2 --max-missing 0.8

vcftools --vcf blackrobinoutput.vcf   --chr JAHLSL010000013.1  --out autosome  --geno-depth --minDP 2 --max-missing 0.8

Eyr 
vcftools --vcf eyr.snps.vcf  --chr QKXG01000089.1 --chr QKXG01000127.1 --chr QKXG01000146.1  --out z2  --geno-depth --minDP 2 --max-missing 0.8

vcftools --vcf blackrobinoutput.vcf   --chr JAHLSL010000013.1  --out autosome  --geno-depth --minDP 2 --max-missing 0.8

Remove four samples that have less than 65% coverage

```
? After filtering, kept 1687 out of a possible 215293 Sites
? 423 individuals

I remove .... because they have more than X.... missing data 

I remove it and create a [popmap_clean.txt](popmap_clean.txt) and re-filter the data with populations 



```
populations -P output_refmap/ -M popmap_clean.txt  --vcf  -r 0.8
Run this later and change popmap from all indiv to just the ones that will be kept (under 60%) indivi that has less than 60% of sites., the 0.8 is removing from sites not individuals
file will be in output refmap called populations.snp.vcp

result (it matches the error at the end of the populations.log file):
..
JAHLSL010000103.1 
Error: Bad consensus length.
Error: Locus 467917
Error: Bad GStacks files.
Aborted.

```


Now you have your SNPs


We found xxx SNPs for xxx samples.

depth of coverage. sire is a or T, a single indiv has reads matching there and as there are more reads the alleles will become more accurate. it ends up looking like those with lower coverage are less diverse 
individual coverage vs indiv coverage. out treshhold that makes it impossible to underestimate heterozygosity. 

--het
oHOM observed homozygotes
n is number of sites
F is inbreeding coefficient from HW comparing them
ohom/N is y axis on the indiv vs coef

explore mean depth and/or the 0.8 (a little) in order to find on r where the lowest value is that the correlation is not there 

in R
ihom - ohom  all divided by ehom proportion of heterozygotes

vcftools --vcf blackrobinoutput.vcf --minDP 5 --max-missing 0.8 --het

vcftools --vcf blackrobinoutput.vcf --minDP 5 --max-missing 0.8 --depth

explore minDP # in order to find smallest number wehre correlation isnt there

```
module load VCFtools
/nesi/nobackup/uoo04226/robins/source_files/output_refmap
vcftools --vcf blackrobinoutput.vcf --max-missing 0.8
#kept 125729 out of a possible 215293 Sites
vcftools --vcf blackrobinoutput.vcf --max-missing 0.4
#kept 215293 out of a possible 215293 Sites
vcftools --vcf blackrobinoutput.vcf --max-missing 0.5
#kept 192030 out of a possible 215293 Sites
vcftools --vcf blackrobinoutput.vcf --missing-indv
#kept 215293 out of a possible 215293 Sites
sort -k 4n out.imiss | less
#opens document in order of col 4
vcftools --vcf blackrobinoutput.vcf --minDP 100 --max-missing 0.8
#kept 11 out of a possible 215293 Sites (bad)
vcftools --vcf blackrobinoutput.vcf --minDP 2 --max-missing 0.8
#kept 99609 out of a possible 215293 Sites
vcftools --vcf blackrobinoutput.vcf --minDP 5 --max-missing 0.8
#kept 57393 out of a possible 215293 Sites
vcftools --vcf blackrobinoutput.vcf --minDP 5 --max-missing 0.8 --het
#kept 57393 out of a possible 215293 Sites
vcftools --vcf blackrobinoutput.vcf --minDP 5 --max-missing 0.8 --depth
#kept 57393 out of a possible 215293 Sites
