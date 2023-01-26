#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=anvio_run_hmm
#SBATCH --output=/work_beegfs/sunam233/day3/5_anvio_profiles/anvio_run_hmm.out
#SBATCH --error=/work_beegfs/sunam233/day3/5_anvio_profiles/anvio_run_hmm.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
module load miniconda3/4.7.12.1


#conda activate anvio
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1


#in dir gehen, wo die reads drin sind
cd /work_beegfs/sunam233/day3/5_anvio_profiles


#create anvi'o contigs-db
anvi-run-hmms -c contigs.db

#nachricht, die erscheint, wenn der job durch ist
echo "fertisch"
