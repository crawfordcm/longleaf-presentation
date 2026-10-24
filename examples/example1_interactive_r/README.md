# Example 1: Interactive R

Interactive R is for testing, debugging, and exploring. Nothing here needs to be
copied to Longleaf; it is a sequence of commands to type.

## From a terminal

Log in, load R, and start it:

```bash
ssh <onyen>@longleaf.unc.edu
module add r
R
```

Inside R, confirm which R you have and try a few commands:

```r
R.version.string
Sys.info()[["nodename"]]   # the login node you are on
x <- rnorm(1e6); mean(x)
```

Leave R with `q()`.

This runs R on the login node, which everyone shares. It is fine for checking
that R starts, that a package loads, or that a script runs at all. For
exploratory work that runs for more than a few minutes or needs real memory,
ask Slurm for an interactive job first and run the same commands there:

```bash
srun -t 1:00:00 -p interact -n 1 --cpus-per-task=1 --mem=4g --pty /bin/bash
module add r
R
```

The prompt changes to show a compute node's name. `exit` returns you to the
login node and releases the resources.

## From the browser

Open OnDemand, Longleaf's web portal at https://ondemand.rc.unc.edu, has an **RStudio Server** app under
*Interactive Apps*. Choose the number of hours, CPUs, memory, and the R module,
and RStudio opens on a compute node in a browser tab. UNC recommends at least two
CPUs for RStudio sessions.

## Testing a job script interactively

Once the Example 2 folder is on Longleaf, load R and try its script before
submitting it:

```bash
cd ~/example2_single_job
module add r
Rscript --vanilla hello_longleaf.R
```

Example 3 uses the same idea to test one row of `conditions.txt` before
submitting the whole array.

## Source

- "Longleaf Cluster SLURM examples," UNC Research Computing:
  https://help.rc.unc.edu/longleaf-slurm-examples/
