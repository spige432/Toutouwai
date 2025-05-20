**miniconda**
-----
```
module purge && module load Miniconda3
source $(conda info --base)/etc/profile.d/conda.sh
export PYTHONNOUSERSITE=1
conda config --add pkgs_dirs /nesi/nobackup/uoo04226/spige432/conda_pkgs
conda create --prefix /nesi/project/uoo04226/admixture_env python=3.8
#use "y" and enter to proceed
conda activate /nesi/project/uoo04226/admixture_env
conda install bioconda::admixture
#use "y" and enter to proceed
```
**vcf file to admixture in miniconda in NeSI**
-----
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
for K in echo $(seq 9) ; do admixture --cv=10 -B1000 -j8 admixtureanalysis.bed $K | tee log${K}.out; done
#K max = n + 1 = 9

```
I think I don't have access to the admixture module becuase I can't find it anywhere
alternate pipeline option?: https://github.com/stevemussmann/admixturePipeline/blob/master/README.md


in the cluster
```
module load Miniconda3
conda init
conda activate /nesi/project/uoo04226/new_admixture_env
cd testing/robins/source_files/admixture/admixjob/
#must contain .bed .bim and .fam
sbatch admix.sl
```
7 day job submitted 3:54 pm Tuesday
