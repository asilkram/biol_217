#!/bin/sh
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=metaquast
#SBATCH --output=/work_beegfs/sunam233/day3/3_coassembly/metaquast.out
#SBATCH --error=/work_beegfs/sunam233/day3/3_coassembly/metaquast.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
#module load miniconda3/4.7.12.1


#conda activate anvio
#conda activate /home/sunam226/.conda/envs/anvio


#in dir gehen, wo die reads drin sind
#cd /work_beegfs/sunam233/day3/3_coassembly/


#
metaquast -t 6 -o /work_beegfs/sunam233/day3/3_coassembly/metaquast_output/ -m 1000 final.contigs.fa


#nachricht, die erscheint, wenn der job durch ist
echo "fertisch"
