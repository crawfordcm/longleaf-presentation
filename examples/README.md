# Workshop examples

The files used in Module 4, "R on Longleaf". Each folder is self-contained and can be copied to Longleaf as-is.

| Folder | Example | Contents |
|---|---|---|
| `example1_interactive_r/` | Interactive R | A README with the commands for a terminal session or RStudio Server. |
| `example2_single_job/` | Submitting a single R job | One R script, one Slurm submission script, and the `logs/` and `results/` folders they write to. |
| `example3_conditions_array/` | Submitting a batch of jobs with parameters | A conditions file, a Slurm job array, and the R scripts that build the conditions, run one row, and collect the results. |

Each folder's README walks through its example step by step.

Keep each example short enough to explain on screen. Before publishing operational scripts, verify Longleaf account, partition, module, memory, runtime, and filesystem requirements against current UNC Research Computing guidance.
