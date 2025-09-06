source("theme/cohc_bslib.R")

# Load functions and navs
listFunctions <- list.files("functions/", full.names = TRUE)
lapply(listFunctions, source)

listNavs <- list.files("navs/", full.names = TRUE)
lapply(listNavs, source)

# Define your navigation items here
nav_items <- function(prefix) {
  list(
    example_nav  # Replace with your actual nav panels
    # Add more nav panels as needed
  )
}

shinyUI(
  page_navbar(
    title = div(
      class = "d-flex align-items-center",
      img(src = "logo.png", class = "navbar-logo", alt = "Holy Cross"),
      "App Name"  # Change this to your app name
    ),
    id = "nav",
    theme = cohc_bslib(),
    tags$head(
      tags$link(
        href = "https://fonts.googleapis.com/css2?family=Manrope:wght@300;400;500;600;700&family=Gelasio:wght@400;500;600;700&display=swap",
        rel = "stylesheet"
      )
    ),
    !!!nav_items("AppName")
  )
)