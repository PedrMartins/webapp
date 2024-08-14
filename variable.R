variable <- tabPanel ("Variable",
          sidebarLayout(
            sidebarPanel (
              checkboxGroupInput (
                inputId = "var",
                label = "Variable",
                choices = c ("CO2" ="CO2",
                             "Temperature" = "temp",
                             "Moisture"= "umi"),
                selected = "temp"
              ),
              checkboxGroupInput(inputId= "parVar",
                                 label = "Parcel",
                                 choiceValues =  unique (pipae7$parcela),
                                 choiceNames = c("Parcel 1", "Parcel 2"),
                                 selected = "par1"),
              width = 3
            ),


            mainPanel(
              plotOutput(outputId = "boxplotvarID")
            )
          )

)
