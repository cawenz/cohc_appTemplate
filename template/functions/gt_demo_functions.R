# functions/gt_demo_functions.R
# All data generation and server logic for GT demo

# Sample data generation function
create_sample_data <- function() {
  
  # Basic enrollment data
  enrollment_data <- tibble(
    Class = c("First Year", "Sophomore", "Junior", "Senior"),
    Students = c(847, 798, 763, 692),
    Percentage = c(27.1, 25.5, 24.4, 22.1),
    Retention_Rate = c(0.943, 0.918, 0.932, 0.896)
  )
  
  # Financial/budget data
  budget_data <- tibble(
    Department = c("Academic Affairs", "Student Life", "Athletics", "Administration", "Facilities"),
    Budget_2024 = c(15600000, 8900000, 4200000, 7800000, 12300000),
    Spent_YTD = c(11200000, 6100000, 3100000, 5600000, 8900000),
    Percent_Used = c(0.718, 0.685, 0.738, 0.718, 0.723),
    Change_from_2023 = c(0.045, -0.023, 0.087, 0.012, 0.034)
  )
  
  # Performance metrics data
  performance_data <- tibble(
    Metric = c("Graduation Rate", "First-Year Retention", "Job Placement", "Graduate School", "Alumni Satisfaction"),
    Current_Rate = c(0.892, 0.943, 0.847, 0.234, 0.918),
    Target = c(0.850, 0.920, 0.800, 0.200, 0.900),
    Status = c("Above Target", "Above Target", "Above Target", "Above Target", "Above Target")
  )
  
  # Department comparison data
  comparison_data <- tibble(
    Department = c("Biology", "Psychology", "Economics", "English", "Mathematics"),
    Last_Year = c(245, 189, 167, 201, 98),
    This_Year = c(263, 195, 142, 218, 105),
    Change = c(0.073, 0.032, -0.150, 0.085, 0.071),
    Avg_GPA = c(3.42, 3.51, 3.38, 3.67, 3.29)
  )
  
  # Large dataset for interactive demo
  interactive_data <- tibble(
    Student_ID = sprintf("HC%05d", 1:150),
    Name = paste(
      sample(c("Alex", "Jordan", "Casey", "Morgan", "Taylor", "Avery", "Riley", "Quinn"), 150, replace = TRUE),
      sample(c("Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis"), 150, replace = TRUE)
    ),
    Class = sample(c("First Year", "Sophomore", "Junior", "Senior"), 150, replace = TRUE),
    Major = sample(c("Biology", "Psychology", "Economics", "English", "Mathematics", "Art", "History", "Chemistry"), 150, replace = TRUE),
    GPA = round(runif(150, 2.0, 4.0), 2),
    Credits = sample(15:140, 150, replace = TRUE),
    Status = sample(c("Good Standing", "Dean's List", "Probation"), 150, replace = TRUE, prob = c(0.7, 0.25, 0.05))
  )
  
  # Advanced formatting data
  advanced_data <- tibble(
    Region = c("New England", "Mid-Atlantic", "Southeast", "Midwest", "West"),
    Applications = c(1247, 892, 634, 445, 289),
    Admitted = c(523, 378, 267, 189, 122),
    Enrolled = c(189, 134, 95, 67, 43),
    Yield_Rate = Enrolled / Admitted,
    SAT_Average = c(1340, 1325, 1310, 1295, 1355)
  )
  
  # Comparison base data
  comparison_base_data <- tibble(
    Category = c("Students", "Faculty", "Staff"),
    Count = c(3100, 312, 445),
    Percentage = c(78.6, 7.9, 11.3)
  )
  
  list(
    enrollment = enrollment_data,
    budget = budget_data,
    performance = performance_data,
    comparison = comparison_data,
    interactive = interactive_data,
    advanced = advanced_data,
    comparison_base = comparison_base_data
  )
}

# GT demo server functions - each output as a separate function

gt_demo_basic_table <- function() {
  sample_data <- create_sample_data()
  
  sample_data$enrollment %>%
    gt() %>%
    gt_theme_cohc() %>%
    add_cohc_header(
      "Student Enrollment by Class",
      "Fall 2024 Academic Year"
    ) %>%
    fmt_number(columns = Students, decimals = 0) %>%
    fmt_percent(columns = c(Percentage, Retention_Rate), decimals = 1) %>%
    cols_label(
      Class = "Class Level",
      Students = "Total Students",
      Percentage = "% of Total",
      Retention_Rate = "Retention Rate"
    ) %>%
    add_cohc_source("Office of Institutional Research")
}

