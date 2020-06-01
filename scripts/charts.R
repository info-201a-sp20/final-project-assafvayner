library(ggplot2)
library(dplyr)
library(plotly)
library(RColorBrewer)
library(lintr)

# Reads in CSV
video_games_2016 <- read.csv("./data/Video_Games_Sales_as_at_22_Dec_2016.csv",
                             stringsAsFactors = FALSE)
video_games_2016 <- video_games_2016[-1, ]

# Bar Chart ----

# Creates bar chart of games, global sales, and publisher for specific genre
barplot_genre_publisher <- function(genre, df) {
  genre_df <- df %>%
    filter(Genre == genre,
           Global_Sales > mean(Global_Sales) + 3 * sd(Global_Sales))

  bar <- ggplot(genre_df, aes(x = Name, y = Global_Sales, fill = Publisher)) +
    geom_bar(stat = "identity") +
    labs(title = paste0("Global Game sales in ", genre),
         x = "Game", y = "Global Sales") +
    theme(axis.text.x = element_text(angle = 70, vjust = 0.5))
  return(bar)
}

# Creates barcharts for different genres
sports_barchart <- barplot_genre_publisher("Sports", video_games_2016)
shooter_barchart <- barplot_genre_publisher("Shooter", video_games_2016)
platform_barchart <- barplot_genre_publisher("Platform", video_games_2016)

# Interactive 3d Scatter plot ----

# Function for 3d scatter plot with Na, Eu, and JP sales on axis
# and color scaling with global sales


make_3d_scatter <- function(x_choice, y_choice ,z_choice, color_choice, sd_choice, df) {
  games_df<- df %>%
    filter(Global_Sales > mean(Global_Sales) + sd_choice * sd(Global_Sales)) %>% 
    rename("Japan Sales" = JP_Sales,
           "North America Sales" = NA_Sales,
           "Europe Sales" = EU_Sales,
           "Other Sales" = Other_Sales,
           "Global Sales" = Global_Sales)
  plot <- plot_ly(games_df, x = ~get(x_choice), y = ~get(y_choice), z = ~get(z_choice),
                  hovertemplate = paste(games_df[["Name"]], "<extra></extra>",
                                        "<br>Genre:", games_df[["Genre"]],
                                        "<br>Global Sales:",
                                        games_df[["Global Sales"]], "<br>NA Sales:",
                                        games_df[["North America Sales"]],
                                        "<br>EU Sales:", games_df[["Europe Sales"]],
                                        "<br>JP Sales:", games_df[["Japan Sales"]],
                                        "<br>Other Sales:", games_df[["Other Sales"]]),
                  marker = list(color = ~get(color_choice),
                                colorscale = c("#FFE1A1", "#683531"),
                                showscale = TRUE)) %>%
    add_markers() %>%
    layout(title = "Comparing Games to Sales in Different Regions") %>%
    layout(scene = list(xaxis = list(title = x_choice),
                        yaxis = list(title = y_choice),
                        zaxis = list(title = z_choice)),
           annotations = list(
             x = 1.08,
             y = 1.05,
             text = color_choice,
             xref = "paper",
             yref = "paper",
             showarrow = FALSE
           ))
  return(plot)
} 

# Assigns plot to variable
x3d_scatterplot <- make_3d_scatter("North America Sales","Europe Sales",
                                   "Japan Sales", "Global Sales", 6, video_games_2016)

pie_console <- function(name, df) {
console <- df %>%
  group_by(Name, Platform) %>%
  summarize(sales = sum(NA_Sales, EU_Sales, JP_Sales,
                        Other_Sales, Global_Sales)) %>%
  filter(Name == name) %>%
  arrange(-sales)
y_name <- paste0("Game: ", name)
plt <- ggplot(console, aes(x = Name, y = sales, fill = Platform)) +
  geom_bar(stat = "identity", width = 1, color = "black") +
  coord_polar("y", start = 0) +
  theme(axis.title.y = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid  = element_blank()) +
  labs(title = "Game Sales by Console", y = y_name) +
  geom_text(aes(label = sales), position = position_stack(vjust = .5),
            color = "white", size = 3)
return(plt)
}
