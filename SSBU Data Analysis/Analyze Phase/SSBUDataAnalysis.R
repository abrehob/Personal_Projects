install.packages("tidyverse")
install.packages("stringr")
install.packages("zoo")
install.packages("lubridate")
library(tidyverse)
library(stringr)
library(zoo)
library(lubridate)




# Question 1: What are the most and least popular characters?


# Get a list of P3 and P4 characters where there's only one character per team
P3_characters_one_per_team <- data_without_errors$`P3 Character`[
  which(!duplicated(data_without_errors$`Team #`))]
P4_characters_one_per_team <- data_without_errors$`P4 Character`[
  which(!duplicated(data_without_errors$`Team #`))]

# Create a dataframe that holds the frequencies of each character
P3_characters_df <- as.data.frame(table(P3_characters_one_per_team))
P4_characters_df <- as.data.frame(table(P4_characters_one_per_team))

# Add the frequencies of matching P3 and P4 characters
character_frequencies <- P3_characters_df
colnames(character_frequencies)[1] <- "Character"
character_frequencies$Freq <- character_frequencies$Freq + P4_characters_df$Freq

# Sort the dataframe and add a "frequency-as-percent" column
character_frequencies <- character_frequencies[
  order(-character_frequencies$Freq),]
total_characters <- sum(character_frequencies$Freq)
character_frequencies <- mutate(character_frequencies,
  FreqAsPercent = round(Freq / total_characters * 100, digits = 2))

# ***** ANSWER *****
print(character_frequencies)

# Validate a sample of the results
data_one_match_per_team <- filter(data_without_errors,
  `Match #` %in% which(!duplicated(data_without_errors$`Team #`)))
(table(data_one_match_per_team$`P3 Character`)["Ganondorf"] +
  table(data_one_match_per_team$`P4 Character`)["Ganondorf"]) /
  (length(data_one_match_per_team$`P3 Character`) +
  length(data_one_match_per_team$`P4 Character`))
(table(data_one_match_per_team$`P3 Character`)["Donkey Kong"] +
  table(data_one_match_per_team$`P4 Character`)["Donkey Kong"]) /
  (length(data_one_match_per_team$`P3 Character`) +
  length(data_one_match_per_team$`P4 Character`))
(table(data_one_match_per_team$`P3 Character`)["Olimar"] +
  table(data_one_match_per_team$`P4 Character`)["Olimar"]) /
  (length(data_one_match_per_team$`P3 Character`) +
  length(data_one_match_per_team$`P4 Character`))
(table(data_one_match_per_team$`P3 Character`)["Rosalina & Luma"] +
  table(data_one_match_per_team$`P4 Character`)["Rosalina & Luma"]) /
  (length(data_one_match_per_team$`P3 Character`) +
  length(data_one_match_per_team$`P4 Character`))


# End of Question 1




# Question 2: What are the most popular character pairings?


# Create a dataframe from the P3 and P4 characters, one per team
character_pairs <- data.frame(P3_characters_one_per_team,
  P4_characters_one_per_team)
colnames(character_pairs)[1] <- "P3Character"
colnames(character_pairs)[2] <- "P4Character"

# Add a new column to the dataframe which contains a string
# of the combined characters, sorted alphabetically
character_pairs <- mutate(character_pairs, PairedCharacters = case_when(
  P3Character < P4Character ~ paste(P3Character, P4Character, sep=", "),
  TRUE ~ paste(P4Character, P3Character, sep=", ")))

# Create a dataframe that holds the frequencies of each character pair
paired_character_freqs <- as.data.frame(table(character_pairs$PairedCharacters))
colnames(paired_character_freqs)[1] <- "CharacterPair"

# Sort the dataframe and add a "frequency-as-percent" column
paired_character_freqs <- paired_character_freqs[
  order(-paired_character_freqs$Freq),]
