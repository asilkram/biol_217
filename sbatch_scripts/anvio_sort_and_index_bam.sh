#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=anvio_sort_and_index_bam
#SBATCH --output=/work_beegfs/sunam233/day3/5_anvio_profiles/anvio_sort_and_index_bam.out
#SBATCH --error=/work_beegfs/sunam233/day3/5_anvio_profiles/anvio_sort_and_index_bam.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
module load miniconda3/4.7.12.1


#conda activate anvio
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1

#go into dir where the bam files are
cd /work_beegfs/sunam233/day3/4_mapping/

#merges two separate samtools commands (sorting and indexing)
for i in *.bam; do anvi-init-bam $i -o /work_beegfs/sunam233/day3/5_anvio_profiles/"$i".sorted.bam; done


#nachricht, die erscheint, wenn der job durch ist
echo "fertisch"
