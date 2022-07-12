#### Conexão com o Postgres ####

con = dbConnect(odbc::odbc(),
                 Server   = "10.68.14.110",
                 Database = "postgres",
                 #Database = rstudioapi::askForPassword("Database name"),
                 UID      = "convidado",
                 PWD      = "convidado",
                 # UID      = rstudioapi::askForPassword("Database user"),
                 # PWD      = rstudioapi::askForPassword("Database password"),
                 Port     = 5432,
                 .connection_string = "Driver={PostgreSQL Unicode};", timeout = 10)

# Extração de dados do DB - bolsa_familia
bolsa_familia = dbGetQuery(con, 'SELECT * FROM bolsa_familia')

# Extração de dados do DB- microdados municípios
municipios = dbGetQuery(con, 'SELECT * FROM municipios')