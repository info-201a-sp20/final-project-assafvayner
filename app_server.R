# Must Run App before using lintr
library(shiny)
source("scripts/charts.R")
source("scripts/summary_table.R")
source("scripts/summary_questions.R")


server <- function(input, output) {
  output$pie <- renderPlotly({
    choice <- input$pie_choice
    plt <- pie_plotly(choice, df = video_games_2016)
    print(plt)
  })

  output$bar <- renderPlot({
    choice <- input$bar_choice
    plt <- barplot_genre_publisher(choice, df = video_games_2016)
    plot(plt)
  })

  output$three_d <- renderPlotly({
    plt <- make_3d_scatter(input$x, input$y, input$z, input$color_by, input$sd,
                           df = video_games_2016)
    print(plt)
  })

  output$two_d <- renderPlot({
    plt <- make_2d_scatter(input$x, input$y, input$color_by, input$sd,
                           df = video_games_2016)
    print(plt)
  })

  output$table <- renderTable(publisher_table, align = "rccccccc")
  output$pt_table <- renderTable(average_playtimes, align = "cc")
}
