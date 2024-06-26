##################################################################
##script para determinar uma regres�o linear m�ltipla, estimar ###
##valores de temperatura e visualizar os dados atrav�s de mapas###
##                                                             ###
##                                                             ###
## desenvolvido por: Mercel Santos                             ###
## contato: contato@mercelsantos.com                           ###
## instagram: @mercelsantos                                    ###
##################################################################

#Remove todos objetos da mem�ria
rm(list = ls())

library(ggplot2) #Para plotar os dados
library(geobr)   #Para baixar os dados do IBGE
library(raster)  #Para ler e manipular dados espaciais
library(fields)  #Para acessar paleta de cores
library(ggspatial) #Para adicionar os elementos do mapa

#Definindo o diret�rio de trabalho
setwd('C:/Users/merce/OneDrive/Documents/aulas/mapa_temperatura')


#Lendo os dados das esta��es
dados.temp <- read.csv('dados/dados_temperatura.csv')


#Lendo os dados espaciais 
relevo <- raster('dados/relevo_minas_gerais.tif') #Relevo
mg     <- read_state(code_state = "MG") #Limite Territorial de MG

#Determinando os coeficientes de regress�o
modelo <- lm(formula = temp~longitude+latitude+altitude,data =dados.temp )

#Convertendo dados espaciais para data.frame
top.df <- as.data.frame(relevo,xy=TRUE)
top.df <- na.omit(top.df)

#Renomeando coluna de dados
names(top.df) <- c("long","lat","alt")

#Criando um nova vari�vel
temp.mg <- top.df

#Calculando a temperatura do ar
temp.mg$temp <- 23.49 - 0.25*top.df$long +0.48*top.df$lat-0.0053*top.df$alt

#Determinando as categorias de temperatura
temp.mg$temp.cat <-  cut(temp.mg$temp, breaks=c(8,10,12,14,16,18,20,22,24,26),labels=c('8-10','10-12','12-14','14-16','16-18','18-20','20-22','22-24','24-26'))

#########################################
#####   Plotando o mapa            ######
#########################################
ggplot(data=temp.mg)+ #Informando os dados de temperatura
  geom_raster(aes(long,lat,fill=temp.cat))+#Definindo colunas de dados e plotando a temperatura
  geom_sf(data = mg,fill='NA')+ #Sobrepondo o limite territorial de Minas Gerais
  scale_fill_manual(values = tim.colors(9))+ #Alterando as cores
  annotation_scale()+ #Inserindo escala no Mapa
  annotation_north_arrow(location="tl", #Inserindo a orienta��o do mapa 
                         style = north_arrow_fancy_orienteering())+ #Estabelecendo o estilo da orienta��o
  labs(title = 'Temperatura M�dia Anual', #Definindo o T�tulo do mapa
       fill='[�C]',x=NULL,y=NULL)+ #Definindo os T�tulos dos eixos e das legendas
  theme_light() #Definindo o tema


#########################################
#####   Salvando o mapa            ######
#########################################
ggsave(filename = 'figuras/mapa_temperatura.png',#nome do arquivo
       width = 12,#Largura 
       height = 10,#Altura
       units = "cm")#Unidade

