#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=taxonomy_assignment
#SBATCH --output=/work_beegfs/sunam233/Day5/taxonomy_assignment.out
#SBATCH --error=/work_beegfs/sunam233/Day5/taxonomy_assignment.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
module load miniconda3/4.7.12.1


#conda activate anvio
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1

#create a taxonomic assignment of 
anvi-run-scg-taxonomy -c /work_beegfs/sunam233/Day5/contigs.db -T 20 -P 2

#nachricht, die erscheint, wenn der job durch ist
echo "fertisch"
