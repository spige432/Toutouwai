```
bcftools query -l recode.renamed.vcf | grep "TA" > popTA.txt
bcftools query -l recode.renamed.vcf | grep "TM" > popTM.txt

vcftools --vcf recode.renamed.vcf --weir-fst-pop popTA.txt --weir-fst-pop popTM.txt --out TAvsTM

After filtering, kept 105 out of 413 Individuals
Outputting Weir and Cockerham Fst estimates.
Weir and Cockerham mean Fst estimate: 0.027749
Weir and Cockerham weighted Fst estimate: 0.047463
After filtering, kept 198474 out of a possible 198474 Sites




```
When comparing the Fst of Tiritiri compated to all the other populations, I believe these Fst values are logical becuase the two natural island populations are the ones with the highest values, meaning that the allele frequencies of TMvsX are more different. The allele frequencies are most similar with TM vs Tāwharanui because Tāwharanui was founded with birds from TM
```
Fst of Tiritiri Matangi vs other pops, ascending		Fst of Hauturu vs other pops, ascending		
		TMvsX (mean)	TMvsX (weighted)				HAvsX (mean)	HAvsX (weighted)
Tāwharanui 	0.028		0.047			Pureora			0.059		0.238
Pureora		0.030		0.064			Mangatutu		0.094		0.269
Mangatutu	0.035		0.064			Bushy Park		0.107		0.276
Bushy Park	0.047		0.086			Tiritiri Matangi	0.111		0.292
Rotokare	0.077		0.117			Tāwharanui 		0.116		0.299
Kapiti		0.100		0.243			Kapiti			0.183		0.418
Hauturu		0.111		0.292			Rotokare		0.208		0.327
```
I haven't done all of the Fst comparisons yet becuase I'm not sure if this is the best way to approach the data
1) how would I add this into a dataframe that can be a heatmap in R
2) would I use the mean or the weighted Fst? I think that weighted is for if there is a large amount of variance across the genome. The order of the variables seems to be really similar 
