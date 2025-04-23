Create a txt document for the samples from each individual population
```
bcftools query -l recode.renamed.vcf | grep "TA" > popTA.txt
bcftools query -l recode.renamed.vcf | grep "TM" > popTM.txt
```
Use vcftools to do pairwise fst between two populaitons. The log shows the Fst values.
```
vcftools --vcf recode.renamed.vcf --weir-fst-pop popTA.txt --weir-fst-pop popTM.txt --out TAvsTM

After filtering, kept 105 out of 413 Individuals
Outputting Weir and Cockerham Fst estimates.
Weir and Cockerham mean Fst estimate: 0.027749
Weir and Cockerham weighted Fst estimate: 0.047463
After filtering, kept 198474 out of a possible 198474 Sites
```
A snpashot of what the Fst values are looking like. The two natural island populations are the ones with the highest values, meaning that the allele frequencies of TMvsX are more different. The allele frequencies are most similar with TM vs Tāwharanui because Tāwharanui was founded with birds from TM. 

It's interesting that Rotokare is the one most different than Hauturu, but maybe it has something to do with how Rotokare was an extremely small natural mainland population. Also it has previously been supplemented with another population so that must have mixed the gene pool up a bit? For this study, Rotokare was supplemented with toutouwai from Bushy Park. This may have not been the best translocation because the Fst between those two locations is quite low at 0.052, meaning that they are more similar than other populations.
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
Should I have used the weighted Fst isntead of the mean?