total_character_pairs <- sum(paired_character_freqs$Freq)
paired_character_freqs <- mutate(paired_character_freqs,
  FreqAsPercent = round(Freq / total_character_pairs * 100, digits = 2))

# ***** ANSWER *****
print(paired_character_freqs)

# Validate a sample of the results
(table(data_one_match_per_team$`P3 Character`,
  data_one_match_per_team$`P4 Character`)["Donkey Kong", "Donkey Kong"]) /
  (length(data_one_match_per_team$`Match #`))
(table(data_one_match_per_team$`P3 Character`,
  data_one_match_per_team$`P4 Character`)["Ganondorf", "Ganondorf"]) /
  (length(data_one_match_per_team$`Match #`))
(table(data_one_match_per_team$`P3 Character`,
  data_one_match_per_team$`P4 Character`)["Lucas", "Ness"] +
  table(data_one_match_per_team$`P3 Character`,
  data_one_match_per_team$`P4 Character`)["Ness", "Lucas"]) /
  (length(data_one_match_per_team$`Match #`))
(table(data_one_match_per_team$`P3 Character`,
  data_one_match_per_team$`P4 Character`)["Hero", "Hero"]) /
  (length(data_one_match_per_team$`Match #`))


# End of Question 2




# Start of preparation for win-rate questions


valid_data <- data_without_errors

# Filter the dataframe to only include matches where P1 and P2 are OT and RCS
valid_data <- mutate(valid_data, P1AndP2 = case_when(
  P1 < P2 ~ paste(P1, P2, sep=", "), TRUE ~ paste(P2, P1, sep=", ")))
valid_data <- filter(valid_data, P1AndP2 == "OT, RCS")

# Remove matches with invalid results
print(unique(valid_data$Result))
valid_data <- filter(valid_data, Result != "RCS 1" &
  Result != "Connection Error")

# Convert match results to booleans
valid_data <- mutate(valid_data, Win = case_when(Result == "-1" |
  Result == "-1 out of 2" | Result == "-1 out of 4" | Result == "-1 to +1" |
  Result == "-2" | Result == "-2 out of 2" | Result == "-2 out of 4" |
  Result == "-2 to 0" | Result == "-3" | Result == "-3 out of 4" |
  Result == "-3 to +3" | Result == "-3 to 0" | Result == "-4" |
  Result == "-4 to +5" | Result == "-5" | Result == "-6" |
  Result == "0 to 0 at time, SD Lose" | Result == "1 to 1 at time, SD Lose" |
  Result == "1 to 1 out of 4 at time, SD Lose" | Result == "1 to 2 at time" |
  Result == "1 to 2 out of 4 at time" ~ FALSE, TRUE ~ TRUE))

# Remove matches where one team wasn't trying to win
valid_data <- filter(valid_data, !CPU)
print(unique(valid_data$`Other Notes`))
valid_data <- filter(valid_data, `Other Notes` != "Opponents only teabagged" &
  `Other Notes` != "P4 didn't move for 29 seconds??" &
  `Other Notes` != "After 30 seconds, opponents did nothing" &
  `Other Notes` != "Opponents sometimes didn't input anything" &
  `Other Notes` != "Unplayable lag, we SDd" &
  `Other Notes` != "P4 didn't move for 25 seconds" &
  `Other Notes` != "Unplayable lag, opponents SDd" &
  `Other Notes` != "Opponents self-destructed" &
  `Other Notes` != "Opponents self-destructed immediately" &
  `Other Notes` != "Oppponents self-destructed immediately" &
  `Other Notes` != "Opponents immediately self-destructed")

# Verify changes
print(table(valid_data$P1, valid_data$P2))
print("Connection Error" %in% as.data.frame(table(valid_data$Result))$Var1)
print("RCS 1" %in% as.data.frame(table(valid_data$Result))$Var1)
print(unique(valid_data$CPU))


# End of preparation for win-rate questions




