# functions/gt_theme.R
# GT theme functions that match Holy Cross branding

# Main GT theme function
gt_theme_cohc <- function(gt_table, 
                          table_width = "100%",
                          header_bg = "#602D89",
                          header_color = "#FFFFFF",
                          stripe_color = "#FAFAFA",
                          border_color = "#AC9E94",
                          auto_align = TRUE) {
  
  themed_table <- gt_table %>%
    # Font styling
    tab_options(
      table.font.names = "Manrope",
      table.font.size = px(14),
      table.width = table_width,
      
      # Header styling
      heading.title.font.size = px(18),
      heading.title.font.weight = "600",
      heading.subtitle.font.size = px(14),
      heading.subtitle.font.weight = "400",
      
      # Column labels
      column_labels.font.size = px(13),
      column_labels.font.weight = "600",
      column_labels.background.color = header_bg,
      column_labels.padding = px(12),
      column_labels.border.top.style = "none",
      column_labels.border.bottom.style = "none",
      
      # Table body
      data_row.padding = px(10),
      
      # Borders and stripes
      table.border.top.style = "none",
      table.border.bottom.style = "solid",
      table.border.bottom.width = px(2),
      table.border.bottom.color = border_color,
      table_body.border.bottom.style = "solid",
      table_body.border.bottom.width = px(1),
      table_body.border.bottom.color = "#F4EDEC",
      
      # Row styling
      row.striping.background_color = stripe_color,
      row.striping.include_table_body = TRUE
    ) %>%
    # Custom CSS for styling not available in tab_options
    opt_css(
      css = paste0("
        .gt_table {
          border-radius: 8px;
          overflow: hidden;
          box-shadow: 0 2px 8px rgba(37, 18, 48, 0.08);
        }
        
        .gt_heading {
          background-color: transparent;
          border-bottom: 2px solid #602D89;
          padding-bottom: 8px;
        }
        
        .gt_title {
          font-family: 'Gelasio', serif !important;
          color: #251230 !important;
          font-weight: 600 !important;
        }
        
        .gt_subtitle {
          color: #666666 !important;
          font-style: italic;
        }
        
        .gt_col_headings {
          background-color: ", header_bg, " !important;
        }
        
        .gt_col_heading {
          color: ", header_color, " !important;
          text-transform: uppercase;
          letter-spacing: 0.5px;
          font-weight: 600;
        }
        
        .gt_column_spanner {
          background-color: ", header_bg, " !important;
          color: ", header_color, " !important;
          font-weight: 600;
        }
        
        .gt_row:hover {
          background-color: #F4EDEC !important;
        }
        
        .gt_sourcenotes {
          background-color: #FAFAFA;
          border-top: 1px solid #AC9E94;
          color: #666666;
          font-size: 12px;
        }
        
        .gt_footnotes {
          color: #666666;
          font-size: 12px;
        }
        
        .gt_table_body {
          font-size: 13px;
        }
      ")
    )
  
  # Apply automatic alignment if enabled
  if (auto_align) {
    themed_table <- themed_table %>%
      cols_align(align = "center", columns = where(is.numeric)) %>%
      cols_align(align = "left", columns = where(is.character)) %>%
      cols_align(align = "left", columns = where(is.factor))
  }
  
  return(themed_table)
}

# Specialized themes for different table types

# Summary/stats table theme
gt_theme_stats <- function(gt_table) {
  gt_table %>%
    gt_theme_cohc() %>%
    tab_options(
      table.font.size = px(15),
      data_row.padding = px(14)
    ) %>%
    # Style numeric columns
    fmt_number(
      columns = where(is.numeric),
      decimals = 1,
      use_seps = TRUE
    )
}

# Data overview table theme (for larger datasets)
gt_theme_data <- function(gt_table) {
  gt_table %>%
    gt_theme_cohc() %>%
    tab_options(
      table.font.size = px(12),
      data_row.padding = px(8),
      column_labels.padding = px(10)
    )
  # Removed opt_interactive() as it may be causing the error
}

# Financial/numeric heavy table theme
gt_theme_financial <- function(gt_table) {
  gt_table %>%
    gt_theme_cohc() %>%
    tab_options(
      table.font.size = px(13),
      data_row.padding = px(12)
    ) %>%
    # Right-align numeric columns
    cols_align(
      align = "right",
      columns = where(is.numeric)
    ) %>%
    # Format currency if detected
    fmt_currency(
      columns = contains(c("cost", "price", "amount", "revenue", "budget")),
      currency = "USD",
      decimals = 0
    ) %>%
    # Format percentages if detected
    fmt_percent(
      columns = contains(c("rate", "percent", "pct")),
      decimals = 1
    )
}

# Comparison table theme (for side-by-side comparisons)
gt_theme_comparison <- function(gt_table, 
                                highlight_cols = NULL,
                                highlight_color = "#F4EDEC") {
  
  theme_table <- gt_table %>%
    gt_theme_cohc() %>%
    tab_options(
      table.font.size = px(13),
      data_row.padding = px(12)
    )
  
  # Highlight specific columns if provided
  if (!is.null(highlight_cols)) {
    theme_table <- theme_table %>%
      tab_style(
        style = cell_fill(color = highlight_color),
        locations = cells_body(columns = all_of(highlight_cols))
      )
  }
  
  theme_table
}

# Helper functions for common GT formatting

# Add Holy Cross branded title and subtitle
add_cohc_header <- function(gt_table, title, subtitle = NULL) {
  if (is.null(subtitle)) {
    gt_table %>%
      tab_header(title = title)
  } else {
    gt_table %>%
      tab_header(
        title = title,
        subtitle = subtitle
      )
  }
}

# Add branded source note
add_cohc_source <- function(gt_table, source_text) {
  gt_table %>%
    tab_source_note(
      source_note = paste("Source:", source_text)
    )
}

# Color-code values based on thresholds
color_performance <- function(gt_table, 
                              column, 
                              good_threshold = 0.8, 
                              poor_threshold = 0.6,
                              higher_is_better = TRUE) {
  
  if (higher_is_better) {
    gt_table %>%
      tab_style(
        style = list(
          cell_fill(color = "#d4edda"),
          cell_text(color = "#155724", weight = "600")
        ),
        locations = cells_body(
          columns = all_of(column),
          rows = get(column) >= good_threshold
        )
      ) %>%
      tab_style(
        style = list(
          cell_fill(color = "#f8d7da"),
          cell_text(color = "#721c24", weight = "600")
        ),
        locations = cells_body(
          columns = all_of(column),
          rows = get(column) <= poor_threshold
        )
      )
  } else {
    gt_table %>%
      tab_style(
        style = list(
          cell_fill(color = "#d4edda"),
          cell_text(color = "#155724", weight = "600")
        ),
        locations = cells_body(
          columns = all_of(column),
          rows = get(column) <= poor_threshold
        )
      ) %>%
      tab_style(
        style = list(
          cell_fill(color = "#f8d7da"),
          cell_text(color = "#721c24", weight = "600")
        ),
        locations = cells_body(
          columns = all_of(column),
          rows = get(column) >= good_threshold
        )
      )
  }
}

# Example usage functions (commented out for reference)
# 
# # Basic usage:
# my_data %>%
#   gt() %>%
#   gt_theme_cohc() %>%
#   add_cohc_header("Student Enrollment", "Fall 2024 Data")
# 
# # Stats table:
# summary_stats %>%
#   gt() %>%
#   gt_theme_stats() %>%
#   add_cohc_header("Key Metrics")
# 
# # Interactive data table:
# large_dataset %>%
#   gt() %>%
#   gt_theme_data() %>%
#   add_cohc_header("Complete Dataset", "Interactive table with search and filters")
# 
# # Financial data:
# budget_data %>%
#   gt() %>%
#   gt_theme_financial() %>%
#   add_cohc_header("Budget Overview", "FY 2024-2025")
# 
# # Performance with color coding:
# performance_data %>%
#   gt() %>%
#   gt_theme_cohc() %>%
#   color_performance("success_rate", 0.85, 0.70) %>%
#   add_cohc_header("Performance Metrics")