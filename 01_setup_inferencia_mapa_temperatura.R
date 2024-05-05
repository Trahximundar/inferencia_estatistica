##################################################################
##script para determinar uma regresão linear múltipla, estimar ###
##valores de temperatura e visualizar os dados através de mapas###
##                                                             ###
##                                                             ###
## adptado por: Everton Peixoto                                ###
## contato:                                                    ###
## instagram:                                                  ###

### Limpar a memória #####################################################################################################################################################################################################################################################################
rm(list = ls())

### Remover notação cientifica #####################################################################################################################################################################################################################################################################
# Definir opções para evitar a notação científica e mostrar 10 dígitos após a vírgula
options(scipen = 999, digits = 10)

### Definindo o diretório de trabalho #####################################################################################################################################################################################################################################################################
setwd('C:/Users/Flávia Cristina/Documents/02_Data_Science/02_Inferencia_Estatistica/inferencia_estatistica')

### Bibliotecas #####################################################################################################################################################################################################################################################################
# Em uso
library(ggplot2) #Para plotar os dados
library(geobr)   #Para baixar os dados do IBGE
library(raster)  #Para ler e manipular dados espaciais
library(fields)  #Para acessar paleta de cores
library(ggspatial) #Para adicionar os elementos do mapa
library(tidyverse) # Manipulação de dados
library(sf) #Trabalhar com dados espaciais
library(leaflet) #Mapas interativos
library(caret) # Biblioteca para regressão
library(patchwork) # Mosaico de graficos
library(car) # Teste normalidade (Durbin-Watson)
library(lmtest) # Teste Homocedasticidade (Breusch-Pagan)
library(psych) # Pairplot
# library(QuantPsych) # Funcao lm.beta - coeficientes padronizados, util para saber qual a variavel mais relevenate para o modelo



# Pressupostos da regressão linear:
# relação linear entre as variaveis;
# normalidade;
# homocedasticidade;
# ausencia de outliers;
# indepedencia dos residuos

