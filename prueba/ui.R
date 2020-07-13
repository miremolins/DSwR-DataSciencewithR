#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application
shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("My App"),
    sidebarPanel(
        textOutput("clickcoord")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        plotOutput("myworld", height="600px", click="plotclick")
    )
))