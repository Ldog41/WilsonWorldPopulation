library(readxl)
library(tidyverse)
library(lubridate)

World_Population <- read_excel("data-raw/World_Population.xlsx",
                               sheet = "ESTIMATES", skip = 16)

colnames(World_Population)[3] <- "Area"

WorldPopulation <- World_Population %>%
  filter(Type == "Country/Area") %>%
  select(-`Parent code`,-Variant, -Notes, -`Country code`,-Index, -Type) %>%
  pivot_longer(cols = starts_with("19") | starts_with("20"), names_to = "Year",
  values_to = "Population") %>%
  mutate(Population = as.numeric(Population))%>%
  pivot_wider(names_from = Area, values_from = Population) %>%
  mutate(Year = as.Date(paste0(Year, "-01-01"), format = "%Y-%m-%d")) %>%
  mutate(Year = year(Year))

usethis::use_data(WorldPopulation, overwrite = TRUE)
