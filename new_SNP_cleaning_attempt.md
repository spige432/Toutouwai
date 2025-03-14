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
view these files using less

use the values in R in order to create a graph, explore mean depth and/or the 0.8 (a little) in order to find on r where the lowest value is that the correlation is not there

--het oHOM observed homozygotes 

n is number of sites 

F is inbreeding coefficient from HW comparing them 

ohom/N is y axis on the indiv vs coef

ehom - ohom all divided by ehom proportion of heterozygotes

"You want proportion of heterozygotes. E is expected under hardy weinberg, o is observed. You want to use oHom (the number of homozygotes) and the total number of sites to get at the proportion of total sites that are heterozygotes."

y axis: ohom / total sites (N) = 0.925 percentage of sites that are homozygous
1 - x = 0.0748 proportion of sites that are heterozygous

y axis: (N - oHOM) / N sites = propotion of sites that are heterozygotes
x axis: depth