# Question 3: Which characters do we struggle against the most?
# Which do we have the easiest time defeating?


# Create a dataframe which pairs each opponent character with its match result
wins_against_P3 <- data.frame(valid_data$`P3 Character`, valid_data$Win)
colnames(wins_against_P3)[1] <- "Character"
colnames(wins_against_P3)[2] <- "Win"
wins_against_P4 <- data.frame(valid_data$`P4 Character`, valid_data$Win)
colnames(wins_against_P4)[1] <- "Character"
colnames(wins_against_P4)[2] <- "Win"
all_results_per_opponent_char <- rbind(wins_against_P3, wins_against_P4)

# Create dataframes which hold the number of opponent characters seen
# and the number of wins we have against those characters
opponent_char_freqs <- as.data.frame(table(
  all_results_per_opponent_char$Character))
all_wins_per_opponent_char <- filter(all_results_per_opponent_char, Win)
win_frequency_by_opponent_char <- as.data.frame(table(
  all_wins_per_opponent_char$Character))
colnames(opponent_char_freqs)[1] <- "Character"
colnames(opponent_char_freqs)[2] <- "MatchCount"
colnames(win_frequency_by_opponent_char)[1] <- "Character"
colnames(win_frequency_by_opponent_char)[2] <- "WinCount"

# Add MatchCount and WinPercent columns to win frequency dataframe and sort it
win_frequency_by_opponent_char["MatchCount"] <- opponent_char_freqs$MatchCount
win_frequency_by_opponent_char <- mutate(win_frequency_by_opponent_char,
  WinPercent = round(WinCount / MatchCount * 100, digits = 2))
win_frequency_by_opponent_char <- win_frequency_by_opponent_char[
  order(win_frequency_by_opponent_char$WinPercent),]

# ***** ANSWER *****
print(win_frequency_by_opponent_char)

# Validate a sample of the results
won_matches <- filter(valid_data, Win)
(table(won_matches$`P3 Character`)["Wii Fit Trainer"] +
  table(won_matches$`P4 Character`)["Wii Fit Trainer"]) /
  (table(valid_data$`P3 Character`)["Wii Fit Trainer"] +
  table(valid_data$`P4 Character`)["Wii Fit Trainer"])
(table(won_matches$`P3 Character`)["Mii Gunner"] +
  table(won_matches$`P4 Character`)["Mii Gunner"]) /
  (table(valid_data$`P3 Character`)["Mii Gunner"] +
  table(valid_data$`P4 Character`)["Mii Gunner"])
(table(won_matches$`P3 Character`)["Duck Hunt"] +
  table(won_matches$`P4 Character`)["Duck Hunt"]) /
  (table(valid_data$`P3 Character`)["Duck Hunt"] +
  table(valid_data$`P4 Character`)["Duck Hunt"])
(table(won_matches$`P3 Character`)["Ryu"] +
  table(won_matches$`P4 Character`)["Ryu"]) /
  (table(valid_data$`P3 Character`)["Ryu"] +
  table(valid_data$`P4 Character`)["Ryu"])


# End of Question 3




# Question 4: How has our win-rate changed over time?


# Create a dataframe which pairs each date with its match result
dates_and_match_results <- data.frame(valid_data$Date, year(valid_data$Date),
  month(valid_data$Date), valid_data$Win)
colnames(dates_and_match_results)[1] <- "Date"
colnames(dates_and_match_results)[2] <- "Year"
colnames(dates_and_match_results)[3] <- "Month"
colnames(dates_and_match_results)[4] <- "Win"
dates_and_match_results <- mutate(dates_and_match_results, YearAndMonth =
  paste(Year, Month, sep=", "))

# Create dataframes which hold the number of matches
# per month and the number of wins per month
matches_by_month <- as.data.frame(table(dates_and_match_results$YearAndMonth))
all_wins_per_month <- filter(dates_and_match_results, Win)
win_frequency_by_month <- as.data.frame(table(
  all_wins_per_month$YearAndMonth))
