get_pharmaverse_pkgs <- function(
  repo_url = "https://github.com/pharmaverse/pharmaverse",
  yaml_path = file.path("data","packages")
) {

# Get the list of pharmaverse packages --------------------------------

  # Create a temporary directory
  temp_dir <- file.path(tempdir(), "pharmaverse_clone")
  dir.create(temp_dir)
  # Clone the repository into the temporary directory
  repo <- git2r::clone(repo_url, temp_dir)
  # List the files in the repository
  yaml_files <- list.files(
    file.path(temp_dir,yaml_path), 
    full.names = TRUE)
  # Function to read a YAML file and convert it to a tibble
  read_yaml_to_tibble <- function(file) {
    yaml_data <- yaml::read_yaml(file)
    tibble::as_tibble(yaml_data)
  }
  # Wrap the function using purrr's safely to handle errors
  safe_read_yaml_to_tibble <- purrr::safely(read_yaml_to_tibble)
  # Apply the function to each YAML file
  yaml_results <- purrr::map(yaml_files, safe_read_yaml_to_tibble)
  # Extract successful results
  yaml_tibbles <- purrr::map(yaml_results, "result") 
  # Remove any NULL entries (files that had errors)
  yaml_tibbles <- purrr::compact(yaml_tibbles)
  # Combine the valid tibbles into one
  packages_data <- dplyr::bind_rows(yaml_tibbles)

  packages_data

}
