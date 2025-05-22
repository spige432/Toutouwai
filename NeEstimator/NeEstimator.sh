#!/bin/sh

#subsample records from a vcf and output both a vcf and a genepop, as well as a linkage group file as an input for NeEstimator ]
###USAGE:
#NeEstimator.sh vcf numberofsnps outputfolder #
###Example usage:
#./NeEstimator.sh test.vcf 10000 test/ # do not forget the forward slash
echo $1
echo $2
vcf=$1
nsnps=$2
outputfolder=$3
#type=


mkdir -p  $outputfolder
basename=$(basename $vcf)


echo "running NeEstimator in the folder "  




#create the vcf
echo "creating VCFs..."
head -n 50000 $vcf | grep "^#" > $outputfolder'/headersvcf'
cat $vcf | grep -v  "^#"| shuf -n $nsnps | cat $outputfolder'/headersvcf' - > $outputfolder$basename'_'$nsnps'.vcf'
echo "created VCFs"


echo "creating genepop file (.dat)..."
perl ~/private/scripts/Negotland_clean/vcf2genepop.pl  vcf=$outputfolder$basename'_'$nsnps'.vcf' pops="all"  | sed  "s/$basename'_'$nsnps'.vcf/$basename'_'$nsnps'.vcf\n/" - > $outputfolder$basename'_'$nsnps'.dat'
echo "created genepop file (.dat)"
python ~/private/scripts/Negotland_clean/quickfixpop.py $outputfolder$basename'_'$nsnps'.dat' # the vcf2genepop.pl does not do exactly what I want so I patch it as my perl is bad


echo "creating LINKAGEFILE..."
python ~/private/scripts/Negotland_clean/createlinkagefileNeestimator.py $outputfolder$basename'_'$nsnps'.dat'	
echo "created LINKAGEFILE"

echo "creating INFO AND OPTIONFILE..."
sh  ~/private/scripts/Negotland_clean/createinfoandoptionforNeEstimator.sh $outputfolder $basename'_'$nsnps'.dat' $basename'_'$nsnps'LINKAGE.txt'
echo "created 'info' AND 'option'"


echo "running NeEstimator"
Ne2-1L i:$outputfolder/info o:$outputfolder/option
echo "DONE"
