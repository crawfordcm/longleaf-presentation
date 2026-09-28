# Getting Started with Longleaf

This repository contains the source for a 45–60 minute presentation and tutorial website introducing UNC's Longleaf computing cluster. The site is organized as a clickable lesson outline so it can be presented live and revisited later as a practical reference.

## Workshop outline

1. [Introduction to Longleaf](modules/01-introduction.qmd)
2. [Key features of computing clusters](modules/02-cluster-basics.qmd)
3. [How do you actually use it?](modules/03-accessing-longleaf.qmd)
4. [Interacting with Longleaf](modules/04-interacting-with-longleaf.qmd)
5. [R on Longleaf](modules/05-r-on-longleaf.qmd)

## Repository structure

- `index.qmd` — clickable workshop outline and homepage
- `modules/` — the five presentation/tutorial modules
- `examples/` — downloadable R and Slurm examples as they are developed
- `images/` — diagrams, screenshots, and the site icon
- `styles.css` — the shared visual design
- `_quarto.yml` — navigation and site settings
- `docs/` — the generated website used by GitHub Pages
- `longleaf_brownbag.docx` — the original planning outline

## Preview the site locally

Install [Quarto](https://quarto.org/docs/get-started/) and run:

```bash
quarto preview
```

Quarto will open a local preview and update it as the source files change.

## Build the website

```bash
quarto render
```

The rendered site is written to `docs/`. To publish with GitHub Pages, configure the repository to deploy from the `docs` folder on the `main` branch.

## Content status

The current files establish the teaching sequence, page structure, and visual system. Longleaf-specific URLs, hostnames, module names, queue rules, package paths, and example resource requests should be checked against current UNC Research Computing guidance before the workshop is delivered.
