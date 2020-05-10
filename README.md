# INFO 201 Spring 2020 Final Project

Authors: Tommy Lam, Eric Le, Maya Nair, Assaf Vayner

## Why we chose this domain:
Our group has a varying degree of interest in video games as well as use different consoles and platforms to game. Because of this, we are all interested in exploring the popularity of different video games and their genres in a given year depending on the sales and maker.

## Data-driven Projects:
- [Data-Driven Games User Research](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/zimmermann-chigur-2012.pdf). This was a research devised and performed by microsoft based off of data from in-game states such as playtime and acheivements. They looked at things like player progression and types of playing modes (online or offline) to better the user experience. 
  
- [Player Dossiers: Analyzing Gameplay Data as a Reward](http://gamestudies.org/1101/articles/medler)
This study was done on a player dossier, or "a data-driven reporting tool comprised of a player's gameplay data." The paper helps explain how a player dossier works and uses dossiers from existing games along with user experience to better understand how to improve dossiers and the overall experience of the game.
 
- [A conceptual model for video games and interactive media](https://asistdl.onlinelibrary.wiley.com/doi/abs/10.1002/asi.23409). This study created a conceptual model for videa games and interactive media. It took information from various sources regadring video games to better understand how different types of people understand video games, and their relationship to them.
 
 - [4 gaming trends to get excited about in 2020](https://blog.globalwebindex.com/chart-of-the-week/gaming-trends-2020/). This study centered around the gaming industry and the great numbers it is doing in 2020. From consoles, to cloud gaming, lots of important statistics are brought forth in this article and we could see some general trends and analyses about its significance in the present day.

## Data-driven Questions:

1. The following quetsions can be answered through the use of comparing devlopers and their games to specific
columns that relate to the quetsion like global sales, specific region sales, or best game.
- Which developer had the most global sales overall?
- Which developers sell more games in each region, or per each console?
- Which developer made the best game for each genre?

2. A specific comparision would have to be made and split down into regions and global to see the
differences of different games in a  series for the following quetsion.
- Has each game in a game series made more than its previous versions?
    
3. Both of these quetsions can be done through comparssion between consels and region.
- Do games in certain genres do better in certain regions or on certain consoles?
- Comparing sales across PC, PS4, and Xbox by either/both global sales and regional sales.

4. This question would have to be answered through analysis by looking at previous games and the details to see when and where the next game was released.
- What factors do previous game launches affect future launches?   
    

Each and all of these questions can be answered with visualizations we can create using R.
We could make graphs or line charts showing trends between these questions by subsetting them in the datasets.

## Finding Data:

### Steam Dataset:
This data contains information about price, play time and ratings for most games on Steam.
- [link to data set on kaggle](https://www.kaggle.com/nikdavis/steam-store-games#steam.csv)
- This data was gathered from the Steam Store and using SteamSpy APIs
- 27075 rows and 18 columns
- This data will help us answer in details the questions on the popularity of games across genres and makers that are played on computers and across operating systems

### Video Game Sales in 2016:
- [link to data set on kaggle](https://www.kaggle.com/sidtwr/videogames-sales-dataset?select=Video_Games_Sales_as_at_22_Dec_2016.csv)
- this data was gathered from web scrapes from VGChartz as well as Metacritic.
- 16719 rows and 16 columns.
- This data will help us see trends of sales of games from different regions like the US, Europe and Japan as well as overall global sales. We could also see the genres of the games as well as their producer and which console they are primarily sold on.


### Video Games and Playtime:
- [link to raw data](https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-07-30/video_games.csv)
- [link to thorough description of the data](https://towardsdatascience.com/analyzing-video-games-data-in-r-1afad7122aab)
- this dataset is from towardsdatascience by Hamza Rafiq. It was made by merging two datasets together, one from tidytuesday and one from kaggle.
- 26689 rows and 10 columns
- this data will help us look further into more games from a broader range of publishers and developers as well as help us compare the playtime of popular games based on their release. Overall, this dataset is useful in expanding the types of questions we could ask around popular game releases such as average price, playtime, and release. 
