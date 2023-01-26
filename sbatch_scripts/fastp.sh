#!/bin/sh
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=fastp
#SBATCH --output=/work_beegfs/sunam233/fastp.out
#SBATCH --output=/work_beegfs/sunam233/fastp.out
#SBATCH --error=fastp.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
module load miniconda3/4.7.12.1


#conda activate anvio
conda activate /home/sunam226/.conda/envs/anvio


#in dir gehen, wo die reads drin sind
cd /work_beegfs/sunam233/day2/0_raw_reads

#dir für output machen
mkdir ../clean_reads


#for loop fastq
for i in `ls *_R1.fastq.gz`;
do
    second=`echo ${i} | sed 's/_R1/_R2/g'`
    fastp -i ${i} -I ${second} -R _report -o ../clean_reads/"${i}" -O ../clean_reads/"${second}" -t 6 -q 20

done

#nachricht, die erscheint, wenn der job durch ist
echo "fertisch"