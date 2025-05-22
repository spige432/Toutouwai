https://omicstutorials.com/step-by-step-guide-to-performing-pca-from-vcf-files/
```
module load PLINK
plink2 --vcf recode.renamed.vcf  --make-bed --out PCA
plink2 --bfile PCA --pca --out pca_results
```
## Redo PCA without outliers (Kapiti and Hauturu) to look at closely grouped sections
```
/testing/robins/source_files/PCA
mkdir clump
cp recode.renamed.vcf clump/recode.renamed.vcf
cd clump/
