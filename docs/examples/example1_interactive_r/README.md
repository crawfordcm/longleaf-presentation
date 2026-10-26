# Example 1: Interactive R

Interactive R is for testing, debugging, exploring, and installing packages.
Nothing here needs to be copied to Longleaf; it is a sequence of commands to
type.

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

## Installing a package

Stay in the same R session. Every package you need on Longleaf gets installed
this way, so install one now:

```r
install.packages("lavaan", repos = "https://cloud.r-project.org")
```

The `repos` argument skips the CRAN mirror menu. The first time you install
anything, R cannot write to the module's library and asks two questions. Answer
`yes` to both:

```
Would you like to use a personal library instead? (yes/No/cancel) yes
Would you like to create a personal library
'~/R/x86_64-pc-linux-gnu-library/4.4'
to install packages into? (yes/No/cancel) yes
```

R prints `* DONE (lavaan)` when it finishes. Later installs go straight to that
personal library without asking. Confirm the package loads and see where it
went:

```r
library(lavaan)
find.package("lavaan")   # the folder it was installed into
```

The folder is inside your home directory, so the package is available to
RStudio Server and to batch jobs as well, as long as they load the same R
module. Install packages here, interactively, never inside a job script.

Leave R with `q()`, and answer `n` when it offers to save the workspace.

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
