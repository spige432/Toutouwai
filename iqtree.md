## phylogenetics 

We did a phylogenetic analysis using IQTREE.

First , I convert the SNPs to a phylogenetic input format for IQtree: phylip, using [vcf2phylip](https://github.com/edgardomortiz/vcf2phylip)
https://github.com/edgardomortiz/vcf2phylip

```sh
./vcf2phylip.pl --input M3_final/populations.snps.vcf
```
 

Then I run IQtree using my own conda environment, the GTR+G model with 1000 bootstraps.

```sh
module load IQ-TREE

iqtree2 -nt 16 -s populations.snps.min4.phy -st DNA -m GTR+G -bb 1000  -pre inferred
```
download FIGtree to visualise it.

-------------------------------------------------------------------------------------

-- 01April25

I need to **rename my sample names** to attribute 4 "UK" (unknown) samples to be from Hauturu, and edit one to be from KA (previously had no location becuase of a typo)

I created an excel and then .txt that had my old sample names in the first column and my new sample names in the second column. I used the list of 427 samples becuase that is the last one that was used on NeSI (ie samples need to be removed)

renamedsamples.txt - upload to newoutput_refmap
```
in newoutput_refmap:
module load BCFtools
bcftools reheader -s renamedsamples.txt populations.snps.vcf  -o renamed.snps.vcf 
```

I need to **erase the remaining 4 UK samples** as they cannot be attributed to any location
```
module load VCFtools #perhaps run this somehwere else so the out.recode.vcf doesn't override the other old one.
vcftools --vcf renamed.snps.vcf --recode --remove-indv PU14637 --remove-indv KA16441 --remove-indv PU16217 --remove-indv TA114678 --remove-indv TM13681 --remove-indv HA13273 --remove-indv HA13278 --remove-indv PU14646 --remove-indv TM13676 --remove-indv PU14631  --remove-indv MA13724 --remove-indv BP16299 --remove-indv UK00-R19 --remove-indv UKB-BM --remove-indv UK13236 --remove-indv UK120700
Kept 413 samples
mv out.recode.vcf recode.renamed.vcf #renames the file
(out.log file was changed for original output from populations.snps.vcf. I ended up moving it to a folder called /subfolder and reran the code as written above so that it would recode it and keep a version that actually had the samples removed)
```

Convert the SNPs to a phylogenetic input format
```
Download files and upload "vcf2phylip.py" to my working directory
python vcf2phylip.py --input recode.renamed.vcf
```
download FigTree (https://github.com/rambaut/figtree/releases v1.4.4)

download java (Version 8 Update 441)

```
module load IQ-TREE
cd testing/robins/source_files/newoutput_refmap/subfolder/
iqtree2 -nt 16 -s recode.renamed.min4.phy -st DNA -m GTR+G -bb 1000  -pre inferred

```
"TOTAL      10.06%  128 sequences failed composition chi2 test (p-value<5%; df=3)"

Nesi crashed (default settings, 1 hour) it says 11073 MB RAM (10 GB) is required

I ran it with 4 cores, 64 GB, back to back sessions from Thursday-Monday

After 1000 interations ->

Log-likelihood cutoff on original alignment: -3775522.060

NOTE: Bootstrap correlation coefficient of split occurrence frequencies: 0.959

NOTE: UFBoot does not converge, continue at least 100 more iterations

Quit to add black robin refernce as a line to the VCF for the root of the tre
```
less recode.renamed.vcf  | grep  "^#" -v | cut -f 4 > blackrobinasonecolumn.txt # grab the column
tr '\n' ',' < blackrobinasonecolumn.txt > blackrobinasonerow.txt #make it a row with commas (weird middle step)
sed -s "s/,//g" blackrobinasonerow.txt | sed -s "s/^/blackrobin\t/g"   > onelineblackrobin.txt # remove the commas and add the sample name
cat onelineblackrobin.txt >> recode.renamed.min4.phy
```
Phylip doesn't run becuase the header must be updated before it will run again
```
sed -i -e "1d" recode.renamed.min4.phy  #removes first line
sed -i '1i 414 198474' recode.renamed.min4.phy #replaces first line, rewritten
iqtree2 -nt 16 -s scary.phy -st DNA -m GTR+G -bb 1000  -pre withBRref #changed name for output
```
I reran this but my file is called "scary.phy" because I was running it on a rest run and then I just let it go

-----
Trying to do a slurm job
```
cd testing/robins/source_files/newoutput_refmap/subfolder/
nano myjob.sl

#!/bin/bash -e
#SBATCH --job-name=iq-tree # job name (shows up in the queue)
#SBATCH --time=5-00:00:00       # Walltime (HH:MM:SS)
#SBATCH --mem=64G          # Memory 
#SBATCH --cpus-per-task=16
#SBATCH --account=uoo04226


cd testing/robins/source_files/newoutput_refmap/subfolder/
module load IQ-TREE
iqtree2 -nt 16 -s scary.phy -st DNA -m GTR+G -bb 1000  -pre withBRref


sbatch myjob.sl
"bash: sbatch: command not found"

```



