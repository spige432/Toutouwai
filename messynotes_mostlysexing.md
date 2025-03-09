Compare to the yellow genome because they have the sex chromosomes known and mapping it with the black robin to know which are the sex chr. there
Eyr take list of z chr and pick out of eyr fasta
Take black robin fasta and compare with z fasta to find names of z linked scaffold in black robin
Then take that and compare it back to original black robin vcf to get the z ones
Males zz aa females zwaa compare coverage ratio
z/a 1 vs 0.5
Subset of fasta with a list of sequence
Module load seqtk
#Subset the z chromosome only from yellow robin
#\/ on eyr_zchr.txt take only the top 2-3 and create new txt then blast both and do the same comparing
seqtk subseq GCA_003426825.1_eyr_v1_genomic.fna eyr_zchr.txt > eyr_z.fna
seqtk subseq GCA_003426825.1_eyr_v1_genomic.fna yellow_z_chrom_3.txt > yellow_z_chrom_3.fna

Module load BLAST
Make blast database
makeblastdb -in GCA_025920805.1_Ptraversi_NRM_v1_genomic.fna -input_type fasta -dbtype nucl
blastn -db GCA_025920805.1_Ptraversi_NRM_v1_genomic.fna -query yellow_z_chrom_3.fna -out blastz.txt -outfmt 6 -max_target_seqs 2

cat blastz.txt | grep -E JAHLSL[0-9.]+ -o |sort |  uniq > blackrobinzlist.txt
sort blackrobinzlist.txt | head -n 3 

Use vcf and take only the ones that have the z chromosomes,  subset vcf
See about getting z from the end of the list if this one doesn’t split nicely into two groups because 6 is the first chromosome that has alignment from the yellow reference to the black reference so it might not really be a good representation of the sex chromosome in the black robin 
vcftools --vcf blackrobinoutput.vcf   --chr JAHLSL010000009.1  --out z2  --geno-depth --minDP 2 --max-missing 0.8

vcftools --vcf blackrobinoutput.vcf   --chr JAHLSL010000013.1  --out autosome  --geno-depth --minDP 2 --max-missing 0.8

Eyr 
vcftools --vcf eyr.snps.vcf  --chr QKXG01000089.1 --chr QKXG01000127.1 --chr QKXG01000146.1  --out z2  --geno-depth --minDP 2 --max-missing 0.8

vcftools --vcf blackrobinoutput.vcf   --chr JAHLSL010000013.1  --out autosome  --geno-depth --minDP 2 --max-missing 0.8

Remove four samples that have less than 65% coverage
9 38 9 +38

#After filtering, kept 1687 out of a possible 215293 Sites
#423 individuals

# vcftools --vcf blackrobinoutput.vcf   --chr JAHLSL010000006.1 --out z  --geno-depth --minDP 2

# vcftools --vcf blackrobinoutput.vcf  --chr JAHLSL010000013.1 --out autosome  --geno-depth --minDP 2

Compare depth of z chromosomes to autosomal chromosomes

Type >autosomal to see it
Type z

vcftools --vcf blackrobinoutput.vcf   --chr JAHLSL010017138.1 --out z  --geno-depth --minDP 2





write.table(total,”PC.txt”row.names=T,col.names=T,sep=”\t”)


load vcftools
vcftools --vcf (file name) 



Explain aligns
module load BWA
src=../locmetsamples_concat
bwa_db=GCA_003426825.1_eyr_v1_genomic.fna
bwa index $bwa_db
for sample in $files
do echo $sample
    bwa mem -t 2 $bwa_db $src/${sample}.fq.gz  |   samtools view -b | samtools sort --threads 4 > ${sample}.bam
done

module load SAMtools

-------

module load BWA
src=../locmetsamples_concat
bwa_db=GCA_025920805.1_Ptraversi_NRM_v1_genomic.fna
for sample in $files
do echo $sample
    bwa mem -t 2 $bwa_db $src/${sample}.fq.gz  |   samtools view -b | samtools sort --threads 4 > ${sample}.bam
