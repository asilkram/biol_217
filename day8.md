gestern hat anscheinend nicht alles geklappt

als erstes wieder reademption environment aktivieren

    conda activate /home/sunam226/.conda/envs/reademption

und dann die reademption super dir erstellen (in der neuen day8 dir)

    reademption create --project_path READemption_analysis --species Methanosarcina='Methanosarcina_mazei'

download the fasta file of the reference genome M. mazei Go1, unzip it and change from .fna into .fa file

    wget -O READemption_analysis/input/Methanosarcina_reference_sequences/GCF_000007065.1_ASM706v1_genomic.fna.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/007/065/GCF_000007065.1_ASM706v1/GCF_000007065.1_ASM706v1_genomic.fna.gz
    gunzip READemption_analysis/input/Methanosarcina_reference_sequences/GCF_000007065.1_ASM706v1_genomic.fna.gz
    mv READemption_analysis/input/Methanosarcina_reference_sequences/GCF_000007065.1_ASM706v1_genomic.fna READemption_analysis/input/Methanosarcina_reference_sequences/GCF_000007065.1_ASM706v1_genomic.fa

download the GFF file of the reference genome (with annotations) and unzip it

    wget -P READemption_analysis/input/Methanosarcina_annotations https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/007/065/GCF_000007065.1_ASM706v1/GCF_000007065.1_ASM706v1_genomic.gff.gz
    gunzip READemption_analysis/input/Methanosarcina_annotations/GCF_000007065.1_ASM706v1_genomic.gff.gz

modify header of the fasta file

    sed -i "s/>/>NC_003901.1 /" READemption_analysis/input/Methanosarcina_reference_sequences/GCF_000007065.1_ASM706v1_genomic.fa


copy the raw reads from yesterday in the day8 dir

    cp /work_beegfs/sunam233/day7/project/READemption_analysis/input/reads/*.fastq ./READemption_analysis/input/reads


dann [reademption.bash](docs/reademption_day8.bash)
anscheinend wird in dem align schritt aus den fastq files fasta gemacht, die später verbuttert werden