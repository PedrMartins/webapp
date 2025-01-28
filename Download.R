Download <- tabPanel("Data Download",
                     sidebarLayout (  #layout
                       sidebarPanel(  #painel lateral
                         selectizeInput("days", "Choose Interval Days",
                                        choices = unique(sort(pipae_all$D)), multiple = TRUE),
                         radioButtons(inputId = "intervalday",
                                      label = "Interval Day",
                                      choices =  c("To"="to",
                                                   "And"="and"),
                                      selected = "to",
                                      inline = TRUE),
                         selectizeInput("month", "Choose Interval Months",
                                        choices = unique(sort(pipae_all$M)), multiple = TRUE),
                         radioButtons(inputId = "intervalmonth",
                                      label = "Interval Month",
                                      choices =  c("To"="to",
                                                   "And"="and"),
                                      selected = "and",
                                      inline = TRUE),
                         selectizeInput("year", "Choose Interval Years",
                                        choices = unique(sort(pipae_all$Y)),
                                        multiple = TRUE),
                         radioButtons(inputId = "intervalyear",
                                      label = "Interval Year",
                                      choices =  c("To"="to",
                                                   "And"="and"),
                                      selected = "and",
                                      inline = TRUE),
                         radioButtons(inputId = "vardown",
                                      label = "Variable",
                                      choices =  c("CO\u2082"="co2",
                                                  "Temperature"="temperatura",
                                                  "Moisture"="umidade",
                                                  "All Variable"="no_one"),
                                      selected = "temperatura"),
                         width = 2
                       ), #sidebarpanel end
                       mainPanel (
                         tabsetPanel(type="tab",
                          tabPanel ("Preview Chart",
                                    plotOutput (outputId = "plotDown"),
                                    downloadButton("downplot","Download Chart",
                                                   class = "custom-download-btn")
                                    ),
                          tabPanel ("Preview Table",
                                    dataTableOutput(outputId="tableDown"),
                                    downloadButton("downtab","Download Table",
                                                   class = "custom-download-btn")
                                    )
                         )
                       )#mainplanel end
                     ) #sidebar layout end
) #tabpanel2 end co2
