#!/bin/bash
# A minimal Slurm job for Module 3.
# Submit from this directory with: sbatch first_job.sl

#SBATCH --job-name=first_job
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100m
#SBATCH --time=00:05:00
#SBATCH --output=first_job_%j.out

echo "Running on $(hostname) as job $SLURM_JOB_ID"
sleep 90
echo "Done"
