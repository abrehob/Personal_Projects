install.packages("tidyverse")
install.packages("ggplot2")
install.packages("forcats")
library(tidyverse)
library(ggplot2)
library(forcats)




# Graph 1: What are the most and least popular characters?


# Filter the character frequency data to only contain the top 8 and bottom 4
# characters in terms of popularity, generate short names for each character,
# and prepare the graph for facet_grid separation
most_and_least_popular_chars <- filter(character_frequencies,
  FreqAsPercent > 2.65 | FreqAsPercent < 0.225)
most_and_least_popular_chars <- mutate(most_and_least_popular_chars,
  ShortCharacter = c("Ganon", "DK", "K. Rool", "Kirby", "Bowser", "Ness",
  "C. Falcon", "Hero", "Sora", "Duck Hunt", "Rosalina", "Olimar"),
  Facet = c(" Most Popular", " Most Popular", " Most Popular",
  " Most Popular", " Most Popular", " Most Popular", " Most Popular",
  " Most Popular", "Least Popular", "Least Popular", "Least Popular",
  "Least Popular"))

# Below describes my process for creating the graph;
# future graphs will follow a similar format

# Create a graph from the data, organize the values in descending order
# (they are naturally sorted alphabetically), and change the column width
ggplot(data = most_and_least_popular_chars, aes(x = fct_reorder(
  Character, -FreqAsPercent), y = FreqAsPercent, width = 0.7)) +
  
# Edit the fill, color, and transparency of each bar in the graph
  geom_col(mapping = aes(alpha = FreqAsPercent),
    fill = "#4285f4", color = "black") +
  
# Separate the most popular characters from the least popular characters
  facet_grid(~Facet, scales = "free", space = "free") +
  
# Adjust the vertical axis
  coord_cartesian(ylim = c(0, 6)) +
  
# Add a graph title and a y-axis title
  labs(title = "Most and Least Popular Characters", y = "% Occurrence") +
  
# Set the plot title format; remove the x-axis title,
# text, and ticks; and remove the graph legend
  theme(plot.title = element_text(face = "bold.italic"),
    axis.title.x = element_blank(), axis.text.x = element_blank(),
    axis.ticks.x = element_blank(), legend.position = "none") +
  
# Add character labels above each bar
  geom_text(aes(label = ShortCharacter), size = 2.5, vjust = -0.5)


# End of Graph 1




# Graph 2: What are the most popular character pairings?


# Filter the character pair frequency data to only contain the top 12
# character pairs in terms of popularity, and generate short names for
# each character in each pair
most_popular_char_pairs <- filter(paired_character_freqs,
  FreqAsPercent > 0.445)
most_popular_char_pairs <- mutate(most_popular_char_pairs,
  ShortCharacterPair1 = c("DK +", "Ganon +", "Lucas +", "Hero +", "DK +",
  "K. Rool +", "C. Falcon +", "Ganon +", "DK +", "Dedede +", "Kirby +",
  "C. Falcon +"),
  ShortCharacterPair2 = c("DK", "Ganon", "Ness", "Hero", "Ganon", "K. Rool", 
  "Ganon", "K. Rool", "K. Rool", "K. Rool", "Kirby", "C. Falcon"))

# Create a graph from the data, altering the dimensions,
# colors, titles, and labels as necessary
ggplot(data = most_popular_char_pairs, aes(x = fct_reorder(
  CharacterPair, -FreqAsPercent), y = FreqAsPercent, width = 0.7)) +
  geom_col(mapping = aes(alpha = FreqAsPercent),
    fill = "#38aa56", color = "black") +
  coord_cartesian(ylim = c(0, 1.05)) +
  labs(title = "Most Popular Character Pairs", y = "% Occurrence") +
  theme(plot.title = element_text(face = "bold.italic"),
    axis.title.x = element_blank(), axis.text.x = element_blank(),
    axis.ticks.x = element_blank(), legend.position = "none") +
  geom_text(aes(label = ShortCharacterPair1), size = 2.5, vjust = -1.8) +
  geom_text(aes(label = ShortCharacterPair2), size = 2.5, vjust = -0.5)


# End of Graph 2




# Graph 3: Which characters do we struggle against the most?
# Which do we have the easiest time defeating?


# Filter the character win-rate data to only contain the 8 toughest and
# 4 easiest characters to defeat, and generate short names for each character
best_and_worst_chars <- filter(win_frequency_by_opponent_char,
  WinPercent < 83.80 | WinPercent > 96.10)
best_and_worst_chars <- mutate(best_and_worst_chars,
  ShortCharacter = c("Wii Fit", "Mii Gunner", "Hero", "Jigglypuff", "Ridley",
  "Rosalina", "Wolf", "Mega Man", "Sheik", "Daisy", "Ryu", "Duck Hunt"),
  Facet = c(" Toughest", " Toughest", " Toughest", " Toughest", " Toughest",
  " Toughest", " Toughest", " Toughest", "Easiest", "Easiest", "Easiest",
  "Easiest"))

