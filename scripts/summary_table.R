library(dplyr)

video_games <- read.csv("./data/Video_Games_Sales_as_at_22_Dec_2016.csv",
                        stringsAsFactors = FALSE)
video_games <- video_games[-1, ]

# calculates global popularity score from given columns
get_global_popularity <- function(na, eu, jp, other, gb) {
  na <- na / gb
  eu <- eu / gb
  jp <- jp / gb
  ot <- other / gb
  vol <- (na - eu) * (na - jp) * (na - ot) * (eu - jp) * (eu - ot) * (jp - ot)
  return(1 / abs(vol))
}

# table of aggregated data to be knit in index.Rmd
publisher_table <- video_games %>%
  group_by(Publisher) %>%
  summarise(NA_Sales = sum(NA_Sales),
            EU_Sales = sum(EU_Sales),
            JP_Sales = sum(JP_Sales),
            Other_Sales = sum(Other_Sales),
            Global_Sales = sum(Global_Sales)) %>%
  filter(Global_Sales > mean(Global_Sales) + 2 * sd(Global_Sales)) %>%
  mutate(Global_Popularity = get_global_popularity(NA_Sales, EU_Sales, JP_Sales,
                                                   Other_Sales, Global_Sales),
         Popularity_rank = dense_rank(desc(Global_Popularity))) %>%
  arrange(-Global_Sales)

# Publisher with the highest popularity score
highest_popularity_publisher <- publisher_table %>%
  filter(Global_Popularity == max(Global_Popularity)) %>%
  pull(Publisher)
