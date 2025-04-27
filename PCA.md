https://omicstutorials.com/step-by-step-guide-to-performing-pca-from-vcf-files/
```
module load PLINK
plink2 --vcf recode.renamed.vcf  --make-bed --out PCA
plink2 --bfile PCA --pca --out pca_results
