Black robin genome:
https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/920/805/GCA_025920805.1_Ptraversi_NRM_v1/
```
#download GCA_025920805.1_Ptraversi_NRM_v1_genomic.fna.gz and upload to NeSI
module load SAMtools #v 1.22
gunzip GCA_025920805.1_Ptraversi_NRM_v1_genomic.fna.gz
samtools faidx GCA_025920805.1_Ptraversi_NRM_v1_genomic.fna  #index it

```
Turn the VCF into a phylip file
https://github.com/edgardomortiz/vcf2phylip
Download file and upload "vcf2phylip.py" to my working directory
```
python vcf2phylip.py --input final.renamed.vcf #creates final.recode.min4.phy
```
Use the black robin genome as an outgroup to my toutouwai SNPs
```
grep -v "^##" final.recode.vcf > nohead.vcf
cut -f 1,2,3 nohead.vcf > 2columns.vcf #take the first 3 columns only
grep -v '^##' 2columns.vcf | awk '$3=$2' > 3columns.vcf #copy the second column to replace the third column
awk '{print $1 ":" $2 "-" $3}' 3columns.vcf > 1column.vcf #adds a hyphen between the two sites (it is the same site, indicating I only want one letter at a time)
#manually remove first row and make it into a txt file (faidxfile.txt)
samtools faidx  GCA_025920805.1_Ptraversi_NRM_v1_genomic.fna -r faidxfile.txt | grep "^>" -v > blackrobincol.txt #grabs the black robin genome
tr '\n' ',' < blackrobincol.txt > blackrobinrow.txt
sed -s "s/,//g" blackrobinrow.txt | sed -s "s/^/blackrobin\t/g"   > realblackrobin.txt
cat realblackrobin.txt >> final.recode.min4.phy #make sure it's on it's own line and at the end of the file
#manually change the first line of the file to reflect there's now 410 samples (the added outgroup)
```
Example of my job submitted on NeSI:
```
#!/bin/bash -e
#SBATCH --job-name=iq-tree # job name (shows up in the queue)
#SBATCH --time=5-00:00:00       # Walltime (HH:MM:SS)
#SBATCH --mem=64G          # Memory 
#SBATCH --cpus-per-task=16
#SBATCH --account=uoo04226


cd /home/spige432/testing/robins/source_files/janoutput_refmap/0.4
module load IQ-TREE
iqtree2 -nt 16 -s 0.4.filtered.min4.phy -st DNA -m GTR+G -bb 1000 -o blackrobin -pre 04grtg
