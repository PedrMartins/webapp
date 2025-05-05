# IoTree Web application 

This application on web was build on R language using shiny package. To understand how build
or improve this application you can follow this tutorial on [youtube](https://www.youtube.com/watch?v=9uFQECk30kA&t=1273s) 
or in this [ebook](https://mastering-shiny.org/).

The main script in this repository is the [app.R](https://github.com/PedrMartins/webapp/blob/master/app.R), 
in these repository you'll find the code that run the front-end (ui) and the back-end (server) 
to combine front and back you must to use the `shinyApp ()` function as the example bellow.

In this application, the user interface are building using the `ui` object. Inside this object we build 6 objects:

- [pression.R](https://github.com/PedrMartins/webapp/blob/master/pression.R)
- [co2.R](https://github.com/PedrMartins/webapp/blob/master/co2.R)
- [temperatura.R](https://github.com/PedrMartins/webapp/blob/master/temperatura.R)
- [umidade.R](https://github.com/PedrMartins/webapp/blob/master/umidade.R)
- [variable.R](https://github.com/PedrMartins/webapp/blob/master/variable.R)
  - All the plots above are building using Plotly package for more details you can watch this [videos](https://www.youtube.com/watch?v=xerW2TvZHbQ&list=PLu6UwBFCnlEd2NazdWqG4htJ8PQjk28Xp), also you can get more details and ideas in this [site](https://plotly.com/r/)
- [Download.R](https://github.com/PedrMartins/webapp/blob/master/Download.R)

Other mainly object use for this application is the `server ()` function that was wrote in the main R script.

the ` shinyApp (ui=ui, server=server) ` will run the application. 

other key srcipts are:
- [library_package.R](https://github.com/PedrMartins/webapp/blob/master/library_package.R)
  - This script will download all the packages requested and open them in the work directory using the `library ()` fiunction.
- [data_update.R](https://github.com/PedrMartins/webapp/blob/master/data_update.R)
  - Here the mainly function of this script you will download the data that are being sesoring by Pipaes on field.
- [funcao_processamento.R](https://github.com/PedrMartins/webapp/blob/master/funcao_processamento.R)
  - In this script all key functions are build for the better working of the application.

For more code examples run the lines bellow

``` r
runExample("01_hello")      # a histogram
runExample("02_text")       # tables and data frames
runExample("03_reactivity") # a reactive expression
runExample("04_mpg")        # global variables
runExample("05_sliders")    # slider bars
runExample("06_tabsets")    # tabbed panels
runExample("07_widgets")    # help text and submit buttons
runExample("08_html")       # Shiny app built from HTML
runExample("09_upload")     # file upload wizard
runExample("10_download")   # file download wizard
runExample("11_timer")      # an automated timer
```


The web app are deployed on [shiny.io](https://www.shinyapps.io/)

>To debug web aplications you might use the log session. To access the log you have to click on your application, and then, 
click on log on topright on your screen.
>For more details use this [page](https://shiny.posit.co/r/articles/) to learning about the package possibilities.
>##### On this site you'll learn how:
> - Debuging your code
>   - The function `browser()` will be very usefull for the buging propouse 
> - Improve the scale of your application
> - Deploy your web application


### The application is deployed on this link [Smart forests](https://pedro-rufino-13021991.shinyapps.io/webapp/)

