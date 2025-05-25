Let's run populations alone to obtain a vcf and explore data quality:
```
module load Stacks
populations -P output_refmap/ -M 413_noUK_popmap.txt --vcf
populations -P ../newoutput_refmap/ -M 413_noUK_popmap.txt --vcf -O /output

i need catalog.fa.gz
