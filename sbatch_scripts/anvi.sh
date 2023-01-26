#!/bin/sh
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=anvio_contigs_db_creation
#SBATCH --output=/work_beegfs/sunam233/day3/4_mapping/anvio_contigs_db_creation.out
#SBATCH --error=/work_beegfs/sunam233/day3/4_mapping/anvio_contigs_db_creation.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
#module load miniconda3/4.7.12.1


#conda activate anvio
conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1


#in dir gehen, wo die reads drin sind
cd /work_beegfs/sunam233/day3/4_mapping



anvi-gen-contigs-database -f contigs.anvio.fa -o contigs.db -n 'biol217'

#nachricht, die erscheint, wenn der job durch ist
echo "fertisch"
