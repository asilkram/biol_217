#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=create_anvio_profile
#SBATCH --output=/work_beegfs/sunam233/day3/5_anvio_profiles/create_anvio_profile.out
#SBATCH --error=/work_beegfs/sunam233/day3/5_anvio_profiles/create_anvio_profile.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
module load miniconda3/4.7.12.1


#conda activate anvio
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1


#in dir gehen, wo die reads drin sind
cd /work_beegfs/sunam233/day3/5_anvio_profiles

#create dir for output
mkdir /work_beegfs/sunam233/day3/5_anvio_profiles/profiling/

#for loop to create anvio profil from every sorted.bam file
for i in `ls *.sorted.bam | cut -d "." -f 1`; do anvi-profile -i "$i".sam.bam.sorted.bam -c contigs.db -o /work_beegfs/sunam233/day3/5_anvio_profiles/profiling/”$i”; done

#cut -d "." -f 1
#Erklärung:
#zerschnippselt den file name jedes mal, wenn ein Punkt auftaucht und nimmt nur die (-f 1) erste column davon weiter
#das macht Sinn, damit die file extensions nicht immer länger werden


#nachricht, die erscheint, wenn der job durch ist
echo "fertisch"
