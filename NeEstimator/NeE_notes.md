populations sampled at more than one time period? How can I do this if I have to mark which generation they're in (idk)

z chromosomes?



Let's run populations alone to obtain a vcf and explore data quality:

413_noUK_popmap.txt is my list of all 413 used populations, corrected names, no unknowns, all listed as "pop"
```
#in source files
module load Stacks
populations -P newoutput_refmap/ -M 413_noUK_popmap.txt --vcf -O neestimator/output/

