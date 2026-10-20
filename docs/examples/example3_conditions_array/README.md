# Example 3: Pass variables to an R script through `conditions.txt`

A template for passing variables to an R script on Longleaf. Instead of editing an R script and resubmitting it for every setting, you:

1. Write every combination of settings you want as one **row** of a plain text
   file, `conditions.txt`.
2. Submit a **SLURM job array** with one task per row.
3. Each task reads its own row and passes the values to R as command-line
   arguments.

Twelve rows means twelve independent jobs that run in parallel on whatever
nodes are free, each saving its own `.rds` file.

## How the pieces fit together

```
sbatch submit_array.sl
   │   #SBATCH --array=1-12  → SLURM starts 12 tasks, SLURM_ARRAY_TASK_ID = 1..12
   │
   └─▶ sh runcode.sh $SLURM_ARRAY_TASK_ID          (task 7 shown)
          │   sed "7q;d" conditions.txt   →   "7 50 0 2"
          │
          └─▶ Rscript run_condition.R 7 50 0 2
                 │   commandArgs() → c("7", "50", "0", "2")
                 │
                 └─▶ results/result_n50_beta0.0_rep02.rds
```

## Files

| file | purpose |
|---|---|
| `make_conditions.R` | Builds `conditions.txt` from an `expand.grid()` of settings. Rerun whenever you change the grid. |
| `conditions.txt` | One row per job. Space-separated, **no header**. Columns: `row_id n beta rep`. |
| `run_condition.R` | The worker. Reads 4 command-line arguments, simulates, saves one `.rds`. |
| `runcode.sh` | Picks the right line of `conditions.txt` and calls R with it. |
| `submit_array.sl` | SLURM array submission script. |
| `collect_results.R` | After the run: stacks all `.rds` into one data frame and lists any missing rows. |
| `logs/` | One `.out`/`.err` per task. |
| `results/` | One `.rds` per task. |

## Step-by-step

### 1. Build the conditions file (on your laptop or on Longleaf)

```bash
Rscript make_conditions.R
wc -l conditions.txt          # note the number of rows
```

`conditions.txt` looks like:

```
1 50 0 1
2 200 0 1
3 50 0.5 1
...  (one row per combination of n, beta, rep)
12 200 0.5 3
```

### 2. Copy the folder to Longleaf

```bash
rsync -av example3_conditions_array/ <onyen>@longleaf.unc.edu:example3_conditions_array/
ssh <onyen>@longleaf.unc.edu
cd ~/example3_conditions_array
```

### 3. Edit `submit_array.sl`

- **`--array=1-12`**: must match `wc -l conditions.txt`. This is the one line
  people forget. Too small and some conditions never run; too large and the
  extra tasks fail with "no line N".
- `--mail-user`: your email, or delete the `--mail-*` lines.
- `--time` / `--mem`: per task, not for the whole array.
- For big arrays add a throttle, e.g. `--array=1-2000%100`, so you don't
  monopolize the partition.

### 4. Test one row interactively before submitting hundreds

```bash
module add r
sh runcode.sh 1          # runs row 1 of conditions.txt
ls results/
```

If this works, the array will work.

### 5. Submit

```bash
sbatch submit_array.sl
```

### 6. Monitor

```bash
squeue -u $USER                    # one line per running/pending task
sacct -j <jobid> --format=JobID,State,ExitCode,Elapsed
tail logs/cond_<jobid>_7.out       # output of task 7
```

### 7. Collect

```bash
Rscript collect_results.R
```

This prints a table of all results, writes `all_results.rds`, and lists any
rows that are missing a result file. To rerun only those, submit again with
an explicit list, e.g.:

```bash
sbatch --array=3,8,11 submit_array.sl
```

(A command-line `--array` overrides the one inside the file.)

## Adapting this to your own project

**Changing what variables are passed.** Three places must agree:

1. `make_conditions.R`: the columns of the grid.
2. `run_condition.R`: the number and order of `args[...]` you read, and the
   `length(args) != 4` check.
3. `collect_results.R`: the `col.names` used to read `conditions.txt` back in.

`runcode.sh` and `submit_array.sl` do not care how many columns there are;
`$input` expands to the whole line.

**Strings are fine as values** (e.g. `high`, `identity`) as long as they contain
no spaces. R receives everything as character; convert with `as.integer()`,
`as.numeric()`, etc.

**Paths.** As in Example 2, everything is relative to the folder you run
`sbatch` from. If you point `results/` somewhere else, create the directory
first and prefer `/work/users/<o>/<n>/<onyen>/...` for anything large.

**Seeds.** Derive the seed from the condition values (as `run_condition.R`
does), not from `SLURM_ARRAY_TASK_ID`, so results are reproducible even if
you reorder or append to `conditions.txt`.

**Multiple methods on the same conditions.** Either add a `method` column to
the grid, or keep one `conditions.txt` and write one `.sl` per method that
passes the method name as an extra argument:

```bash
sh runcode.sh $SLURM_ARRAY_TASK_ID lasso
```

and in `runcode.sh`: `Rscript --vanilla run_condition.R $input $2`.
