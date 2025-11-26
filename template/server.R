library(shiny)
library(bslib)
library(tidyverse)
library(gt)
library(gtExtras)

# Load helper functions
listFunctions <- list.files("functions/", full.names = TRUE)
lapply(listFunctions, source)

shinyServer(function(input, output, session) {
  
  # Example table for template
  output$example_table <- render_gt({
    tibble(
      Category = c("Students", "Faculty", "Staff", "Alumni"),
      Count = c(2847, 312, 445, 15678),
      Percentage = c(72.3, 7.9, 11.3, 8.5)
    ) %>%
      gt() %>%
      gt_theme_cohc() %>%
      add_cohc_header("Campus Community", "Overview Statistics") %>%
      fmt_number(columns = Count, decimals = 0) %>%
      fmt_percent(columns = Percentage, decimals = 1)
  })
  
  # GT Demo outputs - all logic is in functions
  output$basic_table <- render_gt({ gt_demo_basic_table() })
  output$stats_table <- render_gt({ gt_demo_stats_table() })
  output$financial_table <- render_gt({ gt_demo_financial_table() })
  output$performance_table <- render_gt({ gt_demo_performance_table() })
  output$comparison_table <- render_gt({ gt_demo_comparison_table() })
  output$interactive_table <- render_gt({ gt_demo_interactive_table() })
  output$advanced_table <- render_gt({ gt_demo_advanced_table() })
  output$comparison_standard <- render_gt({ gt_demo_comparison_standard() })
  output$comparison_stats <- render_gt({ gt_demo_comparison_stats() })
  
  # Add your actual server logic here
  
})