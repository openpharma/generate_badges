create_badge_data <- function(
  pharmaverse_pkgs,
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
    ) |>
    dplyr::mutate(
  # CRAN ---------------------------
      badge_cran = make_shield(
        label = "CRAN",
        value = Version,
        colour = "blue",
        url = glue::glue(
          "https://cran.r-project.org/web/packages/{name}/index.html"
        )
      ),
  # Contributors ---------------------------
      badge_contributors = make_shield(
        label = "Code contributors",
        value = contributors_n,
        colour = "green",
        url = repo_url
      ),
  # GH stars ---------------------------
      badge_stars = make_shield(
        label = "Github stars",
        value = stars,
        colour = "purple",
        url = repo_url
      )
    ) |>
    dplyr::select(
      name, 
      repo,
      dplyr::starts_with("badge")
    )
  
  
}

# Helper
make_shield <- function(label, value, colour, url) {
  shield <- glue::glue("![](https://img.shields.io/badge/{label}-{value}-{colour}.svg)")
  as.character(glue::glue("[{shield}]({url})"))
}



