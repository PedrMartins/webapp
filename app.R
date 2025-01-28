# Load R packages
source("library_package.R")
source("data_update.R")
source("funcao_processamento.R")
source("co2.R")
source("umidade.R")
source("temperatura.R")
source("variable.R")
source("pression.R")
source("Download.R")

ui= fluidPage(theme = shinytheme("flatly"),# theme = "cerulean",
              # <--- To use a theme
              navbarPage( "Smart Forest",
                          tabPanel("About",
                                   div(includeMarkdown("about.md"),
                                       align="justify")),
                          temperatura,
                          umidade,
                          CO2,
                          Pression,
                          variable,
                          tabPanel ("Status",
                                    h3("Sensor's status"),
                                    dataTableOutput(outputId = "table"),
                          ),
                          tabPanel("Location",
                                   leafletOutput(
                                     "MapsPipae",
                                     height = 600)
                                   ),
                          Download
                          )# navpage end
)

server <- function(input, output, session) {


  output$TemperatureID <- renderPlot({


    pipae_all = pipae_all [pipae_all$parcela ==  input$par,]
    if (input$nivel == "H") {

      pipae_all = pipae_all [ pipae_all$D == input$day &
                                pipae_all$M == input$month &
                                pipae_all$Y == input$year,]
    } else if (input$nivel == "M" ) {
      pipae_all = pipae_all [pipae_all$Y == input$year,]
    } else {
      pipae_all = pipae_all [ pipae_all$M == input$month &
                                pipae_all$Y == input$year,]
    }

    pipae_mediatemperatura = get_dados_separados(pipae_all,
                                                 pipae_all$Temperature,
                                                 date= pipae_all$Date,
                                                 time=pipae_all$Time,
                                                 media_nivel = input$nivel,
                                                 variavel = "temperatura")
    par( bty ="n", bg = "grey99", las =1,
         family="serif")

    if (input$nivel == "H"){
      pipae_mediatemperatura$nivel= pipae_mediatemperatura$H
      escala = range(pipae_mediatemperatura$media_temperatura, na.rm = TRUE)
      min = trunc (escala [1] - 10)
      max = trunc (escala [2] + 10)
      if (nrow(pipae_mediatemperatura) == 0) {
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
      escala = range(pipae_mediatemperatura$media_temperatura, na.rm = TRUE)
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
      escala = range(pipae_mediatemperatura$media_temperatura, na.rm = TRUE)
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


  }, res= 96)


  output$MoistureID <- renderPlot({

    pipae_all = pipae_all [pipae_all$parcela ==  input$parmoisture,]
    if (input$nivelmoisture == "H") {
      pipae_all = pipae_all [ pipae_all$D == input$daymoisture &
                          pipae_all$M == input$monthmoisture &
                          pipae_all$Y == input$yearmoisture,]
    } else if (input$nivelmoisture == "M" ) {
      pipae_all = pipae_all [pipae_all$Y == input$yearmoisture,]
    } else {
      pipae_all = pipae_all [ pipae_all$M == input$monthmoisture &
                          pipae_all$Y == input$yearmoisture,]
    }

    pipae_mediaumidade = get_dados_separados(pipae_all, pipae_all$Humidity,
                                             date= pipae_all$Date,
                                             time=pipae_all$Time,
                                             media_nivel = input$nivelmoisture,
                                             variavel = "umidade")
    par( bty ="n", bg = "grey99", las =1,
         family="serif")

    if (input$nivelmoisture == "H"){
      pipae_mediaumidade$nivel= pipae_mediaumidade$H
      escala = range(pipae_mediaumidade$media_umidade, na.rm = TRUE)
      min = trunc (escala [1] - 10)
      max = trunc (escala [2] + 10)
      if (nrow(pipae_mediaumidade) == 0) {
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
      escala = range(pipae_mediaumidade$media_umidade, na.rm = TRUE)
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
      escala = range(pipae_mediaumidade$media_umidade, na.rm = TRUE)
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


  },res=96)

  output$CO2ID <- renderPlot({

    pipae_all = pipae_all [pipae_all$parcela ==  input$parco2,]

    if (input$nivelco2 == "H") {

      pipae_all = pipae_all [ pipae_all$D == input$dayco2 &
                          pipae_all$M == input$monthco2 &
                          pipae_all$Y == input$yearco2,]
    } else if (input$nivelco2 == "M" ) {
      pipae_all = pipae_all [pipae_all$Y == input$yearco2,]
    } else {
      pipae_all = pipae_all [ pipae_all$M == input$monthco2 &
                          pipae_all$Y == input$yearco2,]
    }

    pipae_mediaCO2 = get_dados_separados(pipae_all, pipae_all$CO2_ppm,
                                         date= pipae_all$Date,
                                         time=pipae_all$Time,
                                         media_nivel = input$nivelco2,
                                         variavel = "co2")
    par(bty ="n", bg = "grey99", las =1,
        family="serif")


    if (input$nivelco2 == "H"){
      pipae_mediaCO2$nivel= pipae_mediaCO2$H
      escala = range(pipae_mediaCO2$media_co2, na.rm = TRUE)
      min = trunc (escala [1] - 100)
      max = trunc (escala [2] + 100)
      if (nrow(pipae_mediaCO2) == 0) {
        stop (safeError(
          "\n No data collection for that date\n use another date")
        )
      }

      plot (media_co2~nivel, data=pipae_mediaCO2,
            type="n",
            ylab=expression("Mean" ~ CO[2] ~ "ppm"), xlab= "Hours",
            main="CO\u2082\nmean by hour",
            ylim = c(min, max),
            xlim=c(0,23))

      lines(media_co2~nivel, data=pipae_mediaCO2,
            lty = 5, lwd =4,
            col = "gray60")


    } else if (input$nivelco2 == "D") {
      pipae_mediaCO2$nivel= pipae_mediaCO2$D
      escala = range(pipae_mediaCO2$media_co2, na.rm = TRUE)
      min = trunc (escala [1] -100)
      max = trunc (escala [2] + 100)
      if (is.finite(min) == FALSE | is.finite(max) == FALSE) {
        stop (safeError(
          "\n No data collection for that date\n use another date")
        )
      }

      plot (media_co2~nivel, data=pipae_mediaCO2,
            type="n",
            ylab=expression("Mean" ~ CO[2] ~ "ppm"), xlab= "Days",
            main="CO\u2082\nmean by day",
            ylim = c(min, max),
            xlim=c(0,30))

      lines(media_co2~nivel, data=pipae_mediaCO2,
            lty = 5, lwd =4,
            col = "gray60")
    } else {
      pipae_mediaCO2$nivel=pipae_mediaCO2$M
      escala = range(pipae_mediaCO2$media_co2, na.rm = TRUE)
      min = trunc (escala [1] - 100)
      max = trunc (escala [2] + 100)

      plot (media_co2~nivel, data=pipae_mediaCO2,
            type="n",
            ylab=expression("Mean" ~ CO[2] ~ "ppm"),
            xlab= "Months",
            main="CO\u2082\nmean by month",
            ylim = c(min, max) ,xlim=c(1,12))

      lines(media_co2 ~nivel, data=pipae_mediaCO2 ,
            lty = 5, lwd =4,
            col = "gray60")
    }


  }, res= 96)

  output$pressID <- renderPlot({

    pipae_all = pipae_all [pipae_all$parcela ==  input$parpress,]

    if (input$nivelpress == "H") {

      pipae_all = pipae_all [ pipae_all$D == input$daypress &
                                pipae_all$M == input$monthpres &
                                pipae_all$Y == input$yearpres,]
    } else if (input$nivelpress == "M" ) {
      pipae_all = pipae_all [pipae_all$Y == input$yearpres,]
    } else {
      pipae_all = pipae_all [ pipae_all$M == input$monthpres &
                                pipae_all$Y == input$yearpres,]
    }

    pipae_mediapress = get_dados_separados(pipae_all,
                                         pipae_all$Pressure,
                                         date= pipae_all$Date,
                                         time=pipae_all$Time,
                                         media_nivel = input$nivelpress,
                                         variavel = "pressao")
    par(bty ="n", bg = "grey99", las =1,
        family="serif")


    if (input$nivelpress == "H"){
      pipae_mediapress$nivel= pipae_mediapress$H
      escala = range(pipae_mediapress$media_pressao, na.rm = TRUE)
      min = round (escala [1] - 0.25, 2)
      max = round (escala [2] + 0.25, 2)
      if (nrow(pipae_mediapress) == 0) {
        stop (safeError(
          "\n No data collection for that date\n use another date")
        )
      }

      plot (media_pressao~nivel, data=pipae_mediapress,
            type="n",
            ylab="Mean Pressure", xlab= "Hours",
            main="Pressure\nmean by hour",
            ylim = c(min, max),
            xlim=c(0,23))

      lines(media_pressao~nivel, data=pipae_mediapress,
            lty = 5, lwd =4,
            col = "pink")


    } else if (input$nivelpress == "D") {
           pipae_mediapress$nivel= pipae_mediapress$D
      escala = range(pipae_mediapress$media_pressao, na.rm = TRUE)
      min = round(escala [1] -0.25, 2)
      max = round (escala [2] + 0.25,2)
      if (is.finite(min) == FALSE | is.finite(max) == FALSE) {
        stop (safeError(
          "\n No data collection for that date\n use another date")
        )
      }

      plot (media_pressao~nivel, data=pipae_mediapress,
            type="n",
            ylab=expression("Mean Pressure"), xlab= "Days",
            main="Pressure\nmean by day",
            ylim = c(min, max),
            xlim=c(0,30))

      lines(media_pressao~nivel, data=pipae_mediapress,
            lty = 5, lwd =4,
            col = "pink")
    } else {
      pipae_mediapress$nivel=pipae_mediapress$M
      escala = range(pipae_mediapress$media_pressao, na.rm = TRUE)
      min = round (escala [1] - 0.25, 2)
      max = round (escala [2] + 0.25, 2)

      plot (media_pressao~nivel, data=pipae_mediapress,
            type="n",
            ylab=expression("Mean" ~ CO[2] ~ "ppm"),
            xlab= "Months",
            main="CO\u2082\nmean by month",
            ylim = c(min, max) ,xlim=c(1,12))

      lines(media_pressao ~nivel, data=pipae_mediapress ,
            lty = 5, lwd =4,
            col = "pink")
    }


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
      result <- rbind(result, pipae_all[pipae_all$parcela == parcel, ])
    }

    pipae_all <- result

    names (pipae_all)[c(3,5,6,17)] <-  c("temp",
                              "umi",
                              "CO2",
                              "parcel")
    vars <- input$var
    if (length(vars) > 0) {
      par(mfrow = c(1,length(vars)), bty = "n",
          bg = "grey99", family="serif")
      col = colorRampPalette(c("darkred", "lightblue"))
      for (var in vars) {
        boxplot(as.formula(paste(var, "~ parcel")),
                data = pipae_all, main = var, col =
                  col(length(unique(pipae_all$parcel))),
                pch="*")

        }

    }
  }, res = 96)

  output$table <- renderDataTable({
    pipaes <- c(unique(pipae_all$tag))
    status <- data.frame()
    for (pipae in pipaes) {

      sensor=pipae_all [pipae_all$tag==pipae,]
      diff <- time_length(Sys.Date()-
                            sensor$Date [length(sensor$Date)],
                          unit="day")

      if (diff > 0) {
        test <- data.frame(sensor=as.character (pipae),
                           dias=sensor$Date [length(sensor$Date)],
                           status="No")
      }else {
        test  <- data.frame(sensor=as.character (pipae),
                            dias=as.character(sensor$Date [length(sensor$Date)]),
                            status="Yes")
      }
      status <-  rbind(status,test)
    }
    names (status) <- c("Sensor","Last Received","Working")
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

  output$plotDown <- renderPlot({

  })

  output$tableDown <- renderDataTable({

    days <- input$daysDown

    if (input$intervalday == "to") {
      max=range (days) [2]
      min=range (days) [1]
      days = c (min:max)
    }else {days <- as.integer(days)}

    month <- input$monthDown

    if (input$intervalmonth == "to") {
      max=range (month) [2]
      min=range (month) [1]
      month = c (min:max)
    }else {month <- as.integer(month)}

    year <- input$yearDown

    if (input$intervalyear == "to") {
      max=range (year) [2]
      min=range (year) [1]
      year = c (min:max)
    }else {year <- as.integer(year)}

    if (input$vardown!="no_one") {
      separate_var_by_input=separate_variable(pipae_all, input$vardown,
                                              na.rm=TRUE, )
      separated_pipae_by_day <- get_data_by_date (separate_var_by_input,
                         days = days,
                         month =  month,
                         year = year)
    }else {
    separated_pipae_by_day=get_data_by_date (pipae_all,
                                              days = days,
                                              month =  month,
                                             year = year)
}
    excluir <- c("Luminosity", "UV.Intensity", "UV.Index",
                 "Latitude", "Longitude", "Speed",
                 "Altitude", "GNSS.Time", "GNSS.Date", "m", "H"
                ,"D", "M", "Y",
                "Date", "Time")
    separated_pipae_by_day <- separated_pipae_by_day[,!(names(
                              separated_pipae_by_day)%in% excluir)]
    separated_pipae_by_day
  })

}

shinyApp(ui=ui, server=server)

#Reserva Florestal do Instituto de
#Biociências


