##libraries in use
library(shiny)
#Interfaz
shinyUI(fluidPage(
  titlePanel("Data To Change Your Mind And Please Your Eyes"),
#Opciones de Entrada
  sidebarLayout(
    sidebarPanel(
    sliderInput("Years","Select year:",value = 1800,min = 1800, max= 2019, step=1, round=0),
    selectInput("X","Eje X",c("ChildMortality","ChildrenPerWoman","CO2Emissions","IncomePerPerson","LifeExpectancy","Population")),
    selectInput("Y","Eje Y",c("ChildMortality","ChildrenPerWoman","CO2Emissions","IncomePerPerson","LifeExpectancy","Population"), selected = "ChildrenPerWoman"),
    selectInput('size', 'Size',c("ChildMortality","ChildrenPerWoman","CO2Emissions","IncomePerPerson","LifeExpectancy","Population"),selected = "Population"),
    selectInput("color","Color",c("Region","Sub.Region")),
    selectInput('facet', 'Facets',c("None","Region","Sub.Region")),
    sliderInput("transparency","Transparency",value = 0.5, min = 0, max= 1),
  ),
  
#Elementos de Salida
    mainPanel(
      tabsetPanel(type = "tabs",
                        tabPanel("Table", dataTableOutput("Table")),
                        tabPanel("Interactive Graph", plotlyOutput("plotly", width = "900px",height="550px"))
                
      )
    )
  )
))

