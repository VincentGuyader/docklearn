launch_learn()

dependances <- tous_les_programmes() %>%
  map(attachment::att_from_rmd) %>%
  unlist() %>%
  unique()
dependances %>% attachment::install_if_missing()

# remotes::install_github("rstudio-education/envtutorial")
# remotes::install_github("rstudio-education/grader")
