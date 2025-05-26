populations sampled at more than one time period? How can I do this if I have to mark which generation they're in (idk)

z chromosomes?



created VCF from my 413 populations (new, no filtering)

I believe I'm supposed to filter my VCF with the following two scripts, separately:

https://github.com/ldutoit/negotland/blob/master/clean_vcf_nogenesnoCNE.py ; https://github.com/ldutoit/negotland/blob/master/clean_vcf_everything.py

However I don't know how to use them. I don't have "bioinfo-tools" module, 

and I don't know what I would do instead of "import negotland_lib as ne" since that doesn't work

413_noUK_popmap.txt is my list of all 413 used populations, corrected names, no unknowns, all listed as "pop"
```
#in source files
module load Stacks
populations -P newoutput_refmap/ -M 413_noUK_popmap.txt --vcf -O neestimator/output/

#in neestimator/output
mv populations.snps.vcf ../

chmod +x NeEstimator.sh
./NeEstimator.sh populations.snps.vcf 10000 test/



```
