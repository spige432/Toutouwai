# SNPcalling.md

The raw data is available on the High Capacity Storage of Otago University. Contact dutoit.ludovic@gmail.com for access.

We are looking at two lanes with the same individuals across both lanes I believe.

## Quality control

The data is signle-end. *Let's subsample it to see how it looks.*

there are  different lanes with one single  barcode file:



```bash
#!/bin/sh
# in source_files
zcat  SQ0890_CD21AANXX_s_4_fastq.txt.gz | head -n 1000000 > lane4.fq # one lane
zcat SQ0890_CDMWVANXX_s_1_fastq.txt.gz | head -n 1000000 > lane1.fq # another lane
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
cutadapt  -a AGATCGGAAGAGC  -m 30    -o SQ0890_CD21AANXX_s_4_cleaned.fastq SQ0890_CD21AANXX_s_4_fastq.txt.gz
cutadapt  -a AGATCGGAAGAGC    -m 30  -o SQ0890_CDMWVANXX_s_1_cleaned.fastq SQ0890_CDMWVANXX_s_1_fastq.txt.gz
````

 I run fastqc again on those trimmed files to confirm that no adapter is left.


```
fastqc SQ0890_CD21AANXX_s_4_cleaned.fastq
fastqc SQ0890_CDMWVANXX_s_1_cleaned.fastq
```

## SNP calling

### Demultiplexing

barcodes are different for both lanes. They should look as specified a bit under [this section  in the manual](https://catchenlab.life.illinois.edu/stacks/manual/index.php#clean), in section 4.1.2

 
I then create two folders to do the demultiplexing of the two lanes, and copy the files for each lane. The two files for a single lane can be demultiplexed together. 

```
#!/bin/sh
mkdir rawSQ0890 samplesSQ0890 
cd rawSQ0890
ln -s ../source_files/SQ0890_CD*cleaned* .
cd ..
```

```
#!/bin/sh
mkdir rawSQ0323 samplesSQ0323 
cd rawSQ0323
ln -s ../source_files/SQ0323_CD*cleaned* .
cd ..
```

I am now ready to run process_radtags to demultiplex, once for each lane.

```
#!/bin/sh
module load Stacks
process_radtags   -p rawSQ0890/ -o samplesSQ0890/ -b barcodes_SQ0890.txt -e pstI -r -c -q --inline-null
```

```
#!/bin/sh
process_radtags   -p rawSQ0323/ -o sampleSQ0323/ -b barcodes_SQ0890.txt -e pstI -r -c -q --inline-null
```

We now have one file per sample per lane. Some samples are on both lanes, they need to combined together, by simply adding all the reads from both lanes. 

```
mkdir samples_concat
# for each file in the first lane, put all the reads in a file in samples_concat
for file in samplesSQ0890/*
do
filenodir=$(basename $file)
zcat samplesSQ0890/$filenodir > samples_concat/$filenodir
done
```


For second lane, but the `>>` means it will append reads if a file with the same name already exist, or create a new one if the file does not exist
```
for file in samplesSQ0890/*
do
filenodir=$(basename $file)
zcat samplesSQ0890/$filenodir >> samples_concat/$filenodir
done
```



### Alignment and variant calling

First alignment for every sample using BWA. 

The complete list of commands is in [align.sh](align.sh).

Then, SNP calling can be done with Stacks using a popmap file ([example](example))


```
#!/bin/sh
#not from alignment folder
module load Stacks
mkdir output_refmap
ref_map.pl --samples alignment --popmap popmap.txt -T 8  -o output_refmap
```


Let's run populations alone to obtain a vcf and explore data quality:

populations -P output_refmap/ -M popmap.txt  --vcf 

Obtained >100k SNPs. Let's explore sample quality.

### Filtering

I will re-run populations keeping only good SNPs found in more than 80% of individuals.

```
populations -P output_refmap/ -M popmap.txt  --vcf  -r 0.8
```

We still have 64528 SNPs for the 190 samples. We could filter more but that seems adequate for this project.


Let's see if some individuals are really poor or not.


```
cd output_refmap
module load VCFtools
vcftools --vcf populations.snps.vcf --missing-indv ## google vcftools
sort -k 4n out.imiss | less # it will show you all the individuals sorted by missing data
```

I remove .... because they have more than X.... missing data 

I remove it and create a [popmap_clean.txt](popmap_clean.txt) and re-filter the data.

```
populations -P output_refmap/ -M popmap_clean.txt  --vcf  -r 0.8
```

Now you have your SNPs


We found xxx SNPs for xxx samples.