# Create a graph from the data, altering the dimensions,
# colors, titles, and labels as necessary
ggplot(data = best_and_worst_chars, aes(x = fct_reorder(
  Character, WinPercent), y = WinPercent, width = 0.7)) +
  geom_col(mapping = aes(fill = WinPercent), color = "black") +
  facet_grid(~Facet, scales = "free", space = "free") +
  scale_fill_gradient(low = "#cc0100", high = "#38aa56") +
  coord_cartesian(ylim = c(60, 103)) +
  labs(title = "Toughest and Easiest Characters to Defeat",
    y = "Win % Against") +
  theme(plot.title = element_text(face = "bold.italic"),
    axis.title.x = element_blank(), axis.text.x = element_blank(),
    axis.ticks.x = element_blank(), legend.position = "none") +
  geom_text(aes(label = ShortCharacter), size = 2.5, vjust = -0.5)


# End of Graph 3




# Graph 4: How has our win-rate changed over time?


# Create a graph from the data, altering the dimensions, colors
# titles, and labels as necessary; also add a line of best fit
ggplot(data = win_frequency_by_month, aes(
  x = YearMonthDouble, y = WinPercent)) +
  geom_smooth(method = "lm", formula = y~x, se = FALSE,
    size = 0.5, color = "gray") +
  geom_line(color = "#4285f4", size = 2) +
  coord_cartesian(ylim = c(60, 103)) +
  labs(title = "Win-Rate Over Time", x = "Year", y = "Win %") +
  theme(plot.title = element_text(face = "bold.italic"),
    legend.position = "none")


# End of Graph 4




# Graph 5: What are Justin's best characters?  What are his worst?


# Filter the RCS character win-rate data to only contain Justin's best 4 and
# worst 8 characters, and generate short names for each character
best_and_worst_chars_RCS <- filter(win_frequency_by_RCS_char,
  WinPercent > 96.00 | WinPercent < 81.80)
best_and_worst_chars_RCS <- mutate(best_and_worst_chars_RCS,
  ShortCharacter = c("Samus", "Lucina", "Sonic", "Wii Fit", "Little Mac",
  "Luigi", "Inkling", "Pichu", "Steve", "Sheik", "Chrom", "Terry"),
  Facet = c("Best", "Best", "Best", "Best", "Worst", "Worst", "Worst", "Worst",
  "Worst", "Worst", "Worst", "Worst"))


# Create a graph from the data, altering the dimensions,
# colors, titles, and labels as necessary
ggplot(data = best_and_worst_chars_RCS, aes(x = fct_reorder(
  RCSCharacter, -WinPercent), y = WinPercent, width = 0.7)) +
  geom_col(mapping = aes(fill = WinPercent), color = "black") +
  facet_grid(~Facet, scales = "free", space = "free") +
  scale_fill_gradient(low = "#cc0100", high = "#38aa56") +
  coord_cartesian(ylim = c(60, 103)) +
  labs(title = "Justin's Best and Worst Characters", y = "Win %") +
  theme(plot.title = element_text(face = "bold.italic"),
    axis.title.x = element_blank(), axis.text.x = element_blank(),
    axis.ticks.x = element_blank(), legend.position = "none") +
  geom_text(aes(label = ShortCharacter), size = 2.5, vjust = -0.5)


# End of Graph 5




# Graph 6(c): Which of the standard stage forms do we perform the best on?


# Create a graph from the data, altering the dimensions,
# colors, titles, and labels as necessary
ggplot(data = win_frequency_by_stage_form, aes(x = fct_reorder(
  StageForm, -WinPercent), y = WinPercent, width = 0.7)) +
  geom_col(mapping = aes(alpha = WinPercent),
    fill = "#38aa56", color = "black") +
  coord_cartesian(ylim = c(60, 103)) +
  labs(title = "Win-Rate on Standard Stage Forms", y = "Win %") +
  theme(plot.title = element_text(face = "bold.italic"),
    axis.title.x = element_blank(), axis.text.x = element_blank(),
    axis.ticks.x = element_blank(), legend.position = "none") +
  geom_text(aes(label = StageForm), size = 3.5, vjust = -0.5)


# End of Graph 6(c)




# Graph 7: On average, how popular is a DLC character during
# the first month of their release?  What about the first 3
# months?  How does this compare to their overall popularity?


# Organize the data to be properly facet-wrapped
time_frame_1 <- c("1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1")
graphable_dlc_percents_1 <- data.frame(dlc_percents_over_time$Character,
  dlc_percents_over_time$`Release Date`, time_frame_1,
  dlc_percents_over_time$`Percent Rep 1 Month`)
