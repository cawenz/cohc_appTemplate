# functions/ui_helpers.R
# Simple UI helper functions for consistent styling

# Simple stat card for key metrics
stat_card <- function(title, value, subtitle = NULL) {
  div(
    class = "stat-card",
    div(class = "stat-number", value),
    div(class = "stat-label", title),
    if (!is.null(subtitle)) div(class = "stat-subtitle", subtitle)
  )
}

# Stats grid container
stats_grid <- function(...) {
  div(class = "stats-grid", ...)
}

# Branded card wrapper
app_card <- function(title, ...) {
  div(
    class = "card",
    div(class = "card-header", h4(title)),
    div(class = "card-body", ...)
  )
}

# Key finding callout
key_finding <- function(title, ...) {
  div(
    class = "key-finding",
    h4(title),
    ...
  )
}