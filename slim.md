```
#create VCF that has only one population at a time, and filtered according to the SLiM manual
vcftools --vcf final.recode.vcf --keep PUonly.txt --minDP 5 --max-missing 0.8 --remove-indels --mac 1 --recode --out PUfiltered 
# kept 62241 out of a possible 98474 Sites

#filter the black robin genome to be the same sites as my SNPs using a VCF that has only one set of samples at a time
grep -v "^##" final.recode.vcf > nohead.vcf
cut -f 1,2,3 nohead.vcf > 2columns.vcf #take the first 3 columns only
grep -v '^##' 2columns.vcf | awk '$3=$2' > 3columns.vcf #copy the second column to replace the third column
awk '{print $1 ":" $2 "-" $3}' 3columns.vcf > 1column.vcf #adds a hyphen between the two sites (it is the same site, indicating I only want one letter at a time)
#manually remove first row and make it into a txt file (faidxfile.txt)
samtools faidx  GCA_025920805.1_Ptraversi_NRM_v1_genomic.fna -r faidxfile.txt > filteredBR.fa
#no N sites to remove

77132 out of range
```
Prepare VCF to be read by SLiM
```
  203  vcftools --vcf final.recode.vcf --max-missing 1.0 --recode-INFO GT --recode 
  216  vcftools --vcf final.recode.vcf --max-missing 1.0 --recode-INFO GT  --contig JAHLSL010000006.1 --recode
  221  cat GCA_025920805.1_Ptraversi_NRM_v1_genomic_upper.fna | tr N A > GCA_025920805.1_Ptraversi_NRM_v1_genomic_upper.fna
  224  cat GCA_025920805.1_Ptraversi_NRM_v1_genomic.fna | tr [:lower:] [:upper:] | tr N A  > GCA_025920805.1_Ptraversi_NRM_v1_genomic_upper.fna
  228  module load SAMtools
  230  samtools faidx  GCA_025920805.1_Ptraversi_NRM_v1_genomic_upper.fna 
  240  cat GCA_025920805.1_Ptraversi_NRM_v1_genomic.fna | tr [:lower:] [:upper:] | tr N A |   sed -se  "s/^>JAHL[0-9A-Z.]+//g" | head -n 5
  246    sed -s -E  "s/^>JAHLSL[0-9.]+//g" GCA_025920805.1_Ptraversi_NRM_v1_genomic_upper.fna | head -n 5
  251    sed -s -e  "s/\PETR//g" GCA_025920805.1_Ptraversi_NRM_v1_genomic_upper.fna | head -n 5
  256    sed -s -E  "s/\sPETR[A-Z0-9.\s]+//g" GCA_025920805.1_Ptraversi_NRM_v1_genomic_upper.fna | head -n 5
  271    sed  's/PETR.*//' GCA_025920805.1_Ptraversi_NRM_v1_genomic_upper.fna | head -n 5
  276    sed  's/\sPETR.*//' GCA_025920805.1_Ptraversi_NRM_v1_genomic_upper.fna | tr [:lower:] [:upper:] | tr N A  > GCA_025920805.1_Ptraversi_NRM_v1_genomic_upper_short.fna
  278  samtools faidx GCA_025920805.1_Ptraversi_NRM_v1_genomic_upper_short.fna 
  293  less -S  final.recode.vcf | sed -E  's/JAHLSL[0-9.]+/test/' | head -20000  | tail | less -S
  294  less -S  final.recode.vcf | sed -E  's/JAHLSL[0-9.]+/test/'  > final_recode_test.vcf
  295  grep "#" final_recode_test.vcf > prefix.vcf
  296  grep -v "#" final_recode_test.vcf > suffix.vcf
  311  awk '{ $2 = NR; print }' suffix.vcf  | awk '{ $4 = "A"; print}' | awk '{ $5 = "T"; print}' | less -S  > suffix_clean.vcf
  312  cat prefix.vcf suffix_clean.vcf  > test_clean.vcf 
  322  awk '{ $2 = NR; print }' suffix.vcf  | awk '{ $4 = "A"; print}' | awk '{ $5 = "T"; print}'   > suffix_clean.vcf
  323  awk '{ $2 = NR; print }' suffix.vcf  | awk '{ $4 = "A"; print}' | awk '{ $5 = "T"; print}'   | cat prefix.vcf - > vcf_clean.vcf
  324  vcftools --vcf vcf_clean.vcf 
  325  vcftools --vcf vcf_clean.vcf --max-missing 1 --recode 
  326  vcftools --vcf vcf_clean.vcf --max-missing 1.0 --recode 
  327  vcftools --vcf vcf_clean.vcf 
  328  less vcf_clean.vcf 
  329  vcftools --vcf vcf_clean.vcf --het
  330  less out.het 
  331  awk '{ $2 = NR; print }' suffix.vcf     | cat prefix.vcf - > vcf_clean.vcf
  332  vcftools --vcf vcf_clean.vcf --het
  333  less out.het 
  334  vcftools --vcf final.recode.vcf  --max-missing 1.0 --recode
  335  less -S  final.recode.vcf | sed -E  's/JAHLSL[0-9.]+/test/'  > final_recode_test.vcf
  336  vcftools --vcf final_recode_test.vcf --max-missing 1.0 --recode
  339  grep  -v "#" final_recode_test.vcf >2.vcf 
  340  grep   "#" final_recode_test.vcf >1.vcf 
  341  cat 1.vcf 2.vcf > 3.vcf
  342  vcftools --vcf 3.vcf  --max-missing 1.0 --recode
  343  grep  -v "#" final_recode_test.vcf > suffix.vcf 
  344  less suffix.vcf 
  345  awk '{ $2 = NR; print }' suffix.vcf     | cat prefix.vcf - > vcf_clean.vcf
  346  vcftools --vcf vcf_clean.vcf  --max-missing 1.0 --recode
  347  cat suffix.vcf     | cat prefix.vcf - > vcf_clean.vcf
  348  vcftools --vcf vcf_clean.vcf  --max-missing 1.0 --recode
  359  awk '{ $2 = NR; print }' suffix.vcf   | sed -s 's/\s/\t/g'  | cat prefix.vcf - > vcf_clean.vcf
  360  cat -E vcf_clean.vcf | tr "\t" "*" | grep -v "#" | less -S
  362  head -20000 vcf_clean.vcf  > test_clean.vcf
  367  vcftools --vcf test_clean.vcf --max-missing 1.0 --recode
  369  cat -E vcf_clean.vcf | tr "\t" "*" | grep -v "#" | less -S
 373  grep -v "#" final.recode.vcf | cut -f 1-2 > outrgoup_from_final_recode_vcf.txt

```




