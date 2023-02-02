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