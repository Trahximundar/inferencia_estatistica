##################################################################
##script para determinar uma regresão linear múltipla, estimar ###
##valores de temperatura e visualizar os dados através de mapas###
##                                                             ###
##                                                             ###
## adptado por: Everton Peixoto                                ###
## contato:                                                    ###
## instagram:                                                  ###
##################################################################### Limpar a memória #####################################################################################################################################################################################################################################################################
rm(list = ls())

### Remover notação cientifica #####################################################################################################################################################################################################################################################################
# Definir opções para evitar a notação científica e mostrar 10 dígitos após a vírgula
options(scipen = 999, digits = 10)

### Definindo o diretório de trabalho #####################################################################################################################################################################################################################################################################
setwd('C:/Users/Flávia Cristina/Documents/pos/estatistica/Dados Metereologicos/inferencia_estatisica')

### Bibliotecas #####################################################################################################################################################################################################################################################################
# Em uso
library(ggplot2) #Para plotar os dados
library(geobr)   #Para baixar os dados do IBGE
library(raster)  #Para ler e manipular dados espaciais
library(fields)  #Para acessar paleta de cores
library(ggspatial) #Para adicionar os elementos do mapa
library(tidyverse) # Manipulação de dados

library(RPostgreSQL) # Conexão ao bd

library(usethis) # GitHub
library(ggplot2) # Gráficos
library(patchwork) # Mosaico de gráficos

### Conexão o Banco de Dados #####################################################################################################################################################################################################################################################################
nome_banco <- "XXXXXXXXX"

conexao_bd <- dbConnect(dbDriver("PostgreSQL"),
                        dbname = nome_banco,
                        host = "XXXXXXX",
                        port = XXXXXX,
                        user = "XXXXXXXX",
                        password = "XXXXXXXX")

# Lista das tabelas presentes no Banco de dados
tabelas <- dbGetQuery(conexao_bd, "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND table_type = 'BASE TABLE'")



