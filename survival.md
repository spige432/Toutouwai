Create data sets

Use survival data excel from Kevin Parker to separate samples into "survived" and "DNS" (did not survive),

filter to keep only samples that are within our data set of 413 remaining samples,

use command line to create VCFs of each group
```
module load VCFtools
vcftools --vcf populations.snps.vcf --keep DNSindivs.txt --out DNSindivs --recode
vcftools --vcf populations.snps.vcf --keep Survivedindivs.txt --out Survivedindivs --recode
```
**Inbreeding coefficient**
```

```
**Proportion heterozygosity**
```

```
**PCA with highlighted survival vs DNS**
```

```
**Trends in survival in one vs multi-sources translocation**
```

```
