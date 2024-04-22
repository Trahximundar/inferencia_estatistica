### Limpar a memória #####################################################################################################################################################################################################################################################################
rm(list = ls())

### Remover notação cientifica #####################################################################################################################################################################################################################################################################
# Definir opções para evitar a notação científica e mostrar 10 dígitos após a vírgula
options(scipen = 999, digits = 10)

### Bibliotecas #####################################################################################################################################################################################################################################################################
# Em uso
library(RPostgreSQL) # Conexão ao bd
library(tidyverse) # Manipulação de dados
library(usethis) # GitHub
library(ggplot2) # Gráficos
library(patchwork) # Mosaico de gráficos

### Conexão o Banco de Dados #####################################################################################################################################################################################################################################################################
nome_banco <- "house_price"

conexao_bd <- dbConnect(dbDriver("PostgreSQL"),
                        dbname = nome_banco,
                        host = "localhost",
                        port = 5432,
                        user = "postgres",
                        password = "predator1602669")

# Lista das tabelas presentes no Banco de dados
tabelas <- dbGetQuery(conexao_bd, "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND table_type = 'BASE TABLE'")



