
get_dados_separados = function ( data, x, date=NULL, time=NULL,
                                media_nivel = "D", variavel = "co2"
                                ,  ...) {

  required_pkgs <- c("lubridate", "dplyr")
  missing_pkgs <- required_pkgs[!(required_pkgs %in% installed.packages()[, "Package"])]
  if (length(missing_pkgs) > 0) {
    stop("Instalar pacotes: ", paste(missing_pkgs, collapse = ", "))
  }
  lapply(required_pkgs, library, character.only = TRUE)

  if (is.null(date)==TRUE) {
    stop ("Argumento 'date' ausente")
  }
  if (is.character(date)==TRUE) {
    date <- dmy (date)
  }
  data$date <- date
  data <- data |>
    mutate (D=day(data$date),
            M= month(data$date),
            Y= year(data$date))


  nivel <- intersect(c("H", "D", "M"), media_nivel)
  var <- intersect(c ("co2","temperatura","umidade", "pressao"), variavel)
  if (nivel== "H" & is.null(time)==TRUE) {
    stop("deve informar variável 'time'")
  }
  if (is.null(time)==FALSE) {
    if (is.character (time)==TRUE) {time = hms(time)}
    data$time <- time
    data= data|>
      mutate (
        m=minute(data$time),
        H=hour(data$time))
  }

  if (length(nivel) != 1 | length (var) !=1 ) {
    stop("\t Argumentos 'media_nivel' ou 'variavel' ausente \n \t ou com erro na digitação")
  }
  var2=paste("media", var, sep="_")

  data$variavel <- x

  dataM = data |>
    group_by (across(all_of(nivel))) |>
    summarise(!!var2:=mean(variavel, na.rm = TRUE)) #' !! : operador retorna o interior
  #'de um objeto

  dataM = dataM |>
    left_join(data,dataM, by =nivel)
   if (nivel == "H"){
    dataM$HD <- paste(dataM$H, dataM$D,sep ="_")
    dataM <- dataM [!duplicated(dataM$HD),]
  } else if (nivel== "M") {
    dataM$M_Y <- paste (dataM$M,dataM$Y, sep="-")
    dataM <- dataM [!duplicated(dataM$M_Y),]
  } else {
    dataM <- dataM [!duplicated(dataM$date),]
  }

  dataM = dataM [order(dataM$date),]
  excluir <- c("time", "date", "HD","m", "M_Y", "variavel")
  dataM <- dataM[,!(names(dataM)%in% excluir)]

  #Nivel de detalhamento escolhas "H" média por hora
  #"D" média diária e "M" média mensal
  return (dataM)
}


separate_variable <- function(x, variable = "co2", na.rm = FALSE,
                              order=FALSE, duplicated= FALSE) {
  # Definindo um vetor nomeado que mapeia variáveis às suas colunas
  column_map <- list(
    co2 = c("CO2_ppm", "Date", "DateTime",
            "Time","H","D", "M", "Y", "m",
            "tag", "parcela"),
    temperatura = c("Temperature", "Date", "DateTime",
                    "Time", "H","D", "M", "Y", "m"
                    , "tag", "parcela"),
    umidade = c("Humidity", "Date", "DateTime",
                "Time", "H","D", "M", "Y", "m",
                "tag", "parcela"),
    pressao = c("Pressure", "Date", "DateTime",
                     "Time","H", "D", "M", "Y", "m",
                     "tag", "parcela")
  )

  # Verifica se a variável está no mapa, caso contrário, retorna NULL
  selected_columns <- column_map[[variable]]

  if (is.null(selected_columns)) {
    stop("Variable not recognized.
         Please choose from 'co2',
         'temperatura', 'umidade', or
         'pressao'.")
  }

  # Subconjunto dos dados com as colunas selecionadas
  x <- x[, selected_columns, drop = FALSE]

  # Remover valores NA, se solicitado
  if (na.rm) { x <- na.omit(x) }
  if (order){x <-  x[order(x$DateTime),]}
  if (duplicated) {x <- x [!duplicated(x$DateTime),]}
  return (x)
}



get_data_by_date <- function(x, month = NULL, days = NULL, year = NULL, order = TRUE) {
  # Ensure the year is provided
  if (is.null(year)) {
    stop("Choose a year to download the data.")
  }

  # Filter by year
  if (length(year) == 1) {
    pipae_separated <- x[x$Y == year, ]
  } else {
    pipae_separated <-  x[x$Y %in% year, ]
  }
  unique(pipae_separated$D)
  # Filter by month if provided
  if (!is.null(month)) {
    if (length(month) == 1) {
      pipae_separated <- pipae_separated[pipae_separated$M == month, ]
    } else {
      pipae_separated <- pipae_separated[pipae_separated$M %in% month, ]
    }
  }

  # Filter by days if provided
  if (!is.null(days)) {
    if (length(days) == 1) {
      pipae_separated <- pipae_separated[pipae_separated$D == days, ]
    } else {
      pipae_separated <- pipae_separated[pipae_separated$D %in% days, ]
    }
  }

  # Order by DateTime if required
  if (order) {
    pipae_separated <- pipae_separated[order(pipae_separated$DateTime), ]
  }

  return(pipae_separated)
}
