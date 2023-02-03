#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=anvi-summarize
#SBATCH --output=/work_beegfs/sunam233/Day5/anvi-summarize.out
#SBATCH --error=/work_beegfs/sunam233//Day5/anvi-summarize.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
module load miniconda3/4.7.12.1


#conda activate anvio
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1


#in dir gehen, wo die reads drin sind
cd /work_beegfs/sunam233/Day5/


anvi-summarize -c /work_beegfs/sunam233/Day5/contigs.db -p /work_beegfs/sunam233/Day5/5_anvio_profiles/merged_profiles/PROFILE.db -C consolidated_bins -o SUMMARY --just-do-it



#nachricht, die erscheint, wenn der job durch ist
echo "fertisch"


