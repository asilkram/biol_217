#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=gunc
#SBATCH --output=/work_beegfs/sunam233/Day5/archaea_bin_refinement/gunc.out
#SBATCH --error=/work_beegfs/sunam233/Day5/archaea_bin_refinement/gunc.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
module load miniconda3/4.7.12.1


#conda activate anvio
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1

#activate gunc
conda activate /home/sunam226/.conda/envs/gunc

#in dir gehen und subdir für output machen
cd /work_beegfs/sunam233/Day5/archaea_bin_refinement
mkdir GUNC

#for loop für gunc
for i in *.fa; do gunc run -i "$i" -r /home/sunam226/Databases/gunc_db_progenomes2.1.dmnd --out_dir GUNC --threads 10 --detailed_output; done

#nachricht, die erscheint, wenn der job durch ist
echo "fertisch"
