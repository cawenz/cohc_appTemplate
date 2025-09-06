library(shiny)
library(bslib)
library(tidyverse)
library(gt)
library(gtExtras)

# Load helper functions
listFunctions <- list.files("functions/", full.names = TRUE)
lapply(listFunctions, source)

shinyServer(function(input, output, session) {
  
  # Example output for the template
  output$example_table <- render_gt({
    # Sample data for demonstration
    tibble(
      Category = c("Students", "Faculty", "Staff", "Alumni"),
      Count = c(2847, 312, 445, 15678),
      Percentage = c(72.3, 7.9, 11.3, 8.5)
    ) %>%
      gt() %>%
      tab_header(title = "Example Data") %>%
      fmt_number(columns = Count, decimals = 0) %>%
      fmt_number(columns = Percentage, decimals = 1, pattern = "{x}%") %>%
      tab_options(
        table.font.names = "Manrope"
      )
  })
  
  # Add your actual server logic here
  
})