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

**admix.sl** (submitted job)
-----
```
#!/bin/bash -e
#SBATCH --job-name=admix  # job name (shows up in the queue)
#SBATCH --time=7-00:00:00      # Walltime (HH:MM:SS)
#SBATCH --mem=64G          # Memory 
#SBATCH --cpus-per-task=16
#SBATCH --account=uoo04226


module purge >/dev/null 2>&1

for K in echo $(seq 9) ; do admixture --cv=10 -B1000 -j8 admixtureanalysis.bed $K | tee log${K}.out; done
```
in admixture/admixjob
```
grep -h CV log*.out>cross_validation.txt
#for the following line, the guide said it would be a .tfam file but I only have a .fam file
cut -f 1 admixtureanalysis.fam > id_admixture.txt
```
Graphing in R
-----
```
Error in `scale_x_continuous()`:
! Discrete values supplied to continuous scale.
ℹ Example values: "K=1", "K=2", "K=3", "K=4", and "K=5"
Run `rlang::last_trace()` to see where the error occurred.
Warning message:
The `size` argument of `element_rect()` is deprecated as
of ggplot2 3.4.0.
ℹ Please use the `linewidth` argument instead.
This warning is displayed once every 8 hours.
