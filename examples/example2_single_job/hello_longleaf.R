###############################################################################
# hello_longleaf.R -- Example 2: a single, self-contained R job
#
# What it does:
#   1. Simulates a small dataset
#   2. Fits a linear model and computes a few summary numbers
#   3. Saves everything to results/hello_results.rds
#
# Run locally:   Rscript hello_longleaf.R
# Run on Longleaf: sbatch submit_single.sl   (see README.md)
###############################################################################

# ---- 0. Settings you may want to change -------------------------------------
n       <- 500                      # sample size
seed    <- 2026                     # for reproducibility
out_dir <- "results"                # relative to the folder you sbatch from
outfile <- file.path(out_dir, "hello_results.rds")

dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

# ---- 1. Report where/when we are running (handy for debugging on the cluster)
cat("Started:   ", format(Sys.time()), "\n")
cat("Host:      ", Sys.info()[["nodename"]], "\n")
cat("Working dir:", getwd(), "\n")
cat("SLURM job: ", Sys.getenv("SLURM_JOB_ID", unset = "(not running under SLURM)"), "\n")

# ---- 2. Simulate data and fit a model ---------------------------------------
set.seed(seed)
x <- rnorm(n)
y <- 1 + 2 * x + rnorm(n, sd = 0.5)
fit <- lm(y ~ x)

# ---- 3. Bundle the results into a list --------------------------------------
results <- list(
  n            = n,
  seed         = seed,
  coefficients = coef(fit),
  r_squared    = summary(fit)$r.squared,
  mean_y       = mean(y),
  sd_y         = sd(y),
  hostname     = Sys.info()[["nodename"]],
  slurm_job_id = Sys.getenv("SLURM_JOB_ID", unset = NA),
  r_version    = R.version.string,
  finished_at  = Sys.time()
)

# ---- 4. Save to disk --------------------------------------------------------
saveRDS(results, outfile)
cat("Saved results to:", normalizePath(outfile), "\n")
cat("Finished:  ", format(Sys.time()), "\n")
