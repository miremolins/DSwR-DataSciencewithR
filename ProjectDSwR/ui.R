##libraries in use
library(shiny)
#SELECTOR DE OPCIONES
shinyUI(fluidPage(
  titlePanel("Data to change your mind"),
  sidebarLayout(
    sidebarPanel(
    sliderInput("Years","Select year:",value = 1800,min = 1800, max= 2019, step=1, round=0),
    selectInput("X","Eje X",c("ChildMortality","ChildrenPerWoman","CO2Emissions","IncomePerPerson","LifeExpectancy","Population")),
    selectInput("Y","Eje Y",c("ChildMortality","ChildrenPerWoman","CO2Emissions","IncomePerPerson","LifeExpectancy","Population")),
    radioButtons(inputId = "geom",label = "Chart type",
                 choices = c("X Y"= "points",
                             "Boxplot"= "boxplot"),
                 selected= "points")
  ),
#CHART+TABLE

  mainPanel(
    tabsetPanel(type = "tabs",
                        tabPanel("Grafico", plotOutput("Plot")),
                        tabPanel("Table", dataTableOutput("Table"))
                
      )
    )
  )
))

