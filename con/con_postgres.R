#### Conexão com o Postgres ####

##### Via ODBC #####
# Dessa maneira é preciso instalar o ODBC na máquina
# con = dbConnect(odbc::odbc(),
#                  Server   = "10.68.14.110",
#                  Database = "postgres",
#                  #Database = rstudioapi::askForPassword("Database name"),
#                  UID      = "convidado",
#                  PWD      = "convidado",
#                  # UID      = rstudioapi::askForPassword("Database user"),
#                  # PWD      = rstudioapi::askForPassword("Database password"),
#                  Port     = 5432,
#                  .connection_string = "Driver={PostgreSQL Unicode};", timeout = 10)

##### VIA JDBC #####
# Dessa maneira é preciso instalar o JAVA na máquina
# drv = JDBC("org.postgresql.Driver","con/postgresql-42.4.0.jar") #lembrar de mudar o local onde o driver JDBC se encontra
# con = dbConnect(drv,
#                 # jdbc:postgresql://host:port/database
#                 url = "jdbc:postgresql://10.68.14.110/postgres",
#                 user = "convidado",
#                 password = "convidado")

##### VIA RPostgres #####
# Apenas usando o pacote Rpostgres
con = dbConnect(RPostgres::Postgres(),
                 host   = "10.68.14.110",
                 dbname = "postgres",
                 user      = "convidado",
                 password      = "convidado",
                 port     = 5432)

# Checar tables do Banco
# dbListTables(con)

# Extração de dados do DB - bolsa_familia
bolsa_familia = dbGetQuery(con, 'SELECT * FROM bolsa_familia')

# Extração de dados do DB- microdados municípios
municipios = dbGetQuery(con, 'SELECT * FROM municipios')
