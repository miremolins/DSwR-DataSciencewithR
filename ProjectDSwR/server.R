#libraries in use
library(shiny)
#code
shinyServer(function(input, output) {
  #Datos
  ExpArms<-read.csv("arms_exports_us_inflation_adjusted.csv")
  ImpArms<-read.csv("arms_imports_us_inflation_adjusted.csv")
})