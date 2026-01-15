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
max_missing=1  -----kept 21469 out of a possible 753541 Sites (watch out for less than 10k)
minQ=20        -----kept 0 out of a possible 753541 Sites
maf= 0         -----kept all  try 0.000001 keeps only polymorph sites (or else you end up with monmorphic sites)
(try only max missing and maf)
filter the VCF by only one pop at a time and redo NeE
```
created VCF with only HA and then one with only KA by doing --keep
```
vcftools --vcf NeE.renamed.vcf --keep HAonly.txt --out HAonly --recode
vcftools --vcf HAonly.recode.vcf --max-missing 1  --maf 0.000001
#After filtering, kept 58 out of 58 Individuals
#After filtering, kept 22011 out of a possible 198474 Sites
./NeEstimator.sh HAonly.recode.vcf 10000 HA/
#download .dat file (TMonly.recode.vcf_10000.dat) and upload it to NeEstimator GUI
#Run it as GENEPOP, only Linkage disequillibrium -> random mating
#create parameter files, upload output "info" file into proper folder on NeSI (if needed)
#Run Ne and view results
#Upload LD.txt and NoDat.txt files to NeSI in the corresponding folder
```
```
chmod +x NeEstimator.sh #this gives it permission to run
./NeEstimator.sh renamed.snps.vcf 10000 test/



```
Running into issues on NeEstimator.sh where I don't have some of the files
```
chmod u+x Ne2-1L
./Ne2-1L i:info
```
```
06Jan26
1. regular VCF with proper names and all samples
2. upload quickfixpop.py and vcf2genepop.pl from ldutoit/GBS_dotterel (edit line 10 of quickfix)
3. module load VCFtools #version 0.1.15
5. vcftools --vcf final.recode.vcf --minDP 5 --max-missing 0.8 --keep HAonly.txt --recode --out HAnoextrafilt #create VCFs with only one population at a time #RECODE IT to output new VCF
6. chmod +x NeEstimator.sh #this gives it permission to run
7. ./NeEstimator.sh HAnoextrafilt.recode.vcf 10000 HA/ #converts the file to genepop with a 10k subsample; repeat for all populations
8. download HAnoextrafilt.recode.vcf_10000.dat #etc
9. put the .dat files on NeEstimator 2.1 GUI with the input settings on GENEPOP and the methods selecting only linkage disequillibrium - model: Random Mating
10. #"Create Parameter Files" to create info file; add the file into their population folder on NeSI #I don't really need this
11. "Run Ne" creates LD (and missing data files if applicable); add both of these to their population folder on NeSI
12. Read files and extract the necessary Ne data

Mangatutu came out infinite on some of the predictions so I reran it with the whole dataset, not just 10k -> turned up nothing besides the non-polymorphic loci
10k of all ALL ran on NeEstimator but gave nothing but the non-polymorphic loci
