Ill contrast the coverage on SNP on a X scaffold vs the rest.

CM030044.1 is the Z
CM030043.1.1 is the W
CM030007.1 is autosoma

I isolate two vcf, and get depth data for both, then I can get the autosome to x coverage ratio (it should be close to 1 for females, and more 2 for males who only have 1 x )

CAAAJK010000001.1

module load VCFtools

```
vcftools --vcf output_refmap/populations.snps.vcf  --chr CM030007.1 --out autosomal  --geno-depth --minDP 2


vcftools --vcf output_refmap/populations.snps.vcf --chr CM030044.1 --geno-depth --out Z  --minDP 2

vcftools --vcf output_refmap/populations.snps.vcf --chr CM030043.1 --geno-depth --out W  --minDP 2 #44

```


```r
true_depth<-function(x){sum(x[which(x>-1)])/length(x)}
Z<-read.table("Z.gdepth",h=T)
Z<-Z[,3:dim(Z)[2]]
Z<-as.data.frame(apply(Z,2,true_depth))
autosomal<-read.table("autosomal.gdepth",h=T)
autosomal<-autosomal[,3:dim(autosomal)[2]]
autosomal<-as.data.frame(apply(autosomal,2,true_depth))
ratio<-cbind(Z[,1]/autosomal[,1],rownames(Z))


##Match to known sex
colnames(ratio)<-c("ratio","id")
recorded_sex<-read.table("recorded_sex.txt",h=T)
ratio<-merge(ratio,recorded_sex,by="id")


ratio<-as.data.frame(ratio)
ratio[,2]<-as.numeric(ratio[,2])
 library("ggplot2")


library(ggplot2)
my_colors<-c("#1b9e77","#d95f02","#7570b3")
ggplot(ratio, aes(x = sex, y = ratio, color = sex)) + geom_jitter() + scale_color_manual(values = my_colors)+theme_classic()  +
  labs(y = "Z / Autosomal Depth ratio")
ggsave("ratioZ.pdf")


##correlation for  females, deoth ratio


### W
#true_depth<-function(x){sum(x[which(x>-1)])/length(x[which(x>-1)])}
true_depth_W<-function(x){sum(x)/length(x)}

W<-read.table("W.gdepth",h=T)
W<-W[,3:dim(W)[2]]
W<-as.data.frame(apply(W,2,true_depth_W<-function(x){sum(x)/length(x)}))

ratio<-cbind(autosomal[,1]/W[,1],rownames(W))


##Match to known sex
colnames(ratio)<-c("ratio","id")
recorded_sex<-read.table("recorded_sex.txt",h=T)
ratio<-merge(ratio,recorded_sex,by="id")
ratio[,2]<-as.numeric(ratio[,2])



library(ggplot2)
my_colors<-c("#1b9e77","#d95f02","#7570b3")
ggplot(ratio, aes(x = sex, y = ratio, color = sex)) + geom_jitter() + scale_color_manual(values = my_colors)+theme_classic()  
ggsave("ratioW.pdf")





```




