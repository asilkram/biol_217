# pangenomics

## 
 ```
#get direct access to a HPC compute node
srun --reservation=biol217 --pty --mem=10G --nodes=1 --tasks-per-node=1 --cpus-per-task=1 /bin/bash

#activate the conda environment
conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1

#start anvi'o interactive display
anvi-display-contigs-stats *db
```

in new terminal:

```
ssh -L 8060:localhost:8087 sunam233@caucluster-old.rz.uni-kiel.de
ssh -L 8087:localhost:8087 node010
```

in interactive interface: comparison between the different bins (with each other and with a complete [reference] genome)

Task: Take some time to click through the views and compare the MAGs. Add a screenshot of your output to your documentation. Answer the following Questions:

Question: How do the MAGs compare in size and number of contigs to the full genome?


    sizes and number of contigs vary quite a lot. The smallest MAGs are around 1.3MB whereas the biggest one is around twice that size (2.6MB). The number of contigs doesn't necessarily 

Question: Based on the contig numbers, sizes and number of marker genes (HMM hits), which two MAGs are the best and which is the worst?

favorites are: methano_bin13 and bin9 (bin_13 ist the second largest of them all, has teh highest hmmand highest N50 [therefore low number of contigs compared to the size], bin9 is the largest one, with the third highest N50 and relatively high hmm)
worst one: Bin_5 (small in size, high contig number, small N50 and low HMM compared to the whole genome)


on the login node: (weil small command)
```
anvi-script-gen-genomes-file --input-dir ../02_contigs-dbs/ -o external-genomes.txt
```

`output:`¸\
name    contigs_db_path\
Methano_Bin1	/work_beegfs/sunam233/Day6/02_contigs-dbs/Bin1.db\
Methano_Bin10	/work_beegfs/sunam233/Day6/02_contigs-dbs/Bin10.db\
Methano_Bin13	/work_beegfs/sunam233/Day6/02_contigs-dbs/Bin13.db\
Methano_Bin3	/work_beegfs/sunam233/Day6/02_contigs-dbs/Bin3.db\
Methano_Bin5	/work_beegfs/sunam233/Day6/02_contigs-dbs/Bin5.db\
Methano_Bin8	/work_beegfs/sunam233/Day6/02_contigs-dbs/Bin8.db\
Methano_Bin9	/work_beegfs/sunam233/Day6/02_contigs-dbs/Bin9.db\
Methano_Mflavescens	/work_beegfs/sunam233/Day6/02_contigs-dbs/Mflavescens.db



to estimate completeness, use just created external genomes files
```
anvi-estimate-genome-completeness -e external-genomes.txt > genome-completeness.txt
```

alle deren completetion unter 70 ist, kommen in einen seperaten aussortier-ordner
redundancy sollte nicht über 10 sein, ist sie aber auch bei keinem
```
mkdir trash_bins
mv 02_contigs-dbs/Bin5.db 02_contigs-dbs/Bin10.db trash_bins/
```


## visualizing
    srun --pty --mem=10G --nodes=1 --tasks-per-node=1 --cpus-per-task=1 --reservation=biol217 --partition=all /bin/bash
    conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1

    anvi-display-pan -p ./methano_pangenome-PAN.db -g ../Methano-GENOMES.db -P 8081

-P flag for specifiyng port number (jeder hat hier eine eigene bekommen)

dann wieder in neuem terminal tab

    ssh -L 8060:localhost:8081 sunam233@caucluster-old.rz.uni-kiel.de
    ssh -L 80801localhost:8081 node010

und in firefox drinne rein http://127.0.0.1:8060



questions zur visualisation

Based on the frequency clustering of genes, do you think all genomes are related? Why?
no. lila genomes cover different regions than blue ones (contain different genes). genomes of the same colour are probably related. 

How does the reference genome compare to its closest bin?
reference has a higher total length and completion (obviously), CG content is very similiar between both of them, bigger difference in singleton gene clusters, number of genes per kbp and number of gene clusters are similiar

What ranges are used determine a prokaryotic species? How high can you go until you see changes in ANI? What does the ANI clustering tell you about genome relatedness?
specis cut-off at 95% ANI. ab 0.7 for Min there are no fading colours only two distinct clusters. Shows us how high the nucleotide identity is between two corresponding genomes. When u set the min to 0.95 the ANI clustering clusters genomes of the same species together, like the two cluster in our 6 MAGs

How are Methanogenesis genes distributed across the genome?
not clustered, just like ... everywhere

Can the organism do methanogenesis? Does it have genes similar to a bacterial secretion system?
ja es kann methanogenese machen. Es hat 7 Gene die similiar zu bacterial secretion systems sind.