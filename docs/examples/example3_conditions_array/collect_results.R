###############################################################################
# collect_results.R -- stack every results/*.rds into one data frame
#
# Run after the array finishes:  Rscript collect_results.R
# Also reports any conditions.txt rows that have no result file (failed or
# still-running tasks), so you know exactly which array indices to resubmit.
###############################################################################

files <- list.files("results", pattern = "\\.rds$", full.names = TRUE)
cat(sprintf("Found %d result files\n", length(files)))

rows <- lapply(files, function(f) {
  r <- readRDS(f)
  data.frame(row_id = r$row_id, n = r$n, beta_true = r$beta_true, rep = r$rep,
             beta_hat = r$beta_hat, p_value = r$p_value,
             hostname = r$hostname)
})
all_results <- do.call(rbind, rows)
all_results <- all_results[order(all_results$row_id), ]
rownames(all_results) <- NULL
print(all_results)

# Which rows of conditions.txt are missing?
cond <- read.table("conditions.txt",
                   col.names = c("row_id", "n", "beta", "rep"))
missing <- setdiff(cond$row_id, all_results$row_id)
if (length(missing) == 0) {
  cat("\nAll conditions complete.\n")
} else {
  cat("\nMISSING rows (resubmit with --array=",
      paste(missing, collapse = ","), "):\n", sep = "")
  print(cond[cond$row_id %in% missing, ])
}

saveRDS(all_results, "all_results.rds")
cat("Saved all_results.rds\n")
