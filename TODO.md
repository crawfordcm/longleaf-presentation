# To-do: supporting Module 4 in the earlier modules

Drafted 2026-10-24; updated the same day after implementing most items. Every remaining item also appears as a yellow dashed **To do** box on the page itself. Find them in the source with `grep -rn '{.todo}' index.qmd modules` and delete the box once the item is done.

## Remaining (need a Longleaf account)

- [ ] **Module 2 · Screenshots.** A first terminal login (`images/terminal-login.png`), the OnDemand dashboard (`images/ondemand-dashboard.png`), and FileZilla connected with both panes visible (`images/filezilla-connected.png`).
- [ ] **Module 4 · Personal-library path.** On Longleaf, run `module add r` then `R -e '.libPaths(); Sys.getenv("R_LIBS_USER")'` and correct the path in "Where packages live" if it differs from `~/R/x86_64-pc-linux-gnu-library/4.4`.
- [ ] **Module 4 · First-install prompts.** Do one first-time `install.packages()` on Longleaf and confirm the two prompts quoted in "Installing packages". If Longleaf pre-creates the library, the prompts never appear and the paragraph should say so.

## Done on 2026-10-24

- [x] Module 2: "Requesting an account" written from UNC's Request a Cluster Account page.
- [x] Module 2: "Logging in from a terminal" written (Mac Terminal, MobaXterm or Windows Terminal, host-key prompt, `exit`, `ssh -X`).
- [x] Module 2: "Working through the browser" written around Open OnDemand (Files, Shell Access, RStudio Server, Job Composer).
- [x] Module 2: VPN service, `vpn.unc.edu`, and Duo verified; the provisional help-site link was replaced with the UNC ITS VPN Client service page.
- [x] Module 2: "Moving files with FileZilla" written; FileZilla replaces `rsync` in Module 4 and the example READMEs.
- [x] Large-data path settled on `/hickory/users/<o>/<n>/<onyen>` (UNC's default from 8/14/2026) in Module 2, Module 4, and both example READMEs. Home and hickory quotas added.
- [x] Module 3: "Software modules" section added (avail, add, list, purge, save; jobs load their own modules; pin versions).
- [x] Module 3: "Interactive jobs" section added with the `srun` line Example 1 uses.
- [x] Module 3: job-script walkthrough now uses the real `submit_single.sl` and explains job-name, output/error with `%j`, mail directives, the submission directory, and the missing-`logs/` failure.
- [x] Module 3: queue state codes (PD, R, CG) and `sacct` added to "Core Slurm actions"; `.sl` extension used throughout.
- [x] Module 3: shell table extended (`cd ~`, `cat`, `tail`, `wc -l`, `nano`, `exit`).
- [x] Module 1.3: "load software" added to the Prepare step.
- [x] Homepage: "Before the workshop" checklist (account, VPN, FileZilla, examples ZIP).
- [x] Module 2 named "Accessing Longleaf" in the title, sidebar, homepage card, and README.
- [x] Module 4: "R installations on Longleaf" written; garbled OnDemand sentence fixed in Example 1 and the example 1 README.
- [x] Six stale pages from the 2026-10-23 rename deleted from `docs/` and the site re-rendered.
