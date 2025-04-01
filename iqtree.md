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


01April25

I need to **rename my sample names** to attribute 4 "UK" (unknown) samples to be from Hauturu, and edit one to be from KA (previously had no location becuase of a typo)

I created an excel and then .txt that had my old sample names in the first column and my new sample names in the second column. I used the list of 427 samples becuase that is the last one that was used on NeSI (ie samples need to be removed)

renamedsamples.txt - upload to newoutput_refmap
```
in newoutput_refmap:
module load BCFtools
bcftools reheader -s renamedsamples.txt populations.snps.vcf  -o nenametest.vcf #practice attempt
bcftools reheader -s renamedsamples.txt populations.snps.vcf  -o renametest.vcf #I haven't done this yet
```

I need to **erase the remaining 4 UK samples** as they cannot be attributed to any location