gt_demo_stats_table <- function() {
  tibble(
    Metric = c("Total Enrollment", "Faculty-Student Ratio", "Average Class Size", "Graduation Rate"),
    Value = c("3,100", "11:1", "19", "89.2%"),
    Comparison = c("↑ 2.1%", "→ Same", "↓ 1 student", "↑ 1.3%")
  ) %>%
    gt() %>%
    gt_theme_stats() %>%
    add_cohc_header("Key Institutional Metrics") %>%
    cols_label(
      Metric = "Measure",
      Value = "Current Value", 
      Comparison = "vs. Last Year"
    ) %>%
    tab_style(
      style = cell_text(color = "#602D89", weight = "bold"),
      locations = cells_body(columns = Comparison)
    )
}

gt_demo_financial_table <- function() {
  sample_data <- create_sample_data()
  
  sample_data$budget %>%
    gt() %>%
    gt_theme_financial() %>%
    add_cohc_header(
      "Departmental Budget Overview",
      "FY 2024-2025 Mid-Year Report"
    ) %>%
    cols_label(
      Department = "Department",
      Budget_2024 = "Annual Budget",
      Spent_YTD = "Spent YTD",
      Percent_Used = "% Used",
      Change_from_2023 = "Change from 2023"
    ) %>%
    tab_style(
      style = cell_fill(color = "#F4EDEC"),
      locations = cells_body(columns = Percent_Used, rows = Percent_Used > 0.75)
    ) %>%
    add_cohc_source("Office of Finance")
}

gt_demo_performance_table <- function() {
  sample_data <- create_sample_data()
  
  sample_data$performance %>%
    gt() %>%
    gt_theme_cohc() %>%
    add_cohc_header("Institutional Performance Metrics") %>%
    color_performance("Current_Rate", 0.85, 0.75, higher_is_better = TRUE) %>%
    fmt_percent(columns = c(Current_Rate, Target), decimals = 1) %>%
    cols_label(
      Metric = "Performance Area",
      Current_Rate = "Current Rate",
      Target = "Target Rate",
      Status = "Status"
    ) %>%
    tab_footnote(
      footnote = "Green indicates above 85%, red indicates below 75%",
      locations = cells_column_labels(columns = Current_Rate)
    )
}

gt_demo_comparison_table <- function() {
  sample_data <- create_sample_data()
  
  sample_data$comparison %>%
    gt() %>%
    gt_theme_comparison(
      highlight_cols = c("This_Year", "Change"),
      highlight_color = "#F4EDEC"
    ) %>%
    add_cohc_header("Department Enrollment Comparison") %>%
    fmt_percent(columns = Change, decimals = 1) %>%
    fmt_number(columns = c(Last_Year, This_Year), decimals = 0) %>%
    fmt_number(columns = Avg_GPA, decimals = 2) %>%
    cols_label(
      Department = "Department",
      Last_Year = "2023",
      This_Year = "2024", 
      Change = "% Change",
      Avg_GPA = "Avg GPA"
    )
}

