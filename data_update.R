
import_pipae <-  function(pipae = NULL){
  pipae_all = data.frame()
  source <- c ( "pipae1" ="https://docs.google.com/spreadsheets/d/e/2PACX-1vQmbdkhDjts41TXdkpoghubvLQ_5waEms3_RSUXBa_JBg1Z0o2AEnjRpWlTe6lv8go3nouimqUEeklI/pub?output=csv",
                "pipae2" ="https://docs.google.com/spreadsheets/d/e/2PACX-1vQZb9G0b6kE_I91HK7KOtIA7XJ_-OpW6I4J4ibTU4v1ljzAlgplWdzLRpsMiLqr6reiV6Jol3yrvOkE/pub?output=csv",
                #"pipae3"="https://docs.google.com/spreadsheets/d/e/2PACX-1vSgEviRT5URoJqohwPc4m-HuNkwkqy9TVDOVnDsu7x0hyNYJvLPlc_B9y3TrEqNf1fhe6fPensFXlOH/pub?output=csv",
                "pipae5"="https://docs.google.com/spreadsheets/d/e/2PACX-1vQqKltuW8wrgqbU7_y8_sqTFl0LzZrQda8vMoerhvJkgC0x7H6DE3ZmnWROEML8tnfVBCoBLXUgwZHW/pub?output=csv",
                "pipae7"="https://docs.google.com/spreadsheets/d/e/2PACX-1vTdOc4PMg1xC0qpUceE6BZV8L1oLn8D5zf-dALqqWiEQZBFJH23dzPiqwn7NOlFowHEis1N4eb7JvFZ/pub?output=csv",
                #"pipae8"="https://docs.google.com/spreadsheets/d/e/2PACX-1vRezDFvNifmWuJUoVIIhyazBaD281lsr4qeV3EWROGEUH8CDBD01riMOWMfDbsPH0Z8wFkEmtQRbfEC/pub?output=csv",
                "pipae9"="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtwvqsZbeuuR-u18YXmgkFYPzCjd0qYGJ-oX0pNx6o6wfcS1mb140y3YNzuGYrrUVnVebdFVUf8Tss/pub?output=csv",
                "pipae10"="https://docs.google.com/spreadsheets/d/e/2PACX-1vTFwcv50LDoLD0EVEV_r423wSCU6KI8gN-7wjmhZAhaWvgTUL3BeyPiAEzEWS_cHzCsAQkg6r3ssOPt/pub?output=csv",
                "pipae11"="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZP1CXjEgzUE0Apxx4fNK81x5711ex1ZED7wWnboy2XFe6RIUXmmXY7CSyXRC7SR6WaztfSsSjlv5n/pub?output=csv",
                "pipae12"="https://docs.google.com/spreadsheets/d/e/2PACX-1vQjS8tOb5qiGdbxjv9HrwS-cpDOcMBSZ4Kyp0YW0StZGRE4lzZDo8EHXAqpfW4X3iYye1idYPXPZW7P/pub?output=csv"
                )

  #sensores <- paste("pipae",seq(1, length(source)), sep="")
  sensores <- paste("pipae", c(1:2,5,7,9:12), sep="")
  if (is.null(pipae)==TRUE) {stop ("inclua sensores")}

  if (length(setdiff(pipae,sensores))!= 0) {
    stop("não há sensores com essa tag ou há erros na tag \n não deixe espaço entre pipae e o número
         \n ex: 'pipae 7' não funcionará \n ex: 'pipae7' funciona",
         call. = FALSE)
  }
  pipaes <- match(pipae, sensores)


  for (i in pipaes){
      site_url <-  source[i]
      site <- read.csv(site_url, dec= ",")


      if (colnames(site)[1]=="Temperature"){
        site  <- site %>% select(Date, Time, everything())
        }
      colnames(site)[which(colnames(site) == "CO2.Concentration")] <- "CO2_ppm"


      if (names(source[i]) %in%
          c(paste("pipae", c(2,9), sep=""))){
        site$tag = rep (names(source[i]),
                        length(site$CO2_ppm))
        site$parcela = rep ("par2", length(site$CO2_ppm))
      } else if (names(source[i]) %in%
                    c(paste("pipae", c(1,10),sep=""))){
        site$tag = rep (names(source[i]),
                        length(site$CO2_ppm))
        site$parcela = rep ("par1", length(site$CO2_ppm))
      } else if (names(source[i]) %in%
                 c(paste("pipae", c(7),sep=""))) {
        site$tag = rep (names(source[i]),
                        length(site$CO2_ppm))
        site$parcela = rep ("par3", length(site$CO2_ppm))
      }else {
        site$tag = rep (names(source[i]),
                        length(site$CO2_ppm))
        site$parcela = rep ("par4", length(site$CO2_ppm))
      }
      pipae_all <- rbind(pipae_all, site)


  }

  pipae_all$Date = dmy (pipae_all$Date)
  pipae_all$Time = hms (pipae_all$Time)
  pipae_all= pipae_all|>
    mutate(H=hour(pipae_all$Time),
           m=minute(pipae_all$Time),
           D=day(pipae_all$Date),
           M= month(pipae_all$Date),
           Y= year(pipae_all$Date))
  pipae_all$DateTime <- as.POSIXct(
    paste(pipae_all$Date, pipae_all$Time),
    format = "%Y-%m-%d %HH %MM %SS")

  pipae_all
}


pipae_all=import_pipae(pipae=paste0(
                              "pipae", c(1:2,5,7,9:12)
                              )
                       )

