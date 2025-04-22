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

```
	TMvsX (mean)	TMvsX (weighted)
Tāwharanui 	0.028	0.047
Pureora	0.030	0.064
Mangatutu	0.035	0.064
Bushy Park	0.047	0.086
Rotokare	0.077	0.117
Kapiti	0.100	0.243
Hauturu	0.111	0.292
		
![image](https://github.com/user-attachments/assets/26db50ac-3cee-426f-b19f-0b2cdde06555)

