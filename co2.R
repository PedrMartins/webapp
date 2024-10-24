CO2 <- tabPanel("CO2",
         sidebarLayout (  #layout
           sidebarPanel(  #painel lateral
             radioButtons(inputId = "nivelco2",
                          label = "Mean Nivel",
                          choices =  c("Hour"="H",
                                       "Day"="D",
                                       "Month"="M"),
                          selected = "D"),
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
             radioButtons(inputId= "parco2",
                          label = "Parcel",
                          choiceValues =  unique (pipae7$parcela),
                          choiceNames = c("Parcel 1", "Parcel 2"),
                          selected = "par1"),
             width = 2
           ), #sidebarpanel end
           mainPanel (
             plotOutput (outputId = "CO2ID")
           )#mainplanel end
         ) #sidebar layout end
) #tabpanel2 end co2
