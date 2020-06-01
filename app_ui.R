library(shiny)


games <- c("Grand Theft Auto V", "Call of Duty: Black Ops 3", "Mario Kart 7",
           "Halo 3", "Minecraft")
           
game_choices <- selectInput("pie_choice", label = "Game Series Choice",
                            games, games[1])

game_types <-  video_games_2016 %>%
  pull(Genre) %>%
  unique()
game_types <- game_types[-13]

genre_choices <- selectInput("bar_choice", label = "Genre Choice",
                             game_types, game_types[1])

sales_lab <- c("Global Sales", "North America Sales", "Europe Sales", "Japan Sales",
                "Other Sales")

x_axis_choice <- selectInput("x", "X axis Choice", sales_lab[-1], sales_lab[2])
y_axis_choice <- selectInput("y", "Y axis Choice", sales_lab[-1], sales_lab[3])
z_axis_choice <- selectInput("z", "Z axis Choice", sales_lab[-1], sales_lab[4])
color_by <- selectInput("color_by", "Color by variable", sales_lab,
                        sales_lab[1])
sd_choice <- numericInput("sd", "Standard Deviations Above the Mean", value = 1)

ui <- fluidPage(
  titlePanel("Title"),
  
  tabsetPanel(
    tabPanel(
      "Intro",
      
      p("intro info")
    ),
    tabPanel(
      "vis 1",
      sidebarLayout(
        sidebarPanel(
          game_choices
        ),
        mainPanel(
          plotOutput("pie"),
          p("The following", em("pie charts"), "show a comparison between the amount of overall", strong("sales"),
            "of games that are released on multiple platforms.
            The pie chart is split into different slices resembling", strong("sales
            on each platform"), "the game is sold.This chart is included to clearly show 
            the", em("sales among platforms"), "for specific games to clear inquiry regarding the many inputs of a certain game.")
        )
      )
    ),
    tabPanel(
      "vis 2",
      sidebarLayout(
        sidebarPanel(
          p("widgets"),
          genre_choices
        ),
        mainPanel(
          plotOutput("bar"),
          p("The following", em("barcharts"), "look at different genres to see which", em("games and publishers sold the most globally."), 
            "This barchart is included because
            it is clear to see", strong("which games performed the most and which publisher produced the games."), "The usage of color
            to", em("differentiate"), "publishers also adds to the clarity of the chart. Above are the barcharts of the", em("12"),
            "genres, ranging from Racing to Strategy."),
        )
      )
    ),
    tabPanel(
      "vis 3",
      sidebarLayout(
        sidebarPanel(
          x_axis_choice,
          y_axis_choice,
          z_axis_choice,
          color_by,
          sd_choice
        ),
        mainPanel(
          p("vis"),
          plotlyOutput("Three_D")
        )
      )
    ),
    tabPanel(
      "summary",
      p("summary")
    )
  )
)