colnames(matches_by_month)[1] <- "YearAndMonth"
colnames(matches_by_month)[2] <- "MatchCount"
colnames(win_frequency_by_month)[1] <- "YearAndMonth"
colnames(win_frequency_by_month)[2] <- "WinCount"

# Split the year and month back up and re-order the columns
win_frequency_by_month <- mutate(win_frequency_by_month,
  Year = str_split(YearAndMonth, ", ", simplify=TRUE)[,1])
win_frequency_by_month <- mutate(win_frequency_by_month,
  Month = str_split(YearAndMonth, ", ", simplify=TRUE)[,2])
win_frequency_by_month <- mutate(win_frequency_by_month,
  YearMonthDouble = as.double(Year) + (as.double(Month) - 1) / 12)
win_frequency_by_month <- win_frequency_by_month[, c(3, 4, 5, 2)]

# Add MatchCount and WinPercent columns to win frequency dataframe and sort it
win_frequency_by_month["MatchCount"] <- matches_by_month$MatchCount
win_frequency_by_month <- mutate(win_frequency_by_month,
  WinPercent = round(WinCount / MatchCount * 100, digits = 2))
win_frequency_by_month <- win_frequency_by_month[
  order(win_frequency_by_month$YearMonthDouble),]

# ***** ANSWER *****
print(win_frequency_by_month)

# Validate a sample of the results
table(year(won_matches$Date), month(won_matches$Date))["2018", "12"] /
  table(year(valid_data$Date), month(valid_data$Date))["2018", "12"]
table(year(won_matches$Date), month(won_matches$Date))["2019", "1"] /
  table(year(valid_data$Date), month(valid_data$Date))["2019", "1"]
table(year(won_matches$Date), month(won_matches$Date))["2022", "3"] /
  table(year(valid_data$Date), month(valid_data$Date))["2022", "3"]
table(year(won_matches$Date), month(won_matches$Date))["2022", "4"] /
  table(year(valid_data$Date), month(valid_data$Date))["2022", "4"]


# End of Question 4




# Question 5: What are Justin's best characters?  What are his worst?


# Create a dataframe which pairs each of Justin's characters with match result
RCS_char_and_match_results <- data.frame(
  valid_data$`RCS Character`, valid_data$Win)
colnames(RCS_char_and_match_results)[1] <- "RCSCharacter"
colnames(RCS_char_and_match_results)[2] <- "Win"

# Create dataframes which hold the number of matches per
# RCS Character and the number of wins per RCS Character
matches_by_RCS_char <- as.data.frame(table(
  RCS_char_and_match_results$RCSCharacter))
all_wins_per_RCS_char <- filter(RCS_char_and_match_results, Win)
win_frequency_by_RCS_char <- as.data.frame(table(
  all_wins_per_RCS_char$RCSCharacter))
colnames(matches_by_RCS_char)[1] <- "RCSCharacter"
colnames(matches_by_RCS_char)[2] <- "MatchCount"
colnames(win_frequency_by_RCS_char)[1] <- "RCSCharacter"
colnames(win_frequency_by_RCS_char)[2] <- "WinCount"

# Add MatchCount and WinPercent columns to win frequency dataframe and sort it
win_frequency_by_RCS_char["MatchCount"] <- matches_by_RCS_char$MatchCount
win_frequency_by_RCS_char <- mutate(win_frequency_by_RCS_char,
  WinPercent = round(WinCount / MatchCount * 100, digits = 2))
win_frequency_by_RCS_char <- win_frequency_by_RCS_char[
  order(-win_frequency_by_RCS_char$WinPercent),]

# ***** ANSWER *****
print(win_frequency_by_RCS_char)

# Validate a sample of the results
table(won_matches$`RCS Character`)["Samus"] /
  table(valid_data$`RCS Character`)["Samus"]
