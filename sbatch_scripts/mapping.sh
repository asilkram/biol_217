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
