# Basic data utility functions

# Safe file loading with error handling
safe_read_csv <- function(file_path) {
  tryCatch({
    readr::read_csv(file_path, show_col_types = FALSE)
  }, error = function(e) {
    warning(paste("Failed to load:", file_path))
    NULL
  })
}

# Format numbers for display
format_number <- function(x, big_mark = ",") {
  formatC(x, format = "d", big.mark = big_mark)
}

# Format percentages
format_percent <- function(x, digits = 1) {
  paste0(round(x * 100, digits), "%")
}

# Quick summary stats
quick_summary <- function(data, group_col = NULL) {
  if (is.null(group_col)) {
    data %>%
      summarise(
        count = n(),
        .groups = "drop"
      )
  } else {
    data %>%
      group_by(across(all_of(group_col))) %>%
      summarise(
        count = n(),
        .groups = "drop"
      )
  }
}