# Load R packages
library(shiny)
library(shinythemes)
library(stringr)
library(lubridate)
library (dplyr)
source("data_update.R")
source("funcao_processamento.R")


ui= fluidPage(theme = shinytheme("flatly"),# theme = "cerulean",
              # <--- To use a theme
              navbarPage( "IoTree",
                          tabPanel("Temperature", #titulo da aba
                                   titlePanel("Temperature"), #titulo do painel

                                   sidebarLayout( #layout

                                     sidebarPanel( #painel lateral
                                                  radioButtons(inputId = "nivel",
                                                               label = "Mean Nivel",
                                                               choices =  c("Hour"="H",
                                                                            "Day"="D",
                                                                            "Month"="M")),
                                                  selectInput(inputId = "day",
                                                              label = "Day",
                                                              choices = unique(sort(pipae7$D)),
                                                              selected = "15",
                                                              width = "100px"),
                                                  selectInput(inputId = "month",
                                                              label = "Month",
                                                              choices = unique(pipae7$M),
                                                              width = "100px"),
                                                  selectInput(inputId = "year",
                                                              label = "Year",
                                                              choices = unique(pipae7$Y),
                                                              width = "100px"),
                                                  width = 2

                                     ),#inputs

                                     mainPanel (
                                       plotOutput(outputId = "TemperatureID")
                                     ) #Main Panel parte central em geral é onde se tem ooutput
                                   )#sidebar layout end
                          ), #tabpanel1 end temperatura
                          tabPanel ("Moisture", titlePanel("Moisture"),
                                    sidebarLayout( #layout

                                      sidebarPanel( #painel lateral
                                                   radioButtons(inputId = "nivelmoisture",
                                                                label = "Mean Nivel",
                                                                choices =  c("Hour"="H",
                                                                             "Day"="D",
                                                                             "Month"="M")),
                                                   selectInput(inputId = "daymoisture",
                                                                label = "Day",
                                                                choices = unique(sort(pipae7$D)),
                                                                selected = "15",
                                                               width = "100px"),
                                                   selectInput(inputId = "monthmoisture",
                                                               label = "Month",
                                                               choices = unique(pipae7$M),
                                                               selected = " ",
                                                               width = "100px"),
                                                   selectInput(inputId = "yearmoisture",
                                                               label = "Year",
                                                               choices = unique(pipae7$Y),
                                                               selected = " ",
                                                               width = "100px"),
                                                   width = 2
                                      ), #inputs end

                                      mainPanel (
                                        plotOutput(outputId = "MoistureID")
                                      ) #Main Panel parte central em geral é onde se tem ooutput
                                    )#sidebar end
                          ), #tabpanel2 end umidade
                          tabPanel("CO2", titlePanel("CO2"),
                                   sidebarLayout (  #layout
                                     sidebarPanel(  #painel lateral
                                                   radioButtons(inputId = "nivelco2",
                                                                label = "Mean Nivel",
                                                                choices =  c("Hour"="H",
                                                                             "Day"="D",
                                                                             "Month"="M")),
                                                   selectInput(inputId = "dayco2",
                                                                label = "Day",
                                                                choices = unique(sort(pipae7$D)),
                                                               selected = "15",
                                                               width = "100px"),
                                                   selectInput(inputId = "monthco2",
                                                               label = "Month",
                                                               choices = unique(pipae7$M),
                                                               selected = " ",
                                                               width = "100px"),
                                                   selectInput(inputId = "yearco2",
                                                               label = "Year",
                                                               choices = unique(pipae7$Y),
                                                               selected = " ",
                                                               width = "100px"),
                                                   width = 2


                                     ), #sidebarpanel end
                                     mainPanel (
                                       plotOutput (outputId = "CO2ID")
                                     )#mainplanel end
                                   ) #sidebar layout end
                          ), #tabpanel2 end co2
                          tabPanel("Variables", "em construção" ), #"será um boxplot com parando parcelas"#tabpanel2 end Variáveis (será boxplot)
                          tabPanel("About", "em construção" )# "Markdown com informações do projeto possivelmente com o script tbm"
              )# navpage end
)




server <- function(input, output, session) {

  output$TemperatureID <- renderPlot({
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
                                                 pipae7$Temperatura, date= pipae7$Data,
                                                 time=pipae7$Hora, media_nivel = input$nivel,
                                                 variavel = "temperatura")
    par( bty ="n", bg = "grey97", las =1)
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
    par( bty ="n", bg = "grey97", las =1)

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
            ylab="Mean temperature ºC", xlab= "Months",
            main="Temperature\nmean by month",
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

    par(bty ="n", bg = "grey97", las =1)


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
            ylab="Mean temperature ºC",
            xlab= "Months",
            main="Temperature\nmean by month",
            ylim = c(min, max) ,xlim=c(1,12))

      lines(media_co2 ~nivel, data=pipae_mediaCO2 ,
            lty = 5, lwd =4,
            col = "gray60")
    }

    legend("topleft",c("Pipae7"),
           col= c("gray60"),
           lty = c(2,3,1), bty = "n")

  }, res= 96)
}

shinyApp(ui=ui, server = server)

