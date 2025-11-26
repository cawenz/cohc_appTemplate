get_config <- function(key, default = NULL, config = APP_CONFIG) {
  if (key %in% names(config)) {
    config[[key]]
  } else {
    default
  }
}

# Check if feature is enabled
feature_enabled <- function(feature_name) {
  get_config(feature_name, FALSE)
}

# Get app info for display
get_app_info <- function() {
  paste0(
    get_config("name", "Shiny App"), 
    " v", 
    get_config("version", "1.0.0")
  )
}

# Validate configuration
validate_config <- function() {
  required_keys <- c("name", "version", "navbar_title")
  missing_keys <- setdiff(required_keys, names(APP_CONFIG))
  
  if (length(missing_keys) > 0) {
    stop("Missing required config keys: ", paste(missing_keys, collapse = ", "))
  }
  
  TRUE
}

# Load environment variables if they exist
load_env_vars <- function() {
  # Check for .env file (if using dotenv package)
  if (file.exists(".env")) {
    # dotenv::load_dot_env()  # Uncomment if using dotenv package
  }
}