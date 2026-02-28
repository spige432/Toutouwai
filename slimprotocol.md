```
module load VCFtools
vcftools --vcf mtbh.recode.vcf --maf 0.00000000001 --recode --out mtbhMAF #filter for only polymorphic sites
vcftools --vcf mtbhMAF.recode.vcf --het --out mtbhpre #het before it goes in the model
```
take the MAF filtered VCF into SLiM
run the model and put the output vcf ("post") back into NeSI
```
vcftools --vcf mtbh300slowpost.vcf --het --out mtbh300slowpost
```
take both het files into R
```
mtbhpre$y_axis = (mtbhpre$N_SITES - mtbhpre$O.HOM.) / mtbhpre$N_SITES
mtbh300slowpost$y_axis = (mtbh300slowpost$N_SITES - mtbh300slowpost$O.HOM.) / mtbh300slowpost$N_SITES
mtbhpre$group <- "a_pre"
mtbh300slowpost$group <-  "b_post"
allmtbh <- bind_rows(mtbhpre, mtbh300slowpost)
ggplot(allmtbh, aes(x = group, y = y_axis, color = group)) + 
  geom_boxplot(alpha = 0.7, outlier.shape = NA) + 
  geom_jitter(alpha = 0.4) +
  labs( title = "Proportion Heterozygosity by VCF", 
        x = "VCF (generations)", 
        y = "Proportion Heterozygosity" )

```
27Feb26
filtered all the VCFs to be their 5 different translocations from vcf_clean WITH max-missing = 1
(when i filter the whole vcf with max missing 1 it only leaves 1000 sites so i won't do that)
possibly still true / MAF or not it doesn't make a difference on het

all populations VCF (looking at just MTSP)
(sites-ohom)/sites = 0.074
(sites-ohom)/98k = 0.065

filtered by pop, then filtered for max missing (looking at just MTSP)
(sites-ohom)/sites = 0.154
(sites-ohom)/98k = 0.013
(sites-ohom)/17859 = 0.072
17859 is the number of sites remaining after it has been filtered to have no missing data

filtered the whole VCF for missing data, left only 1025 sites
(sites-hom)/sites = (sites-hom)/1025 = 0.053

from no missing data whole vcf, i filtered just the MTSP pop
(sites-hom)/1025 = 0.053

1. filter by population
2. filter max-missing 1 one at a time
3. for --het results, divide by the nubmer of sites that were in each individual vcf
4. run 1-10 seeds on slim 


for f in mtbhF1nm.seed*.vcf; do
    vcftools --vcf "$f" --het --out "${f%.vcf}"
done


vcf_clean has 98474 sites


graph idea:
left side is before the model, all the individuals wiht their individual heterozygosity showing the average
right side is 100 points but they're the average of the populations after they have gone through the model

i should separate the multi source populations into two so that I can see how each of their hets looked before and after 

graph it so that it shows what it looks like in the 100 years 

do sensitivity models and graphs on it
change K 
population viability analysis


bruce will ask yasmine to do realtedneess
ans ask chris if he can help me on slim

indivs have been removed before they go into slim becuase there's only so many data pieces about the birds that sruvived etc so that's part of why the heterozygosity is different 
2-3 pages for the chapter intor chapters and very cfocuse don what i'm looking at
pop phylogeography of nz species and robins and expectations 
frankham stuff about off shor islands 

we don't know aht the trans popus will look like hat's why we look at the het (genetic diversity)

email kevin about the structure



meniah fenton SI robin dispersal 
