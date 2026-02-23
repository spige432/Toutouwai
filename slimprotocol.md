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
