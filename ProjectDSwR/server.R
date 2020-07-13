#libraries in use
library(shiny)
library(readr)
#code
shinyServer(function(input, output) {
dfDatos<- data.frame(Countries = input$X[,1],VariableX = input$X[,is.double(input$Year)],VariableY = input$Y[,is.double(input$Year)])
})
