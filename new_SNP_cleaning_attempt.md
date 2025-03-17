```
12March25
in sourcefiles
module load Stacks
mkdir newoutput_refmap
ref_map.pl --samples alignment --popmap 429popmap.txt -T 8  -o newoutput_refmap
```

```
populations -P newoutput_refmap/ -M 429popmap.txt  --vcf

"Removed 0 loci that did not pass sample/population constraints from 637698 loci.
Kept 637698 loci, composed of 54051543 sites; 0 of those sites were filtered, 759419 variant sites remained.
    46376676 genomic sites, of which 7027407 were covered by multiple loci (15.2%).
Mean genotyped sites per locus: 84.62bp (stderr 0.02).

Population summary statistics (more detail in populations.sumstats_summary.tsv):
  pop: 185.43 samples per locus; pi: 0.14946; all/variant/polymorphic sites: 53961185/759419/759419; private alleles: 0"
```

```
populations -P newoutput_refmap/ -M 429popmap.txt  --vcf  -r 0.8

"Removed 576294 loci that did not pass sample/population constraints from 637698 loci.
Kept 61404 loci, composed of 4928235 sites; 784935 of those sites were filtered, 196806 variant sites remained.
    4155965 genomic sites, of which 27439 were covered by multiple loci (0.7%).
Mean genotyped sites per locus: 68.13bp (stderr 0.08)."
```
```
populations -P newoutput_refmap/ -M 429popmap.txt  --vcf  -r 0.8
"After filtering, kept 429 out of 429 Individuals
Outputting Individual Missingness
After filtering, kept 196806 out of a possible 196806 Sites"
```
```
cd newoutput_refmap
module load VCFtools
vcftools --vcf populations.snps.vcf --missing-indv
sort -k 4n out.imiss | less

shows all individuals sorted by missing data
higher number is worse. Of my 429 samples I have two that are above 0.6
MA13724 and BP16299 (these two were included in the six that were removed on my last running of this)
```

created new popmap with the two samples removed

newcleanpopmap.txt uploaded to source files

```
What Ludo told me to run on Monday in source files ->
module purge
module load Stacks
populations -P newoutput_refmap/ -M newcleanpopmap.txt  --vcf  -r 0.8

"Removed 575893 loci that did not pass sample/population constraints from 637698 loci.
Kept 61805 loci, composed of 4962327 sites; 786379 of those sites were filtered, 198474 variant sites remained.
    4188341 genomic sites, of which 27821 were covered by multiple loci (0.7%).
Mean genotyped sites per locus: 68.22bp (stderr 0.08).

Population summary statistics (more detail in populations.sumstats_summary.tsv):
  pop: 400.94 samples per locus; pi: 0.062944; all/variant/polymorphic sites: 4216289/198474/198474; private alleles: 0
Populations is done."
```
Is it unusual that this removed more loci? I would think at this stage that it would have kept all of them becuase 
I put in the "clean" popmap with the ones above 0.6 removed

```
module load VCFtools
cd newoutput_refmap/
vcftools --vcf populations.snps.vcf --minDP 5 --max-missing 0.8 --het
"kept 95018 out of a possible 198474 Sites"

vcftools --vcf populations.snps.vcf --minDP 5 --max-missing 0.8 --depth
"kept 95018 out of a possible 198474 Sites"
```

```
17March25
1. Download out.het and out.idepth files
2. import them into R
3. run the following code on R

het5.8$y_axis = (het5.8$N_SITES - het5.8$O.HOM.) / het5.8$N_SITES                               #creates new column that represents the proportion of hereozygous individuals
plot(dep5.8 [,3], het5.8 [,6], xlab = "depth", ylab= "proportion heterozygous", main = "title") #plots proportion hetero vs depth in order to see if there is a correlation between them
dep5.8[dep5.8[, 3] <7, 1]                                                                       #shows which individuals have the lowest depth, I will remove them to minimize the possibility that they are skewing the data

4. run the following code on NeSI to recode the VCF file with the remaining 416 samples. [I had to go back to my folder called "output_refmap" as opposed to "newoutput_refmap" that I have been using becuase that is where the blackrobinoutput.vcf is. I don't think this will make a difference.]

vcftools --vcf blackrobinoutput.vcf --minDP 5 --max-missing 0.8 --recode --remove-indv PU14637 --remove-indv KA16441 --remove-indv PU16217 --remove-indv TA114678 --remove-indv TM13681 --remove-indv HA13273 --remove-indv HA13278
```
When I used "vcftools --vcf populations.snps.vcf --missing-indv" and "sort -k 4n out.imiss | less", this is the list of the lowest quality. The ones I removed are **bold**. I thought it was interesting that they're not just the bottom 7 in order.
TM13676
**PU14637
TM13681**
PU14631
PU14646
**HA13278
TA114678
HA13273
PU16217
KA16441**
