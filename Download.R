Download <- tabPanel("Data Download",
                     sidebarLayout (  #layout
                       sidebarPanel(  #painel lateral
                         selectizeInput("days", "Days",
                                        choices = unique(sort(pipae_all$D)), multiple = TRUE),
                         radioButtons(inputId = "intervalday",
                                      label = "Interval Day",
                                      choices =  c("To"="to",
                                                   "And"="and"),
                                      selected = "To"),
                         selectizeInput("month", "Months",
                                        choices = unique(sort(pipae_all$M)), multiple = TRUE),
                         radioButtons(inputId = "intervalmonth",
                                      label = "Interval Month",
                                      choices =  c("To"="to",
                                                   "And"="and"),
                                      selected = "To"),
                         selectizeInput("year", "Years",
                                        choices = unique(sort(pipae_all$Y)),
                                        multiple = TRUE),
                         radioButtons(inputId = "intervalyear",
                                      label = "Interval Year",
                                      choices =  c("To"="to",
                                                   "And"="and"),
                                      selected = "To"),
                         checkboxGroupInput(inputId = "tab_plot",
                                      label = "Format",
                                      choices =  c("Table"="tab",
                                                   "Chart"="plot"),
                                      selected = "Chart")
                         ,
                         width = 2
                       ), #sidebarpanel end
                       mainPanel (
                         tabsetPanel(type="tab",
                          tabPanel ("Chart",
                                    plotOutput (outputId = "plotDown"),
                                    downloadButton("downplot","Download Chart",
                                                   class = "custom-download-btn")
                                    ),
                          tabPanel ("Table",
                                    tableOutput(outputId="tableDown"),
                                    downloadButton("downtab","Download Table",
                                                   class = "custom-download-btn")
                                    )
                         )
                       )#mainplanel end
                     ) #sidebar layout end
) #tabpanel2 end co2