gt_demo_interactive_table <- function() {
  # Create comprehensive data showing various GT features
  interactive_data <- tibble(
    Student_ID = sprintf("HC%05d", 1:25),
    Name = c("Alex Smith", "Jordan Johnson", "Casey Williams", "Morgan Brown", "Taylor Jones", 
             "Avery Garcia", "Riley Miller", "Quinn Davis", "Blake Wilson", "Cameron Moore",
             "Drew Anderson", "Sage Thompson", "River Clark", "Phoenix Lee", "Skylar White",
             "Rowan Harris", "Ellis Martin", "Finley Garcia", "Emery Rodriguez", "Kendall Lewis",
             "Reese Walker", "Dakota Hall", "Hayden Allen", "Justice Young", "Parker King"),
    Class = rep(c("First Year", "Sophomore", "Junior", "Senior", "Graduate"), 5),
    Major = c("Biology", "Psychology", "Economics", "English", "Mathematics", 
              "Art", "History", "Chemistry", "Physics", "Computer Science",
              "Political Science", "Sociology", "Philosophy", "Music", "Theater",
              "Environmental Studies", "International Studies", "Education", "Nursing", "Business",
              "Anthropology", "Religious Studies", "Studio Art", "Literature", "Film Studies"),
    GPA = c(3.42, 3.67, 2.89, 3.91, 3.23, 3.78, 3.45, 3.12, 3.89, 3.56,
            2.95, 3.74, 3.33, 3.82, 3.19, 3.65, 3.28, 3.47, 3.93, 3.15,
            3.71, 3.38, 3.84, 3.52, 3.26),
    Credits = c(32, 67, 89, 124, 156, 71, 95, 118, 31, 63,
                45, 78, 102, 125, 48, 82, 98, 119, 35, 69,
                87, 103, 127, 52, 76),
    Status = c("Good Standing", "Dean's List", "Good Standing", "Dean's List", "Good Standing",
               "Dean's List", "Good Standing", "Good Standing", "Dean's List", "Good Standing",
               "Good Standing", "Dean's List", "Probation", "Good Standing", "Good Standing",
               "Good Standing", "Good Standing", "Dean's List", "Dean's List", "Good Standing",
               "Good Standing", "Dean's List", "Dean's List", "Good Standing", "Good Standing")
  )
  
  interactive_data %>%
    gt() %>%
    # Use the interactive theme instead of regular theme
    gt_theme_interactive() %>%
    add_cohc_header(
      "Student Records Database",
      "Interactive table with search, filter, and pagination"
    ) %>%
    # Formatting
    fmt_number(columns = GPA, decimals = 2) %>%
    fmt_number(columns = Credits, decimals = 0) %>%
    # Column labels
    cols_label(
      Student_ID = "Student ID",
      Name = "Full Name",
      Class = "Class Level",
      Major = "Academic Major",
      GPA = "Cumulative GPA",
      Credits = "Total Credits",
      Status = "Academic Status"
    ) %>%
    # Column grouping with spanners
    tab_spanner(
      label = "Student Information",
      columns = c(Student_ID, Name, Class)
    ) %>%
    tab_spanner(
      label = "Academic Record",
      columns = c(Major, GPA, Credits, Status)
    ) %>%
    # Conditional formatting for GPA (using row numbers to avoid condition errors)
    tab_style(
      style = list(
        cell_fill(color = "#d4edda"),
        cell_text(color = "#155724", weight = "600")
      ),
      locations = cells_body(
        columns = GPA,
        rows = c(2, 4, 9, 12, 14, 18, 19, 22, 23) # High GPA students
      )
    ) %>%
    tab_style(
      style = list(
        cell_fill(color = "#f8d7da"),
        cell_text(color = "#721c24", weight = "600")
      ),
      locations = cells_body(
        columns = Status,
        rows = 13 # Probation student
      )
    ) %>%
    # Color code by class level
    tab_style(
      style = cell_fill(color = "#FFF3E0"),
      locations = cells_body(columns = Class, rows = c(1, 6, 11, 16, 21)) # First Year
    ) %>%
    tab_style(
      style = cell_fill(color = "#E8F5E8"),
      locations = cells_body(columns = Class, rows = c(4, 9, 14, 19, 24)) # Senior
    ) %>%
    # Footnotes
    tab_footnote(
      footnote = "Students with GPA ≥ 3.75 highlighted in green",
      locations = cells_column_labels(columns = GPA)
    ) %>%
    tab_footnote(
      footnote = "Interactive features: Use search box, column filters, and pagination",
      locations = cells_title()
    ) %>%
    # Source note
    add_cohc_source("Office of the Registrar") %>%
    # Finally add interactive features
    opt_interactive(
      use_search = TRUE,
      use_filters = TRUE,
      use_pagination = TRUE,
      page_size_default = 10
    )
}

gt_demo_advanced_table <- function() {
  sample_data <- create_sample_data()
  
  sample_data$advanced %>%
    gt() %>%
    gt_theme_cohc() %>%
    add_cohc_header("Regional Admissions Analysis", "Applications, Admissions, and Enrollment by Region") %>%
    tab_spanner(
      label = "Application Process",
      columns = c(Applications, Admitted, Enrolled)
    ) %>%
    tab_spanner(
      label = "Performance Metrics", 
      columns = c(Yield_Rate, SAT_Average)
    ) %>%
    fmt_number(columns = c(Applications, Admitted, Enrolled, SAT_Average), decimals = 0) %>%
    fmt_percent(columns = Yield_Rate, decimals = 1) %>%
    cols_label(
      Region = "Geographic Region",
      Applications = "Applied",
      Admitted = "Admitted",
      Enrolled = "Enrolled",
      Yield_Rate = "Yield Rate",
      SAT_Average = "Avg SAT"
    ) %>%
    tab_footnote(
      footnote = "Yield rate calculated as enrolled divided by admitted students",
      locations = cells_column_labels(columns = Yield_Rate)
    ) %>%
    tab_footnote(
      footnote = "SAT scores based on students who submitted scores",
      locations = cells_column_labels(columns = SAT_Average)
    ) %>%
    add_cohc_source("Office of Admissions")
}

gt_demo_comparison_standard <- function() {
  sample_data <- create_sample_data()
  
  sample_data$comparison_base %>%
    gt() %>%
    gt_theme_cohc() %>%
    tab_header(title = "Standard Theme") %>%
    fmt_number(columns = Count, decimals = 0) %>%
    fmt_percent(columns = Percentage, decimals = 1)
}

gt_demo_comparison_stats <- function() {
  sample_data <- create_sample_data()
  
  sample_data$comparison_base %>%
    gt() %>%
    gt_theme_stats() %>%
    tab_header(title = "Stats Theme") %>%
    fmt_number(columns = Count, decimals = 0) %>%
    fmt_percent(columns = Percentage, decimals = 1)
}