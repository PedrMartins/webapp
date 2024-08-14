umidade <- tabPanel ("Moisture",
          sidebarLayout( #layout

            sidebarPanel( #painel lateral
              radioButtons(inputId = "nivelmoisture",
                           label = "Mean Nivel",
                           choices =  c("Hour"="H",
                                        "Day"="D",
                                        "Month"="M"),
                           selected = "D"),
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
              radioButtons(inputId= "parmoisture",
                           label = "Parcel",
                           choiceValues =  unique (pipae7$parcela),
                           choiceNames = c("Parcel 1", "Parcel 2"),
                           selected = "par1"),
              width = 2,
              fluid = TRUE
            ), #inputs end

            mainPanel (
              plotOutput(outputId = "MoistureID")
            ) #Main Panel parte central em geral é onde se tem ooutput
          )#sidebar end
) #tabpanel2 end umidade
