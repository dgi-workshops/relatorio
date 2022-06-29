# Script for Postgres Connection

library(DBI)
con <- dbConnect(odbc::odbc(),
                 Server   = "10.68.14.110",
                 Database = "postgres",
                 #Database = rstudioapi::askForPassword("Database name"),
                 UID      = rstudioapi::askForPassword("Database user"),
                 PWD      = rstudioapi::askForPassword("Database password"),
                 Port     = 5432,
                 .connection_string = "Driver={PostgreSQL Unicode};", timeout = 10)
