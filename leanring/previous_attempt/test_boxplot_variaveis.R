library(ggplot2)


ui = fluidPage (theme = shinytheme("flatly"),
                navbarPage("Teste",
                           tabPanel ("teste",
                             sidebarLayout(
                               sidebarPanel (
                                 checkboxGroupInput (
                                   inputId = "var",
                                   label = "Variable",
                                   choices = c ("CO2" ="CO2",
                                                "Temperature" = "temp",
                                                "Moisture"= "umi"),
                                   selected = "CO2"
                                 ),
                                 width = 2
                               ),
                               mainPanel(
                                 plotOutput(outputId = "boxplotvarID")
                               )
                             )

                           )

                )
)

server = function(input, output) {
  output$boxplotvarID <-renderPlot({
  head (pipae7)

  excluir <- c("Luminosidade...", "UV...","Data", "Hora",
               "H","D","M","Y","Pressão","m" )
  pipae7 <- pipae7[,!(names(pipae7)%in% excluir)]
  names (pipae7) <-  c("CO2",
                       "temp",
                       "umi",
                       "parcela")
  pipae7 = na.omit(pipae7)
  vars <- input$var
  if (length(vars) > 0) {
    plot_list <- lapply(vars, function(var) {
      ggplot(pipae7, aes_string(x = "parcela", y = var, fill = "parcela")) +
        geom_boxplot() +
        labs(title = var, x = "Parcela", y = var) +
        theme_minimal()
    })
    gridExtra::grid.arrange(grobs = plot_list, ncol = length(vars))
  }
  }, res = 96)
}




shinyApp(ui,server)

head
