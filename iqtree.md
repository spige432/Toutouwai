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