done


removed from pop map for bus error and then EOF error



module load BWA
src=../locmetsamples_concat
bwa_db=GCA_003426825.1_eyr_v1_genomic.fna
for sample in $files
do echo $sample
    bwa mem -t 2 $bwa_db $src/${sample}.fq.gz  |   samtools view -b | samtools sort --threads 4 > ${sample}.bam
done

module load SAMtools


eyr_zchr.txt
yellow_z_chrom_3.txt


populations -P eyr_output_refmap/ -M 40popmap.txt  --vcf  -r 0.8

Removed 127319 loci that did not pass sample/population constraints from 160266 loci.
Kept 32947 loci, composed of 2512449 sites; 216237 of those sites were filtered, 32768 variant sites remained.
    2290254 genomic sites, of which 12331 were covered by multiple loci (0.5%).
Mean genotyped sites per locus: 69.89bp (stderr 0.10).

Population summary statistics (more detail in populations.sumstats_summary.tsv):
  pop: 37.483 samples per locus; pi: 0.12669; all/variant/polymorphic sites: 2302601/32768/32768; private alleles: 0
Populations is done.


ctrl +r is  search

colnames(total)<-c("PC1", "PC2","pop")
> colnames(total)<-c("PC1", "PC2","pop")
ggplot(total, aes(PC1, PC2,col=pop)) + geom_point()# Plotting with ggplot2 package geom_point() +theme_minimal() write.table(total,"PCA_dotterels.txt",quote=F,row.names=F,sep="\t") ggsave("PCA.pdf")

> dev.off()
null device 
          1 
> total[,1]<-as.numeric(total[,1])
total[,2]<-as.numeric(total[,2])
> 
> 
colnames(total)<-c("PC1", "PC2","pop")
ggplot(total, aes(PC1, PC2,col=pop)) + geom_point()# Plotting with ggplot2 package geom_point() +theme_minimal() write.table(total,"PCA_dotterels.txt",quote=F,row.names=F,sep="\t") ggsave("PCA.pdf")


use PCA to see if the populations are different as a first step of doing admixture and then also to see if it can be determined where the Unknown samples are from

2017 50 to pureora
what's with the differences in the pureora number cause it doesn't add up




bushy park to rotokare
	bushy park translocated from unknown location
pureora and mangatutu natural populations



tiritiri Matangi to tawh 2007, 21
mamaku plateau to tiritiri 1992, 58
winstone international forest to bushy park 2001, 28


NIRO428barcodes.txt
locmet427barcodes.txt

Out.recode
z2.gdepth 
autosome.gdepth 
z.gdepth


Rstudio
  true_depth<-function(x){sum(x[which(x>-1)])/length(x[which(x>-1)])}
  Z<-read.table("z2.gdepth",h=T)
  Z<-Z[,3:dim(Z)[2]]
  Z<-as.data.frame(apply(Z,2,true_depth))
  autosomal<-read.table("autosome.gdepth",h=T)
  autosomal<-autosomal[,3:dim(autosomal)[2]]
  autosomal<-as.data.frame(apply(autosomal,2,true_depth))
  ratio<-cbind(Z[,1]/autosomal[,1],rownames(Z),1:dim(Z)[2],autosomal)
  ratio<-as.data.frame(ratio)
  ratio[,1]<-as.numeric(ratio[,1])
  ratio[,4]<-as.numeric(ratio[,4])
  
    colnames(ratio)<-c("ratio","ind","x","autoomal")
  library(ggplot2)
  my_colors<-c("#1b9e77","#d95f02","#7570b3")
  ggplot(ratio, aes(x = x, y = ratio))  +geom_point()+ scale_color_manual(values = my_colors)+theme_classic()  
  
  ggplot(ratio, aes(x = x, y = ratio))  +geom_jitter()+ scale_color_manual(values = my_colors)+theme_classic()  
  
  
  plot(Z[,1],ratio[,1])
  

