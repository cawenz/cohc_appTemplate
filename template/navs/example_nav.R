# navs/example_nav.R
# Example navigation panel showing how to use the helper functions

example_nav <- nav_panel(
  title = "Overview",
  div(
    class = "container-fluid",
    h1("Application Overview"),
    p("This is an example page demonstrating the Holy Cross branded styling and helper functions."),
    
    # Example stats using helper functions
    stats_grid(
      stat_card("Total Records", "1,234"),
      stat_card("Average Score", "87.5", "Above target"),
      stat_card("Success Rate", "92%", "Excellent")
    ),
    
    # Example key finding
    key_finding(
      "Important Insight",
      p("This callout box highlights important findings or insights using the branded styling.")
    ),
    
    # Example card with content
    app_card(
      "Sample Data Table",
      p("This table demonstrates the branded GT styling with Holy Cross colors and fonts."),
      gt_output("example_table")
    ),
    
    # Example regular content
    h2("Additional Content"),
    p("You can add regular content using standard HTML/Shiny elements. The typography and spacing will automatically follow the Holy Cross brand guidelines.")
  )
)