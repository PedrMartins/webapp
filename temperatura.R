temperatura <- tabPanel("Temperature", #titulo da aba
         sidebarLayout( #layout

           sidebarPanel( #painel lateral
             radioButtons(inputId = "nivel",
                          label = "Mean Nivel",
                          choices =  c("Hour"="H",
                                       "Day"="D",
                                       "Month"="M"),
                          selected = "D"),
             selectInput(inputId = "day",
                         label = "Day",
                         choices = unique(sort(pipae_all$D)),
                         selected = "15",
                         width = "100px"),
             selectInput(inputId = "month",
                         label = "Month",
                         choices = unique(pipae_all$M),
                         width = "100px"),
             selectInput(inputId = "year",
                         label = "Year",
                         choices = unique(pipae_all$Y),
                         width = "100px"),
             radioButtons(inputId= "par",
                          label = "Parcel",
                          choiceValues =  unique (pipae_all$parcela),
                          choiceNames = c("Parcel 1", "Parcel 2", "Parcela 3", "Parcela 4"),
                          selected = "par1"),
             width = 2

           ),#inputs

           mainPanel (
             plotOutput(outputId = "TemperatureID")
           ) #fim Main Panel parte central em geral é onde se tem output
         )#sidebar layout end
) #tabpanel1 end temperatura
