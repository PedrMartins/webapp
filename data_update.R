library(lubridate)
library (dplyr)

pp_7 = "https://docs.google.com/spreadsheets/d/e/2PACX-1vQ0biF6sgjNEaNduLJlkIZV1nMLkZRLWz2ztt5EgKF06-4UJrjWQeAG0KeG-GgVnC_9slqM59gMY78Y/pub?output=csv"

pipae7_raw = read.csv(pp_7, dec= ",")
pipae7 = pipae7_raw
pipae7$Data = dmy (pipae7$Data)
pipae7$Hora = hms (pipae7$Hora)


pipae7 <- pipae7 |>
  mutate(H=hour(pipae7$Hora),
         D=day(pipae7$Data),
         M= month(pipae7$Data),
         Y= year(pipae7$Data),
         m=minute(pipae7$Hora),
         parcela= rep("par1", length(pipae7[,1])))

pp_3 ="https://docs.google.com/spreadsheets/d/e/2PACX-1vSgEviRT5URoJqohwPc4m-HuNkwkqy9TVDOVnDsu7x0hyNYJvLPlc_B9y3TrEqNf1fhe6fPensFXlOH/pub?output=csv"
pipae3_raw = read.csv(pp_3, dec= ",")

pipae3 = pipae3_raw
pipae3$Data = dmy (pipae3$Data)
pipae3$Hora = hms (pipae3$Hora)


pipae3 <- pipae3 |>
  mutate(H=hour(pipae3$Hora),
         D=day(pipae3$Data),
         M= month(pipae3$Data),
         Y= year(pipae3$Data),
         m=minute(pipae3$Hora),
         parcela= rep("par2", length(pipae3[,1])))


pipae7=rbind(pipae7, pipae3)
