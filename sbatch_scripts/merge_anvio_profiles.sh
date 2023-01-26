#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=merge_anvio_profiles
#SBATCH --output=/work_beegfs/sunam233/day3/5_anvio_profiles/profiling/merge_anvio_profiles.out
#SBATCH --error=/work_beegfs/sunam233/day3/5_anvio_profiles/profiling/merge_anvio_profiles.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
module load miniconda3/4.7.12.1


#conda activate anvio
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1


#in dir gehen, wo die reads drin sind
cd /work_beegfs/sunam233/day3/5_anvio_profiles/profiling

#merge all anvio profiles into one
anvi-merge /work_beegfs/sunam233/day3/5_anvio_profiles/profiling/BGR_130305/PROFILE.db /work_beegfs/sunam233/day3/5_anvio_profiles/profiling/BGR_130527/PROFILE.db /work_beegfs/sunam233/day3/5_anvio_profiles/profiling/BGR_130708/PROFILE.db -o /work_beegfs/sunam233/day3/5_anvio_profiles/profiling/merged_profiles -c /work_beegfs/sunam233/day3/5_anvio_profiles/contigs.db --enforce-hierarchical-clustering

#nachricht, die erscheint, wenn der job durch ist
echo "fertisch"