table(won_matches$`RCS Character`)["Lucina"] /
  table(valid_data$`RCS Character`)["Lucina"]
table(won_matches$`RCS Character`)["Terry"] /
  table(valid_data$`RCS Character`)["Terry"]
table(won_matches$`RCS Character`)["Chrom"] /
  table(valid_data$`RCS Character`)["Chrom"]


# End of Question 5




# Question 6a: What is our win-rate when Smash Meter, Smash
# Balls, or Items are present in a match?  How does that
# compare with our win-rate when they aren't present?


# Create a dataframe which pairs the presence of Smash Meter,
# Smash Balls, or Items with the match result
items_and_match_results <- data.frame(valid_data$`Smash Meter`,
  valid_data$`Smash Balls`, valid_data$Items, valid_data$Win)
colnames(items_and_match_results)[1] <- "SmashMeter"
colnames(items_and_match_results)[2] <- "SmashBalls"
colnames(items_and_match_results)[3] <- "Items"
colnames(items_and_match_results)[4] <- "Win"
items_and_match_results <- mutate(items_and_match_results,
  SMorSBorI = SmashMeter | SmashBalls | Items)
items_and_match_results <- items_and_match_results[, c(1, 2, 3, 5, 4)]

# Create dataframes which hold the number of wins and matches
# overall and with Smash Meter, Smash Balls, or Items
matches_by_item_presence <- as.data.frame(table(
  items_and_match_results$SMorSBorI))
all_wins_per_item_presence <- filter(items_and_match_results, Win)
win_frequency_by_item_presence <- as.data.frame(table(
  all_wins_per_item_presence$SMorSBorI))
colnames(matches_by_item_presence)[1] <- "SM or SB or I"
colnames(matches_by_item_presence)[2] <- "MatchCount"
colnames(win_frequency_by_item_presence)[1] <- "SM or SB or I"
colnames(win_frequency_by_item_presence)[2] <- "WinCount"

# Add MatchCount and WinPercent columns to win frequency dataframe and sort it
win_frequency_by_item_presence["MatchCount"] <-
  matches_by_item_presence$MatchCount
win_frequency_by_item_presence <- mutate(win_frequency_by_item_presence,
  WinPercent = round(WinCount / MatchCount * 100, digits = 2))
win_frequency_by_item_presence <- win_frequency_by_item_presence[
  order(-win_frequency_by_item_presence$WinPercent),]

# ***** ANSWER *****
print(win_frequency_by_item_presence)


# End of Question 6a




# Question 6b: What is our win-rate on a non-standard stage form?
# How does that compare with our win-rate on a standard stage form?


# Create a dataframe which pairs the stage form with the match result
stage_form_and_match_results <- data.frame(
  valid_data$`Stage Form`, valid_data$Win)
colnames(stage_form_and_match_results)[1] <- "StageForm"
colnames(stage_form_and_match_results)[2] <- "Win"
stage_form_and_match_results <- mutate(stage_form_and_match_results,
  StandardStage = StageForm == "Battlefield" |
  StageForm == "Small Battlefield" | StageForm == "Omega")
stage_form_and_match_results <- stage_form_and_match_results[, c(1, 3, 2)]

# Create dataframes which hold the number of wins and
# matches overall and with a standard stage form
matches_by_stage_standardness <- as.data.frame(table(
  stage_form_and_match_results$StandardStage))
all_wins_per_stage_standardness <- filter(stage_form_and_match_results, Win)
win_frequency_by_stage_standardness <- as.data.frame(table(
  all_wins_per_stage_standardness$StandardStage))
colnames(matches_by_stage_standardness)[1] <- "StandardStage"
colnames(matches_by_stage_standardness)[2] <- "MatchCount"
colnames(win_frequency_by_stage_standardness)[1] <- "StandardStage"
colnames(win_frequency_by_stage_standardness)[2] <- "WinCount"

