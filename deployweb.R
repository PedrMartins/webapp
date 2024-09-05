install.packages('rsconnect')
library (rsconnect)

rsconnect::setAccountInfo(name= ${{ secrets.SHINYAPPS_NAME}},
                          token=${{ secrets.SHINYAPPS_TOKEN}},
                          secret=${{ secrets.SHINYAPPS_SECRET}})
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
