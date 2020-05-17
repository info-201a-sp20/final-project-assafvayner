library(dplyr)

video_games <- read.csv("./data/Video_Games_Sales_as_at_22_Dec_2016.csv")
video_games <- video_games[-1, ]
  
publisher_table <- video_games %>%
  filter(Platform %in% c("PS3", "PS4", "X360", "XOne", "Wii")) %>%
  group_by(Publisher) %>%
  summarise(NA_Sales = sum(NA_Sales),
            EU_Sales = sum(EU_Sales),
            JP_Sales = sum(JP_Sales),
            Other_Sales = sum(Other_Sales),
            Global_Sales = sum(Global_Sales)) %>%
  filter(Global_Sales > mean(Global_Sales) + sd(Global_Sales)) %>%
  arrange(-Global_Sales)
