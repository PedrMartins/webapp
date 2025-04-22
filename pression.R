Pression <- tabPanel("Barometer",
                sidebarLayout (  #layout
                  sidebarPanel(  #painel lateral
                    radioButtons(inputId = "nivelpress",
                                 label = "Mean Nivel",
                                 choices =  c("Day"="H",
                                              "Month"="D",
                                              "Year"="M"),
                                 selected = "D"),
                    selectInput(inputId = "daypress",
                                label = "Day",
                                choices = unique(sort(pipae_all$D)),
                                selected = day(Sys.time()),
                                width = "100px"),
                    selectInput(inputId = "monthpres",
                                label = "Month",
                                choices = unique(pipae_all$M),
                                selected = month(Sys.Date()),,
                                width = "100px"),
                    selectInput(inputId = "yearpres",
                                label = "Year",
                                choices = unique(pipae_all$Y),
                                selected = year(Sys.Date()),
                                width = "100px"),
                    width = 2
                  ), #sidebarpanel end
                  mainPanel (
                    plotlyOutput (outputId = "pressID")
                  )#mainplanel end
                ) #sidebar layout end
) #tabpanel2 end co2
