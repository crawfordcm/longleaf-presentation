# Example 2: Submit a single R script to Longleaf

The simplest Longleaf workflow. One R script that runs once and saves its output as an `.rds` file.

## Files

| file | purpose |
|---|---|
| `hello_longleaf.R` | The R script. Simulates data, fits `lm()`, saves a list to `results/hello_results.rds`. |
| `submit_single.sl` | The SLURM submission script. Tells the scheduler what resources you need and what command to run. |
| `logs/` | Where SLURM writes the job's console output (`.out`) and errors (`.err`). |
| `results/` | Where the R script writes its `.rds` file. |

## Step-by-step

### 1. Copy the folder to Longleaf

From your laptop, in the directory that contains `example2_single_job/`:

```bash
rsync -av example2_single_job/ <onyen>@longleaf.unc.edu:example2_single_job/
```

Replace `<onyen>` with your ONYEN. This puts the folder in your home directory,
`/nas/longleaf/home/<onyen>/example2_single_job`. (Use `scp -r` if you prefer.)

### 2. Log in and go to the folder

```bash
ssh <onyen>@longleaf.unc.edu
cd ~/example2_single_job
```

### 3. Edit the submission script

Open `submit_single.sl` and change:

- `--mail-user=<onyen>@unc.edu` to your email (or delete the two `--mail-*`
  lines if you don't want emails).
- `--time`, `--mem` if your real job needs more. Ask for a little more than you
  expect; jobs that exceed their limits are killed.
- `module add r` if you want a specific R version (`module avail r` lists them).

Nothing else needs changing: `--output` and `--error` are relative to the folder
you submit from, and so is the `results/` path inside the R script.


### 4. Submit

```bash
sbatch submit_single.sl
```

You'll see `Submitted batch job 12345678`. That number is the job ID.

### 5. Monitor

```bash
squeue -u $USER          # is it pending (PD) or running (R)?
sacct -j 12345678        # status / exit code after it finishes
cat logs/hello_12345678.out   # what the script printed
```

### 6. Look at the results

```bash
module add r
Rscript -e 'str(readRDS("results/hello_results.rds"))'
```

Or copy it back to your laptop:

```bash
rsync -av <onyen>@longleaf.unc.edu:example2_single_job/results/ ./results/
```

## Adjusting paths for your own project

- **Keep everything relative to the submission folder.** SLURM starts the job
  in the directory where you ran `sbatch`, so `results/` and `logs/` just work.
- **If you must use absolute paths**, your home directory on Longleaf is
  `/nas/longleaf/home/<onyen>`. Large or temporary output belongs in your work
  space, `/work/users/<o>/<n>/<onyen>` (first letter, second letter, ONYEN), not
  in home.
- **Make sure the log directory exists before submitting.** SLURM will not
  create `logs/`; if it is missing the job fails silently with no output.

## Setting variables

Everything configurable in this example lives at the top of `hello_longleaf.R`
(`n`, `seed`, `out_dir`). Edit those and resubmit. If you find yourself wanting
to run the same script with many different settings, see Example 3.
