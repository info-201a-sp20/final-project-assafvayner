library(shiny)
source("scripts/charts.R")

server <- function(input, output) {
  output$pie <- renderPlot({
    choice <- input$pie_choice
    plt <- pie_console(choice, df = video_games_2016)
    plot(plt)
  })
  
  output$bar <- renderPlot({
    choice <- input$bar_choice
    print(choice)
    plt <- barplot_genre_publisher(choice, df = video_games_2016)
    plot(plt)
  })
  
  output$Three_D <- renderPlotly({
    plt <- make_3d_scatter(input$x, input$y, input$z, input$color_by, input$sd, df=video_games_2016)
    print(plt)
  })
}

