#!/bin/bash
# submit_single.sl -- SLURM submission script for Example 2 (one R job)
#
# Submit from inside this folder with:   sbatch submit_single.sl
# Check status with:                     squeue -u $USER
#
# Everything starting with "#SBATCH" is a directive read by the scheduler.
# Lines starting with a plain "#" are ordinary comments.

#SBATCH --job-name=hello_longleaf
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2g
#SBATCH --time=00:10:00
#SBATCH --output=logs/hello_%j.out
#SBATCH --error=logs/hello_%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=<onyen>@unc.edu

# ---- Load R -----------------------------------------------------------------
# "module add r" loads the cluster's default R. To pin a version, run
# "module avail r" on a login node and use, e.g., "module add r/4.4.0".
module add r

# ---- Run the script ---------------------------------------------------------
# SLURM starts the job in the directory you ran sbatch from, so relative
# paths (hello_longleaf.R, results/, logs/) resolve as expected.
Rscript --vanilla hello_longleaf.R
