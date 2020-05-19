# Assigned to Maya
library("dplyr")

steam <- read.csv("./data/steam.csv", stringsAsFactors = FALSE)
videogames <- read.csv("./data/video_games.csv", stringsAsFactors = FALSE)
videogames_2016 <- read.csv("./data/Video_Games_Sales_as_at_22_Dec_2016.csv", stringsAsFactors = FALSE)

#Which publisher sold the most games in North America, Europe, Japan, and globally?
# changed to publisher bc too many holes in dev column
top_publisher <- function(region_sales){
  videogames_2016 %>%
  group_by(Publisher) %>%
  summarise(num_sales = sum(!!as.name(region_sales))) %>%
  filter(num_sales == max(num_sales)) %>%
  pull(Publisher)
}
na_publisher <- top_publisher("NA_Sales")
jp_publisher <- top_publisher("JP_Sales")
eu_publisher <- top_publisher("EU_Sales")
global_publisher <- top_publisher("Global_Sales")

# What are the top 3 game genres in a given region based on sales?
top3_genres <- function(region_sales) {
  videogames_2016 %>%
  group_by(Genre)%>% 
  summarise(NA_genre = sum(!!as.name(region_sales))) %>%
  arrange(-NA_genre) %>%
  top_n(3)
}  
na_genres <- top3_genres("NA_Sales")
jp_genres <- top3_genres("JP_Sales")
eu_genres <- top3_genres("EU_Sales")

#Do certain consoles get played more in certain regions?


#Do age restricted games get more play time on steam?


#Are there more occurences of people buying multiplayer or single player games?


