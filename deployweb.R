install.packages('rsconnect')
library (rsconnect)

rsconnect::setAccountInfo(name='${SHINYAPPS_NAME}',
                          token='${SHINYAPPS_TOKEN}',
                          secret='${SHINYAPPS_SECRET}')
rsconnect::deployApp("~/Desktop/R_analysis/webapp",
                     appFiles = c("app.R",
                                  "data_update.R",
                                  "funcao_processamento.R",
                                  "about.md",
                                  "umidade.R",
                                  "variable.R",
                                  "temperatura.R",
                                  "co2.R")
                     )

