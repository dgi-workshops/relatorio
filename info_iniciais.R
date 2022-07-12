#### Informações Gerais e Iniciais ####

# Limpando nossa entradas nulas (NA, NAN e NULLS)
bolsa_familia = na.omit(bolsa_familia)

bolsa_familia = bolsa_familia[!is.na(bolsa_familia$valor_repassado_bolsa_familia),]

#início do programa
anomes_inicial = min(bolsa_familia$anomes)

#final do programa
anomes_final = max(bolsa_familia$anomes)

# Definindo nossos cortes
info_corte1 = 2010

info_corte2 = 2004