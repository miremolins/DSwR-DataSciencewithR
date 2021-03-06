##=========================================================================##
##                                                                         ##
##  DATA SCIENCE AMB R                                                     ##
##  Gapminder                                                              ##
##  @authors: Marc Macori, Julia Martinez, Mireia Molins                   ##
##                                                                         ##
##  Required datasets: quan ho tinguem sha d posar.zip                                                ##
##                                                                         ##
##=========================================================================##
#libraries in use
if(!require("readr")) {
  install.packages("readr")
  library("readr")
}
if(!require("reshape2")) {
  install.packages("reshape2")
  library("reshape2")
}
if(!require("dplyr")) {
  install.packages("dplyr")
  library("dplyr")
}
if(!require("plotly")) {
  install.packages("plotly")
  library("plotly")
}
if(!require("ggiraph")) {
  install.packages("ggiraph")
  library("ggiraph")
}
#Dataset Creation
childmortality1<- read.csv("Datos/child_mortality_0_5_year_olds_dying_per_1000_born.csv",check.names = FALSE)
childrenperwoman1<- read.csv("Datos/children_per_woman_total_fertility.csv",check.names = FALSE)
co2emissions1<-read.csv("Datos/co2_emissions_tonnes_per_person.csv",check.names = FALSE)
incomeperperson1<-read.csv("Datos/income_per_person_gdppercapita_ppp_inflation_adjusted.csv",check.names = FALSE)
lifeexpectancy1<- read.csv("Datos/life_expectancy_years.csv",check.names = FALSE)
population1<- read.csv("Datos/population_total.csv",check.names = FALSE)
democracyindex1<-read.csv("Datos/democracy_score_use_as_color.csv",check.names = FALSE)
#coordenadasdata
coord1<-read_delim("geolocation.csv", 
                   "\t", escape_double = FALSE, 
                   trim_ws = TRUE)
coord1<-coord1[,-1]
colnames(coord1)[3] <- c("country")
coord1$latitude<-as.numeric(as.character(coord1$latitude))
coord1$longitude<-as.numeric(as.character(coord1$longitude))

childmortality1<-melt(childmortality1,id.vars="country", variable.name = "Years", value.name="ChildMortality", na.rm = TRUE)
childrenperwoman1<-melt(childrenperwoman1,id.vars="country", variable.name = "Years", value.name="ChildrenPerWoman", na.rm = TRUE)
co2emissions1<-melt(co2emissions1,id.vars="country", variable.name = "Years", value.name="CO2Emissions", na.rm = TRUE)
incomeperperson1<-melt(incomeperperson1,id.vars="country", variable.name = "Years", value.name="IncomePerPerson", na.rm = TRUE)
lifeexpectancy1<-melt(lifeexpectancy1,id.vars="country", variable.name = "Years", value.name="LifeExpectancy", na.rm = TRUE)
population1<-melt(population1,id.vars="country", variable.name = "Years", value.name="Population", na.rm = TRUE)
democracyindex1<-melt(democracyindex1,id.vars="country", variable.name = "Years", value.name="DemocracyIndex", na.rm = TRUE)

