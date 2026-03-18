required_packages <- c(
  "flexdashboard", "tidyverse", "tidytext", "wordcloud2", "leaflet",
  "sf", "DT", "plotly", "stopwords", "scales", "htmltools", "stringi"
)

missing_packages <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]

if (length(missing_packages) == 0) {
  message("Toutes les dependances sont deja installees.")
} else {
  message("Installation des packages manquants: ", paste(missing_packages, collapse = ", "))
  install.packages(
    missing_packages,
    dependencies = TRUE,
    repos = "https://cloud.r-project.org"
  )
}

message("Verification finale:")
status <- vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)
print(data.frame(package = required_packages, installed = status))
