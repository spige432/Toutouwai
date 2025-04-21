```
bcftools query -l recode.renamed.vcf | grep "TA" > popTA.txt
bcftools query -l recode.renamed.vcf | grep "TM" > popTM.txt

vcftools --vcf recode.renamed.vcf --weir-fst-pop popTA.txt --weir-fst-pop popTM.txt --out TAvsTM

After filtering, kept 105 out of 413 Individuals
Outputting Weir and Cockerham Fst estimates.
Weir and Cockerham mean Fst estimate: 0.027749
Weir and Cockerham weighted Fst estimate: 0.047463
After filtering, kept 198474 out of a possible 198474 Sites


vcftools --vcf recode.renamed.vcf --weir-fst-pop popTA.txt --weir-fst-pop popTM.txt --out TAvsTMtest --recode


```

data <- read.table("TAvsTM.weir.fst", header = TRUE)
plot(data$POS, data$WEIR_AND_COCKERHAM_FST,
     xlab="Position",
     ylab= "Pairwise Fst",
     main= "Pairwise Fst Across the Genome",
     pch= ".",
     col= "blue")
