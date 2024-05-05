#Determinando as categorias de temperatura
temp.mg$temp.cat <-  cut(temp.mg$temp, breaks=c(8,10,12,14,16,18,20,22,24,26),
                                       labels=c('8-10','10-12','12-14','14-16','16-18','18-20','20-22','22-24','24-26'))

