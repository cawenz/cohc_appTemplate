# This is where database config functions will live


# EXAMPLES 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# DB_CONFIG <- list(
#   # SQLite (local file)
#   sqlite = list(
#     driver = "SQLite",
#     path = "data/app_data.db"
#   ),
#   
#   # MySQL/MariaDB (if you use central databases)
#   mysql = list(
#     driver = "MySQL",
#     host = Sys.getenv("DB_HOST", "localhost"),
#     port = as.integer(Sys.getenv("DB_PORT", "3306")),
#     database = Sys.getenv("DB_NAME", ""),
#     username = Sys.getenv("DB_USER", ""),
#     password = Sys.getenv("DB_PASS", "")
#   )
# )
# 
# # Helper function to get database connection
# get_db_connection <- function(type = "sqlite") {
#   config <- DB_CONFIG[[type]]
#   
#   switch(type,
#          "sqlite" = {
#            DBI::dbConnect(RSQLite::SQLite(), config$path)
#          },
#          "mysql" = {
#            DBI::dbConnect(
#              RMariaDB::MariaDB(),
#              host = config$host,
#              port = config$port,
#              dbname = config$database,
#              username = config$username,
#              password = config$password
#            )
#          }
#   )
# }