# navs/gt_demo.R
# Comprehensive demonstration of GT theme capabilities

gt_demo <- nav_panel(
  title = "GT Demo",
  div(
    class = "container-fluid",
    h1("GT Theme Demonstration"),
    p("This page showcases all the GT theme functions and styling options available in the Holy Cross template."),
    
    # Stats overview using helper functions
    stats_grid(
      stat_card("Theme Variants", "6", "Different specialized themes"),
      stat_card("Helper Functions", "8", "Formatting and styling aids"),
      stat_card("Color Options", "Multiple", "Performance indicators")
    ),
    
    # Basic GT theme demonstration
    app_card(
      "Basic GT Theme",
      p("The core gt_theme_cohc() function provides consistent Holy Cross branding with proper fonts, colors, and spacing."),
      gt_output("basic_table")
    ),
    
    # Stats theme
    app_card(
      "Statistics Theme",
      p("The gt_theme_stats() variant is optimized for summary statistics and key metrics with larger fonts and padding."),
      gt_output("stats_table")
    ),
    
    # Financial theme
    app_card(
      "Financial Theme", 
      p("The gt_theme_financial() theme automatically formats currency and percentages, with right-aligned numeric columns."),
      gt_output("financial_table")
    ),
    
    # Performance with color coding
    key_finding(
      "Performance Color Coding",
      p("Tables can include conditional formatting to highlight performance metrics above or below thresholds."),
      gt_output("performance_table")
    ),
    
    # Comparison theme
    app_card(
      "Comparison Theme",
      p("The gt_theme_comparison() theme highlights specific columns for side-by-side analysis."),
      gt_output("comparison_table")
    ),
    
    # Interactive data theme
    app_card(
      "Interactive Data Theme",
      p("The gt_theme_data() theme includes search, filtering, and pagination for large datasets."),
      gt_output("interactive_table")
    ),
    
    # Advanced formatting
    app_card(
      "Advanced Formatting",
      p("Demonstration of spanners, footnotes, and custom styling options available with the themes."),
      gt_output("advanced_table")
    ),
    
    # Theme comparison
    h2("Theme Comparison"),
    p("Below you can see how the same data looks with different theme applications:"),
    
    div(
      class = "row",
      div(
        class = "col-md-6",
        app_card("Standard Theme", gt_output("comparison_standard"))
      ),
      div(
        class = "col-md-6", 
        app_card("Stats Theme", gt_output("comparison_stats"))
      )
    )
  )
)