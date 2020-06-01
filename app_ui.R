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
          p("vis"),
          plotOutput("pie")
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
          p("vis"),
          plotOutput("bar")
        )
      )
    ),
    tabPanel(
      "vis 3",
      sidebarLayout(
        sidebarPanel(
          p("widgets")
        ),
        mainPanel(
          p("vis")
        )
      )
    ),
    tabPanel(
      "summary",
      p("summary")
    )
  )
)
