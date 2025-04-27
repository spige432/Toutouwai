library(ggplot2)
library(ggrepel)
library(tidyverse)

#Import the eigenvec and eigenval files that were from NeSI

#Edit the dataframe and make a scree plot
percent_var <- (eigenval$V1 / sum(eigenval$V1)) * 100

eigenval <- add_column(eigenval, principal_component = 1:10, .before = "V1")

plot(eigenval, type = "b",
     xlab = "Principal Component",
     ylab = "Eigenvalue",
     main = "Scree Plot")

eigenval$V1/sum(eigenval$V1)


#Edit the dataframe and make a PCA
eigenvec$V1 <- substr(eigenvec$V2, 1, 2)
names(eigenvec)[1] <- "Population"
eigenvec[eigenvec$Population=="BP", "Population"] <- "Bushy Park"
eigenvec[eigenvec$Population=="HA", "Population"] <- "Hauturu"
eigenvec[eigenvec$Population=="KA", "Population"] <- "Kapiti"
eigenvec[eigenvec$Population=="MA", "Population"] <- "Mangatutu"
eigenvec[eigenvec$Population=="PU", "Population"] <- "Pureora"
eigenvec[eigenvec$Population=="RO", "Population"] <- "Rotokare"
eigenvec[eigenvec$Population=="TA", "Population"] <- "Tawharanui"
eigenvec[eigenvec$Population=="TM", "Population"] <- "Tiritiri Matangi"




PCA <- ggplot(eigenvec, aes(x = V3, y = V4, color = Population)) +
  geom_point(size = 2) +
  xlab(paste0("PC1: ", round(percent_var[1], 2), "% variance")) +
  ylab(paste0("PC2: ", round(percent_var[2], 2), "% variance"))

print(PCA)
