# Must Run App before using lintr
library(plotly)
library(shiny)
library(dplyr)
source("scripts/charts.R")
source("scripts/summary_questions.R")

# creates list of games
games <- c(
  "Grand Theft Auto V", "Call of Duty: Black Ops 3", "Mario Kart 8",
  "Halo 3", "Minecraft"
)

# creates select widget for piechart with games
game_choices <- selectInput("pie_choice",
  label = "Game Series Choice",
  games, games[1]
)

# creates vector of genres
game_types <- video_games_2016 %>%
  pull(Genre) %>%
  unique()
game_types <- game_types[-13]

# creates select widget for barchart with genre
genre_choices <- selectInput("bar_choice",
  label = "Genre Choice",
  game_types, game_types[1]
)

# creates list of sale locations
sales_lab <- c(
  "Global Sales", "North America Sales", "Europe Sales", "Japan Sales",
  "Other Sales"
)

# creates select widgets for scatterplot(x, y, z, color choice, and
# standard deviation)
x_axis_choice <- selectInput("x", "X axis Choice", sales_lab[-1], sales_lab[2])
y_axis_choice <- selectInput("y", "Y axis Choice", sales_lab[-1], sales_lab[3])
z_axis_choice <- selectInput("z", "Z axis Choice (for 3D plot only)",
                             sales_lab[-1], sales_lab[4])
color_by <- selectInput(
  "color_by", "Color by variable", sales_lab,
  sales_lab[1]
)
sd_choice <- numericInput("sd", "Standard Deviations Above the Mean", value = 6)

# create the fluid page for our UI
ui <- fluidPage(
  includeCSS("style.css"),
  h1("Analysis of Video Game Data"),
  h3("By Tommy Lam, Eric Le, Maya Nair, Assaf Vayner for INFO 201 SP20"),

  tabsetPanel(
    tabPanel(
      "Introduction",
      h2("Looking At Some Video Game Data"),
      p(paste("In this project we examined the world of video games, looking",
               "at popularity, sales, and the variety of video games on the",
               "market. The questions we explored in this final version of the",
               "project were: how do the sales of popular video games compare",
               "across different regions, which consoles are more popular for",
               "a few popular games, and which games sell the best within each",
               "genre. We utilized a 3 datasets in the beginning however",
               "only one is used in this final iteration of the project.")),
      br(),
      # image
      HTML('<center><img src = "controller.jpg"></center>'),
      br(),
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
      br(),
      # image
      HTML('<center><img src = "switch.jpg"></center>'),
      br()
    ),
    tabPanel(
      "Games to Different Consoles",
      sidebarLayout(
        sidebarPanel(
          game_choices
        ),
        mainPanel(
          h2("Pie Chart"),
          plotlyOutput("pie"),
          p(
            "The following", em("pie charts"), "show a comparison between the
            amount of overall", strong("sales"),
            "of games that are released on multiple platforms.
            Each price of the bar chart is represented in", strong("millions"),
            ". The pie chart is split into different slices resembling",
            strong("sales on each platform"), "the game is sold. This chart is
            included to clearly show the", em("sales among platforms"),
            "for specific games to clear inquiry regarding the many inputs of a
            certain game."
          )
        )
      )
    ),

    tabPanel(
      "Game Genres",
      sidebarLayout(
        sidebarPanel(
          genre_choices
        ),
        mainPanel(
          h2("Barchart"),
          plotlyOutput("bar"),
          p(
            "The following", strong("barchart"),
            "looks at different genres to see
            which", strong("games"), "and",  strong("publishers"),
            "sold the most globally.
            Each sale is represented in", strong("millions."),
            "This barchart was used becuase it
            clearly shows", em("which games sold the most and
            which publisher produced the corresponding games."),
            "The usage of color
            to", em("differentiate"), "publishers also adds to the clarity of
            the chart. Above are the barcharts of the", em("12"),
            "genres, ranging from Racing to Strategy."
          ),
        )
      )
    ),
    tabPanel(
      "Game Sales in Different Regions",
      sidebarLayout(
        sidebarPanel(
          x_axis_choice,
          y_axis_choice,
          z_axis_choice,
          color_by,
          sd_choice
        ),
        mainPanel(
          h2("2D plot"),
          plotlyOutput("two_d"),
          br(),
          p("The following scatterplot is interactive to help
           see how well each game performed in specific regions and globally.
           For the axis, you can change the the different options to be",
            strong("North America, Japan, Europe"), "and",
            strong("Other sales"),
            ", while having the color scale to change with any of the listen
            options about including", strong("Global sales"), ". There is also
            a number input for how many", strong("Standard Deviations"),
            "above the mean to sort out the global sales in order for the user
            to see results depending on how well the game did globally.
            Each price is represented in", strong("millions"), ".
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
          h2("3D Scatterplot"),
          plotlyOutput("three_d"),
        )
      )
    ),
    # Summary Page
    tabPanel(
      "Summary",
      # Showcases trend in popular rankings of genres and publishers
      h2("Popularity Based on Region"),
      p(
        "On interesting trend we noticed when looking at top genres and
        publishers across different regions, was that North America, Europe
        and Japan all appear to have similar popularity rankings around these
        given topics. However, Japan appeared to be a slight outlier as there
        were a few different publishers and genres dominating their lists
        whereas North America and Europes rankings aligned."),
      # Shows list of top genres in each region
      h4("Top Genres"),
      p("North America: ", vector3_to_string(na_genres), br(),
        "Europe: ", vector3_to_string(eu_genres), br(),
        "Japan: ", vector3_to_string(jp_genres)),
      # Shows list of top publishers in a given region
      h4("Top Publishers"),
      p("North America: ", vector3_to_string(na_publisher), br(),
        "Europe: ", vector3_to_string(eu_publisher), br(),
        "Japan: ", vector3_to_string(jp_publisher)),
      # Discusses findings on restrictions and playtime
      h2("Age Restrictions"),
      p(
        "One piece of information our group was interested in analyzing, was
        whether or not the playtime on various Steam games had to do with age
        restrictions. The age restriction with the least playtime was age 7.
        While this may be assumed being that children at this age generally have
        their screentime monitored, we found it interesting that games with 0
        age restrictions got the most playtime. This debunked our theory that
        age restriction and playtime may correlate with higher age restrictions
        getting more playtime. Nevertheless, it was interesting to discover that
        games with no age restriction got the most playtime."
      ),
      h4("Playtimes by Age Group"),
      # Renders table of age restrictions and playtime
      tableOutput("pt_table"),
      # Showcases trends discovered in the summmary table
      h2("Summary Table"),
      p("This table is made of publishers who had global sales greater than
      2 standard deviations from the mean global sales of all publishers.
      The Global Popularity column is calculated by the reciprocal of the
      multiplication of the disparities between the NA, EU, JP and other Sales
      normalized to be from 0 to 1 by deviding by global sales.", br(),
      "The Popularity Rank column helps to show which Publishers have higher
      Global Popularity values. The goal of this measurement is to show which
      video game publishers do well across all regions rather than in a
      single region.", br(), "This shows that while NA has greater over all
      Global Sales, Konami Digital Entertainment does a better job at selling
      their products across the world at more similar rate. The Sales values
      are included as is the Global Popularity score to present the actual
      differences in sales, and it is apparent from the tables that the
      publishers with sales numbers closer to each other have a lower
      popularity score and rank."),
      #Renders summary table
      tableOutput("table")
    )
  )
)
