library(dplyr)
library(stringr)

steam <- read.csv("./data/steam.csv", stringsAsFactors = FALSE)
videogames <- read.csv("./data/video_games.csv", stringsAsFactors = FALSE)
videogames_2016 <- read.csv("./data/Video_Games_Sales_as_at_22_Dec_2016.csv", stringsAsFactors = FALSE)
videogames_2016 <- videogames_2016[-1, ] # remove outlier wii sports

#Which publisher sold the most games in North America, Europe, Japan, and globally?
# changed to publisher bc too many holes in dev column
top3_publishers <- function(region_sales){
  videogames_2016 %>%
  group_by(Publisher) %>%
  summarise(num_sales = sum(!!as.name(region_sales))) %>%
  arrange(-num_sales) %>%
  slice(1:3) %>%
  pull(Publisher)
}
na_publisher <- top3_publishers("NA_Sales")
jp_publisher <- top3_publishers("JP_Sales")
eu_publisher <- top3_publishers("EU_Sales")
global_publisher <- top3_publishers("Global_Sales")

# What are the top 3 game genres in a given region based on sales?
top3_genres <- function(region_sales) {
  videogames_2016 %>%
  group_by(Genre)%>% 
  summarise(NA_genre = sum(!!as.name(region_sales))) %>%
  arrange(-NA_genre) %>%
  slice(1:3) %>%
  pull(Genre)
}
na_genres <- top3_genres("NA_Sales")
jp_genres <- top3_genres("JP_Sales")
eu_genres <- top3_genres("EU_Sales")

#Do certain consoles get played more in certain regions?


#Do age restricted games get more play time on steam?


#Are there more occurences of people buying multiplayer or single player games?

