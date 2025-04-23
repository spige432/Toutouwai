```
mkdir admixture
cp recode.renamed.vcf ../../admixture/
```
upload vcf2bed.py from https://github.com/Nolan1324/VCF-to-BED
```
python vcf2bed.py -i recode.renamed.vcf    -o admixture.bed
```
 Traceback (most recent call last):

   File "/nesi/nobackup/uoo04226/robins/source_files/admixture/vcf2bed.py", line 31, in "module"
  
     firstTabIndex = line.index('\t');
    
                     ^^^^^^^^^^^^^^^^
                    
 ValueError: substring not found
