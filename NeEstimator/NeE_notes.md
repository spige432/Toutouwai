populations sampled at more than one time period? How can I do this if I have to mark which generation they're in (idk)

z chromosomes?

-----
Create a fresh VCF to filter it a specific way for NeEstimator

My files used to create the VCF still uses the old sample names, so I had to make 413 popmap with UK and wrong KA still in place. 

413_UKs_popmap.txt is my list of all 413 used populations, not corrected names, includes unknowns, all listed as "pop"

```
#in source files
module load Stacks
populations -P newoutput_refmap/ -M 413_UKs_popmap.txt --vcf -O neestimator/output/

#in neestimator/output
mv populations.snps.vcf ../
```
I had to rename the samples to be not UK. 413renamed.txt includes a list of the old names on the left and the new name for it on the right.
```
cd neestimator
module load BCFtools
bcftools reheader -s 413renamed.txt populations.snps.vcf  -o renamed.snps.vcf
```
I believe I'm supposed to filter my VCF with the following two scripts, separately:

https://github.com/ldutoit/negotland/blob/master/clean_vcf_nogenesnoCNE.py ; https://github.com/ldutoit/negotland/blob/master/clean_vcf_everything.py

However I don't know how to use them. I don't have "bioinfo-tools" module, 

and I don't know what I would do instead of "import negotland_lib as ne" since that doesn't work

below is some of the code from within the script. Using it alone in VCFtools erases all sites so the filters must be changed
```
vcftools --vcf populations.snps.vcf --minDP 10 --maxDP 100 --max-missing 1 --minQ 20 --maf 0




minDP=10       -----kept all
maxDP = 100    -----kept all
max_missing=1  -----kept 21469 out of a possible 753541 Sites
minQ=20        -----kept 0 out of a possible 753541 Sites
maf= 0         -----kept all
```

```
chmod +x NeEstimator.sh
./NeEstimator.sh populations.snps.vcf 10000 test/



```
Running into issues on NeEstimator.sh where I don't have some of the files
