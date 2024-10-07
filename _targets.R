#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# To test
# 
# targets::tar_manifest(fields = all_of("command"))
# targets::tar_visnetwork()

# Load packages required to define the pipeline:
library(targets)
# library(tarchetypes) # Load other packages as needed.

# Set target options:
tar_option_set(
  packages = c("renv","qs"), # Packages that your targets need for their tasks.
  format = "qs", # Optionally set the default storage format. qs is fast.
)

# Run the R scripts in the R/ folder with your custom functions:
tar_source()

# Replace the target list below with your own:
list(
  tar_target(
    name = pkgs,
    command = get_pharmaverse_pkgs()
  ),
  tar_target(
    name = cran,
    command = get_cran(pkgs$name)
  ),
  tar_target(
    name = github,
    command = get_github(pkgs$repo)
  ),
  tar_target(
    name = badge_data,
    command = create_badge_data(
      pharmaverse_pkgs = pkgs,
      cran_data = cran,
      github_data = github
    )
  )
)
