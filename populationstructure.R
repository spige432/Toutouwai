#Setting up the data
out.depth <- read.delim("~/Gemma Uni/Thesis data/het_depth/out.depth.idepth")
out.het <- read.delim("~/Gemma Uni/Thesis data/het_depth/out.het.het")
het5.8$y_axis = (het5.8$N_SITES - het5.8$O.HOM.) / het5.8$N_SITES

#plotting Depth vs proportion heterozygous
plot(dep5.8 [,3], het5.8 [,6], xlab = "Depth", ylab= "Proportion heterozygous", main = "SNPs Read Coverage") #right one

#qc checks and removing data that makes there be a correlation between the variables (and not enough depth of coverage)
dep5.8[, 3] <5 #all false
dep5.8[dep5.8[, 3] <7, 1]
#[1] "PU14637"  "KA16441"  "PU16217"  "TA114678" "TM13681"  "HA13273"  "HA13278" 
#I like the idea of removing these ones because they have come up before as having a lot of missing data

#Removing all samples that need to be removed for any reason                                                  
filtered_dep5.8 <- dep5.8[!(dep5.8$INDV %in% c("MA13724", "BP16299", "KA16441", "TA114678", "TM13681", "TM13676", "HA13273", "HA13278", "PU16217", "PU14637", "PU14646", "PU14631", "UK00-R19", "UKB-BM", "UK13236", "UK120700")),]
filtered_het5.8 <- het5.8[!(het5.8$INDV %in% c("MA13724", "BP16299", "KA16441", "TA114678", "TM13681", "TM13676", "HA13273", "HA13278", "PU16217", "PU14637", "PU14646", "PU14631", "UK00-R19", "UKB-BM", "UK13236", "UK120700")),]

#Final and proper graph
plot(filtered_dep5.8 [,3], filtered_het5.8 [,6], xlab = "Depth", ylab= "Proportion heterozygous", main = "Filtered SNPs Read Coverage")

#oddities from the graph
het5.8[het5.8[, 6] >0.09, 1] #PU14637, one very heterozygous individual
het5.8[het5.8[, 6] <0.04, 1] #HA13585, one very homozygous individual
#some samples are hanging out between the two groups of "proportion heterozygous), from a visual look at the data frame:
#TA14725	(0.06421826), TA4197, HA13273,TA105274, TA121600, TM13684, TA13542	(0.05854532)



#Creating a box plot to visualize inbred coefficient by population

#Editing sample names. I wrote it like this cause for some reason the line numbers do not align
filtered_het5.8[filtered_het5.8$INDV=="16417", "INDV"] <- "KA16417"
filtered_het5.8[filtered_het5.8$INDV=="UK13257", "INDV"] <- "HA13257"
filtered_het5.8[filtered_het5.8$INDV=="UK12240", "INDV"] <- "HA12240"
filtered_het5.8[filtered_het5.8$INDV=="UK12241", "INDV"] <- "HA12241"
filtered_het5.8[filtered_het5.8$INDV=="UK12242", "INDV"] <- "HA12242"
filtered_het5.8[filtered_het5.8$INDV=="UK12243", "INDV"] <- "HA12243"

#Create new column of just the first two letters to make it easy to group by population
filtered_het5.8$population <- substr(filtered_het5.8$INDV, 1, 2)

#Compare F across populations
library(ggplot2)
ggplot(data = filtered_het5.8) +
  geom_boxplot (mapping = aes(x = population, y = F)) +
  geom_boxplot(mapping = aes(x = population, y = F, color = population), data = filtered_het5.8)

ggplot(filtered_het5.8, aes(x= population, y = F, color = population)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(alpha = 0.3) +
  labs(title = "Inbreeding Coefficient by Population",
       x = "Population")

#find means
mean_F <- aggregate(F ~ population, data = filtered_het5.8, FUN = mean)
colnames(mean_F)[2] <- "Average F"


#homozygousity by population
filtered_het5.8$homo = (filtered_het5.8$N_SITES - filtered_het5.8$E.HOM.) / filtered_het5.8$N_SITES
ggplot(data = filtered_het5.8) +
  geom_boxplot (mapping = aes(x = population, y = homo)) +
  geom_boxplot(mapping = aes(x = population, y = homo, color = population), data = filtered_het5.8)

ggplot(filtered_het5.8, aes(x= population, y = homo, color = population)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(alpha = 0.4) +
  labs(title = "Proportion Homozygosity by Population",
       x = "Population",
       y = "Proportion Homozygosity")
