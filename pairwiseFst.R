library(ggplot2)
library(dplyr)
library(tidyr)
library(tidyverse)

#I created an excel of each population compared against the other one time with the columns pop1, pop2, and Fst

library(readxl)
mean_fst <- read_excel("~/Gemma Uni/Thesis data/mean_fst.xlsx")
View(mean_fst)


pop_names <- c("BP", "HA", "KA", "MA", "PU", "RO", "TA", "TM")
fst_matrix <- matrix(NA,
                     nrow = length(pop_names), ncol = length(pop_names),
                     dimnames = list(pop_names, pop_names))

for(i in 1:nrow(w_fst)) {
  fst_matrix[w_fst$pop1[i], w_fst$pop2[i]] <- w_fst$w_Fst[i]
  fst_matrix[w_fst$pop2[i], w_fst$pop1[i]] <- w_fst$w_Fst[i]
}

fst_matrix[lower.tri(fst_matrix)] <- NA


fst_long <- fst_matrix %>%
  as.data.frame() %>%
  rownames_to_column("pop1") %>%
  pivot_longer(-pop1, names_to = "pop2", values_to = "fst") %>%
  mutate(is_diag = pop1 == pop2)

fst_long$pop1 <- factor(fst_long$pop1, levels = (unique(fst_long$pop1)))
fst_long$pop2 <- factor(fst_long$pop2, levels = (unique(fst_long$pop2)))

fst_heat <- ggplot(fst_long, aes(pop1, pop2,  fill = fst)) +
  geom_tile() +
  geom_tile(aes(alpha = ifelse(is_diag, 1, 0)), show.legend = F, fill = "gray") +
  geom_text(aes(label = round(fst, 3)), size = 3, colour = "white") +
  scale_fill_continuous(na.value = "white") +
  labs(title = expression(Pairwise~F[ST])) +
  labs(color = expression(F[ST])) +
  labs(x = "", y = "") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 70, hjust = 1) ) 
 # theme(axis.text.y = element_text(angle = 45, hjust = 1) )

fst_heat
