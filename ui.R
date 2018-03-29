library(plotly)
library(shiny)
library(shinyBS)
names <- names(data())
res <- data()$results
res <- data.frame(res)
res <- res[res$Package=="datasets",]
res <- res[order(res$Item),]
datasets <- res$Item
name <- as.character(datasets[1])
data(list=name)
eval(parse(text=paste("dataset <- ",name)))
shinyUI(pageWithSidebar(
  headerPanel("3D Scatter Plots"),
  sidebarPanel(
      selectInput(inputId="dataset", label="Dataset:", choices=datasets, selected = NULL, multiple = FALSE,
                  selectize = TRUE, width = NULL, size = NULL),
      bsPopover("dataset", "Dataset Choice", "Select the dataset to create a customized scatter plot.", placement = "right",
                 trigger = "focus", options = NULL),
      selectInput(inputId="x_axis", label="X axis:", choices="", selected = NULL, multiple = FALSE,
                  selectize = TRUE, width = NULL, size = NULL),
      bsPopover("x_axis", "X axis Choice", "Select the variable of x axis of the chart.", placement = "right",
                trigger = "focus", options = NULL),
      selectInput(inputId="y_axis", label="Y axis:", choices="", selected = NULL, multiple = FALSE,
                  selectize = TRUE, width = NULL, size = NULL),
      bsPopover("y_axis", "Y axis Choice", "Select the variable of y axis of the chart.", placement = "right",
                trigger = "focus", options = NULL),
      selectInput(inputId="z_axis", label="Z axis:", choices="", selected = NULL, multiple = FALSE,
                  selectize = TRUE, width = NULL, size = NULL),
      bsPopover("z_axis", "Z axis Choice", "Select the variable of z axis of the chart.", placement = "right",
                trigger = "focus", options = NULL),
      selectInput(inputId="color", label="Color:", choices="", selected = NULL, multiple = FALSE,
                  selectize = TRUE, width = NULL, size = NULL),
      bsPopover("color", "Color Choice", "Select the variable that will be used to color each point.", placement = "right",
                trigger = "focus", options = NULL)
      
      
      
  ),
  mainPanel(
      htmltools::div(style = "display:inline-block", plotlyOutput("scatter")),
      h4("User Guide"),
      p("This application renders an interactive scatter chart based on user input."),
      tags$ol (
        tags$li("Select dataset;"),
        tags$li("Choose the variable of dataset to plot in X axis;"),
        tags$li("Choose the variable of dataset to plot in Y axis;"),
        tags$li("Choose the variable of dataset to plot in Y axis;"),
        tags$li("Choose the variable of dataset to use as color code of each point;")
      ),
      h5("Luis Andre Dutra e Silva"),
      h6("03/29/2018")
  )
))
