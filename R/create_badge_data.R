create_badge_data <- function(
  pharmaverse_pkgs
  cran_data,
  github_data 
){
  pharmaverse_pkgs |>
    dplyr::left_join(
      cran_data |>
        dplyr::select(
          Package, Version
        ),
      by = c("name" = "Package")
    ) |>
    dplyr::left_join(
      github_data |>
        dplyr::select(
          fullname, repo_url, stars, contributors_n 
        ),
      by = c("repo" = "fullname")
    )
}