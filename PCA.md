https://omicstutorials.com/step-by-step-guide-to-performing-pca-from-vcf-files/
```
module load PLINK
plink2 --vcf recode.renamed.vcf  --make-bed --out PCA
plink2 --bfile PCA --pca --out pca_results



plink2 --vcf recode.renamed.vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 10 0.1 --out take2
plink2 --vcf recode.renamed.vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --extract take2.prune.in --make-bed --pca --out take2
