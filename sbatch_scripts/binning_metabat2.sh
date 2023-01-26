#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=binning_metabat2
#SBATCH --output=/work_beegfs/sunam233/day3/5_anvio_profiles/profiling/merged_profiles/binning_metabat2.out
#SBATCH --error=/work_beegfs/sunam233/day3/5_anvio_profiles/profiling/merged_profiles/binning_metabat2.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
module load miniconda3/4.7.12.1


#conda activate anvio
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1


#in dir gehen, wo die reads drin sind
cd /work_beegfs/sunam233/day3/5_anvio_profiles/profiling/merged_profiles/

#binning with metabat2
anvi-cluster-contigs -p PROFILE.db -c /work_beegfs/sunam233/day3/5_anvio_profiles/contigs.db -C METABAT --driver metabat2 --just-do-it --log-file log-metabat2

anvi-summarize -p PROFILE.db -c /work_beegfs/sunam233/day3/5_anvio_profiles/contigs.db -o SUMMARY_METABAT -C METABAT

#nachricht, die erscheint, wenn der job durch ist
echo "fertisch"
