variable <- tabPanel ("Variable",
          sidebarLayout(
            sidebarPanel (
              selectizeInput(inputId = "dayvar",
                          label = "Day",
                          choices = unique(sort(pipae_all$D)),
                          selected = day(Sys.time()),
                          multiple=TRUE),
              radioButtons(inputId = "intervalday_var",
                           label = "Interval Year",
                           choices =  c("To"="to",
                                        "And"="and"),
                           selected = "and",
                           inline = TRUE),
              selectizeInput(inputId = "monthvar",
                          label = "Month",
                          choices = unique(pipae_all$M),
                          selected = month(Sys.Date()),
                          multiple=TRUE),
              radioButtons(inputId = "intervalmonth_var",
                           label = "Interval Year",
                           choices =  c("To"="to",
                                        "And"="and"),
                           selected = "and",
                           inline = TRUE),
              selectizeInput(inputId = "yearvar",
                          label = "Year",
                          choices = unique(pipae_all$Y),
                          selected = year(Sys.Date()),
                          multiple=TRUE),
              radioButtons(inputId = "intervalyear_var",
                           label = "Interval Year",
                           choices =  c("To"="to",
                                        "And"="and"),
                           selected = "and",
                           inline = TRUE),
              radioButtons(inputId = "vari",
                          label = "Variables",
                          choices = c("Tempretura"="temp",
                                      "Barometre"="bar",
                                      "Moisture"="umi",
                                      "CO\u2082"="CO2")
                          ),
              width = 3
            ),


            mainPanel(
              plotlyOutput(outputId = "boxplotvarID")
            )
          )

)
