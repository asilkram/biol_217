#!/bin/bash
#SBATCH --job-name=pub_data
#SBATCH --output=pub_data.out
#SBATCH --error=pub_data.out
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH	--qos=long
#SBATCH --time=0-05:00:00
#SBATCH --partition=all
#SBATCH --reservation=biol217

source ~/.bashrc

#load conda
module load miniconda3/4.7.12.1

#load python
module load python/3.7.4

#activate reademption environment
conda activate /home/sunam226/.conda/envs/reademption
################################### ---CALCULATIONS---
#aligning:
reademption align --fastq -f READemption_analysis --poly_a_clipping --min_read_length 12 --segemehl_accuracy 95  

# coverage:
reademption coverage -p 4 --project_path READemption_analysis 

#gene wise quanty:
reademption gene_quanti -p 4 --features CDS,tRNA,rRNA --project_path READemption_analysis 

#differential gene expression:
#(hier Unterschied zu gestern, fa statt fastq)
#bei der Aufzählung immer treatment zuerst und dann Kontrolle, also erst mut und dann wt
reademption deseq -l mut_r1.fa,mut_r2.fa,wt_r1.fa,wt_r2.fa -c mut,mut,wt,wt \
	-r 1,2,1,2 --libs_by_species Methanosarcina=mut_r1,mut_r2,wt_r1,wt_r2 --project_path READemption_analysis

############################## ---PLOTS---
reademption viz_align --project_path READemption_analysis
reademption viz_gene_quanti --project_path READemption_analysis
reademption viz_deseq --project_path READemption_analysis
conda deactivate
jobinfo