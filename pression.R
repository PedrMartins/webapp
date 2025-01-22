Pression <- tabPanel("Barometer",
                sidebarLayout (  #layout
                  sidebarPanel(  #painel lateral
                    radioButtons(inputId = "nivelpress",
                                 label = "Mean Nivel",
                                 choices =  c("Hour"="H",
                                              "Day"="D",
                                              "Month"="M"),
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
                    radioButtons(inputId= "parpress",
                                 label = "Parcel",
                                 choiceValues =  sort(unique (pipae_all$parcela)),
                                 choiceNames = c("Parcel 1", "Parcel 2",
                                                 "Parcel 3", "Parcel 4"),
                                 selected = "par1"),
                    width = 2
                  ), #sidebarpanel end
                  mainPanel (
                    plotOutput (outputId = "pressID")
                  )#mainplanel end
                ) #sidebar layout end
) #tabpanel2 end co2
