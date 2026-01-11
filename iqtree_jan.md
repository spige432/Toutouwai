```
https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/025/920/805/GCA_025920805.1_Ptraversi_NRM_v1/
download GCA_025920805.1_Ptraversi_NRM_v1_genomic.fna.gz and upload to NeSI
samtools v 1.22
gunzip GCA_025920805.1_Ptraversi_NRM_v1_genomic.fna.gz
samtools faidx GCA_025920805.1_Ptraversi_NRM_v1_genomic.fna  #index it

actually i took the old blackrobinasoneline.txt and i just deleted the second half of it to make it the same length

```
sunday afternoon
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
```
