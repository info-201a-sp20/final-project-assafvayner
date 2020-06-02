library(plotly)
library(shiny)
library(dplyr)
source("scripts/charts.R")

games <- c(
  "Grand Theft Auto V", "Call of Duty: Black Ops 3", "Mario Kart 7",
  "Halo 3", "Minecraft"
)

game_choices <- selectInput("pie_choice",
  label = "Game Series Choice",
  games, games[1]
)

game_types <- video_games_2016 %>%
  pull(Genre) %>%
  unique()
game_types <- game_types[-13]

genre_choices <- selectInput("bar_choice",
  label = "Genre Choice",
  game_types, game_types[1]
)

sales_lab <- c(
  "Global Sales", "North America Sales", "Europe Sales", "Japan Sales",
  "Other Sales"
)

x_axis_choice <- selectInput("x", "X axis Choice", sales_lab[-1], sales_lab[2])
y_axis_choice <- selectInput("y", "Y axis Choice", sales_lab[-1], sales_lab[3])
z_axis_choice <- selectInput("z", "Z axis Choice", sales_lab[-1], sales_lab[4])
color_by <- selectInput(
  "color_by", "Color by variable", sales_lab,
  sales_lab[1]
)
sd_choice <- numericInput("sd", "Standard Deviations Above the Mean", value = 6)

ui <- fluidPage(
  includeCSS("style.css"),
  h1("Title"),

  tabsetPanel(
    tabPanel(
      "Introduction to the Project",
      h2("Looking At Some Video Game Data"),
      p(paste("In this project we examined the world of video games, looking",
               "at popularity, sales, and the variety of video games on the",
               "market. The questions we explored in this final version of the",
               "project were: how do the sales of popular video games compare",
               "across different regions, which consoles are more popular for",
               "a few popular games, and which games sell the best within each",
               "genre. We utilized a 3 datasets in the beginning however",
               "only one is used in this final iteration of the project.")),
      HTML('<center><img src = "controller.jpg"></center>'),
      p(paste("The dataset we used contains information about the sales of",
              "video games in multiple regions blocked by console used to play",
              "each game. This data contains such information as well as a few",
              "more attributes such as the developer and publisher of the ",
              "game for all popular games from the 1980's to 2016. We found",
              "this data on kaggle and can be found at this "),
        a(href = paste0("https://www.kaggle.com/sidtwr/videogames-sales-dataset
                        ?select=Video_Games_Sales_as_at_22_Dec_2016.csv"),
                        "link"),
        "."
        ),
      HTML('<center><img src = "switch.jpg"></center>'),
      br()
    ),
    tabPanel(
      "Visualization of Games to Different Consoles",
      sidebarLayout(
        sidebarPanel(
          game_choices
        ),
        mainPanel(
          h2("Pie Chart"),
          plotOutput("pie"),
          p(
            "The following", em("pie charts"), "show a comparison between the
            amount of overall", strong("sales"),
            "of games that are released on multiple platforms.
            The pie chart is split into different slices resembling",
            strong("sales on each platform"), "the game is sold. This chart is
            included to clearly show the", em("sales among platforms"),
            "for specific games to clear inquiry regarding the many inputs of a
            certain game."
          )
        )
      )
    ),

    tabPanel(
      "Visualization of Game Genres",
      sidebarLayout(
        sidebarPanel(
          genre_choices
        ),
        mainPanel(
          h2("Barchart"),
          plotOutput("bar"),
          p(
            "The following", em("barcharts"), "look at different genres to see
            which", em("games and publishers sold the most globally."),
            "This barchart is included because
            it is clear to see", strong("which games performed the most and
            which publisher produced the games."), "The usage of color
            to", em("differentiate"), "publishers also adds to the clarity of
            the chart. Above are the barcharts of the", em("12"),
            "genres, ranging from Racing to Strategy."
          ),
        )
      )
    ),
    tabPanel(
      "Visualization of Game Sales in Different Regions",
      sidebarLayout(
        sidebarPanel(
          x_axis_choice,
          y_axis_choice,
          z_axis_choice,
          color_by,
          sd_choice
        ),
        mainPanel(
          h2("3D Scatterplot"),
          plotlyOutput("Three_D"),
          p(
            "The following scatterplot is interactive to help
           see how well each game performed in specific regions and globally.
           For the axis, you can change the the different options to be",
            strong("North America, Japan, Europe"), "and",
            strong("Other sales"),
            ", while having the color scale to change with any of the listen
            options about including", strong("Global sales"), ". There is also
            a number input for how many", strong("Standard Deviations"),
            "above the mean to sort out the global sales in order for the user
            to see results depending on how well the game did globally.
            We decided to do an interactivescatter plot for this part in order
            for the reader to see how the game sold in each region
            specifically, and the color scaling helps see which games did the
            best globally. The chart gives us the option to have 4 different
            variables in the axis and color, while a normal scatter plot
            only allows for 3. The graph itself was an interesting idea
            because of how we made it", em("3 dimensional"), " and how clearly
            you can see how some games are outperforming others overall or
            just regionally. While hovering over each dot, you can see the
            stats broken down along with", em("name"), " and", em("genre"),
            ". The default data was set to 6 standard deviations above the
            mean, but there are still many games so we can tell that there
            have been more games that performed worse than games that have
            been successful. We can see from the games that sold 25M +,
            the US contributed the most out of the regions tested and so
            we can tell that most of the game sales come from the US. The
            genres of popular games are also diverse being Platform, Puzzle,
            Shooter, and Role-playing so that means there is variety when
            it comes to popular games and not one genre is dominating the
            market."
          ),
        )
      )
    ),
    tabPanel(
      "summary",
      h2("summary end"),
      p("summary")
    )
  )
)
