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

sales_lab <- c("Global_Sales", "NA_Sales", "EU_Sales", "JP_Sales",
                "Other_Sales")

x_axis_choice <- selectInput("x", "X axis Choice", sales_lab[-1], sales_lab[2])
y_axis_choice <- selectInput("y", "Y axis Choice", sales_lab[-1], sales_lab[3])
z_axis_choice <- selectInput("z", "Z axis Choice", sales_lab[-1], sales_lab[4])
color_by <- selectInput("color_by", "Color by variable", sales_lab,
                        sales_lab[1])

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
          x_axis_choice,
          y_axis_choice,
          z_axis_choice,
          color_by
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