childmortality1$Years<- as.numeric(as.character(childmortality1$Years))
childrenperwoman1$Years<- as.numeric(as.character(childrenperwoman1$Years))
co2emissions1$Years<- as.numeric(as.character(co2emissions1$Years))
incomeperperson1$Years<- as.numeric(as.character(incomeperperson1$Years))
lifeexpectancy1$Years<- as.numeric(as.character(lifeexpectancy1$Years))
population1$Years<- as.numeric(as.character(population1$Years))
democracyindex1$Years<-as.numeric((as.character(democracyindex1$Years)))
countrydata<-read.csv("https://raw.githubusercontent.com/lukes/ISO-3166-Countries-with-Regional-Codes/master/all/all.csv",stringsAsFactors = FALSE, check.names = FALSE)
colnames(countrydata)[1] <- c("country")
colnames(countrydata)[6] <- c("Region")
colnames(countrydata)[7] <- c("Sub.Region")
countrydata<-transmute(countrydata,country, Region, Sub.Region)
countrydata[27,1]<-"Bolivia"
countrydata[34,1]<-"Brunei"
countrydata[38,1]<-"Cape Verde"
countrydata[52,1]<-"Congo, Dem. Rep."
countrydata[51,1]<-"Congo, Rep."
countrydata[55,1]<-"Cote d'Ivoire"
countrydata[60,1]<-"Czech Republic"
countrydata[106,1]<-"Iran"
countrydata[122,1]<-"Kyrgyz Republic"
countrydata[123,1]<-"Lao"
countrydata[145,1]<-"Micronesia, Fed. Sts."
countrydata[146,1]<-"Moldova"
countrydata[119,1]<-"North Korea"
countrydata[171,1]<-"Palestine"
countrydata[184,1]<-"Russia"
countrydata[203,1]<-"Slovak Republic"
countrydata[250,]<-list("South Korea","Asia","Eastern Asian")
countrydata[188,1]<-"St. Kitts and Nevis"
countrydata[189,1]<-"St. Lucia"
countrydata[192,1]<-"St. Vincent and the Grenadines"
countrydata[71,1]<-"Swaziland"
countrydata[217,1]<-"Syria"
countrydata[220,1]<-"Tanzania"
countrydata[235,1]<-"United Kingdom"
countrydata[236,1]<-"United States"
countrydata[241,1]<-"Venezuela"
countrydata[242,1]<-"Vietnam"
#UnirContinentesZonasyVariables
gapdata <- left_join(population1, childmortality1, by=c("country","Years"))
gapdata <- left_join(gapdata, childrenperwoman1, by=c("country","Years"))
gapdata <- left_join(gapdata, co2emissions1, by=c("country","Years"))
gapdata <- left_join(gapdata, incomeperperson1, by=c("country","Years"))
gapdata <- left_join(gapdata, lifeexpectancy1, by=c("country","Years"))
gapdata<- left_join(gapdata,democracyindex1, by=c("country","Years"))
gapdata <- left_join(gapdata, countrydata, by=c("country"))
gapdata<-left_join(gapdata,coord1,by="country")
#code
shinyServer(function(input, output) {
#informacion
output$htm <- renderText(
    paste(readLines("Gapminder.htm"), collapse="")
    )
#input
dataset<-reactive({filter(gapdata, gapdata[,2] == input$Years)})

DrawPlotly<-reactive({
  chart <- ggplot(dataset(),aes_string(x = input$X, 
                                       y = input$Y, size=input$size, 
                                       color = input$color, w = "country")) + 
    geom_point(alpha=input$transparency) + 
    scale_size(range=c(1,24)) + 
    theme_classic()+
    theme(legend.position = "right", legend.title = element_blank())
  
  if(input$facet != "None")
    chart <- chart + facet_wrap(c(input$facet))
  
  graph<-ggplotly(chart, tooltip = c("w","colour","size","x","y"))
})

DrawMap<-reactive({
    world <- map_data("world")
    worldmap <- ggplot()+
    geom_path(aes(x = long, y = lat, group = group), data = world)+
    geom_point(data = dataset(),inherit.aes=FALSE,aes_string(x="longitude", 
                                                             y="latitude", 
                                                             size = input$size, 
                                                             color = input$color,
                                                             w = "country"), 
               alpha = input$transparency)+
    theme_classic()+
    scale_size(range=c(1,20))+
    theme(legend.position = "right", legend.title = element_blank())
    mapa<-ggplotly(worldmap, tooltip = c("w","colour","size","x","y"))
})
#output
 output$Table<-renderDataTable(dataset())
 output$plotly <- renderPlotly({DrawPlotly()})
 output$mapa<-renderPlotly({DrawMap()})
  })



