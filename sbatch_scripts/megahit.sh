#!/bin/sh
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=megahit
#SBATCH --output=/work_beegfs/sunam233/day2/megahit.out
#SBATCH --error=/work_beegfs/sunam233/day2/megahit.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
module load miniconda3/4.7.12.1


#conda activate anvio
conda activate /home/sunam226/.conda/envs/anvio


#in dir gehen, wo die reads drin sind
cd /work_beegfs/sunam233/day2/clean_reads

                                       
megahit -1 BGR_130305_R1_clean.fastq.gz -1 BGR_130527_R1_clean.fastq.gz -1 BGR_130708_R1_clean.fastq.gz -2 BGR_130305_R2_clean.fastq.gz -2 BGR_130527_R2_clean.fastq.gz -2 BGR_130708_R2_clean.fastq.gz --min-contig-len 1000 --presets meta-large -m 0.85 -o /work_beegfs/sunam233/day2/megahit/"$i" -t 20                      

#nachricht, die erscheint, wenn der job durch ist
echo "mega_der_hit_alter"