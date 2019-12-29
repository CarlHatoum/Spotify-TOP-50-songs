# Spotify Top 50 songs of 2019 data visualization 🎵

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

**Disclaimer** This Notebook is rather a exploratory approach rather than a explainatory one.
## Exploring the data 📊

Using R, let us start by loading the data :
```r
data <- read.csv("https://raw.githubusercontent.com/CarlHatoum/Spotify-TOP-50-songs/master/top50.csv")
```
Then, we select only the numerical variables (e.g, removing the track name, artist, and the genre).
```r
filtered_data = data[,c(5:14)]
```
### Numerical variables histograms
Let us display the distribution of each numerical variables with histogram :
```r
 filtered_data <- filtered_data %>%
+   gather(key="text", value="value") %>%
+   mutate(text = gsub("\\.", " ",text)) %>%
+   mutate(value = round(as.numeric(value),0))
```
Plotting :
```r
p <- filtered_data %>%
mutate(text = fct_reorder(text, value)) %>%
ggplot( aes(x=value, color=text, fill=text)) +
geom_histogram(alpha=0.6, binwidth = 5) +
scale_fill_viridis(discrete=TRUE) +
scale_color_viridis(discrete=TRUE) +
theme_ipsum() +
theme(legend.position="none", panel.spacing = unit(0.1, "lines"), strip.text.x = element_text(size = 8)) +
xlab("") +
ylab("") +
facet_wrap(~text)
```
### Finding potential correlation
We correlate each pair of the variables (default method is [Pearson's](https://en.wikipedia.org/wiki/Correlation_and_dependence#Pearson's_product-moment_coefficient) ), and plot the correlogram :
```r
mtCor <- cor(filtered_data)
corrplot(mtCor, method = "number", type = "upper")
```
We obtain the following result :
![correlogram](https://github.com/CarlHatoum/Spotify-TOP-50-songs/blob/master/images/correlo.png)

We can clearly see a relatively high correlation between Loudness and Energy (0.67), but also with Speechiness and Beats per Minute(0.56).

### Plotting the correlated variables
Since we see there is a correlation between some variables, let us plot them, and highlight the genre of each song :

```r
library(plotly)
plot_ly(data = data, x = ~Energy, y = ~Loudness..dB.., color= ~Genre, colors = "Set1" )
plot_ly(data = data, x = ~Beats.Per.Minute, y = ~Speechiness., color= ~Genre, colors = "Set1")
```
![energy_loudness](https://github.com/CarlHatoum/Spotify-TOP-50-songs/blob/master/images/energy_loudness.png)
![speechiness_bpm](https://github.com/CarlHatoum/Spotify-TOP-50-songs/blob/master/images/speechiness_bpm.png)
## Release History

* 0.0.1
    

## Meta
Author : [Carl Hatoum](https://https://github.com/CarlHatoum).

A very useful [website](https://www.data-to-viz.com/), when it comes to choose the most appropriate graph for your data.
## Contributing

1. Fork it (<https://github.com/yourname/yourproject/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

