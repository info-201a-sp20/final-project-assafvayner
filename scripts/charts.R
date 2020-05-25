# assigned to Tommy and Eric
data <- read.csv("./data/video_games.csv", stringsAsFactors = FALSE)
video_games_2016 <- read.csv("./data/Video_Games_Sales_as_at_22_Dec_2016.csv",
                        stringsAsFactors = FALSE)
video_games_2016 <- video_games_2016[-1, ]
library(ggplot2)
library(dplyr)
library(plotly)
library(RColorBrewer)

## Barchart of games and prices ----
game_name <- data %>% 
  group_by(game) %>%
  summarise(price = sum(price, na.rm = TRUE)) %>% 
  head(10)
game <- data %>% 
  group_by(game) %>%
  summarise(price = sum(price, na.rm = TRUE), 
            average_playtime = sum(average_playtime, na.rm=TRUE)) %>% 
  head(10)

plot <- ggplot(game_name) +
  geom_col(mapping = aes(x = game, y = price))+
  labs(title = "Game Prices", x= "Games", y= "Prices") +
  theme(plot.title = element_text(hjust=.5)) +
  theme(axis.text.x = element_text(angle=70, hjust=1))+
  labs(fill =("Prices"))

# Bar Chart ----

# Creates bar chart of games, global sales, and publisher for specific genre
barplot_genre_publisher <- function(genre, df){
  genre_df <- df %>% 
    filter(Genre == genre, Global_Sales > 5)
  
  bar <- ggplot(genre_df, aes(x=Name, y=Global_Sales, fill=Publisher)) +
    geom_bar(stat="identity")+labs(title = paste0("Global Game sales in ", genre), x ="Game", y="Global Sales")+
    theme(axis.text.x = element_text(angle = 70, vjust = 0.5))
  return(bar)
}

barplot_genre_publisher("Sports", video_games_2016)

# Interactive 3d Scatter plot ----

# Function for 3d scatter plot with Na, Eu, and JP sales on axis
# and color scaling with global sales
make_3d_scatter <- function(df){
  plot <- plot_ly(filtered, x = ~NA_Sales, y = ~EU_Sales, z = ~JP_Sales, 
                  hovertemplate = paste(df$Name,'<extra></extra>' , '<br>Global Sales:', df$Global_Sales,'<br>NA Sales:', df$NA_Sales,
                                        '<br>EU Sales:', df$EU_Sales, '<br>JP Sales:', df$JP_Sales),
                  marker = list(color = ~Global_Sales, colorscale = c('#FFE1A1', '#683531'), showscale = TRUE)) %>% 
    add_markers() %>% 
    layout(scene = list(xaxis = list(title = 'North America Sales'),
                        yaxis = list(title = 'Europe Sales'),
                        zaxis = list(title = 'Japan Sales')),
           annotations = list(
             x = 1.13,
             y = 1.05,
             text = 'Global Sales',
             xref = 'paper',
             yref = 'paper',
             showarrow = FALSE
           ))
  return(plot)
}

# Filters the data from 10 to 70 global sales
filtered <- video_games_2016 %>% 
  filter(Global_Sales > 10) 

x3d_scatterplot <-make_3d_scatter(filtered)

x3d_scatterplot

## Pie Chart for most used consoles for certain games
game_sales <- read.csv("Video_Games_Sales_as_at_22_Dec_2016.csv", stringsAsFactors = FALSE)
console <- game_sales %>% 
  group_by(Name, Platform) %>% 
  summarize(sales = sum(NA_Sales,EU_Sales, JP_Sales, Other_Sales, Global_Sales)) %>% 
  filter(Name == "Grand Theft Auto IV") %>% 
  arrange(-sales)

pie <- function(name){
console <- game_sales %>% 
  group_by(Name, Platform) %>% 
  summarize(sales = sum(NA_Sales,EU_Sales, JP_Sales, Other_Sales, Global_Sales)) %>% 
  filter(Name == name) %>% 
  arrange(-sales)
y_name <- paste0("Game: ", name)
ggplot(console, aes(x = Name, y = sales, fill = Platform)) +
  geom_bar(stat = "identity", width = 1, color = "black") +
  coord_polar("y", start=0) + 
  theme(axis.title.y = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid  = element_blank()) +
  labs(title = "Game Sales by Console", y = y_name) +
  geom_text(aes(label = sales), position = position_stack(vjust = .5), color = "white", size = 3)
}
pie("Grand Theft Auto V")
