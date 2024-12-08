#' function that will output the population over time of a country inside the United Nation from 1950-2020
#'
#'
#' @param Name The name of the county with inside "" with spaces if needed
#' @return Graph showing the population of that country over time
#' @examples
#' CountryPopulation("United States of America")
#' @export
CountryPopulation <- function(Name){
  if (!Name %in% colnames(WorldPopulation)) {
    stop("The specified country does not exist in the WorldPopulation dataset.")
  }

c_data <- WorldPopulation %>%
  select(Year, all_of(Name))

colnames(c_data)[2] <- "Pop"

output <- ggplot(c_data, aes(x = Year, y = Pop )) +
  geom_line() +
  scale_y_continuous(labels = scales::comma) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, size = 16),
        axis.title = element_text(size = 14),
        legend.title = element_text(size = 12),
        legend.text = element_text(size = 10))+
  labs(title = paste("Population of", Name, "Over Time"),
       x = "Year",
       y = "Population (Thousands)")

return(output)
}
