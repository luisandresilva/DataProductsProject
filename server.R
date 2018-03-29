library(plotly)
library(shiny)

shinyServer(
   function(input, output, session) {
       output$scatter <- renderPlotly({
           tryCatch({
                eval(parse(text=paste("ds <- data.frame(",input$dataset,")")))
                eval(parse(text=paste("xs <- ds$",input$x_axis)))
                eval(parse(text=paste("ys <- ds$", input$y_axis)))
                eval(parse(text=paste("zs <- ds$", input$z_axis)))
                eval(parse(text=paste("cl <- ds$", input$color)))
                p <- plot_ly(ds, x = ~xs, y = ~ys, z = ~zs, color =~cl, colors = c('#BF382A', '#0C4B8E')) %>%
                    add_markers() %>%
                    layout(scene = list(xaxis = list(title = input$x_axis),
                                        yaxis = list(title = input$y_axis),
                                        zaxis = list(title = input$z_axis)))
                p
           },
           error = function(e)
           {
               plotly_empty()
           },
           warning = function(w)
           {
               plotly_empty()
           })
       })
       observe({
           eval(parse(text=paste("ds2 <- data.frame(",input$dataset,")")))
           choices <- names(ds2)
           updateSelectInput(session, "x_axis",
                             choices = choices)
           updateSelectInput(session, "y_axis",
                            choices = choices)
           updateSelectInput(session, "z_axis",
                             choices = choices)
           updateSelectInput(session, "color",
                             choices = choices)
           
       })
   }
)
