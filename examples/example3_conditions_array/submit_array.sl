#!/bin/bash
# submit_array.sl -- SLURM job array for Example 3
#
# Submit from inside this folder with:   sbatch submit_array.sl
#
# --array=1-12 launches 12 copies of this script. Each copy gets a different
# value of $SLURM_ARRAY_TASK_ID (1, 2, ..., 12), which we use to pick a line
# from conditions.txt. The range MUST match the number of lines in that file
# (wc -l conditions.txt). Add %N to throttle, e.g. --array=1-500%50 runs at
# most 50 at a time.

#SBATCH --job-name=cond_array
#SBATCH --array=1-12
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1g
#SBATCH --time=00:05:00
#SBATCH --output=logs/cond_%A_%a.out
#SBATCH --error=logs/cond_%A_%a.err
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=<onyen>@unc.edu

# %A = the array's master job ID, %a = this task's index, so each task
# gets its own log file, e.g. logs/cond_12345678_7.out

sh runcode.sh $SLURM_ARRAY_TASK_ID
