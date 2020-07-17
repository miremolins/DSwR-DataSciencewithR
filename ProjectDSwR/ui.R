#libraries in use
library(shiny)
#SELECTOR DE OPCIONES
shinyUI(fluidPage(
  titlePanel("Data to change your mind"),
  sidebarLayout(
    sidebarPanel(
    actionButton("start","Calculate"),
    sliderInput("Year","Select year:",value = 1800,min = 1800, max= 2019, step=1, round=0),
    selectInput("X","Eje X",c("Childmortality","childrenperwoman","co2emission","incomeperperson","lifeexpectancy","population")),
    selectInput("Y","Eje Y",c("Childmortality","childrenperwoman","co2emission","incomeperperson","lifeexpectancy","population")),
    radioButtons(inputId = "geom",label = "Chart type",
                 choices = c("X Y"= "points",
                             "Boxplot"= "boxplot"),
                 selected= "points")
  ),
#CHART+TABLE

  mainPanel(
    tabsetPanel(type = "tabs",
                        tabPanel("Grafico", plotOutput("Plot")),
                        tabPanel("DatosX", dataTableOutput("TableX")),
                        tabPanel("DatosY",dataTableOutput("Table")),
                tabPanel("Poblacion",dataTableOutput("TableP")),
                tabPanel("combo",dataTableOutput("TableC"))
                
      )
    )
  )
))

