# Launch the flexdashboard in a Shiny runtime (do not use static Live Server).
options(shiny.host = "127.0.0.1", shiny.port = 3838)
rmarkdown::run(
  file = "Dashboard_Sante_Territoires.Rmd",
  shiny_args = list(host = getOption("shiny.host"), port = getOption("shiny.port"), launch.browser = TRUE)
)
