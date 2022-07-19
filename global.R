#### Funções Customizadas e Configurações ####

##### Pacotes #####

# Carregar e instalar Pacotes Necessários (cran)
packages = c("ggplot2", #pacote para gráfico 
             "readr", #pacote para carregar arquivo csv
             "tidyverse", #
             "DBI", #pacote conexão com o banco
             "purrr", #
             "stringr", #
             "kableExtra",
             "RJDBC",
             "RPostgres") #

if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))
}

lapply(packages, library, character.only = TRUE)


##### Configurações #####
# Não utilização de notação científica:
options(scipen = 999)

# Configurando virgula como separador decimal;
options(OutDec = ",") 

# Configurando sistema para a língua portuguesa pt-BR

# Sys.setlocale("LC_TIME", "pt_BR")
# Sys.setlocale("LC_ALL","pt_BR")

# Conexão Banco de Dados (postgres)
if (c('con') %in% ls() == TRUE && is.null(con) == FALSE){
  # caso verdade para ambos
  # fazer nada, conexão já criada!!
} else{
  # caso uma ou as duas condições falsas
  # criar a conexão!!!!
  source('con/con_postgres.R')
}

# Lista as tabelas pertecentes ao DB
# dbListTables(con)

##### Funções Customizadas #####

###### Dinheiro ######
# Função para limpar strings de dinheiro
limpaFormatacaoDinheiro <- function(x){
  
  x <- str_remove_all(x,"R[$]")
  x <- str_remove_all(x," ")
  x <- str_remove_all(x,"[.]")
  x <- str_remove_all(x,"[-]")
  x <- str_replace_all(x,",",".")
  
  x
  
}


# Formata dinheiro com . como separador de milhares e , como decimal
formatarDinheiro <- function(valores){
  
  paste0("R$ ",format((valores), nsmall=2, big.mark=".", decimal.mark=","))

  
}


###### Data ######

# Formata data para a estrutura numero_mes/ano

formatarData <- function(anomes){
  
  paste0(substr(anomes, 5,6),"/",substr(anomes,1,4))
  
}


# Formata data para a estrutura mês/ano (jun/2022)

formatarData2 <- function(anomes, primeira_maiuscula=F){
  
  mes <- as.numeric(substr(anomes,5,6))
  
  mes <- switch(
    mes,
    "jan",
    "fev",
    "mar",
    "abr",
    "mai",
    "jun",
    "jul",
    "ago",
    "set",
    "out",
    "nov",
    "dez"
  )
  
  paste0(ifelse(primeira_maiuscula,str_to_title(mes), mes),"/",substr(anomes,1,4))
  
}


# Troca o número do mês pela abrevição do mês 
trocar_mes <- function(mes, primeira_maiuscula=F){
  
  mes <- switch(
    mes,
    "jan",
    "fev",
    "mar",
    "abr",
    "mai",
    "jun",
    "jul",
    "ago",
    "set",
    "out",
    "nov",
    "dez"
  )
  paste0(ifelse(primeira_maiuscula,str_to_title(mes), mes))
}


###### Outras #######

# Função para compressão de valores (bilhões, trilhões, ...)
comprss <- function(tx) { 
  
  div <- findInterval(as.numeric(gsub("\\,", "", tx)), 
                      c(0, 1e3, 1e6, 1e9, 1e12) )  # modify this if negative numbers are possible
  paste0(plyr::round_any( as.numeric(gsub("\\,","",tx))/10^(3*(div-1)), accuracy=.1, f=floor),
         c("","K","M","B","T")[div] )
  
}

# Formata porcentagem para um número de casas específicos e retorna string com %
formatarPercentagem <- function(valores, digitos){
  
  paste0(format(round(valores,digits = digitos)*100, big.mark=".", decimal.mark=","), "%")
  
}

# Formata número usando . para milhares e , para decimais
formatarNumero <- function(valores){
  
  format(valores, nsmall = 2, big.mark=".", decimal.mark=",")
  
}

# Formata número apenas usando . para separar milhares
formatarNumero2 <- function(valores){
  
  format(valores, nsmall = 0, big.mark=".")
  
}

# Limpa a URL do SolR

trataURL <- function(url){
  url=gsub("\\s+", " ", str_trim(url))
  url=gsub("[\r\n]", "", url)
  url=gsub(" ", "%20", url)
  url
}

##### Paleta de cores #####

# Paletas de cores em formato RGB (Padrão Serpro) 
# Cores Gradiente 1 - azul/lilás
cores_grad_1 = c('87,145,237', '98,142,244', '130,137,255', '150,126,251' ,'173,121,233', '216,91,239')
# Cores Gradiente 2 - azul/verde
cores_grad_2 = c('36,145,255', '40,160,203', '0,156,193', '54,161,145' ,'0,168,113', '0,169,28')
# Cores Gráfico pizza
cores_pizza = c('36,145,255', '253,68,150', '230,111,14', '0,168,113', '179,140,0')

# Função que converte um vetor RGB para REX
rgb_to_hex = function(vector){
  
  return(sapply(strsplit(vector, ","), function(x)
    rgb(x[1], x[2], x[3], maxColorValue=255)))
  
}
