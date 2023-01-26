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
