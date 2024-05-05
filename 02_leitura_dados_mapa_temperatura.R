#Lendo os dados das estações
dados_temperatura <- read.csv("C:/Users/Flávia Cristina/Documents/02_Data_Science/02_Inferencia_Estatistica/inferencia_estatistica/dados/dados_temperatura.csv") %>% 
                     dplyr::filter(!is.na(temp)) # Removendo os registros onde temp e NA

#Lendo o dado raster 
relevo <- raster::raster("C:/Users/Flávia Cristina/Documents/02_Data_Science/02_Inferencia_Estatistica/inferencia_estatistica/dados/relevo_minas_gerais.tif") %>% 
          raster::projectRaster(crs = 4326)
  
#Lendo o .shp do estado 
mg <- read_state(code_state = "MG") %>%  #Limite Territorial de MG
      sf::st_transform(crs = 4326)
  

