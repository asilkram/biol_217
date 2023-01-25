# Day 2

## preparation conda und anvio laden

`load miniconda`\
#module avail\
#dann conda version aussuchen\
```
module load miniconda3/4.7.12.1
```

`conda activate anvio`\
#conda von sunam226 holen:\
```
conda activate /home/sunam226/.conda/envs/anvio
```


## bash script

#!/bin/bash\
#SBATCH --nodes=1\
#SBATCH --cpus-per-task=4\
#SBATCH --mem=10G\
#SBATCH --time=1:00:00\
#SBATCH --job-name=fastqc\
#SBATCH --output=/work_beegfs/sunam233/fastqc.out\
#SBATCH --error=/work_beegfs/sunam233/fastqc.err\
#SBATCH --partition=all\
#SBATCH --reservation=biol217


#load conda
module load miniconda3/4.7.12.1

#conda activate anvio
conda activate /home/sunam226/.conda/envs/anvio

#commands are printed into the log
set -xu


#Finish each script with this (prints Done and a Unicorn into your logile), then you know everything has run through
echo "Done removing"

printf '\U1F984\n'

#this prints the required resources into your logfile
jobinfo

----
`eigene notes zum script oben`\
#erste line nicht verändern\
#nodes auch erstmal nicht verändern (ob parallel oder nicht)\
#jobname anpassen fastqc zu was auch immer\
#basically: line 6-8 anpassen\
#partition auch strukturellen PC_Hintergrund\
#reservation so lassen, ist der HPC reserviert für diesen Kurs,damit das nicht mit allen anderen interferiert

---
`batch script submitten`\
ohne die Klammern
```
sbatch <jobscript> 
```

`gucken wo in der WArteschlange mein script ist`
```
squeue -u sunam233
```

`abbrechen`
```
scancel <jobid>
```

---

# fastqc

```
module load fastqc
```

für ein einzelnes file
```
fastqc file.gz -o output_folder/ 
```

for-loop für alle gz files
```
for i in *.gz; do fastqc $i -o output_folder/; done
```

# fastp

```
fastp -i sample1_R1.fastq.gz -I sample1_R2.fastq.gz -R fastp_report -o sample1_R1_clean.fastq.gz -O sample1_R2_clean.fastq.gz -t 6 -q 20
```

R1 und R2 sind in diesem Fall hier for und rev read derselben sequence (paired end sequncing)\

`-q` gibt ab ab welchem phred wert (darunter) alles rausgefiltert wird (20 guter wert weil hier Sicherheit, dass richtige Base bei 99%)


oder als loop

```
for i in `ls *_R1.fastq.gz`;
do
    second=`echo ${i} | sed 's/_R1/_R2/g'`
    fastp -i ${i} -I ${second} -R _report -o output_folder/"${i}" -O output_folder/"${second}" -t 6 -q 20

done
```


----

**html zum Kursskript:**

https://github.com/AammarTufail/Bioinformatics_Master_Module2023/blob/main/Day-2/Tutorial_Day2.md
