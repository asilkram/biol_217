
`log in with sunam233 and run this directly in command line`
```
srun --pty --mem=10G --nodes=1 --tasks-per-node=1 --cpus-per-task=1 --partition=all /bin/bash
```

*remember node number*

`go in dir where the contigs.db of interest is in`
```
conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1

anvi-display-contigs-stats contigs.db
```

`open a second (new) terminal`
```
ssh -L 8060:localhost:8080 sunam233@caucluster-old.rz.uni-kiel.de
ssh -L 8080:localhost:8080 node###
```