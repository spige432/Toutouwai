```
module purge && module load Miniconda3
source $(conda info --base)/etc/profile.d/conda.sh
export PYTHONNOUSERSITE=1
conda config --add pkgs_dirs /nesi/nobackup/uoo04226/spige432/conda_pkgs
conda create --prefix /nesi/project/uoo04226/admixture_env python=3.8
#use "y" and enter to proceed
conda activate /nesi/project/uoo04226/slim_env
conda install conda-forge::slim
#use "y" and enter to proceed

slim -testEidos
#7194
slim -testSLiM
#36807
```
SLiM manual page 608
```
#create VCF that has only one population at a time, and filtered according to the SLiM manual
vcftools --vcf final.recode.vcf --keep PUonly.txt --minDP 5 --max-missing 0.8 --remove-indels --mac 1 --recode --out PUfiltered 
# kept 62241 out of a possible 98474 Sites

#filter the black robin genome to be the same sites as my SNPs using a VCF that has only one set of samples at a time
grep -v "^##" final.recode.vcf > nohead.vcf
cut -f 1,2,3 nohead.vcf > 2columns.vcf #take the first 3 columns only
grep -v '^##' 2columns.vcf | awk '$3=$2' > 3columns.vcf #copy the second column to replace the third column
awk '{print $1 ":" $2 "-" $3}' 3columns.vcf > 1column.vcf #adds a hyphen between the two sites (it is the same site, indicating I only want one letter at a time)
#manually remove first row and make it into a txt file (faidxfile.txt)
samtools faidx  GCA_025920805.1_Ptraversi_NRM_v1_genomic.fna -r faidxfile.txt > filteredBR.fa
#no N sites to remove

77132 out of range
