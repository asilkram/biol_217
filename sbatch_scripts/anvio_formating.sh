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
