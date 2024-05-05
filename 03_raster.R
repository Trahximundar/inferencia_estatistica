# Manipulacoes no dado raster

# Convertendo dado raster para data.frame
top.df <- relevo %>% 
          as.data.frame(xy=TRUE) %>% # Convertendo objeto do tipo raster em data.frame mantendo as coordenadas, isso se faz necessario devido ao fato de que a função lm() trabalha com data.frame
          na.omit() %>%  # Removendo valores NA
          dplyr::select(longitude = x,
                        latitude = y,
                        altitude = relevo_minas_gerais) #Renomeando coluna de dados


#Criando um nova variável
temp.mg <- top.df
