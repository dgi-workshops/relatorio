#### Corte 1 - Ano de 2010 ####

##### Analise 2010 por mes (dados para a série histórica) #####
bolsa_familia_2010_mes = bolsa_familia %>% separate(anomes, c('ano', 'mes'), sep =  4)

bolsa_familia_2010_mes$ano = as.numeric(bolsa_familia_2010_mes$ano)

bolsa_familia_2010_mes$mes = as.numeric(bolsa_familia_2010_mes$mes)

bolsa_familia_2010_mes = bolsa_familia_2010_mes %>% filter(ano == 2010)

bolsa_familia_2010_mes = bolsa_familia_2010_mes %>% group_by(mes)

bolsa_familia_2010_mes = bolsa_familia_2010_mes %>% summarise(total_repasse = sum(valor_repassado_bolsa_familia, na.rm = TRUE))

#bolsa_familia_2010_mes$mes = map(bolsa_familia_2010_mes$mes, trocar_mes)

##### Analise 2010 por Município (dados para a estrutura por município) #####
bolsa_familia_2010 = bolsa_familia %>% filter(anomes >= 201001 & anomes <= 201012)

bolsa_familia_2010 = bolsa_familia_2010 %>% group_by(ibge)

bolsa_familia_2010 = bolsa_familia_2010 %>% summarise(total_repasse = sum(valor_repassado_bolsa_familia),
                                                      media_familias = mean(qtd_familias_beneficiarias_bolsa_familia))

names(bolsa_familia_2010) = c('codigo_ibge',
                              'total_repasse',
                              'media_familias')

bolsa_familia_2010 = merge(bolsa_familia_2010, municipios, by = 'codigo_ibge')

bolsa_familia_2010 = bolsa_familia_2010 %>% select(codigo_ibge, nome_municipio,
                                                   sigla_uf, regiao,
                                                   total_repasse, media_familias)

bolsa_familia_2010 = bolsa_familia_2010 %>% arrange(desc(total_repasse))

bolsa_familia_2010$media_familias = map(bolsa_familia_2010$media_familias, formatarNumero)

bolsa_familia_2010$total_repasse = map(bolsa_familia_2010$total_repasse, formatarDinheiro)

names(bolsa_familia_2010) = c('Código Ibge',
                              'Nome do Município',
                              'UF',
                              'Região',
                              'Total do Repasse',
                              'Média de Famílias')


##### Analise 2010 por Região (dados para a estrutura por região) #####
bolsa_familia_2010_regiao = bolsa_familia %>% filter(anomes >= 201001 & anomes <= 201012)

bolsa_familia_2010_regiao = bolsa_familia_2010_regiao %>% group_by(ibge)

bolsa_familia_2010_regiao = bolsa_familia_2010_regiao %>% summarise(total_repasse = sum(valor_repassado_bolsa_familia),
                                                      media_familias = mean(qtd_familias_beneficiarias_bolsa_familia))

names(bolsa_familia_2010_regiao) = c('codigo_ibge',
                              'total_repasse',
                              'media_familias')

bolsa_familia_2010_regiao = merge(bolsa_familia_2010_regiao, municipios, by = 'codigo_ibge')

bolsa_familia_2010_regiao = bolsa_familia_2010_regiao %>% select(codigo_ibge, nome_municipio,
                                                   sigla_uf, regiao,
                                                   total_repasse, media_familias)

bolsa_familia_2010_regiao = bolsa_familia_2010_regiao %>% group_by(regiao)

bolsa_familia_2010_regiao = bolsa_familia_2010_regiao %>%
  summarise(total_repasse = sum(total_repasse, na.rm = TRUE),
            media_familias = round(mean(media_familias, na.rm = TRUE), 2))


#bolsa_familia_2010_regiao$media_familias = map(bolsa_familia_2010_regiao$media_familias, formatarNumero)

#bolsa_familia_2010_regiao$total_repasse = map(bolsa_familia_2010_regiao$total_repasse, formatarDinheiro)
