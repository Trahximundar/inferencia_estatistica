### Mapa #####################################################################################################################################################################################################################################################################
ggplot(data=temp.mg)+ #Informando os dados de temperatura
        geom_raster(aes(longitude,latitude,fill=temp.cat))+#Definindo colunas de dados e plotando a temperatura
        geom_sf(data = mg,fill='NA')+ #Sobrepondo o limite territorial de Minas Gerais
        scale_fill_manual(values = tim.colors(9))+ #Alterando as cores
        annotation_scale()+ #Inserindo escala no Mapa
        annotation_north_arrow(location="tl", #Inserindo a orientação do mapa 
                               style = north_arrow_fancy_orienteering())+ #Estabelecendo o estilo da orientação
        labs(title = 'Temperatura Média Anual', #Definindo o Título do mapa
             fill='[ºC]',x=NULL,y=NULL)+ #Definindo os Títulos dos eixos e das legendas
        theme_light() #Definindo o tema


#########################################
#####   Salvando o mapa            ######
#########################################
ggsave(filename = 'figuras/mapa_temperatura.png',#nome do arquivo
       width = 12,#Largura 
       height = 10,#Altura
       units = "cm")#Unidade