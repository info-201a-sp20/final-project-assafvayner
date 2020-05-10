# Final Project

Authors: Tommy Lam, Eric Le, Maya Nair, Assaf Vayner

## Why we chose this domain:
Our group has a varying degree of interest in video games as well as use different consoles and platforms to game. Because of this, we are all interested in exploring the popularity of different video games and their genres in a given year depending on the sales and maker.

- Examples of other data driven projects related to this domain (**6 points**, 2 points each)?
    - Provides link to a data driven projects (**1 point**)
    - Briefly describes the project in 1 - 2 sentences (**1 points**)

## data-driven projects:
 [Data-Driven Games User Research](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/zimmermann-chigur-2012.pdf)
 This was a research devised and performed by microsoft based off of data from in-game states such as playtime and acheivements. They looked at things like player progression and types of playing modes (online or offline) to better the user experience. 
 [Player Dossiers: Analyzing Gameplay Data as a Reward](http://gamestudies.org/1101/articles/medler)
 This study was done on a player dossier, or "a data-driven reporting tool comprised of a player's gameplay data."
 The paper helps explain how a player dossier works and uses dossiers from existing games along with user experience
 to better understand how to improve dossiers and the overall experience of the game.
 [A conceptual model for video games and interactive media](https://asistdl.onlinelibrary.wiley.com/doi/abs/10.1002/asi.23409)
 This study created a conceptual model for videa games and interactive media. It took information from various sources regadring video games to better understand how different types of people understand video games, and their relationship to them.
 

- What data-driven questions do you hope to answer about this domain (**6 points**, 2 points each)
    - Question is related to the field (**1 point**)
    - Describes how the question can be answered using data (e.g., a specific comparison within or analysis of the data that answers the question) (**1 point**)

Which developer had the most global sales overall? 
Which developers sell more games in each region, or per each console?
Which developer made the best game for each genre?
Has each game in a game series made more than its previous versions?
Do games in certain genres do better in certain regions or on certain consoles?
Comparing sales across PC, PS4, and Xbox by either/both global sales and regional sales.

Each and all of these questions can be answered with visualizations we can create using R. 
We could make graphs or line charts showing trends between these questions by subsetting them in the datasets.

## Finding Data (**15 points**, 5 points each)
For each identified data source, 
- Link to URL where data is from, and download the data into the project repo in a `data/` folder (**1 point**)?
- Description of how was the data collected or generated (**1 point**)?
- How many observations (rows) and features (columns) are in your data(**1 point**)?
- What questions (from above) can be answered using the data in this dataset(**1 point**)?

## Finding Data:

### Steam Data:
This data contains information about price, play time and ratings for most games on Steam.
- [link to data set on kaggle](https://www.kaggle.com/nikdavis/steam-store-games#steam.csv)
- This data was gathered from the Steam Store and using SteamSpy APIs
- 18 columns and 27075 rows
- This data will help us answer in details the questions on the popularity of games across genres and makers that are played on computers and across operating systems