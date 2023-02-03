# day 5
## batch script for gunc

```
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

#go to dir of interest and create new dir named GUNC
cd /work_beegfs/sunam233/Day5/archaea_bin_refinement
mkdir GUNC

#for loop for gunc
for i in *.fa; do gunc run -i "$i" -r /home/sunam226/databases/gunc_db_progenomes2.1.dmnd --out_dir GUNC --threads 10 --detailed_output; done
```

## gunc output 

Questions:

    Do you get bins that are chimeric?
    - there seem to be some in Bin_Bin_1_sub (CSS is kingdom to class near 1 and pass.GUNC is FALSE), Bin_METABAT__25 looks fine
    Explain what is a chimeric bin.
    - a chimeric bin contains contigs of not one but two or more genomes and was therefore faulty binned
    
  
## step I couldn't do with putty
### interactive anvi'o bin refinement
  
```
srun --reservation=biol217 --pty --mem=10G --nodes=1 --tasks-per-node=1 --cpus-per-task=1 /bin/bash
```

**note node**


```
conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
anvi-refine -c /work_beegfs/sunam233/Day5/contigs.db -C consolidated_bins -p /work_beegfs/sunam233/Day5/5_anvio_profiles/merged_profiles/PROFILE.db --bin-id Bin_METABAT__25
```


in new terminal
```
ssh -L 8060:localhost:8080 sunam233@caucluster-old.rz.uni-kiel.de
ssh -L 8080:localhost:8080 node010
```
and in browser
```
http://127.0.0.1:8060
```

## update: worked with mobaXterm <3 


bash script for taxonomic assignment 

```
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=taxonomy_assignment
#SBATCH --output=/work_beegfs/sunam233/Day5/taxonomy_assignment.out
#SBATCH --error=/work_beegfs/sunam233/Day5/taxonomy_assignment.err
#SBATCH --partition=all
#SBATCH --reservation=biol217


#load conda
module load miniconda3/4.7.12.1


#conda activate anvio
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1

#create a taxonomic assignment of
anvi-run-scg-taxonomy -c /work_beegfs/sunam233/Day5/contigs.db -T 20 -P 2

#nachricht, die erscheint, wenn der job durch ist
echo "fertisch"
```


