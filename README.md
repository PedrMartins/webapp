# IoTree Web application 

This application on web was build on R language using shiny package. To understand how build
or improve this application you can follow this tutorial [on youtube](https://www.youtube.com/watch?v=9uFQECk30kA&t=1273s) 
or in this [ebook](https://mastering-shiny.org/)

The main script in this repository is the [app.R](https://github.com/PedrMartins/webapp/blob/master/app.R), 
in these repository you'll find the code that run the front-end (ui) and the back-end (server) 
to combine front and back you must to use the `shinyApp ()` function as the example bellow.

` shinyApp (ui=ui, server=server) `

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
> - Improve the scale of your application
> - Deploy your web application


### [smart forest](https://pedro-rufino-13021991.shinyapps.io/webapp/)

