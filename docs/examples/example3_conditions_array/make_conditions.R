###############################################################################
# make_conditions.R -- builds conditions.txt for Example 3
#
# Each ROW of conditions.txt is one job in the SLURM array. Columns are
# separated by spaces and there is NO header row (the shell script reads
# lines by number, so a header would be mistaken for condition 1).
#
# Run:  Rscript make_conditions.R
###############################################################################

grid <- expand.grid(
  n    = c(50, 200),           # sample size
  beta = c(0, 0.5),            # true slope
  rep  = 1:3,                  # replication
  stringsAsFactors = FALSE
)

# Add the row number as the first column so each job knows its own ID.
grid <- cbind(row_id = seq_len(nrow(grid)), grid)

write.table(grid, "conditions.txt",
            row.names = FALSE, col.names = FALSE, quote = FALSE)

cat(sprintf("Wrote conditions.txt with %d rows (use --array=1-%d)\n",
            nrow(grid), nrow(grid)))
print(grid)
