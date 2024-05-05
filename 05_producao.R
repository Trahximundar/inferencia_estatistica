temperatura_modelo <- predict(modelo, newdata = temp.mg)

temp.mg <- temp.mg %>% 
           dplyr::mutate(temp = temperatura_modelo, #Calculando a temperatura do ar
                         temp.cat = cut(temp, breaks=c(8,10,12,14,16,18,20,22,24,26),
                                        labels=c('8-10','10-12','12-14','14-16','16-18','18-20','20-22','22-24','24-26'))) #Determinando as categorias de temperatura

