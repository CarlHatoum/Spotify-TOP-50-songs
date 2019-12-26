# Spotify Top 50 songs of 2019 data visualization

## Introduction
"Top 50 Spotify Songs - 2019" is a CSV database from [Kaggle](https://www.kaggle.com/leonardopena/top50spotify2019). It contains several variables :
- Track.Name : Name of the Track
- Artist.Name : Name of the Artist
- Genre : the genre of the track
- Beats.Per.Minute : The tempo of the song.
- Energy : The energy of a song - the higher the value, the more energtic. song
- Danceability : The higher the value, the easier it is to dance to this song.
- Loudness..dB.. : The higher the value, the louder the song.
- Liveness : The higher the value, the more likely the song is a live recording.
- Valence. : The higher the value, the more positive mood for the song.
- Length. : The duration of the song.
- Acousticness.. : The higher the value the more acoustic the song is.
- Speechiness. : The higher the value the more spoken word the song contains.
- Popularity : The higher the value the more popular the song is.

## Exploring the data
Using R, let us start by plotting the correlogram of the different variables :

Loading the data :
```r
data <- read.csv("https://raw.githubusercontent.com/CarlHatoum/Spotify-TOP-50-songs/master/top50.csv")
```
Then, selecting only the numerical variables (e.g removing the track name, artist, and the genre)
```r
filtered_data = data[,c(5:14)]
```
Finally, we correlate the variables (default method is [Pearson's](https://en.wikipedia.org/wiki/Correlation_and_dependence#Pearson's_product-moment_coefficient) ), and plotting the correlogram :
```r
mtCor <- cor(filtered_data)
corrplot(mtCor, method = "ellipse", type = "upper", tl.srt = 45)
```
We obtain the following result :
![correlogram](https://github.com/CarlHatoum/Spotify-TOP-50-songs/blob/master/images/top50_correlogram.png)

We can clearly see a high correlation between Loudness and Energy, but also with Speechiness and Beats per Minute.

### Plotting the correlated variables
Since we see where there is a correlation between some variables, let us plot them, to see if there is a pattern :
```r
library(plotly)
plot_ly(data = data, x = ~Loudness..dB.., y = ~Energy)
plot_ly(data = data, x = ~Speechiness., y = ~Beats.Per.Minute)
```
![energy_loudness](https://github.com/CarlHatoum/Spotify-TOP-50-songs/blob/master/images/energy_loudness.png)
![speechiness_bpm](https://github.com/CarlHatoum/Spotify-TOP-50-songs/blob/master/images/speechiness_bpm.png)
## Release History

* 0.0.1
    

## Meta
Author : [Carl Hatoum](https://https://github.com/CarlHatoum)

## Contributing

1. Fork it (<https://github.com/yourname/yourproject/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

