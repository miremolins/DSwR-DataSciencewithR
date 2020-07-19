##libraries in use
library(shiny)
#Interfaz
shinyUI(fluidPage(
  titlePanel("Data To Change Your Mind And Please Your Eyes"),
#Opciones de Entrada
    sidebarPanel(
    conditionalPanel(condition="input.tabselected==4", 
                     actionButton("Calcular","Welcome To GapminderApp", icon("line-chart"),
                     style="color:#fff000; background-color: #337ab7;
                     border-color: #2e6da4")),
    conditionalPanel(condition = "input.tabselected<3",
    sliderInput("Years","Select year:",value = 1800,min = 1800, max= 2019, step=1, round=0),
    selectInput("X","X",c("ChildMortality","ChildrenPerWoman","CO2Emissions","IncomePerPerson","LifeExpectancy","Population","DemocracyIndex")),
    selectInput("Y","Y",c("ChildMortality","ChildrenPerWoman","CO2Emissions","IncomePerPerson","LifeExpectancy","Population"), selected = "ChildrenPerWoman"),
    selectInput('size', 'Size',c("ChildMortality","ChildrenPerWoman","CO2Emissions","IncomePerPerson","LifeExpectancy","Population"),selected = "Population"),
    selectInput("color","Color",c("Region","Sub.Region","DemocracyIndex")),
    selectInput('facet', 'Facets',c("None","Region","Sub.Region")),
    sliderInput("transparency","Transparency",value = 0.5, min = 0, max= 1),
    )
),
  
#Elementos de Salida
    mainPanel(
      tabsetPanel(type = "tabs",
                        tabPanel("Informacion", value = 4, htmlOutput("htm")),
                        tabPanel("Table", value = 1, dataTableOutput("Table")),
                        tabPanel("Interactive Graph", value = 2, plotlyOutput("plotly", width = "900px",height="550px")),
                        id="tabselected"
                
      )
    )
  )
)

