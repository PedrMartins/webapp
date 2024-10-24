# Load R packages
library(shiny)
library(shinythemes)
library(stringr)
library(lubridate)
library (dplyr)
library(markdown)
library(leaflet)
library(sf)
source("data_update.R")
source("funcao_processamento.R")
source("co2.R")
source("umidade.R")
source("temperatura.R")
source("variable.R")

ui= fluidPage(theme = shinytheme("flatly"),# theme = "cerulean",
              # <--- To use a theme
              navbarPage( "IoTree",
                          tabPanel("About",
                                   div(includeMarkdown("about.md"),
                                       align="justify")),
                          temperatura,
                          umidade,
                          CO2,
                          variable,
                          tabPanel ("Status",
                                    h3("Sensor's status"),
                                    dataTableOutput(outputId = "table"),
                          ),
                          tabPanel("Location",
                                   leafletOutput(
                                     "MapsPipae",
                                     height = 600)
                                   )
                          )# navpage end
)

server <- function(input, output, session) {


  output$TemperatureID <- renderPlot({
    pipae7 = pipae7 [pipae7$parcela ==  input$par,]
    if (input$nivel == "H") {
      pipae7 = pipae7 [ pipae7$D == input$day &
                          pipae7$M == input$month &
                          pipae7$Y == input$year,]
    } else if (input$nivel == "M" ) {
      pipae7 = pipae7 [pipae7$Y == input$year,]
    } else {
      pipae7 = pipae7 [ pipae7$M == input$month &
                          pipae7$Y == input$year,]
    }

    pipae_mediatemperatura = get_dados_separados(pipae7,
                                                 pipae7$Temperatura,
                                                 date= pipae7$Data,
                                                 time=pipae7$Hora,
                                                 media_nivel = input$nivel,
                                                 variavel = "temperatura")
    par( bty ="n", bg = "grey99", las =1,
         family="serif")

    if (input$nivel == "H"){
      pipae_mediatemperatura$nivel= pipae_mediatemperatura$H
      escala = range(pipae_mediatemperatura$media_temperatura)
      min = trunc (escala [1] - 10)
      max = trunc (escala [2] + 10)
      if (is.finite(min) == FALSE | is.finite(max) == FALSE) {
        stop (safeError(
          "\n No data collection for that date\n use another date")
        )
      }

      plot (media_temperatura~nivel,
            data=pipae_mediatemperatura,
            type="n",
            ylab="Mean temperature ºC",
            xlab= "Hours",
            main="Temperature\nmean by hour",
            ylim = c(min,max),
            xlim=c(0,23))
      lines(media_temperatura~nivel,
            data=pipae_mediatemperatura, lty = 5,
            lwd = 4, col = "darkorange")

    }else if (input$nivel=="D") {
      pipae_mediatemperatura$nivel= pipae_mediatemperatura$D
      escala = range(pipae_mediatemperatura$media_temperatura)
      min = trunc (escala [1] - 10)
      max = trunc (escala [2] + 10)
      if (is.finite(min) == FALSE | is.finite(max) == FALSE) {
        stop (safeError(
          "\n No data collection for that date\n use another date")
        )
      }


      plot (media_temperatura~nivel,
            data=pipae_mediatemperatura, type="n",
            ylab="Mean temperature ºC", xlab= "Days",
            main="Temperature\nmean by day",
            ylim = c(min,max) ,xlim=c(0,30))

      lines(media_temperatura ~nivel,
            data=pipae_mediatemperatura ,
            lty = 5, lwd =4,
            col = "darkorange")


    } else {
      pipae_mediatemperatura$nivel=pipae_mediatemperatura$M
      escala = range(pipae_mediatemperatura$media_temperatura)
      min = trunc (escala [1] - 10)
      max = trunc (escala [2] + 10)

      plot (media_temperatura~nivel,
            data=pipae_mediatemperatura,
            type="n",ylab="Mean temperature ºC",
            xlab= "Months",
            main="Temperature\nmean by month",
            ylim = c(min,max) ,xlim=c(1,12))

      lines(media_temperatura ~nivel,
            data=pipae_mediatemperatura ,
            lty = 5, lwd =4,
            col = "darkorange")


    }

    legend("topleft",c("Pipae7"),
           col= c("darkorange"),
           lty = c(2,3,1), bty = "n")


  }, res= 96)


  output$MoistureID <- renderPlot({
    pipae7 = pipae7 [pipae7$parcela ==  input$parmoisture,]
    if (input$nivelmoisture == "H") {
      pipae7 = pipae7 [ pipae7$D == input$daymoisture &
                          pipae7$M == input$monthmoisture &
                          pipae7$Y == input$yearmoisture,]
    } else if (input$nivelmoisture == "M" ) {
      pipae7 = pipae7 [pipae7$Y == input$yearmoisture,]
    } else {
      pipae7 = pipae7 [ pipae7$M == input$monthmoisture &
                          pipae7$Y == input$yearmoisture,]
    }

    pipae_mediaumidade = get_dados_separados(pipae7, pipae7$Umidade,
                                             date= pipae7$Data,
                                             time=pipae7$Hora,
                                             media_nivel = input$nivelmoisture,
                                             variavel = "umidade")
    par( bty ="n", bg = "grey99", las =1,
         family="serif")

    if (input$nivelmoisture == "H"){
      pipae_mediaumidade$nivel= pipae_mediaumidade$H
      escala = range(pipae_mediaumidade$media_umidade)
      min = trunc (escala [1] - 10)
      max = trunc (escala [2] + 10)
      if (is.finite(min) == FALSE | is.finite(max) == FALSE) {
        stop (safeError(
          "\n No data collection for that date\n use another date")
        )
      }

      plot (media_umidade~nivel,
            data=pipae_mediaumidade, type="n",
            ylab="Mean moisture %", xlab= "Hours",
            main="Moisture\nmean by hour",
            ylim = c(min, max),
            xlim=c(0,23))

      lines(media_umidade~nivel, data=pipae_mediaumidade,
            lty = 5, lwd =4,
            col = "darkblue")


    } else if (input$nivelmoisture == "D") {

      pipae_mediaumidade$nivel= pipae_mediaumidade$D
      escala = range(pipae_mediaumidade$media_umidade)
      min = trunc (escala [1] - 10)
      max = trunc (escala [2] + 10)
      if (is.finite(min) == FALSE | is.finite(max) == FALSE) {
        stop (safeError(
          "\n No data collection for that date\n use another date")
        )
      }


      plot (media_umidade~nivel,
            data=pipae_mediaumidade, type="n",
            ylab="Mean Moisture %", xlab= "Days",
            main="Moisture\nmean by day",
            ylim = c(min, max),
            xlim=c(0,30))

      lines(media_umidade~nivel, data=pipae_mediaumidade ,
            lty = 5, lwd =4,
            col = "darkblue")
    } else {
      pipae_mediaumidade$nivel=pipae_mediaumidade$M
      escala = range(pipae_mediaumidade$media_umidade)
      min = trunc (escala [1] - 10)
      max = trunc (escala [2] + 10)

      plot (media_umidade~nivel, data=pipae_mediaumidade,
            type="n",
            ylab="Mean Moisture %", xlab= "Months",
            main="Moisture\nmean by month",
            ylim = c(min, max),
            xlim=c(1,12))

      lines(media_umidade ~nivel, data=pipae_mediaumidade ,
            lty = 5, lwd =4,
            col = "darkblue")
    }

    legend("topleft",c("Pipae7"),
           col= c("darkblue"),
           lty = c(2,3,1), bty = "n")

  },res=96)

  output$CO2ID <- renderPlot({
    pipae7 = pipae7 [pipae7$parcela ==  input$parco2,]
    if (input$nivelco2 == "H") {
      pipae7 = pipae7 [ pipae7$D == input$dayco2 &
                          pipae7$M == input$monthco2 &
                          pipae7$Y == input$yearco2,]
    } else if (input$nivelco2 == "M" ) {
      pipae7 = pipae7 [pipae7$Y == input$yearco2,]
    } else {
      pipae7 = pipae7 [ pipae7$M == input$monthco2 &
                          pipae7$Y == input$yearco2,]
    }

    pipae_mediaCO2 = get_dados_separados(pipae7, pipae7$CO2,
                                         date= pipae7$Data,
                                         time=pipae7$Hora,
                                         media_nivel = input$nivelco2,
                                         variavel = "co2")
    "serif"
    par(bty ="n", bg = "grey99", las =1,
        family="serif")


    if (input$nivelco2 == "H"){
      pipae_mediaCO2$nivel= pipae_mediaCO2$H
      escala = range(pipae_mediaCO2$media_co2)
      min = trunc (escala [1] - 100)
      max = trunc (escala [2] + 100)
      if (is.finite(min) == FALSE | is.finite(max) == FALSE) {
        stop (safeError(
          "\n No data collection for that date\n use another date")
        )
      }

      plot (media_co2~nivel, data=pipae_mediaCO2,
            type="n",
            ylab="Mean CO2 ppm", xlab= "Hours",
            main="CO2\nmean by hour",
            ylim = c(min, max),
            xlim=c(0,23))

      lines(media_co2~nivel, data=pipae_mediaCO2,
            lty = 5, lwd =4,
            col = "gray60")


    } else if (input$nivelco2 == "D") {
      pipae_mediaCO2$nivel= pipae_mediaCO2$D
      escala = range(pipae_mediaCO2$media_co2)
      min = trunc (escala [1] -100)
      max = trunc (escala [2] + 100)
      if (is.finite(min) == FALSE | is.finite(max) == FALSE) {
        stop (safeError(
          "\n No data collection for that date\n use another date")
        )
      }

      plot (media_co2~nivel, data=pipae_mediaCO2,
            type="n",
            ylab="Mean CO2 ppm", xlab= "Days",
            main="CO2\nmean by day",
            ylim = c(min, max),
            xlim=c(0,23))

      lines(media_co2~nivel, data=pipae_mediaCO2,
            lty = 5, lwd =4,
            col = "gray60")
    } else {
      pipae_mediaCO2$nivel=pipae_mediaCO2$M
      escala = range(pipae_mediaCO2$media_co2)
      min = trunc (escala [1] - 100)
      max = trunc (escala [2] + 100)

      plot (media_co2~nivel, data=pipae_mediaCO2,
            type="n",
            ylab="Mean CO2 ppm",
            xlab= "Months",
            main="CO2\nmean by month",
            ylim = c(min, max) ,xlim=c(1,12))

      lines(media_co2 ~nivel, data=pipae_mediaCO2 ,
            lty = 5, lwd =4,
            col = "gray60")
    }

    legend("topleft",c("Pipae7"),
           col= c("gray60"),
           lty = c(2,3,1), bty = "n")

  }, res= 96)

  output$boxplotvarID <-renderPlot({
    parcels <- input$parVar
    result <- data.frame()
    if (length (parcels)==0) {
      stop (safeError(
        "\n Select a parcel")
      )
    }
    for (parcel in parcels) {
      result <- rbind(result, pipae7[pipae7$parcela == parcel, ])
    }

    pipae7 <- result

    excluir <- c("Luminosidade...", "UV...","Data", "Hora",
                 "H","D","M","Y","Pressão","m" )
    pipae7 <- pipae7[,!(names(pipae7)%in% excluir)]
    names (pipae7) <-  c("CO2",
                         "temp",
                         "umi",
                         "parcela")
    pipae7 = na.omit(pipae7)
    vars <- input$var
    if (length(vars) > 0) {
      par(mfrow = c(1,length(vars)), bty = "n",
          bg = "grey99", family="serif")
      col = colorRampPalette(c("darkred", "lightblue"))
      for (var in vars) {
        boxplot(as.formula(paste(var, "~ parcela")),
                data = pipae7, main = var, col =
                  col(length(unique(pipae7$parcela))),
                pch="*")
        #dicionariuo = var (estudar) xlab=dict[var]
      }
    }
  }, res = 96)

  output$table <- renderDataTable({
    pipaes <- c(unique(pipae7$sensor))
    status <- data.frame()
    for (pipae in pipaes) {

      sensor=pipae7 [pipae7$sensor==pipae,]
      diff <- time_length(Sys.Date()-
                            sensor$Data [length(sensor$Data)],
                          unit="day")

      if (diff > 0) {
        test <- data.frame(sensor=as.character (pipae),
                           dias=sensor$Data [length(sensor$Data)],
                           status="No")
      }else {
        test  <- data.frame(sensor=as.character (pipae),
                            dias=as.character(sensor$Data [length(sensor$Data)]),
                            status="Yes")
      }
      status <-  rbind(status,test)
    }
    names (status) <- c("Sensor","Last Received","Working fine")
    status
  })

  output$MapsPipae <- renderLeaflet ({
    a <-  data.frame(lat = -23.565297,
                     long=-46.728907)
    leaflet() |>
      addProviderTiles(
        provider = providers$Esri.WorldImagery, group="Stallite View") |>
      addProviderTiles("OpenStreetMap",
                group = "Street View") |>
      addLayersControl(baseGroups = c("Satellite View",
                                      "Street View")) |>
      addCircleMarkers(lat = -23.565297,
                 lng = -46.728907,
                 radius = 30,
                 popup = paste(sep= "<br/>",
                               "Forest Reserve of the Institute of Biosciences"),
                 opacity = 0.10,
                 label="IoTree")
  })
}

shinyApp(ui=ui, server = server)



#Reserva Florestal do Instituto de
#Biociências
