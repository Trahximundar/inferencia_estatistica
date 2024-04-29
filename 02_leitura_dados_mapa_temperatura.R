#Lendo os dados das estações
dados_temperatura <- read.csv('mapa_temperatura/dados/dados_temperatura.csv')


#Lendo os dados espaciais 
relevo <- raster('mapa_temperatura/dados/relevo_minas_gerais.tif') #Relevo

mg <- read_state(code_state = "MG") #Limite Territorial de MG



#Convertendo dados espaciais para data.frame
top.df <- as.data.frame(relevo,xy=TRUE)
top.df <- na.omit(top.df)

#Renomeando coluna de dados
names(top.df) <- c("long","lat","alt")

#Criando um nova variável
temp.mg <- top.df