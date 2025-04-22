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
              navbarPage( "Smart Forests",
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

  output$TemperatureID <- renderPlotly({

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

    if (input$nivel == "H"){
      pipae_mediatemperatura$nivel= pipae_mediatemperatura$H } else if (
        input$nivel == "D"){
        pipae_mediatemperatura$nivel= pipae_mediatemperatura$D
      } else {pipae_mediatemperatura$nivel= pipae_mediatemperatura$M}

      if (nrow(pipae_mediatemperatura) == 0) {
        stop (safeError(
          "\n No data collection for that date\n use another date")
        )
      }

      date <- switch (input$nivel,
              "H"="Day",
              "D"="Month",
              "M"="Year")
      var <- switch (input$nivel,
        "H" = "Hour",
        "D" = "Day",
        "M" = "Month")


     names (pipae_mediatemperatura)[1] <- "nivel_var"

      plot_ly(data=pipae_mediatemperatura,
              x=~nivel_var,
              y=~media_temperatura,
              color=~parcela,
              type="scatter",
              mode="lines") |>
      layout(title= paste ("Temperature mean by",
                           date, sep = " "),
             xaxis = list(title = var),
             yaxis = list(title = 'Mean Temperature ºC'),
             plot_bgcolor = "gray95")

  })

  output$MoistureID <- renderPlotly({


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

    if (input$nivelmoisture == "H"){
      pipae_mediaumidade$nivelmoisture= pipae_mediaumidade$H} else if (
        input$nivelmoisture == "D"){
        pipae_mediaumidade$nivelmoisture= pipae_mediaumidade$D}else{
          pipae_mediaumidade$nivelmoisture= pipae_mediaumidade$M
        }

      if (nrow(pipae_mediaumidade) == 0) {
        stop (safeError(
          "\n No data collection for that date\n use another date")
        )
      }

    date <- switch (input$nivelmoisture,
                    "H"="Day",
                    "D"="Month",
                    "M"="Year")

    var <- switch (input$nivelmoisture,
                   "H" = "Hour",
                   "D" = "Day",
                   "M" = "Month")
    names (pipae_mediaumidade)[1] <- "nivel_var"


      plot_ly(data=pipae_mediaumidade,
              x=~nivel_var,
              y=~media_umidade,
              color=~parcela,
              type="scatter",
              mode="lines") |>
        layout(title= paste ("Moiture mean by",
                             date, sep = " "),
               xaxis = list(title = var),
               yaxis = list(title = 'Mean Moiture %'),
               plot_bgcolor = "gray95")

  })

  output$CO2ID <- renderPlotly({

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

    if (input$nivelco2 == "H"){
      pipae_mediaCO2$nivelco2= pipae_mediaCO2$H } else if (
        input$nivelco2 == "D"){pipae_mediaCO2$nivelco2= pipae_mediaCO2$D} else {
          pipae_mediaCO2$nivelco2= pipae_mediaCO2$M
        }

      if (nrow(pipae_mediaCO2) == 0) {
        stop (safeError(
          "\n No data collection for that date\n use another date")
        )
      }
    date <- switch (input$nivelco2,
                    "H"="Day",
                    "D"="Month",
                    "M"="Year")
    var <- switch (input$nivelco2,
                   "H" = "Hour",
                   "D" = "Day",
                   "M" = "Month")

    names (pipae_mediaCO2)[1] <- "nivel_var"

    plot_ly(data=pipae_mediaCO2,
            x=~nivel_var,
            y=~media_co2,
            color=~parcela,
            type="scatter",
            mode="lines") |>
      layout(title= paste ("CO\u2082 mean by",
                           date, sep = " "),
             xaxis = list(title = var),
             yaxis = list(title = 'Mean CO\u2082 ppm'),
             plot_bgcolor = "gray95")


  })

  output$pressID <- renderPlotly({

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

    if (input$nivelpress == "H"){
      pipae_mediapress$nivelpress= pipae_mediapress$H } else if (
        input$nivelpress == "D"){
        pipae_mediapress$nivelpress= pipae_mediapress$D} else {
          pipae_mediapress$nivelpress= pipae_mediapress$M
        }
    if (nrow(pipae_mediapress) == 0) {
        stop (safeError(
          "\n No data collection for that date\n use another date")
        )
    }
    date <- switch (input$nivelpress,
                    "H"="Day",
                    "D"="Month",
                    "M"="Year")
    var <- switch (input$nivelpress,
                   "H" = "Hour",
                   "D" = "Day",
                   "M" = "Month")

    names (pipae_mediapress)[1] <- "nivel_var"

    plot_ly(data=pipae_mediapress,
            x=~nivel_var,
            y=~media_pressao,
            color=~parcela,
            type="scatter",
            mode="lines") |>
      layout(title= paste ("Atmospheric Pressure mean by",
                           date, sep = " "),
             xaxis = list(title = var),
             yaxis = list(title = 'Atmospheric Pressure Pa'),
             plot_bgcolor = "gray95")

  })

  output$boxplotvarID <-renderPlotly({

    days <- input$dayvar

    if (input$intervalday_var == "to") {
      max=range (days) [2]
      min=range (days) [1]
      days = c (min:max)
    }else {days <- as.integer(days)}

    month <- input$monthvar

    if (input$intervalmonth_var == "to") {
      max=range (month) [2]
      min=range (month) [1]
      month = c (min:max)
    }else {month <- as.integer(month)}

    year <- input$yearvar

    if (input$intervalyear_var == "to") {
      max=range (year) [2]
      min=range (year) [1]
      year = c (min:max)
    }else {year <- as.integer(year)}


    pipae_all <- pipae_all [ pipae_all$D == days &
                              pipae_all$M == month &
                              pipae_all$Y == year,]


    names (pipae_all)[c(3,4,5,6,17)] <-  c("temp",
                                           "bar",
                                          "umi",
                                          "CO2",
                                          "parcel")
    variavel <- switch(input$vari,
           temp="temp",
           bar="bar",
           umi="umi",
           CO2="CO2")

    name_var <- switch(input$vari,
                       temp="Temperature",
                       bar="Pressure",
                       umi="Moisture",
                       CO2="CO\u2082")
    unit <- switch(input$vari,
                   temp="ºC",
                   bar="Pa",
                   umi="%",
                   CO2="ppm")

    plot_ly(data= pipae_all,
            type = "box",
            x= ~parcel,
            y= as.formula(paste0("~", variavel)),
            color=~parcel) |>
    layout(title= paste ("Boxplot ",name_var,
                         "\n ",sep = " "),
           xaxis = list(title = "Parcel"),
           yaxis = list(title = paste (name_var,
                                       unit, sep = " ")),
           plot_bgcolor = "gray95")

  })

  output$table <- renderDataTable({
    pipaes <- c(unique(pipae_all$tag))
    status <- data.frame()
    now <- Sys.time()
    last_24h <- now - hours(24)

    for (pipae in pipaes) {
      sensor=pipae_all [pipae_all$tag==pipae,]
      time <- sensor$DateTime [length(sensor$DateTime)]
      int <- interval(Sys.time(),time)
      diff <- time_length (int, "hour")
      diff <- abs(diff)

      if (is.na(diff)) {
        next
      }

      if (diff > 24) {

        packs <- sensor %>%
          filter(DateTime >= now - hours(24), DateTime <= now) %>%
          nrow()

        test <- data.frame(sensor=as.character (pipae),
                           dias=as.character(sensor$Date [length(sensor$Date)]),
                           parcela=unique (sensor$parcela),
                           status="No",
                           packs=packs)


      }else {
        packs <- sensor %>%
          filter(DateTime >= now - hours(24), DateTime <= now) %>%
          nrow()

        test  <- data.frame(sensor=as.character (pipae),
                            dias=as.character(sensor$Date [length(sensor$Date)]),
                            parcela=unique (sensor$parcela),
                            status="Yes",
                            packs=packs)
      }
      status <-  rbind(status,test)
    }
    names (status) <- c("Sensor","Last Received",
                        "Parcel","Working",
                        "Sample size at the last 24 hours")
    status
  })

  output$MapsPipae <- renderLeaflet ({

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

  filtered <- reactive({

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
    return (separated_pipae_by_day)
  })

  output$tableDown <- renderDT ({

    datatable (filtered (), options= list (pageLength = 10))
  })

  output$downtab <- downloadHandler(
    filename = function() {
      paste("Smart_forest_data_", Sys.Date(), ".tsv", sep = "")
    },
    content = function(file) {
      write.table(filtered(), file, row.names = TRUE,)
    }
  )

}

shinyApp(ui=ui, server=server)

#Reserva Florestal do Instituto de
#Biociências


