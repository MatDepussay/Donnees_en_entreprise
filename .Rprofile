# Ensure rmarkdown can find pandoc when running from VS Code.
local({
  quarto_candidates <- c(
    "C:/Program Files/Quarto/bin/tools",
    file.path(Sys.getenv("LOCALAPPDATA"), "Programs/Quarto/bin/tools")
  )

  pandoc_dir <- quarto_candidates[file.exists(quarto_candidates)][1]

  if (!is.na(pandoc_dir) && nzchar(pandoc_dir)) {
    old_path <- Sys.getenv("PATH")
    if (!grepl(pandoc_dir, old_path, fixed = TRUE)) {
      Sys.setenv(PATH = paste(pandoc_dir, old_path, sep = .Platform$path.sep))
    }
    options(rmarkdown.pandoc.dir = pandoc_dir)
  }
})
