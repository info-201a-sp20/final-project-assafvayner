# assigned to Tommy and Eric
data <- read.csv("./data/video_games.csv", stringsAsFactors = FALSE)
library(ggplot2)
library(dplyr)
library(plotly)
library(plotly.express)
install.packages("plotly") 
## Barchart of games and prices
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


plot

fig <- plot_ly(data = game_name, x = ~game, y = ~price)
fig


fig <- plot_ly(game, x = ~game, y = ~price, z = ~average_playtime, colors = c('#BF382A', '#0C4B8E'))
fig <- fig %>% add_markers()
fig <- fig %>% layout(scene = list(xaxis = list(title = 'Weight'),
                                   yaxis = list(title = 'Gross horsepower'),
                                   zaxis = list(title = '1/4 mile time')))

fig
