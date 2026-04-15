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
**rerunning everything with the samples marked as the destination instead of the source**
```
create SORLO folder
mv vcfs (Surv and dns) into there and use BCFtools to reheader/rename it using the SORLOrename.txt
recode vcf to contain SORLOsurv and SORLOdns
re-call het and dep to go into R


