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

childmortality1<-melt(childmortality1,id.vars="country", variable.name = "Years", value.name="ChildMortality", na.rm = TRUE)
childrenperwoman1<-melt(childrenperwoman1,id.vars="country", variable.name = "Years", value.name="ChildrenPerWoman", na.rm = TRUE)
co2emissions1<-melt(co2emissions1,id.vars="country", variable.name = "Years", value.name="CO2Emissions", na.rm = TRUE)
incomeperperson1<-melt(incomeperperson1,id.vars="country", variable.name = "Years", value.name="IncomePerPerson", na.rm = TRUE)
lifeexpectancy1<-melt(lifeexpectancy1,id.vars="country", variable.name = "Years", value.name="LifeExpectancy", na.rm = TRUE)
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
#input
  
dataset<-reactive ({filter(gapdata, gapdata[,2] == input$Years) })

DrawChart <- reactive({
  
  chart <- ggplot(dataset()) 
  
  if(input$geom == "points") {
    chart <- chart + geom_point(aes_string(x = input$X, y = input$Y))
  } else if(input$geom == "boxplot") {
    chart <- chart + geom_boxplot(aes(input$Y))
  } 
  
  print(chart)
  
})

#output

 output$Table<-renderDataTable(dataset())
 output$Plot <- renderPlot({
   DrawChart()
 }, width = 1200, height = 720)

  })

