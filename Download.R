Download <- tabPanel("Data Download",
                     sidebarLayout (  #layout
                       sidebarPanel(  #painel lateral
                         selectizeInput("yearDown", "Choose Interval Years",
                                        choices = unique(sort(pipae_all$Y)),
                                        multiple = TRUE,
                                        selected = year(Sys.Date())),
                         radioButtons(inputId = "intervalyear",
                                      label = "Interval Year",
                                      choices =  c("To"="to",
                                                   "And"="and"),
                                      selected = "and",
                                      inline = TRUE),
                         selectizeInput("monthDown", "Choose Interval Months",
                                        choices = unique(sort(pipae_all$M)),
                                        multiple = TRUE,
                                        selected = month(Sys.Date())),
                         radioButtons(inputId = "intervalmonth",
                                      label = "Interval Month",
                                      choices =  c("To"="to",
                                                   "And"="and"),
                                      selected = "and",
                                      inline = TRUE),
                         selectizeInput("daysDown", "Choose Interval Days",
                                        choices = unique(sort(pipae_all$D)),
                                        multiple = TRUE,
                                        selected = day(Sys.Date())),
                         radioButtons(inputId = "intervalday",
                                      label = "Interval Day",
                                      choices =  c("To"="to",
                                                   "And"="and"),
                                      selected = "to",
                                      inline = TRUE),
                         radioButtons(inputId = "vardown",
                                      label = "Variable",
                                      choices =  c("CO\u2082"="co2",
                                                  "Temperature"="temperatura",
                                                  "Moisture"="umidade",
                                                  "Barometer"="pressao",
                                                  "All Variable"="no_one"),
                                      selected = "no_one"),
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
