```
mkdir admixture
cp recode.renamed.vcf ../../admixture/
```
make vcf a bed file (https://github.com/laurabenestan/Admixture)
```
module load VCFtools
module load PLINK
vcftools --vcf recode.renamed.vcf --plink-tped --out admixture
vcftools --vcf recode.renamed.vcf --plink-tped --out admixture
plink2 --tped admixture.tped --tfam admixture.tfam --make-bed --out admixtureanalysis
for K in echo $(seq 29) ; do admixture --cv=10 -B2000 -j8 admixtureanalysis.bed $K | tee log${K}.out; done
```
I think I don't have access to the admixture module becuase I can't find it anywhere
alternate pipeline option?: https://github.com/stevemussmann/admixturePipeline/blob/master/README.md

##miniconda
```
module purge && module load Miniconda3
source $(conda info --base)/etc/profile.d/conda.sh
export PYTHONNOUSERSITE=1
