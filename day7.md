
paper we work on: https://www.tandfonline.com/doi/full/10.1080/15476286.2017.1306170\

for what words to search when a paper is on RNA seq? ncbi, sra, accession -> shows which strains where used when u click on SRA Number \
(link under accession in paper: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE85456)\
(next step link under SRA [in the new window]: https://www.ncbi.nlm.nih.gov/sra?term=SRP081251)\
find out if they used paired or single end synthesis: strg F -> single or paired

SRR: every sample has a unique SRR -ID, so here: 4 SRR numbers\
(https://www.ncbi.nlm.nih.gov/sra/SRX2012146[accn]) <- SRR number unten in Tabelle unter Run

**SRR numbers of the tutorial:**\
#14 und 15= wildtype replicate 1 und 2\
SRR4018514\
SRR4018515\
#deletion mutant replicate 1 und 2\
SRR4018516\
SRR4018517


first activate conda environment on your HPC

    conda activate /home/sunam226/.conda/envs/grabseq

try with grabseq, to automatically asign metadata information to each SRR number

    grabseqs -t 4 -m metadata.csv SRR***

*-t threads for parallel running\
-m verknüpft die metadata des papers mit den SRR numbers, also welche SRRnumber welches replicate ist und wildtype oder mutant*

weeeeeeeeeeeell\
that didn't work

on front end:\

    fasterq-dump SRR4018514 SRR4018515 SRR4018516 SRR4018517

than we have to assign the shit manually\
yay

download the metadata.csv

    grabseqs sra -l -t 4 -m metadata.csv SRP081251
*SRP number= project number*\
*-l =driver ????*\
contains only 3 out of 4 samples

metadata für jetzt ziemlich unwichtig\
als nächstes fastqc 

## fastqc

    sbatch fastqc.sh

hier batch script verlinken\
dann einen Ordner machen und die ganzen html files zu einer zusammenfassen\
das vor allem praktisch wenn man arsch viele html hat

    mkdir multiqc_output
    multiqc -d . -o multiqc_output 

wenn wir dieses html im browser öffnen kann man unter Sequence Quality Histograms sehen, wie die phred scores von allen 4 aussehen\
anhand dieser scores entscheiden wir, ob wir die reads reinigen müssen\
müssen wir hier nicht, weil alle phred scores über 25 sind, also sind die reads schon cleaned

müssten wir das machen, würden wir folgenden loop nehmen im batch script

    for i in *.fastq.gz; do fastp -i $i -o ${i}_cleaned.fastq.gz -h ../qc_reports/${i}_fastp.html -j ${i}_fastp.json -w 4 -q 20 -z 4; done

--html creates an .html report file in html format\
-i input file name\
-R report title, here ‘_report’ is added to each file\
-o output_folder.fastq.gz output file\
-t trim tail 1, default is 0, here 6 bases are trimmed\
-q 20 reads with a phred score of <=20 are trimmed -zcompression level for gzip output (1 ~ 9). 1 is fastest, 9 is smallest, default is 4. (int [=4]) Generating multiqc report can help us further:

dann könnten wir das wieder zusammenfassen mit

    multiqc -d . -o multiqc_output 

---

## important files in rna seq

FASTA : only sequence \
FASTQ : sequence and quality scores \
GFF/GTF : with gene annotations

---

## preparation thoughts

1. more replicates in lab or more read depth/coverage?\
    more replicates
2. how many replicates?\
    3 is fine as a starting point, bc u can calculate mean and SD from that and remove Ausreißer, u can do  more when u have the money for it 
3. read length\
    for single end 50bp and for paired end 100bp as minimum, don't go over 300bp
4. paired end read or single end read?\
    paired end reads help in mapping bc the distance between both read starting points is known -> higher confidence is our data

---

## READemption

1. fragmentation of RNA
2. sequencing (FASTQ)
3. alignment to reference genome (FASTA and GFF)
4. annotate genes
5. 


activate the reademption environment

    conda activate /home/sunam226/.conda/envs/reademption

check list of programs in reademption environment

    conda list

erstmal mit folgendem command eine directory erstellen, diese hat arschviele subdirs, alle leer

    reademption create --project_path READemption_analysis --species Methanosarcina="Methanosarcina mazei"

---project_path give project a name
--species what organism am I working with

**in input dir:**\
reads -> put fastq reads here\
reference sequence -> put fasta file of reference genome here\
annotations -> put GFF file of reference genome here

von origin dir aus: (das kreiert einfach nur die ZUweisung, dass wannimmer FTP_SOURCE in irgendeinem code steht [siehe unten], der folgende link gemeint ist)

    FTP_SOURCE=ftp://ftp.ncbi.nih.gov/genomes/archive/old_refseq/Bacteria/Salmonella_enterica_serovar_Typhimurium_SL1344_uid86645/

download the fasta files from the reference genome (auch alles von origin dir aus)

    wget -O READemption_analysis/input/salmonella_reference_sequences/NC_016810.fa $FTP_SOURCE/NC_016810.fna
    wget -O READemption_analysis/input/salmonella_reference_sequences/NC_017718.fa $FTP_SOURCE/NC_017718.fna
    wget -O READemption_analysis/input/salmonella_reference_sequences/NC_017719.fa $FTP_SOURCE/NC_017719.fna
    wget -O READemption_analysis/input/salmonella_reference_sequences/NC_017720.fa $FTP_SOURCE/NC_017720.fna

download the GFF file:

    wget -P READemption_analysis/input/salmonella_annotations https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/210/855/GCF_000210855.2_ASM21085v2/GCF_000210855.2_ASM21085v2_genomic.gff.gz

unzip the just downloaded GFF file

    gunzip READemption_analysis/input/salmonella_annotations/GCF_000210855.2_ASM21085v2_genomic.gff.gz


- open the fasta files and the GFF file (GFF starts with sth liek NC_..., but fasta starts with sth like gi|386730659|ref|NC_...)
- either delete the gi|386730659|ref| in the fasta files manually
- OR run the following code to change the header of the fasta files

    sed -i "s/>/>NC_016810.1 /" READemption_analysis/input/salmonella_reference_sequences/NC_016810.fa
    sed -i "s/>/>NC_017718.1 /" READemption_analysis/input/salmonella_reference_sequences/NC_017718.fa
    sed -i "s/>/>NC_017719.1 /" READemption_analysis/input/salmonella_reference_sequences/NC_017719.fa
    sed -i "s/>/>NC_017720.1 /" READemption_analysis/input/salmonella_reference_sequences/NC_017720.fa

when the reference genome headers (so fasta and GFF) are not the same, the whole shit won't work

now download the raw reads:

    wget -P READemption_analysis/input/reads http://reademptiondata.imib-zinf.net/InSPI2_R1.fa.bz2
    wget -P READemption_analysis/input/reads http://reademptiondata.imib-zinf.net/InSPI2_R2.fa.bz2
    wget -P READemption_analysis/input/reads http://reademptiondata.imib-zinf.net/LSP_R1.fa.bz2
    wget -P READemption_analysis/input/reads http://reademptiondata.imib-zinf.net/LSP_R2.fa.bz2

(these raw reads can stay zipped)\
congratulation, now u have all the input files u need

## alignment

make a .bash file in origin dir for the first step = alignment of the raw reads to the reference genome

```
#!/bin/bash
#SBATCH --job-name=reademption
#SBATCH --output=reademption.out
#SBATCH --error=reademption.err
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=12G
#SBATCH --qos=long
#SBATCH --time=0-05:00:00
#SBATCH --partition=all
#SBATCH --export=NONE
#SBATCH --reservation=biol217

#show the script its a bash file
source ~/.bashrc

#activating conda
module load miniconda3/4.7.12.1

#activate reademption environment
conda activate /home/sunam226/.conda/envs/reademption

#align the reads + cleaning mit poly_a_clipping
reademption align -p 4 --poly_a_clipping --project_path READemption_analysis


jobinfo
```

then run\
sbatch [reademption.bash](docs/reademption.bash)

the whole bash script is [here](docs/huiii.bash)\
*when u have 4 files, choose 4 CPUs*

