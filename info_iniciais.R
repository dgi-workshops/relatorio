#### Informações Gerais e Iniciais ####

# Configurando o nosso R para a Língua Portuguesa
Sys.setlocale('LC_TIME', 'pt_BR')
Sys.setlocale('LC_ALL','pt_BR')

# Limpando nossa entradas nulas (NA, NAN e NULLS)
bolsa_familia = na.omit(bolsa_familia)

bolsa_familia = bolsa_familia[!is.na(bolsa_familia$valor_repassado_bolsa_familia),]

# Início do programa
anomes_inicial = min(bolsa_familia$anomes)

# Final do programa
anomes_final = max(bolsa_familia$anomes)

# Definindo nossos cortes
info_corte1 = 2010

info_corte2 = 2004