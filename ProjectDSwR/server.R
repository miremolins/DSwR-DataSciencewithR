#libraries in use
library(shiny)
library(readr)

childmortality1<- read.csv("Datos/child_mortality_0_5_year_olds_dying_per_1000_born.csv")
childrenperwoman1<- read.csv("Datos/children_per_woman_total_fertility.csv")
co2emissions1<-read.csv("Datos/co2_emissions_tonnes_per_person.csv")
incomeperperson1<-read.csv("Datos/income_per_person_gdppercapita_ppp_inflation_adjusted.csv")
lifeexpectancy1<- read.csv("Datos/life_expectancy_years.csv")
population<-read.csv("Datos/population_total.csv")
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

