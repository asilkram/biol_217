#!/bin/sh
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=fastqc
#SBATCH --output=/work_beegfs/sunam233/day2/fastqc.out
#SBATCH --error=/work_beegfs/sunam233/day2/fastqc.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
module load miniconda3/4.7.12.1


#conda activate anvio
conda activate /home/sunam226/.conda/envs/anvio

#commands are printed into the log
set -xu


# Finish each script with this (prints Done and a Unicorn into your logile), then you know everything has run through
echo "Done removing"

printf '\U1F984\n'

#this prints the required resources into your logfile
jobinfo