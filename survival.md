Create data sets
-----
Use survival data excel from Kevin Parker to separate samples into "survived" and "DNS" (did not survive),

Filter to keep only samples that are within our data setof 413 remaining samples. 
```
module load VCFtools
vcftools --vcf populations.snps.vcf --keep DNSindivs.txt --out DNSindivs --recode
vcftools --vcf populations.snps.vcf --keep Survivedindivs.txt --out Survivedindivs --recode