# Add MatchCount and WinPercent columns to win frequency dataframe and sort it
win_frequency_by_stage_standardness["MatchCount"] <-
  matches_by_stage_standardness$MatchCount
win_frequency_by_stage_standardness <- mutate(
  win_frequency_by_stage_standardness, WinPercent =
  round(WinCount / MatchCount * 100, digits = 2))
win_frequency_by_stage_standardness <- win_frequency_by_stage_standardness[
  order(-win_frequency_by_stage_standardness$WinPercent),]

# ***** ANSWER *****
print(win_frequency_by_stage_standardness)


# End of Question 6b




# Question 6c: Which of the standard stage forms do we perform the best on?


# Create dataframes which hold the number of wins and
# matches overall and with a standard stage form
matches_by_stage_form <- as.data.frame(table(
  stage_form_and_match_results$StageForm))
all_wins_per_stage_form <- filter(stage_form_and_match_results, Win)
win_frequency_by_stage_form <- as.data.frame(table(
  all_wins_per_stage_form$StageForm))
colnames(matches_by_stage_form)[1] <- "StageForm"
colnames(matches_by_stage_form)[2] <- "MatchCount"
colnames(win_frequency_by_stage_form)[1] <- "StageForm"
colnames(win_frequency_by_stage_form)[2] <- "WinCount"

# Add MatchCount and WinPercent columns to win frequency dataframe and sort it
win_frequency_by_stage_form["MatchCount"] <- matches_by_stage_form$MatchCount
win_frequency_by_stage_form <- mutate(win_frequency_by_stage_form,
  WinPercent = round(WinCount / MatchCount * 100, digits = 2))
win_frequency_by_stage_form <- filter(win_frequency_by_stage_form,
  StageForm == "Battlefield" | StageForm == "Small Battlefield" |
  StageForm == "Omega")
win_frequency_by_stage_form <- win_frequency_by_stage_form[
  order(-win_frequency_by_stage_form$WinPercent),]

# ***** ANSWER *****
print(win_frequency_by_stage_form)

# Validate results
table(won_matches$`Stage Form`)["Battlefield"] /
  table(valid_data$`Stage Form`)["Battlefield"]
table(won_matches$`Stage Form`)["Omega"] /
  table(valid_data$`Stage Form`)["Omega"]
table(won_matches$`Stage Form`)["Small Battlefield"] /
  table(valid_data$`Stage Form`)["Small Battlefield"]


# End of Question 6c




# Question 7: On average, how popular is a DLC character during
# the first month of their release?  What about the first 3
# months?  How does this compare to their overall popularity?


# Get a list of match dates where there's only one date per team
date_one_per_team <- data_without_errors$Date[
  which(!duplicated(data_without_errors$`Team #`))]

# Pair each character with the date on which they were played
# (using variables defined in Question 1)
P3_character_dates <- data.frame(date_one_per_team, P3_characters_one_per_team)
P4_character_dates <- data.frame(date_one_per_team, P4_characters_one_per_team)
colnames(P3_character_dates)[1] <- "Date"
colnames(P3_character_dates)[2] <- "Character"
colnames(P4_character_dates)[1] <- "Date"
colnames(P4_character_dates)[2] <- "Character"
character_dates <- rbind(P3_character_dates, P4_character_dates)
character_dates <- character_dates[order(character_dates$Date),]


# Define a function that returns the percent representation of a given
# DLC character within a given list of dates and characters
get_dlc_percent_in_dateframe <- function(
  date_and_character_sublist, character)
{
  character_frequencies <- as.data.frame(table(
    date_and_character_sublist$Character))
  colnames(character_frequencies)[1] <- "Character"
  num_all_characters_played <- sum(character_frequencies$Freq)
  num_dlc_character_played <- character_frequencies$Freq[
    character_frequencies$Character == character]
  dlc_character_percent <- round(num_dlc_character_played /
    num_all_characters_played * 100, digits = 2)
  return(dlc_character_percent)
}

