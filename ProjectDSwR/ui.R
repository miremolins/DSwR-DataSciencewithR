#libraries in use
library(shiny)
#code
shinyUI(fluidPage(
  titlePanel("Data to change your mind"),
  sidebarLayout(
    sidebarPanel(
    actionButton("start","Calculate"),
    sliderInput("Year","Select year:",value = 1800,min = 1800, max= 2019, step=1, round=0),
    selectInput("X","Eje X",c("Childmortality","childrenperwoman","co2emission","incomeperperson","lifeexpectancy","population")),
    selectInput("Y","Eje Y",c("Childmortality","childrenperwoman","co2emission","incomeperperson","lifeexpectancy","population")),
  ),
  mainPanel(
    tabsetPanel(type = "tabs",
                        tabPanel("Grafico", plotOutput("Plot")),
                        tabPanel("Datos", dataTableOutput("Table"))
      )
    )
  )
))