colnames(graphable_dlc_percents_1)[1] <- "Character"
colnames(graphable_dlc_percents_1)[2] <- "ReleaseDate"
colnames(graphable_dlc_percents_1)[3] <- "TimeFrame"
colnames(graphable_dlc_percents_1)[4] <- "PercentRep"
time_frame_2 <- c("3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3")
graphable_dlc_percents_2 <- data.frame(dlc_percents_over_time$Character,
  dlc_percents_over_time$`Release Date`, time_frame_2,
  dlc_percents_over_time$`Percent Rep 3 Months`)
colnames(graphable_dlc_percents_2)[1] <- "Character"
colnames(graphable_dlc_percents_2)[2] <- "ReleaseDate"
colnames(graphable_dlc_percents_2)[3] <- "TimeFrame"
colnames(graphable_dlc_percents_2)[4] <- "PercentRep"
time_frame_3 <- c("All", "All", "All", "All", "All",
  "All", "All", "All", "All", "All", "All", "All")
graphable_dlc_percents_3 <- data.frame(dlc_percents_over_time$Character,
  dlc_percents_over_time$`Release Date`, time_frame_3,
  dlc_percents_over_time$`Percent Rep to Date`)
colnames(graphable_dlc_percents_3)[1] <- "Character"
colnames(graphable_dlc_percents_3)[2] <- "ReleaseDate"
colnames(graphable_dlc_percents_3)[3] <- "TimeFrame"
colnames(graphable_dlc_percents_3)[4] <- "PercentRep"
graphable_dlc_percents <- rbind(graphable_dlc_percents_1,
  graphable_dlc_percents_2, graphable_dlc_percents_3)

# Create a labeller function to label each facet
# according to character instead of release date
dlc_release_date_map <- list("2019-01-29" = "Piranha Plant",
    "2019-04-17" = "Joker", "2019-07-30" = "Hero",
    "2019-09-04" = "Banjo & Kazooie", "2019-11-06" = "Terry",
    "2020-01-28" = "Byleth", "2020-06-29" = "Min Min",
    "2020-10-13" = "Steve", "2020-12-17" = "Sephiroth",
    "2021-03-04" = "Pyra/Mythra", "2021-06-29" = "Kazuya",
    "2021-10-18" = "Sora")
graph_labeller <- function(variable, value)
{
  return(dlc_release_date_map[value])
}

# Create graphs from the data, altering the dimensions,
# colors, titles, and labels as necessary
ggplot(data = graphable_dlc_percents, aes(x = TimeFrame,
  y = PercentRep, width = 0.7)) +
  geom_col(mapping = aes(fill = Character), color = "black") +
  facet_wrap(~ReleaseDate, labeller = labeller(ReleaseDate = graph_labeller)) +
  coord_cartesian(ylim = c(0, 30)) +
  labs(title = "DLC Representation", y = "% Occurrence",
    subtitle = "1 Month, 3 Months, and All Months After Release") +
  theme(plot.title = element_text(face = "bold.italic"),
    axis.title.x = element_blank(), axis.text.x = element_blank(),
    axis.ticks.x = element_blank(), legend.position = "none")


# End of Graph 7




# Graph 8: What are the most popular character-color combinations?


# Filter the character color frequency data to only contain the top 12
# character colors in terms of popularity, and generate short names for
# each character per character color
most_popular_char_colors <- filter(char_color_freq, FreqAsPercent > 0.715)
most_popular_char_colors <- mutate(most_popular_char_colors,
  ColorText = c("Gray", "Red (D)", "Green (D)", "Pink (D)", "Black",
  "White", "Gray", "Orange (D)", "White", "Brown (D)", "Black", "Gray"),
  CharText = c("Ganon", "Ganon", "K. Rool", "Kirby", "DK",
  "DK", "Bowser", "Bowser", "K. Rool", "DK", "Kirby", "K. Rool"))

# Create a graph from the data, altering the dimensions,
# colors, titles, and labels as necessary
ggplot(data = most_popular_char_colors, aes(x = fct_reorder(
  CharacterColor, -FreqAsPercent), y = FreqAsPercent, width = 0.7)) +
  geom_col(mapping = aes(fill = CharacterColor), color = "black") +
  coord_cartesian(ylim = c(0, 1.7)) +
  labs(title = "Most Popular Character Colors", y = "% Occurrence",
    subtitle = "(D) = Default Color") +
  theme(plot.title = element_text(face = "bold.italic"),
    axis.title.x = element_blank(), axis.text.x = element_blank(),
    axis.ticks.x = element_blank(), legend.position = "none") +
  geom_text(aes(label = ColorText), size = 2.5, vjust = -1.8) +
  geom_text(aes(label = CharText), size = 2.5, vjust = -0.5) +

# Fill each character's column with its corresponding color
# (in alphabetical character color order)
  scale_fill_manual(values = c("#2b2b2b", "#494769", "#df9f46",
    "#753f21", "#6a2828", "#5c7f51", "#fcc7de", "#5e6368",
    "#68686c", "#cccccc", "#757e83", "#d6cdce"))


# End of Graph 8

