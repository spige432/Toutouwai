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

01April25

I need to **rename my sample names** to attribute 4 "UK" (unknown) samples to be from Hauturu, and edit one to be from KA (previously had no location becuase of a typo)

I created an excel and then .txt that had my old sample names in the first column and my new sample names in the second column. I used the list of 427 samples becuase that is the last one that was used on NeSI (ie samples need to be removed)

renamedsamples.txt - upload to newoutput_refmap
```
in newoutput_refmap:
module load BCFtools
bcftools reheader -s renamedsamples.txt populations.snps.vcf  -o renamed.snps.vcf #I haven't done this yet
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
iqtree2 -nt 16 -s recode.renamed.min4.phy -st DNA -m GTR+G -bb 1000  -pre inferred
```
"TOTAL      10.06%  128 sequences failed composition chi2 test (p-value<5%; df=3)"

Nesi crashed (default settings, 1 hour) it says 11073 MB RAM (10 GB) is required

below is copied from Ash to try to do a slurm job
```
#!/bin/bash -e
#SBATCH --job-name=iqtree 
#SBATCH --time=10:00:00      # Walltime (HH:MM:SS) 48h
#SBATCH --mem=64G            # Memory in MB
#SBATCH --account=uoo04226
#SBATCH --cpus-per-task=8

module purge

module load IQ-TREE	

iqtree2 -nt 16 -s recode.renamed.min4.phy -st DNA -m GTR+G -bb 1000  -pre inferred


echo "run complete"


```