# Define a function that returns the percent representation of a given
# DLC character within 1 month, 3 months, and all months after release
dlc_frequency_over_time <- function(character_name, release_date)
{
  characters_within_one_month <- filter(character_dates,
    Date >= release_date & Date < release_date %m+% months(1))
  dlc_percent_in_one_month <- get_dlc_percent_in_dateframe(
    characters_within_one_month, character_name)
  characters_within_three_months <- filter(character_dates,
    Date >= release_date & Date < release_date %m+% months(3))
  dlc_percent_in_three_months <- get_dlc_percent_in_dateframe(
    characters_within_three_months, character_name)
  characters_after_release <- filter(character_dates, Date >= release_date)
  dlc_percent_after_release <- get_dlc_percent_in_dateframe(
    characters_after_release, character_name)
  return(c(dlc_percent_in_one_month, dlc_percent_in_three_months,
    dlc_percent_after_release))
}


# Map each DLC character to its release date
dlc_characters = c("Piranha Plant", "Joker", "Hero", "Banjo & Kazooie", "Terry",
  "Byleth", "Min Min", "Steve", "Sephiroth", "Pyra/Mythra", "Kazuya", "Sora")
dlc_release_dates = c(as.Date("2019-01-29"), as.Date("2019-04-17"),
  as.Date("2019-07-30"), as.Date("2019-09-04"), as.Date("2019-11-06"),
  as.Date("2020-01-28"), as.Date("2020-06-29"), as.Date("2020-10-13"),
  as.Date("2020-12-17"), as.Date("2021-03-04"), as.Date("2021-06-29"),
  as.Date("2021-10-18"))
dlc_with_release_dates <- data.frame(Characters = dlc_characters,
  ReleaseDate = dlc_release_dates)

# For each DLC character, get its percent occurrence over time
# (with each time frame as separate vectors)
one_month_percents <- c()
three_month_percents <- c()
after_release_percents <- c()
for (row in 1:nrow(dlc_with_release_dates))
{
  dlc_percents <- dlc_frequency_over_time(
    dlc_with_release_dates$Characters[row],
    dlc_with_release_dates$ReleaseDate[row])
  one_month_percents <- append(one_month_percents, dlc_percents[1])
  three_month_percents <- append(three_month_percents, dlc_percents[2])
  after_release_percents <- append(after_release_percents, dlc_percents[3])
}

# Combine the DLC percent occurrences into a single data frame
dlc_percents_over_time <- data.frame(dlc_characters, dlc_release_dates,
  one_month_percents, three_month_percents, after_release_percents)
colnames(dlc_percents_over_time)[1] <- "Character"
colnames(dlc_percents_over_time)[2] <- "Release Date"
colnames(dlc_percents_over_time)[3] <- "Percent Rep 1 Month"
colnames(dlc_percents_over_time)[4] <- "Percent Rep 3 Months"
colnames(dlc_percents_over_time)[5] <- "Percent Rep to Date"

# ***** ANSWER *****
print(dlc_percents_over_time)

# Validate a sample of the results
matches_right_after_pplant <- filter(data_one_match_per_team, Date >=
  as.Date("2019-01-29") & Date <= as.Date("2019-02-28"))
(table(matches_right_after_pplant$`P3 Character`)["Piranha Plant"] +
  table(matches_right_after_pplant$`P4 Character`)["Piranha Plant"]) /
  (length(matches_right_after_pplant$`Match #`) * 2)
matches_a_bit_after_terry <- filter(data_one_match_per_team, Date >=
  as.Date("2019-11-06") & Date < as.Date("2020-02-06"))
(table(matches_a_bit_after_terry$`P3 Character`)["Terry"] +
  table(matches_a_bit_after_terry$`P4 Character`)["Terry"]) /
  (length(matches_a_bit_after_terry$`Match #`) * 2)
