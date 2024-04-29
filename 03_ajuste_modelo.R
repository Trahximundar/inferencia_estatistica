#Determinando os coeficientes de regressão
modelo <- lm(formula = temp~longitude+latitude+altitude,data =dados_temperatura)
