# enrollment_theme.R
# Custom theme function for the enrollment application

cohc_bslib <- function() {
  bs_theme(
    version = 5,
    # Primary color palette
    primary = "#602D89",
    secondary = "#AC9E94", 
    success = "#602D89",
    info = "#602D89",
    warning = "#AC9E94",
    danger = "#602D89",
    light = "#F4EDEC",
    dark = "#251230",
    
    # Background colors
    bg = "#FFFFFF",
    fg = "#000000",
    
    # Google Fonts - incorporating serif for headings
    base_font = font_google("Manrope"),
    heading_font = font_google("Gelasio", wght = c(400, 500, 600, 700)),
    code_font = font_google("JetBrains Mono")
  ) %>%
    # Add custom SCSS file
    bs_add_rules(sass::sass_file("www/cohc_styles.scss"))
}