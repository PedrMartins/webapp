CO2 <- tabPanel("CO\u2082",
         sidebarLayout (  #layout
           sidebarPanel(  #painel lateral
             radioButtons(inputId = "nivelco2",
                          label = "Mean Nivel",
                          choices =  c("Day"="H",
                                       "Month"="D",
                                       "Year"="M"),
                          selected = "D"),
             selectInput(inputId = "dayco2",
                         label = "Day",
                         choices = unique(sort(pipae_all$D)),
                         selected = day(Sys.time()),
                         width = "100px"),
             selectInput(inputId = "monthco2",
                         label = "Month",
                         choices = unique(pipae_all$M),
                         selected = month(Sys.Date()),,
                         width = "100px"),
             selectInput(inputId = "yearco2",
                         label = "Year",
                         choices = unique(pipae_all$Y),
                         selected = year(Sys.Date()),
                         width = "100px"),
             radioButtons(inputId= "parco2",
                          label = "Parcel",
                          choiceValues =  sort(unique (pipae_all$parcela)),
                          choiceNames = c("Parcel 1", "Parcel 2",
                                          "Parcel 3", "Parcel 4"),
                          selected = "par1"),
             width = 2
           ), #sidebarpanel end
           mainPanel (
             plotOutput (outputId = "CO2ID")
           )#mainplanel end
         ) #sidebar layout end
) #tabpanel2 end co2
