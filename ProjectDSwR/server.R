#libraries in use
library(shiny)
library(readr)
#code
shinyServer(function(input, output) {
  #Datos
  Childmortality<- read_csv("Datos/child_mortality_0_5_year_olds_dying_per_1000_born.csv")
  childrenperwoman<-read_csv("Datos/children_per_woman_total_fertility.csv")
  co2emission<-read_csv("Datos/co2_emissions_tonnes_per_person.csv")
  incomeperperson<-read_csv("Datos/income_per_person_gdppercapita_ppp_inflation_adjusted.csv")
  lifeexpectancy<-read_csv("Datos/life_expectancy_years.csv")
  population<-read_csv("Datos/population_total.csv")
})