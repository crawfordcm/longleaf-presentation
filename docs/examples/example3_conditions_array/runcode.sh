#!/bin/bash
# runcode.sh -- glue between SLURM and R for Example 3
#
# Usage:  sh runcode.sh <line_number>
#
# Picks line <line_number> out of conditions.txt and passes its contents to
# run_condition.R as command-line arguments. submit_array.sl calls this with
# $SLURM_ARRAY_TASK_ID, so array task 7 runs row 7 of conditions.txt.

CONDITIONS=conditions.txt

# sed "Nq;d" prints line N of the file and nothing else.
input=$(sed "${1}q;d" $CONDITIONS)

if [ -z "$input" ]; then
  echo "ERROR: no line $1 in $CONDITIONS" >&2
  exit 1
fi

echo "Task $1 -> conditions: $input"

module purge
module add r
Rscript --vanilla run_condition.R $input
