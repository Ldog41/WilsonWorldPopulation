library(tidyverse)
library(plotly)
library(rvest)
library(stringr)



url <- 'https://en.wikipedia.org/wiki/FIFA_World_Cup'
page_html <- read_html(url)

World_Cup <-  page_html %>%
  html_nodes("table,td,.headerSort") %>%
  .[[40]] %>%
  html_table(header=TRUE, fill=TRUE) %>%
  .[-1,]

colnames(World_Cup)[4] <- "Totalattendance"

World_Cup <- World_Cup %>%
  select(Year, Hosts, Matches, Totalattendance, Averageattendance ) %>%
  .[-c(23:26), ] %>%
  mutate(Totalattendance = str_replace_all(Totalattendance, pattern=',', replacement=''),
         Averageattendance = str_replace_all(Averageattendance, pattern=',', replacement='')) %>%
  mutate(Totalattendance = as.numeric(Totalattendance),
         Averageattendance = as.numeric(Averageattendance),
         Matches = as.numeric(Matches))

World_Cup <- World_Cup %>%
  mutate(WorldCup = str_c(Hosts, Year),
         WorldCup = str_replace_all(WorldCup, pattern=' ', replacement='') ) %>%
  select(-Hosts,-Year)%>%
  mutate(WorldCup = reorder(WorldCup, Averageattendance))


usethis::use_data(World_Cup, overwrite = TRUE)
