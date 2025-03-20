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
              checkboxGroupInput(inputId= "parVar",
                                 label = "Parcel",
                                 choiceValues =  sort (unique (pipae_all$parcela)),
                                 choiceNames = c("Parcel 1", "Parcel 2",
                                                 "Parcel 3", "Parcel 4"),
                                 selected = "par1"),
              width = 3
            ),


            mainPanel(
              plotOutput(outputId = "boxplotvarID")
            )
          )

)
