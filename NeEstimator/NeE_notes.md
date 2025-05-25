populations sampled at more than one time period? How can I do this if I have to mark which generation they're in (idk)

z chromosomes?



Let's run populations alone to obtain a vcf and explore data quality:
```
module load Stacks
populations -P output_refmap/ -M 413_noUK_popmap.txt --vcf
populations -P ../newoutput_refmap/ -M 413_noUK_popmap.txt --vcf -O /output

i need catalog.fa.gz
