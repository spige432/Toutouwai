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
vcftools --vcf recode.renamed.vcf --keep 320_noKAHA.txt --recode --out nokaha
```
320_noKAHA.txt contains all samples that are not Kapiti or Hauturu
```
plink2 --vcf nokaha.recode.vcf  --make-bed --out PCA
plink2 --bfile PCA --pca --out pca_results
```
use pca_results.eigenval and pca_results.eigenvec in R following PCAreal.R
