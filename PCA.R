library("pcadapt")  
data <- read.pcadapt("out.recode.vcf", type = "vcf") 
metadata <-read.table("../metadata.txt",h=T)


x <- pcadapt(input = data, K = 20) 
rownames(x$scores)<-metadata[,1]
colnames(x$scores)<-paste("PC",1:20,sep="")
plot(x, option = "screeplot")
plot(x$scores[,1],x$scores[,2],col="white")
text(x$scores[,1],x$scores[,2],metadata[,1])

total<-as.data.frame(cbind(x$scores[,1],x$scores[,2],metadata[,2]))
total[,1]<-as.numeric(total[,1])
total[,2]<-as.numeric(total[,2])

colnames(total)<-c("PC1", "PC2","pop")
ggplot(total, aes(PC1, PC2,col=pop)) + geom_point()# Plotting with ggplot2 package geom_point() +theme_minimal() write.table(total,"PCA_dotterels.txt",quote=F,row.names=F,sep="\t") ggsave("PCA.pdf")

