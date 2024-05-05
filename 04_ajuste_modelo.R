### Ajuste do modelo #####################################################################################################################################################################################################################################################################
modelo <- lm(formula = temp ~ longitude + latitude + altitude, data = dados_temperatura)

### Tabelas #####################################################################################################################################################################################################################################################################
# Resumo
modelo_resumo <- summary(modelo)
# Valor de p indica se o coeficiente é estatisticamente != 0
# O coeficiente só pode ser interpretado se ele for != de 0
# H0: coeficiente = 0 -> p > 0.05
# H1: coeficiente != 0 -> p <= 0.05
# F-statistic é a comparação entre o modelo nulo e o modelo criado
# Modelo nulo considera só o intercepto
# O valor de p do f-static deve ser menor que 0.05,
# o que indica que o modelo criado é melhor que o modelo nulo
# H0: modelo criado = modelo nulo -> p > 0.05
# H1: modelo criado != modelo nulo -> p <= 0.05

# Residuos
modelo_residuos <- modelo_resumo$residuals

# Valores previstos
modelo_previsao <- predict(modelo)

# Valores reais 
modelo_valores_reais <- dados_temperatura$temp #Substituir o temp

# Tabela de valores
modelo_valores <- tibble(as.data.frame(cbind("Residuos" = modelo_residuos,
                                             "Valores previstos" = modelo_previsao,
                                             "Valores reais" = modelo_valores_reais)))

# R² (Coeficiente de determinação)
modelo_r2 <- modelo_resumo$r.squared

# RMSE (Root Mean Squared Error)
modelo_rmse <- RMSE(dados_temperatura$temp, modelo_previsao) #Substituir o temp

# MAE (Mean Absolute Error)
modelo_mae <- MAE(dados_temperatura$temp, modelo_previsao) #Substituir o temp

# Tabela de coefcientes
modelo_parametros <- tibble(as.data.frame(cbind("R²" = modelo_r2,
                                                "RMSE" = modelo_rmse,
                                                "MAE" = modelo_mae)))
### Presupostos #####################################################################################################################################################################################################################################################################
# Normalidade dos resíduos:
shapiro.test(modelo_residuos)
# H0: distruição dos dados = normal -> p > 0.05
# H1: distruição dos dados != normal -> p <= 0.05

## Outliers nos resíduos:
summary(rstandard(modelo))
# residuos devem ficar entre o intervalo -3 e +3

## Independência dos resíduos (Durbin-Watson):
durbinWatsonTest(modelo)
# D-W Statistic deve estar proxima a 2
# Recomendação D-W Statistic entre 1 e 3
# p-value analisa a correlação entre os residuos, se p-valu for != 0 então os residuos são independentes (os residuos devem ser independetes)

## Homocedasticidade (Breusch-Pagan):
bptest(modelo)
# H0: há homocedasticidade -> p > 0.05
# H1: não há homocedasticidade -> p <= 0.05

# Não deve haver multicolineariadade (correlaão muito alta entre as variaveis dependentes)
# Multicolinearidade: r > 0.9 (ou 0.8)
# Coeficiente de correlão de Pearson
pairs.panels(dados_temperatura)

vif(modelo)
### Multicolinearidade: VIF > 10  VIF - Fator de inflacao

## Obtenção dos coeficientes padronizados
# Util para saber qual a variavel mais relevenate para o modelo
lm.beta(modelo)

## AIC e BIC - Comparação entre quaisquer modelos - AIC Criterio de informacao de akaike, BIC Criterio de informacao beysiano;
# Quanto menor melhor
AIC(modelo)
BIC(modelo)

### Graficos #####################################################################################################################################################################################################################################################################
# Gráfico de dispersão
# Gráfico de dispersão dos valores previstos em relaão aos valores reais
modelo_g1_residuo <- ggplot(data = modelo_valores, aes(x = modelo_previsao, y = modelo_valores_reais)) +
                     geom_point() +
                     geom_abline(intercept = 0, color = "red") +
                     labs(x = "Valores Previstos", y = "Valores Reais") +
                     ggtitle("Gráfico de Dispersão: Valores Previstos vs. Valores Reais")

# Gráfico de Resíduos
# Gráfico de resíduos versus valores ajustados
modelo_g2_residuo <- ggplot(data = modelo_valores, aes(x = modelo_previsao, y = modelo_residuos)) +
                     geom_point() +
                     geom_hline(yintercept = 0, color = "red") +
                     labs(x = "Valores Previstos", y = "Resíduos") +
                     ggtitle("Gráfico de Resíduos: Valores Previstos vs. Resíduos")

# Histograma de Resíduos
# Dados utilizado no histograma
modelo_g3_residuo_padronizado <- modelo_valores %>% 
                                 dplyr::mutate(across(where(is.numeric), scale))

modelo_g3_residuo_padronizado <- as.data.frame(lapply(modelo_g3_residuo_padronizado, unlist))

# Histograma
modelo_g3_residuo <- ggplot(data = modelo_g3_residuo_padronizado, aes(x = Residuos)) +
                     geom_histogram() +
                     labs(x = "Resíduos", y = "Frequência") +
                     ggtitle("Histograma de Resíduos")

# Histograma de Densidade
modelo_g3_residuo_densidade <- ggplot(data = modelo_g3_residuo_padronizado, aes(x = Residuos)) +
                               geom_density(color = "blue", linewidth = 1.5) +
                               labs(title = "Histograma de Densidade dos Resíduos", 
                                    x = "Densidade", 
                                    y = "Resíduos")

# Q-Q Plot
modelo_g4_residuo <- ggplot(data = modelo_valores, aes(sample = modelo_residuos)) +
                     stat_qq() +
                     stat_qq_line() +
                     labs(x = "Quantis Teóricos", y = "Resíduos Observados") +
                     ggtitle("Gráfico Q-Q Plot de Resíduos")

modelo_g5_residuos <- (modelo_g1_residuo + modelo_g2_residuo)/(modelo_g3_residuo + modelo_g4_residuo) +
                       plot_annotation(title = "Analíse dos Resíduos (modelo)",
                                       subtitle = "Temperatura Minas Gerais: inferência estatistica")

# Salvar gráfico
ggsave

# A regressão linear múltipla mostrou que a longitude a latitude e a altitude tem efeito sobre a temperatura. 
# A cada diminuição de 1° de longitude a temperatura diminui em média 0.25 C° (t = -6.02026; p < 0.001). 
# Com relação a latutude, a cada aumento de 1° na latitude, a temperatura diminui em média 0.4 C° (t = 12.09026; p < 0.001).
# E por fim, a cada 1m de aumento na altitude a temperatura dimunui 0.005 C° (t = -15.06991; p < 0.001).




