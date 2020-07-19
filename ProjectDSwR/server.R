#libraries in use
library(readr)
library(reshape2)
library(dplyr)
#Dataset Creation
childmortality1<- read.csv("Datos/child_mortality_0_5_year_olds_dying_per_1000_born.csv",check.names = FALSE)
childrenperwoman1<- read.csv("Datos/children_per_woman_total_fertility.csv",check.names = FALSE)
co2emissions1<-read.csv("Datos/co2_emissions_tonnes_per_person.csv",check.names = FALSE)
incomeperperson1<-read.csv("Datos/income_per_person_gdppercapita_ppp_inflation_adjusted.csv",check.names = FALSE)
lifeexpectancy1<- read.csv("Datos/life_expectancy_years.csv",check.names = FALSE)
population1<- read_csv("Datos/population_total.csv")

childmortality1<-melt(childmortality1,id.vars="country", variable.name = "Years", value.name="Child Mortality", na.rm = TRUE)
childrenperwoman1<-melt(childrenperwoman1,id.vars="country", variable.name = "Years", value.name="Children Per Woman", na.rm = TRUE)
co2emissions1<-melt(co2emissions1,id.vars="country", variable.name = "Years", value.name="CO2 Emissions", na.rm = TRUE)
incomeperperson1<-melt(incomeperperson1,id.vars="country", variable.name = "Years", value.name="Income Per Person", na.rm = TRUE)
lifeexpectancy1<-melt(lifeexpectancy1,id.vars="country", variable.name = "Years", value.name="Life Expectancy", na.rm = TRUE)
population1<-melt(population1,id.vars="country", variable.name = "Years", value.name="Population", na.rm = TRUE)

childmortality1$Years<- as.numeric(as.character(childmortality1$Years))
childrenperwoman1$Years<- as.numeric(as.character(childrenperwoman1$Years))
co2emissions1$Years<- as.numeric(as.character(co2emissions1$Years))
incomeperperson1$Years<- as.numeric(as.character(incomeperperson1$Years))
lifeexpectancy1$Years<- as.numeric(as.character(lifeexpectancy1$Years))
population1$Years<- as.numeric(as.character(population1$Years))

gapdata <- left_join(childmortality1, childrenperwoman1, by=c("country","Years"))
gapdata <- left_join(gapdata, co2emissions1, by=c("country","Years"))
gapdata <- left_join(gapdata, incomeperperson1, by=c("country","Years"))
gapdata <- left_join(gapdata, lifeexpectancy1, by=c("country","Years"))
gapdata <- left_join(gapdata, population1, by=c("country","Years"))

#code
shinyServer(function(input, output) {
  
  datasetx <- reactive({
    if(input$X=="Childmortality") {
      datasetx<-childmortality1[,c(1,input$Year-1798)]
    } else if(input$X=="childrenperwoman") {
      datasetx<-childrenperwoman1[,c(1,input$Year-1798)]
    } else if(input$X=="co2emission") {
      datasetx<-co2emissions1[,c(1,input$Year-1798)]
    } else if(input$X=="incomeperperson") {
      datasetx<-incomeperperson1[,c(1,input$Year-1798)]
    } else if(input$X=="lifeexpectancy") {
      datasetx<-lifeexpectancy1[,c(1,input$Year-1798)]
    }
    
  })
  
  datasety <- reactive({
    if(input$Y=="Childmortality") {
      datasety<-childmortality1[,c(1,input$Year-1798)]
    } else if(input$Y=="childrenperwoman") {
      datasety<-childrenperwoman1[,c(1,input$Year-1798)]
    } else if(input$Y=="co2emission") {
      datasety<-co2emissions1[,c(1,input$Year-1798)]
    } else if(input$Y=="incomeperperson") {
      datasety<-incomeperperson1[,c(1,input$Year-1798)]
    } else if(input$Y=="lifeexpectancy") {
      datasety<-lifeexpectancy1[,c(1,input$Year-1798)]
    } 
    
  })
  
  datasetP<-reactive(
    datasetP<-population[,c(1,input$Year-1798)]
  )
  
  datasetc<-
    
    
    
    
    
#el datasetC seria la combinacion de los otros tres para que salga pais+poblacio+variablex+
    #variableY todo en una misma tabla , la idea es que si funciona eliminar el output de
    #las otras tablas y dejar esta, pero los datset se quedarian.
#he intentado con funciones de cbind para dataframes pero el problema es que al ser un
    #reactive enviroment no funcionan
   
#tema graficos estoy un poco perdidad como seleccionar los datos que queremos 
    
 output$TableX<-renderDataTable(datasetx())
 output$Table<-renderDataTable(datasety())
 output$TableP<-renderDataTable(datasetP())
 output$TableC<-renderDataTable(datasetc())
  })

