##libraries in use
library(shiny)
#Interfaz
shinyUI(fluidPage(
  titlePanel("Data to change your mind"),
#Opciones de Entrada
  sidebarLayout(
    sidebarPanel(
    sliderInput("Years","Select year:",value = 1800,min = 1800, max= 2019, step=1, round=0),
    selectInput("X","Eje X",c("ChildMortality","ChildrenPerWoman","CO2Emissions","IncomePerPerson","LifeExpectancy","Population")),
    selectInput("Y","Eje Y",c("ChildMortality","ChildrenPerWoman","CO2Emissions","IncomePerPerson","LifeExpectancy","Population"), selected = "ChildrenPerWoman"),
    selectInput('size', 'Size',c("ChildMortality","ChildrenPerWoman","CO2Emissions","IncomePerPerson","LifeExpectancy","Population"),selected = "Population"),
    selectInput("color","Color",c("Region","Sub.Region")),
    sliderInput("transparency","Transparency",value = 0.5, min = 0, max= 1),
    radioButtons(inputId = "geom",label = "Chart type",
                 choices = c("ScatterPlot"= "points",
                             "Boxplot"= "boxplot"),
                 selected= "points")
  ),
  
#Elementos de Salida
    mainPanel(
      tabsetPanel(type = "tabs",
                        tabPanel("Grafico", plotOutput("Plot")),
                        tabPanel("Table", dataTableOutput("Table"))
                
      )
    )
  )
))

