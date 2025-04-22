temperatura <- tabPanel("Temperature", #titulo da aba
         sidebarLayout( #layout

           sidebarPanel( #painel lateral
             radioButtons(inputId = "nivel",
                          label = "Mean Nivel",
                          choices =  c("Day"="H",
                                       "Month"="D",
                                       "Year"="M"),
                          selected = "D"),
             selectInput(inputId = "day",
                         label = "Day",
                         choices = unique(sort(pipae_all$D)),
                         selected = day(Sys.Date()),
                         width = "100px"),
             selectInput(inputId = "month",
                         label = "Month",
                         choices = unique(pipae_all$M),
                         selected = month(Sys.Date()),
                         width = "100px"),
             selectInput(inputId = "year",
                         label = "Year",
                         choices = unique(pipae_all$Y),
                         selected = year(Sys.Date()),
                         width = "100px"),
             width = 2

           ),#inputs

           mainPanel (
             plotlyOutput(outputId = "TemperatureID")
           ) #fim Main Panel parte central em geral é onde se tem output
         )#sidebar layout end
) #tabpanel1 end temperatura
