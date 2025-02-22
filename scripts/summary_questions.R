library(dplyr)
library(stringr)

steam <- read.csv("./data/steam.csv", stringsAsFactors = FALSE)
videogames <- read.csv("./data/video_games.csv", stringsAsFactors = FALSE)
videogames_2016 <- read.csv("./data/Video_Games_Sales_as_at_22_Dec_2016.csv",
                            stringsAsFactors = FALSE)
videogames_2016 <- videogames_2016[-1, ] # remove outlier wii sports

vector3_to_string <- function(vec) {
  res <- paste0(vec[1], ", ", vec[2], " and ", vec[3])
  return(res)
}

# Which publisher sold the most games in North America, Europe, Japan, and
# globally?
top3_publishers <- function(region_sales) {
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
  group_by(Genre) %>%
  summarise(top_genre = sum(!!as.name(region_sales))) %>%
  arrange(-top_genre) %>%
  slice(1:3) %>%
  pull(Genre)
}
na_genres <- top3_genres("NA_Sales")
jp_genres <- top3_genres("JP_Sales")
eu_genres <- top3_genres("EU_Sales")
global_genres <- top3_genres("Global_Sales")

#Do certain consoles get played more in certain regions?
top_consoles <- function(region) {
  videogames_2016 %>%
    group_by(Platform) %>%
    summarise(top_platform = length(nrow(!!as.name(region)))) %>%
    arrange(-top_platform) %>%
    slice(1:3) %>%
    pull(Platform)
}

na_platform <- top_consoles("NA_Sales")
jp_platform <- top_consoles("JP_Sales")
eu_platform <- top_consoles("EU_Sales")

# What age restriction gets the least and most playtime on Steam?
#Creates graph of each are restriction based on average playtime
average_playtimes <- steam %>%
  group_by(required_age) %>%
  summarise(playtime = sum(average_playtime))
colnames(average_playtimes) <- c("Required Age", "Playtime")

most_play_time <- steam %>%
  group_by(required_age) %>%
  summarise(playtime = sum(average_playtime)) %>%
  filter(playtime == max(playtime)) %>%
  pull(required_age)

least_play_time <- steam %>%
  group_by(required_age) %>%
  summarise(playtime = sum(average_playtime)) %>%
  filter(playtime == min(playtime)) %>%
  pull(required_age)

#Are there more occurences of people buying multiplayer or single player games?
steam_multiplayer_playtime <- steam %>%
  filter(median_playtime != 0 & average_playtime != 0) %>%
  mutate(multiplayer = str_detect(categories, "Multi") |
           str_detect(steamspy_tags, "Multiplayer"),
         not_multiplayer = !(str_detect(categories, "Multi") |
           str_detect(steamspy_tags, "Multiplayer")),
         multiplayer_playtime = multiplayer * average_playtime,
         non_multi_playtime = not_multiplayer * average_playtime) %>%
  summarise(num_games = n(),
            num_multi = sum(multiplayer),
            multiplayer_playtime = round(mean(multiplayer_playtime), 2),
            num_not_multi = sum(not_multiplayer),
            non_multi_playtime = round(mean(non_multi_playtime), 2))
