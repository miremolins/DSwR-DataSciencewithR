#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(maps)
library(ggplot2)
library(rworldmap)

shinyServer(function(input, output) {
    
    output$myworld <- renderPlot({
        
        world <- map_data("world")
        worldmap <- ggplot(aes(x = long, y = lat, group = group), data = world) +
            geom_path()
        
        print(worldmap)
    })
    
    output$clickcoord <- renderPrint({
        print(input$plotclick)
    })
})