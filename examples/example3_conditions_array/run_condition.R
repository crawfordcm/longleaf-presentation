###############################################################################
# run_condition.R -- Example 3 worker script: ONE row of conditions.txt
#
# Called by runcode.sh as:
#   Rscript --vanilla run_condition.R <row_id> <n> <beta> <rep>
#
# The four values after the script name are one line of conditions.txt.
# R receives them as a character vector from commandArgs(); convert types
# yourself.
###############################################################################

# ---- 1. Read the command-line arguments -------------------------------------
args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 4) {
  stop("Usage: Rscript run_condition.R <row_id> <n> <beta> <rep>\n",
       "Got ", length(args), " argument(s): ", paste(args, collapse = " "))
}

row_id <- as.integer(args[1])
n      <- as.integer(args[2])
beta   <- as.numeric(args[3])
rep_i  <- as.integer(args[4])

cat(sprintf("=== Row %d: n=%d, beta=%.2f, rep=%d ===\n", row_id, n, beta, rep_i))
cat("Host:", Sys.info()[["nodename"]],
    " SLURM task:", Sys.getenv("SLURM_ARRAY_TASK_ID", unset = "(none)"), "\n")

# ---- 2. Seed from the condition, not from the row order ---------------------
# This way re-running row 7 always gives the same answer, and adding rows to
# the bottom of conditions.txt never changes earlier results.
set.seed(1000 * n + 100 * round(beta * 10) + rep_i)

# ---- 3. Do the (trivial) work -----------------------------------------------
x   <- rnorm(n)
y   <- beta * x + rnorm(n)
fit <- lm(y ~ x)

results <- list(
  row_id     = row_id,
  n          = n,
  beta_true  = beta,
  rep        = rep_i,
  beta_hat   = unname(coef(fit)["x"]),
  p_value    = summary(fit)$coefficients["x", "Pr(>|t|)"],
  hostname   = Sys.info()[["nodename"]],
  finished   = Sys.time()
)

# ---- 4. Save with a filename that encodes the condition ---------------------
out_dir <- "results"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
outfile <- file.path(out_dir,
                     sprintf("result_n%d_beta%.1f_rep%02d.rds", n, beta, rep_i))
saveRDS(results, outfile)
cat("Saved:", outfile, "\n")
