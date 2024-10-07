get_github <- function(
  x
){

  x <- setdiff(x,"ddsjoberg/gtsummary")

  git_stats <- GitStats::create_gitstats() |>
    GitStats::set_github_host(
      repos = x,
      token = Sys.getenv("GITHUB_PAT")
    )
  
  repo_summary <- GitStats::get_repos(git_stats, progress = TRUE)
}

# Make cache
# repos <- pkgs$repo

# # update 
# # repos <- pkgs |>
# #   dplyr::filter(name %in% unique(commits$repository)) |>
# #   dplyr::pull(repo)
# # repos <- c(i,repos)


# commits <- NULL
# for (i in repos){
#   git_stats <- GitStats::create_gitstats() |>
#     GitStats::set_github_host(
#       repos = i,
#       token = Sys.getenv("GITHUB_PAT")
#     )

#   commits <- dplyr::bind_rows(
#     GitStats::get_commits(git_stats, since = Sys.Date() - look_back_days),
#     commits
#   )
# }
 