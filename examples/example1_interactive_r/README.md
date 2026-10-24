# Example 1: Interactive R on a compute node

Interactive sessions are for testing, debugging, and exploring. Nothing here needs
to be copied to Longleaf; it is a sequence of commands to type.

## From a terminal

Log in, then ask Slurm for an interactive shell on the `interact` partition:

```bash
ssh <onyen>@longleaf.unc.edu
srun -t 1:00:00 -p interact -n 1 --cpus-per-task=1 --mem=4g --pty /bin/bash
```

The prompt changes to show a compute node's name once the session starts. Load R
and start it:

```bash
module add r
R
```

Inside R, confirm where you are and try a few commands:

```r
Sys.info()[["nodename"]]   # a compute node, not a login node
R.version.string
x <- rnorm(1e6); mean(x)
```

Leave R, then the session, so the node is released for other users:

```r
q()
```

```bash
exit
```

If you need graphics windows (for example `plot()`), log in with `ssh -X` and add
`--x11=first` to the `srun` command.

## From the browser

Open OnDemand, Longleaf's web portal at https://ondemand.rc.unc.edu, has an **RStudio Server** app under
*Interactive Apps*. Choose the number of hours, CPUs, memory, and the R module,
and RStudio opens on a compute node in a browser tab. UNC recommends at least two
CPUs for RStudio sessions.

## Testing a job script interactively

Once the Example 2 folder is on Longleaf, an interactive session is the place to
try its script before submitting it:

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
