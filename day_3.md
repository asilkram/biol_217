# day 3

## binning
### which contigs belong to which genome


sequence completion
=k-mer frequencies are similiar within one genome\
Ausnahme: rRNA (highly conserved) + genomic islands (foreign DNA) will probably stand out

multiple sample coverage
=coverage of contigs changes similiary in different samples when they belong to the same genome


---

## quality parameters to check afterwards

- contamination (multiple copies of single copy genes)
- completion of the genome (presence or absence of single copy genes)
- fragmentation (how many contigs form one genome, more contigs=more fragmented)
- heterogenicity 


---

[Hier](https://github.com/AammarTufail/Bioinformatics_Master_Module2023/blob/main/Day-3/Tutorial_Day3.md) ist der link zum heutigen Kursskript

---

## check how many final contigs there are

```
grep -c ">" final.contigs.fa
```

(every contig starts with >, deswegen danach suchen sinnvoll)


conda aktivieren
```
conda activate /home/sunam226/.conda/envs/anvio
```

aus fasta file fastg file machen, denn damit möchte Bandage gefüttert werden:
```
megahit_toolkit contig2fastg 99 final.contigs.fa > final.contigs.fastg
```


das wunderschöne [Bild](sexy_pics/graph_also.png), was Bandage kreiert hat, zeigt die contigs\
*Schleifen in Abbildung zeigen die bubbles der De-Bruijn-Graphen*

anschließend folgendes batch script laufen lassen
```
#!/bin/sh
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=metaquast
#SBATCH --output=/work_beegfs/sunam233/day3/3_coassembly/metaquast.out
#SBATCH --error=/work_beegfs/sunam233/day3/3_coassembly/metaquast.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
#module load miniconda3/4.7.12.1


#conda activate anvio
#conda activate /home/sunam226/.conda/envs/anvio


#in dir gehen, wo die reads drin sind
#cd /work_beegfs/sunam233/day3/3_coassembly/


#
metaquast -t 6 -o /work_beegfs/sunam233/day3/3_coassembly/metaquast_output/ -m 1000 final.contigs.fa


#nachricht, die erscheint, wenn der job durch ist
echo "fertisch"
```

(in der theorie, denn das dauert ewig und deswegen haben wirs am Ende von Cynthia kopiert mit:
```
cp -r /home/sunam226/Day3/3_metaquast_out/* /work_beegfs/sunam233/day3/3_metaquast/

```
)


## **Interpretation der Statistik**

- What is your N50 value? Why is this value relevant?\
`N50` Erlärung [hier](https://www.metagenomics.wiki/tools/assembly/n50) -> contigs, die so lang oder länger sind, machen die Hälfte des genomes aus


- How many contigs are assembled?\
  57414

- What is the total length of the contigs?\
  145675865 bases in the assembly

---
# binning

## reformating fasta into anvio fasta format
batch script:
```
#!/bin/sh
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=anvio_format
#SBATCH --output=/work_beegfs/sunam233/day3/3_coassembly/anvio_format.out
#SBATCH --error=/work_beegfs/sunam233/day3/3_coassembly/anvio_format.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
#module load miniconda3/4.7.12.1


#conda activate anvio
#conda activate /home/sunam226/.conda/envs/anvio


#in dir gehen, wo die reads drin sind
#cd /work_beegfs/sunam233/day3/3_coassembly/


#
anvi-script-reformat-fasta final.contigs.fa -o /work_beegfs/sunam233/day3/4_mapping/contigs.anvio.fa --min-len 1000 --simplify-names --report-file name_conversion.txt


#nachricht, die erscheint, wenn der job durch ist
echo "fertisch"
```

### dann anvio fasta zu index files

```
#!/bin/sh
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=mapping
#SBATCH --output=/work_beegfs/sunam233/day3/3_coassembly/mapping.out
#SBATCH --error=/work_beegfs/sunam233/day3/3_coassembly/mapping.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
#module load miniconda3/4.7.12.1


#conda activate anvio
#conda activate /home/sunam226/.conda/envs/anvio


#make anvio fasta files to index files
bowtie2-build /work_beegfs/sunam233/day3/4_mapping/contigs.anvio.fa /work_beegfs/sunam233/day3/4_mapping/contigs.anvio.fa.index


#nachricht, die erscheint, wenn der job durch ist
echo "fertisch"
```


### for loop zum mapping

```
#!/bin/sh
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=mapping_loop
#SBATCH --output=/work_beegfs/sunam233/day3/3_coassembly/mapping_loop.out
#SBATCH --error=/work_beegfs/sunam233/day3/3_coassembly/mapping_loop.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
#module load miniconda3/4.7.12.1


#conda activate anvio
#conda activate /home/sunam226/.conda/envs/anvio



#change directory to where the fastq.gz files are
cd /work_beegfs/sunam233/day3/2_fastp/


#for-loop
for i in `ls *mapped_R1.fastq.gz`;
do
    second=`echo ${i} | sed 's/_R1/_R2/g'`
    bowtie2 --very-fast -x /work_beegfs/sunam233/day3/4_mapping/contigs.anvio.fa.index -1 ${i} -2 ${second} -S /work_beegfs/sunam233/day3/4_mapping/"$i".sam 
done

#nachricht, die erscheint, wenn der job durch ist
echo "fertisch"
```


### convert sam to bam files
```
#!/bin/sh
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=sam_to_bam
#SBATCH --output=/work_beegfs/sunam233/day3/3_coassembly/sam_to_bam.out
#SBATCH --error=/work_beegfs/sunam233/day3/3_coassembly/sam_to_bam.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
#module load miniconda3/4.7.12.1


#conda activate anvio
#conda activate /home/sunam226/.conda/envs/anvio

#load module
module load samtools 

#change directory to where the fastq.gz files are
cd /work_beegfs/sunam233/day3/4_mapping/


#for-loop
for i in *.sam; do samtools view -bS $i > "$i".bam; done

#nachricht, die erscheint, wenn der job durch ist
echo "fertisch"
```
