umidade <- tabPanel ("Moisture",
          sidebarLayout( #layout

            sidebarPanel( #painel lateral
              radioButtons(inputId = "nivelmoisture",
                           label = "Mean Nivel",
                           choices =  c("Day"="H",
                                        "Month"="D",
                                        "Year"="M"),
                           selected = "D"),
              selectInput(inputId = "daymoisture",
                          label = "Day",
                          choices = unique(sort(pipae_all$D)),
                          selected = day(Sys.Date()),,
                          width = "100px"),
              selectInput(inputId = "monthmoisture",
                          label = "Month",
                          choices = unique(pipae_all$M),
                          selected = month(Sys.Date()),,
                          width = "100px"),
              selectInput(inputId = "yearmoisture",
                          label = "Year",
                          choices = unique(pipae_all$Y),
                          selected = year(Sys.Date()),,
                          width = "100px"),
              width = 2,
              fluid = TRUE
            ), #inputs end

            mainPanel (
              plotlyOutput(outputId = "MoistureID")
            ) #Main Panel parte central em geral é onde se tem ooutput
          )#sidebar end
) #tabpanel2 end umidade
