variable <- tabPanel ("Variable",
          sidebarLayout(
            sidebarPanel (
              checkboxGroupInput (
                inputId = "var",
                label = "Variable",
                choices = c ("CO\u2082" ="CO2",
                             "Temperature" = "temp",
                             "Moisture"= "umi",
                             "Barometer"="bar"),
                selected = "temp"
              ),
              selectInput(inputId = "dayvar",
                          label = "Day",
                          choices = unique(sort(pipae_all$D)),
                          selected = day(Sys.time()),
                          width = "100px"),
              selectInput(inputId = "monthvar",
                          label = "Month",
                          choices = unique(pipae_all$M),
                          selected = month(Sys.Date()),,
                          width = "100px"),
              selectInput(inputId = "yearvar",
                          label = "Year",
                          choices = unique(pipae_all$Y),
                          selected = year(Sys.Date()),
                          width = "100px"),
              width = 3
            ),


            mainPanel(
              tabsetPanel (type="tab",
                tabPanel ("CO\u2082",
                  plotlyOutput(outputId = "boxplotvarID")
                )

                )

            )
          )

)
