library(shiny)
source("scripts/charts.R")
source("scripts/summary_table.R")


server <- function(input, output) {
# Renders pie chart for tab 2
  output$pie <- renderPlot({
    choice <- input$pie_choice
    plt <- pie_console(choice, df = video_games_2016)
    plot(plt)
  })

# Renders bar chart for tab 3
  output$bar <- renderPlotly({
    choice <- input$bar_choice
    plt <- barplot_genre_publisher(choice, df = video_games_2016)
    plot(plt)
  })

# Renders 3d scatter plot for tab 4
  output$three_d <- renderPlotly({
    plt <- make_3d_scatter(input$x, input$y, input$z, input$color_by, input$sd,
                           df = video_games_2016)
    print(plt)
  })

# Renders 2d scatter plot for tab 4  
  output$two_d <- renderPlotly({
    plt <- make_2d_scatter(input$x, input$y, input$color_by, input$sd,
                           df = video_games_2016)
    print(plt)
  })

# Renders publisher table for tab 5  
  output$table <- renderTable(publisher_table,
                              align = 'rccccccc')

# Renders playtime table for tab 5  
  output$pt_table <- renderTable(average_playtimes,
                                 align = 'cc')
  
}

