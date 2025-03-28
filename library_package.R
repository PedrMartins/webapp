pkg <- c("shiny","shinythemes","stringr","lubridate",
         "dplyr","markdown","leaflet","sf","DT")

pkg <- pkg[!pkg%in%installed.packages()]
pkg
install.packages (pkg)


library(shiny)
library(shinythemes)
library(stringr)
library(lubridate)
library (dplyr)
library(markdown)
library(leaflet)
library(sf)
library(DT)