matches_after_kazuya <- filter(data_one_match_per_team, Date >=
  as.Date("2021-06-29"))
(table(matches_after_kazuya$`P3 Character`)["Kazuya"] +
  table(matches_after_kazuya$`P4 Character`)["Kazuya"]) /
  (length(matches_after_kazuya$`Match #`) * 2)


# End of Question 7




# Question 8: What are the most popular character-color combinations?


# Get a list of P3 and P4 colors where there's only one color per team
P3_colors_one_per_team <- data_without_errors$`P3 Color`[
  which(!duplicated(data_without_errors$`Team #`))]
P4_colors_one_per_team <- data_without_errors$`P4 Color`[
  which(!duplicated(data_without_errors$`Team #`))]

# Create a dataframe from the P3 and P4 colors and characters, one per team
characters_and_colors = data.frame(P3_colors_one_per_team,
  P3_characters_one_per_team, P4_colors_one_per_team,
  P4_characters_one_per_team)
colnames(characters_and_colors)[1] <- "P3Color"
colnames(characters_and_colors)[2] <- "P3Character"
colnames(characters_and_colors)[3] <- "P4Color"
colnames(characters_and_colors)[4] <- "P4Character"

# Separate P3 (characters/colors) and P4 (characters/colors) into their
# own dataframes and combine colors with characters
P3_character_colors <- data.frame(P3ColorAndChar = paste(
  character_colors$P3Color, character_colors$P3Character, sep=" "))
P4_character_colors <- data.frame(P4ColorAndChar = paste(
  character_colors$P4Color, character_colors$P4Character, sep=" "))
colnames(P3_character_colors)[1] <- "CharacterColor"
colnames(P4_character_colors)[1] <- "CharacterColor"

# Combine P3 and P4 character colors and calculate frequencies
all_character_colors <- rbind(P3_character_colors, P4_character_colors)
char_color_freq <- as.data.frame(table(all_character_colors$CharacterColor))
colnames(char_color_freq)[1] <- "CharacterColor"

# Sort the dataframe and add a "frequency-as-percent" column
char_color_freq <- char_color_freq[order(-char_color_freq$Freq),]
total_character_colors <- sum(char_color_freq$Freq)
char_color_freq <- mutate(char_color_freq, FreqAsPercent =
  round(Freq / total_character_colors * 100, digits = 2))

# ***** ANSWER *****
print(char_color_freq)

# Validate a sample of the results
(table(data_one_match_per_team$`P3 Color`,
  data_one_match_per_team$`P3 Character`)["White", "Ganondorf"] +
  table(data_one_match_per_team$`P4 Color`,
  data_one_match_per_team$`P4 Character`)["White", "Ganondorf"]) /
  (length(data_one_match_per_team$`Match #`) * 2)
(table(data_one_match_per_team$`P3 Color`,
  data_one_match_per_team$`P3 Character`)["Default", "Ganondorf"] +
  table(data_one_match_per_team$`P4 Color`,
  data_one_match_per_team$`P4 Character`)["Default", "Ganondorf"]) /
  (length(data_one_match_per_team$`Match #`) * 2)
(table(data_one_match_per_team$`P3 Color`,
  data_one_match_per_team$`P3 Character`)["Default", "King K. Rool"] +
  table(data_one_match_per_team$`P4 Color`,
  data_one_match_per_team$`P4 Character`)["Default", "King K. Rool"]) /
  (length(data_one_match_per_team$`Match #`) * 2)
(table(data_one_match_per_team$`P3 Color`,
  data_one_match_per_team$`P3 Character`)["Default", "Kirby"] +
  table(data_one_match_per_team$`P4 Color`,
  data_one_match_per_team$`P4 Character`)["Default", "Kirby"]) /
  (length(data_one_match_per_team$`Match #`) * 2)


# End of Question 8

