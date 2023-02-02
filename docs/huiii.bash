#!/bin/bash
#SBATCH --job-name=reademption
#SBATCH --output=reademption.out
#SBATCH --error=reademption.err
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --qos=long
#SBATCH --time=0-05:00:00
#SBATCH --partition=all
#SBATCH --export=NONE
#SBATCH --reservation=biol217

#show the script its a bash file
source ~/.bashrc

#activating conda
module load miniconda3/4.7.12.1

#activate reademption environment
conda activate /home/sunam226/.conda/envs/reademption

#align the raw reads to the reference + cleaning mit poly_a_clipping
reademption align -p 4 --poly_a_clipping --project_path READemption_analysis

#coverage analysis
reademption coverage -p 4 --project_path READemption_analysis

#gene quantification 
reademption gene_quanti -p 4 --features CDS,tRNA,rRNA --project_path READemption_analysis

#differential expression
reademption deseq -l InSPI2_R1.fa.bz2,InSPI2_R2.fa.bz2,LSP_R1.fa.bz2,LSP_R2.fa.bz2 -c InSPI2,InSPI2,LSP,LSP -r 1,2,1,2 --libs_by_species salmonella=InSPI2_R1,InSPI2_R2,LSP_R1,LSP_R2 --project_path READemption_analysis
#-l list all raw read files, seperated with comma


#####make plots

#visualize alignment
reademption viz_align --project_path READemption_analysis

#visualize gene quantification
reademption viz_gene_quanti --project_path READemption_analysis

#visualize differential expression
reademption viz_deseq --project_path READemption_analysis

#deactivate conda
conda deactivate


jobinfo