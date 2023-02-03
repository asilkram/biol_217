# Metagenome project

## question: wie verändert sich die Besiedlung und deren mikrobielle Zusammensetzung Tasten einer Uni-Laptop-Tastatur im Verlauf eines zweiwöchigen Bioinformatikmoduls?

sampling from: 11 Kurs Tastauren
-vor Erstsampling: cleanen der ganzen Tastatur _ t0
-Abstrich von der ganzen Tastaur
-über verschiedene Zeitpunkte: t0: nach cleanen, t1: nach erstem tag, t2: nach letztem tag

Überlegungen:
-Replication: 11 students
-condition: ein 2wöchiges praktikum
-money: nicht gesagt aber halt voll gut in realistischen Rahmen und so :)
-Time: sampling: 2 Wochen, Analyse: ehm ja

-pilot study to determine whether high or low diversity: test abstrich einer tatstaur und daraufhin bewertung wie krass depth und replication size sein muss

-Abstrich von den ganzer Tastatur, son wisch mit salzwasser (saline rinsed swabs)
-cell disruption mechanic (genogrinder oder precellysis, der bessere genogrinder)
-DNA isolation mit wizard kit

-Illumnina Sequencing, bc we no rich 
-read covergae: at least 100
-negative control sequenzieren -> kit shit etc.
-positive control: mock community, um zu gucken wie gut unsere pipeline ist für etwas dessen ergbenis bekannt ist
-host (human DNA) removal

-quality control: fastqc
-quality enhancement, adapter trimming: fastp
-assembly: coassembly of each 11 samples of one spec. time point
-mapping reads: bowtie
-sorting and indexing: samtools
(-what is our coverage?)
-anvi'o 
    -building contigs db
    -HMM to identify SCG -> comleteness and redundancy
    -to identify taxa:
        -functional annotaion: COG database as reference , DIAMOND as tool (bc faster than BLAST)
        -taxonomy assignmet: CENTRIFUGE
    -anvio interactive for visualization    


