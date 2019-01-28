library(magrittr)
library(rvest)
library(readxl)
library(dplyr)
movie.url <- "https://www.imdb.com/chart/top?ref_=nv_mv_250"
movie_names_dates_rank_css <- "#main strong , .secondaryInfo , .titleColumn a"
release_time_css <- ".secondaryInfo"
movie_names_css <- ".titleColumn a"
star_css <- "#main strong"

html<- read_html(movie.url)   
release_time<- html_nodes(html,css = release_time_css )                          
release_time <- html_text(release_time)
release_time <- substr(release_time,start=2,stop = 5)
release_time

html<- read_html(movie.url)     
movie_names<- html_nodes(html,css = movie_names_css)
movie_names<- html_text(movie_names)
movie_names

html<- read_html(movie.url)     
star<- html_nodes(html,css = star_css )                       
star <- html_text(star)
star


total <- data.frame(
  MovieNames=movie_names,
  MovieReleaseTime=release_time,
  MovieRanking=star,
  stringsAsFactors = FALSE
)
total$MovieRanking <- as.numeric(total$MovieRanking)
total$MovieReleaseTime <- as.numeric(total$MovieReleaseTime)
str(total)

newest <- total$MovieReleaseTime > 1999
newer_good_movie <- total[newest,]
View(newer_good_movie)