Prepare black robin genome to be read by SLiM
```

```



SLiM code
```
//recipe 19.12 + 16.11


initialize() {
	setSeed(10);
	defineConstant("K", 300);       // carrying capacity
	defineConstant("R_AGE_M", 1);   // minimum age of reproduction (male)
	defineConstant("R_AGE_F", 1);   // minimum age of reproduction (female)
	defineConstant("FECUN", 2.48);   // from paper
	
	initializeSLiMModelType("nonWF");
	initializeSLiMOptions(nucleotideBased=T);
	
	initializeSex();
	
	
	// Load real genome
	length = initializeAncestralNucleotides("realblackrobin.fa");
	defineConstant("L", length);  //makes the length the same as the .fa
	
	// Neutral mutation type
	initializeMutationTypeNuc("m1", 0.5, "f", 0.0); //all neutral mutations
	
	// Jukes–Cantor mutation model
	initializeGenomicElementType("g1", m1, 1.0, mmJukesCantor(2.3e-9)); //create mutations, based on collared flycatcher
	initializeGenomicElement(g1, 0, L-1);
	
	// Recombination
	//initializeRecombinationRate(1e-8); //pre-set recombination rate in SLiM
	initializeRecombinationRate(0.5); //shuffle alleles; sexual reproduction recombination

}


1 first() {
	sim.addSubpop("p1", 39); //changes based on the number of individuals in the VCF
	p1.haplosomes.readHaplosomesFromVCF("8pur.recode.vcf", m1); //VCF changes based on the group I'm running
	p1.individuals.age = rdunif(39, min=0, max=3); //must reflect number of indivs in the VCF, all indivs are randomly assigned 0-3 years old
	p1.individuals.tag = -1;
	
	// Create a log file for heterozygosity and other metrics
	hetFile = community.createLogFile("pur8_fecun5.csv"); //name of output file that gives observed H
	
	// Log every generation
	hetFile.setLogInterval(1);
	
	// Tick number
	hetFile.addTick();
	
	// Mean pairwise heterozygosity
	hetFile.addCustomColumn("mean_pairwise_het", "meanPairwiseHet();"); 
	
	// Population size
	hetFile.addPopulationSize();
	
	// Store handle
	sim.setValue("hetFile", hetFile);
	
	heterozygosity = calcHeterozygosity(p1.haplosomes);
	cat("Mean E heterozygosity init = " + heterozygosity + "\n");
}

function (f) meanPairwiseHet(void) {
	inds = p1.individuals;
	n = size(inds);
	hets = float(n);
	for (i in 0:(n-1)) {
		ind = inds[i];
		hets[i] = calcPairHeterozygosity(ind.haploidGenome1, ind.haploidGenome2);
	}
	return(mean(hets));
}



//largely unchanged from the SLiM manual
first() {
	// find mated individuals whose mate has died, and mark them as unmated
	mated_individuals = p1.individuals;
	mated_individuals = mated_individuals[mated_individuals.tag >= 0];
	
	if (size(mated_individuals) > 0)
	{
		tags = mated_individuals.tag;
		tag_counts = tabulate(tags);
		tags_to_fix = which(tag_counts == 1);
		unmated_indices = match(tags_to_fix, tags);
		mated_individuals[unmated_indices].tag = -1;
	}
	
	// find the next tag value to use for new mating pairs
	next_tag = max(p1.individuals.tag) + 1;
	
	// find unmated individuals that are of reproductive age
	unmated_F = p1.subsetIndividuals(sex="F", tag=-1, minAge=R_AGE_F);
	unmated_M = p1.subsetIndividuals(sex="M", tag=-1, minAge=R_AGE_M);
	
	// pair individuals randomly; some individuals may be left unpaired
	pair_count = min(size(unmated_F), size(unmated_M));
	unmated_F = sample(unmated_F, pair_count, replace=F);
	unmated_M = sample(unmated_M, pair_count, replace=F);
	
	for (f in unmated_F, m in unmated_M, tag in seqLen(pair_count) + next_tag)
	{
		f.tag = tag;
		m.tag = tag;
	}
}

reproduction() {
	// find the subset of individuals that have a mate
	mated_F = p1.subsetIndividuals(sex="F");
	mated_F = mated_F[mated_F.tag >= 0];
	
	mated_M = p1.subsetIndividuals(sex="M");
	mated_M = mated_M[mated_M.tag >= 0];
	
	// look up the male for each female, by tag
	male_indices = match(mated_F.tag, mated_M.tag);
	mated_M = mated_M[male_indices];
	
	pair_count = size(mated_F);
	
	// produce offspring from each mated pair
	for (f in mated_F,
		m in mated_M,
		c in rpois(pair_count, FECUN),
		new_tag in seqLen(pair_count))
	{
		// re-tag paired individuals to compact tags down
		f.tag = new_tag;
		m.tag = new_tag;
		
		offspring = p1.addCrossed(f, m, count=c);
		offspring.tag = -1;	// mark offspring as unmated
	}
	
	self.active = 0;		// deactivate for the rest of the tick ("big bang")	
}


early() {
	// density-dependent population regulation
	p1.fitnessScaling = K / p1.individualCount;
	
	//individuals older than 3 die
	old = p1.individuals[p1.individuals.age > 3];
	old.fitnessScaling = 0.0;
}




100 late() {
	heterozygosity = calcHeterozygosity(p1.haplosomes);
	cat("Mean E heterozygosity after = " + heterozygosity + "\n");
	
	//	p1.haplosomes.outputHaplosomesToVCF("ptm6nm.seed5.vcf"); //if you want to save the end of the SLiM run as a new VCF
	
	sim.simulationFinished();
}
