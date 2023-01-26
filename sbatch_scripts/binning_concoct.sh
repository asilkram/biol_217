#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=binning_concoct
#SBATCH --output=/work_beegfs/sunam233/day3/5_anvio_profiles/profiling/merged_profiles/binning_concoct.out
#SBATCH --error=/work_beegfs/sunam233/day3/5_anvio_profiles/profiling/merged_profiles/binning_concoct.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
module load miniconda3/4.7.12.1


#conda activate anvio
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1


#in dir gehen, wo die reads drin sind
cd /work_beegfs/sunam233/day3/5_anvio_profiles/profiling/merged_profiles/

#binning with concoct
anvi-cluster-contigs -p PROFILE.db -c /work_beegfs/sunam233/day3/5_anvio_profiles/profiling/contigs.db -C CONCOCT --driver concoct --just-do-it

anvi-summarize -p PROFILE.db -c /work_beegfs/sunam233/day3/5_anvio_profiles/profiling/contigs.db -o SUMMARY_CONCOCT -C CONCOCT

#nachricht, die erscheint, wenn der job durch ist
echo "fertisch"
