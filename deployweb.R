install.packages('rsconnect')
library (rsconnect)

rsconnect::setAccountInfo(name='pedro-rufino-13021991',
                          token='CA30B0338DD2F76AEED6C6909E5B78D7',
                          secret='Ycqoz/R8hsOToeu28g0BJQumh6SlVjwHQ3chk5cG')
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



all_c = colors()
str_subset(all_c, "red")
q ()



