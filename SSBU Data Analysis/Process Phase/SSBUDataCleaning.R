install.packages("tidyverse")
install.packages("stringr")
install.packages("zoo")
library(tidyverse)
library(stringr)
library(zoo)

# Load data
raw_data <- read_csv("Ultimate Online Chart Without Metadata.csv")
clean_data <- raw_data




# Start of removing null values


# Use more descriptive column names
colnames(clean_data)[7] <- "Team #"
colnames(clean_data)[12] <- "Match #"
colnames(clean_data)[14] <- "Desired Stage Form"
colnames(clean_data)[15] <- "Stage Form"

# Temporarily rename Common Notes columns
colnames(clean_data)[17] <- "Common Note 1"
colnames(clean_data)[18] <- "Common Note 2"
colnames(clean_data)[19] <- "Common Note 3"
colnames(clean_data)[20] <- "Common Note 4"
colnames(clean_data)[21] <- "Common Note 5"
colnames(clean_data)[22] <- "Common Note 6"
colnames(clean_data)[23] <- "Common Note 7"
colnames(clean_data)[24] <- "Common Note 8"

# Remove newlines from cells in Result and Other Notes columns
clean_data$Result <- gsub("\n", " ", clean_data$Result)
clean_data$`Other Notes` <- gsub("\n", " ", clean_data$`Other Notes`)

# Remove "OT Character" column since it won't be necessary for analysis
clean_data <- select(clean_data, -`OT Character`)

# Transform Common Notes data into a set of booleans
clean_data <- mutate(clean_data, CPU =
    (!is.na(`Common Note 1`) & `Common Note 1` == "CPU") |
    (!is.na(`Common Note 2`) & `Common Note 2` == "CPU") |
    (!is.na(`Common Note 3`) & `Common Note 3` == "CPU") |
    (!is.na(`Common Note 4`) & `Common Note 4` == "CPU") |
    (!is.na(`Common Note 5`) & `Common Note 5` == "CPU") |
    (!is.na(`Common Note 6`) & `Common Note 6` == "CPU") |
    (!is.na(`Common Note 7`) & `Common Note 7` == "CPU") |
    (!is.na(`Common Note 8`) & `Common Note 8` == "CPU")) %>%
  mutate(clean_data, Stamina =
    (!is.na(`Common Note 1`) & `Common Note 1` == "Stam") |
    (!is.na(`Common Note 2`) & `Common Note 2` == "Stam") |
    (!is.na(`Common Note 3`) & `Common Note 3` == "Stam") |
    (!is.na(`Common Note 4`) & `Common Note 4` == "Stam") |
    (!is.na(`Common Note 5`) & `Common Note 5` == "Stam") |
    (!is.na(`Common Note 6`) & `Common Note 6` == "Stam") |
    (!is.na(`Common Note 7`) & `Common Note 7` == "Stam") |
    (!is.na(`Common Note 8`) & `Common Note 8` == "Stam")) %>%
  mutate(clean_data, `Time Mode` =
    (!is.na(`Common Note 1`) & `Common Note 1` == "Time") |
    (!is.na(`Common Note 2`) & `Common Note 2` == "Time") |
    (!is.na(`Common Note 3`) & `Common Note 3` == "Time") |
    (!is.na(`Common Note 4`) & `Common Note 4` == "Time") |
    (!is.na(`Common Note 5`) & `Common Note 5` == "Time") |
    (!is.na(`Common Note 6`) & `Common Note 6` == "Time") |
    (!is.na(`Common Note 7`) & `Common Note 7` == "Time") |
    (!is.na(`Common Note 8`) & `Common Note 8` == "Time")) %>%
  mutate(clean_data, `Smash Meter` =
    (!is.na(`Common Note 1`) & `Common Note 1` == "SM") |
    (!is.na(`Common Note 2`) & `Common Note 2` == "SM") |
    (!is.na(`Common Note 3`) & `Common Note 3` == "SM") |
    (!is.na(`Common Note 4`) & `Common Note 4` == "SM") |
    (!is.na(`Common Note 5`) & `Common Note 5` == "SM") |
    (!is.na(`Common Note 6`) & `Common Note 6` == "SM") |
    (!is.na(`Common Note 7`) & `Common Note 7` == "SM") |
    (!is.na(`Common Note 8`) & `Common Note 8` == "SM")) %>%
  mutate(clean_data, `Smash Balls` =
    (!is.na(`Common Note 1`) & `Common Note 1` == "SB") |
    (!is.na(`Common Note 2`) & `Common Note 2` == "SB") |
    (!is.na(`Common Note 3`) & `Common Note 3` == "SB") |
    (!is.na(`Common Note 4`) & `Common Note 4` == "SB") |
    (!is.na(`Common Note 5`) & `Common Note 5` == "SB") |
    (!is.na(`Common Note 6`) & `Common Note 6` == "SB") |
    (!is.na(`Common Note 7`) & `Common Note 7` == "SB") |
    (!is.na(`Common Note 8`) & `Common Note 8` == "SB")) %>%
  mutate(clean_data, Items =
    (!is.na(`Common Note 1`) & (`Common Note 1` == "AT" |
      `Common Note 1` == "PB" | `Common Note 1` == "I" |
      `Common Note 1` == "SF" | `Common Note 1` == "DD")) |
    (!is.na(`Common Note 2`) & (`Common Note 2` == "AT" |
      `Common Note 2` == "PB" | `Common Note 2` == "I" |
      `Common Note 2` == "SF" | `Common Note 2` == "DD")) |
    (!is.na(`Common Note 3`) & (`Common Note 3` == "AT" |
      `Common Note 3` == "PB" | `Common Note 3` == "I" |
      `Common Note 3` == "SF" | `Common Note 3` == "DD")) |
    (!is.na(`Common Note 4`) & (`Common Note 4` == "AT" |
      `Common Note 4` == "PB" | `Common Note 4` == "I" |
      `Common Note 4` == "SF" | `Common Note 4` == "DD")) |
    (!is.na(`Common Note 5`) & (`Common Note 5` == "AT" |
      `Common Note 5` == "PB" | `Common Note 5` == "I" |
      `Common Note 5` == "SF" | `Common Note 5` == "DD")) |
    (!is.na(`Common Note 6`) & (`Common Note 6` == "AT" |
      `Common Note 6` == "PB" | `Common Note 6` == "I" |
      `Common Note 6` == "SF" | `Common Note 6` == "DD")) |
    (!is.na(`Common Note 7`) & (`Common Note 7` == "AT" |
      `Common Note 7` == "PB" | `Common Note 7` == "I" |
      `Common Note 7` == "SF" | `Common Note 7` == "DD")) |
    (!is.na(`Common Note 8`) & (`Common Note 8` == "AT" |
      `Common Note 8` == "PB" | `Common Note 8` == "I" |
      `Common Note 8` == "SF" | `Common Note 8` == "DD")))
clean_data <- select(clean_data, -`Common Note 1`, 
  -`Common Note 2`, -`Common Note 3`, -`Common Note 4`, -`Common Note 5`,
  -`Common Note 6`, -`Common Note 7`, -`Common Note 8`)

# For every cell containing "NA" in the Date, Location, Team #, P3 Character,
# and P4 Character columns, fill it with the previous non-NA value
clean_data$Date <- na.locf(clean_data$Date)
clean_data$Location <- na.locf(clean_data$Location)
clean_data$`Team #` <- na.locf(clean_data$`Team #`)
clean_data$`P3 Character` <- na.locf(clean_data$`P3 Character`)
clean_data$`P4 Character` <- na.locf(clean_data$`P4 Character`)

# For every cell in the P1 and P2 columns, replace every "*" with an empty
# string (ex. "OT*" becomes "OT"), replace all cells that contain just an
# empty string with "NA", and fill all NAs with the previous non-NA value
clean_data$P1 <- gsub("\\*", "", clean_data$P1)
clean_data$P2 <- gsub("\\*", "", clean_data$P2)
clean_data$P1[clean_data$P1 == ""] <- NA
clean_data$P2[clean_data$P2 == ""] <- NA
clean_data$P1 <- na.locf(clean_data$P1)
clean_data$P2 <- na.locf(clean_data$P2)

# For every cell containing "NA" in the P3 Color and P4 Color columns,
# fill it with "Default" if the previous non-NA value is from a row with
# a different Team #, otherwise fill it with the previous non-NA value
p3_color_by_team <- aggregate(clean_data$`P3 Color`~clean_data$`Team #`, FUN=c)
p4_color_by_team <- aggregate(clean_data$`P4 Color`~clean_data$`Team #`, FUN=c)
colnames(p3_color_by_team)[1] <- "Team #"
colnames(p3_color_by_team)[2] <- "P3 Color"
colnames(p4_color_by_team)[1] <- "Team #"
colnames(p4_color_by_team)[2] <- "P4 Color"
clean_data$`P3 Color`[which(!(clean_data$`Team #` %in%
  p3_color_by_team$`Team #`))] = "Default"
clean_data$`P4 Color`[which(!(clean_data$`Team #` %in%
  p4_color_by_team$`Team #`))] = "Default"
clean_data$`P3 Color` <- na.locf(clean_data$`P3 Color`)
clean_data$`P4 Color` <- na.locf(clean_data$`P4 Color`)

# Replace every "NA" in the RCS Character and Other Notes columns
# with the string, "N/A"
clean_data$`RCS Character`[is.na(clean_data$`RCS Character`)] <- "N/A"
clean_data$`Other Notes`[is.na(clean_data$`Other Notes`)] <- "N/A"


# End of removing null values




# Start of finding and fixing errors


data_without_errors <- clean_data


# Check that all dates are within range and are always non-strictly increasing
print(min(data_without_errors$Date))
print(max(data_without_errors$Date))
print(data_without_errors$Date[1] == min(data_without_errors$Date))
print(data_without_errors$Date[length(data_without_errors$Date)] ==
  max(data_without_errors$Date))
print(!is.unsorted(data_without_errors$Date))

# Check Location, P1, P2, and RCS Character columns for invalid values
print(unique(data_without_errors$Location))
print(unique(data_without_errors$P1))
print(unique(data_without_errors$P2))
print(unique(data_without_errors$`RCS Character`))


# Check that all Team #s are within range and are always non-strictly increasing
print(min(data_without_errors$`Team #`))
print(max(data_without_errors$`Team #`))
print(data_without_errors$`Team #`[1] == min(data_without_errors$`Team #`))
print(data_without_errors$`Team #`[length(data_without_errors$`Team #`)] ==
  max(data_without_errors$`Team #`))
print(!is.unsorted(data_without_errors$`Team #`))

# Team # column is unsorted, so search for the invalid value(s)
which(diff(data_without_errors$`Team #`) < 0)

# Team # decreases from index 10181 to 10182, so find the exact culprit
print(data_without_errors$`Team #`[10180:10183])

# Team #6929 was incorrectly recorded as #6292, so fix that
data_without_errors$`Team #`[10182] <- 6929

# Check that the data is now sorted
print(!is.unsorted(data_without_errors$`Team #`))


# Check P3 Character and P4 Character columns for invalid values
print(unique(data_without_errors$`P3 Character`))
print(unique(data_without_errors$`P4 Character`))

# Find the instance(s) where P3's character is "RIchter"
which(data_without_errors$`P3 Character` == "RIchter")

# Replace that "RIchter" with "Richter"
data_without_errors$`P3 Character`[16607] <- "Richter"

# Confirm that there are now only 86 unique characters for P3
print(length(unique(data_without_errors$`P3 Character`)) == 86)


# View possible P3 and P4 colors
print(unique(data_without_errors$`P3 Color`))
print(unique(data_without_errors$`P4 Color`))

# Check that all Match #s are within range and always increase by 1
print(min(data_without_errors$`Match #`))
print(max(data_without_errors$`Match #`))
print(data_without_errors$`Match #`[1] == 1)
print(all(diff(data_without_errors$`Match #`) == 1))

# Check Stage Form and Desired Stage Form columns for invalid values
print(unique(data_without_errors$`Stage Form`))
print(unique(data_without_errors$`Desired Stage Form`))


# Check that Stage column contains only valid values, Small Battlefield stage
# always has Small Battlefield form, and Battlefield and Final Destination only
# have Battlefield or Omega forms
print(unique(data_without_errors$Stage))
print(all(data_without_errors$`Stage Form`[which(data_without_errors$`Stage` ==
  "Small Battlefield")] == "Small Battlefield"))
print(all(data_without_errors$`Stage Form`[which(data_without_errors$`Stage` ==
  "Battlefield")] %in% c("Omega", "Battlefield")))
print(all(data_without_errors$`Stage Form`[which(data_without_errors$`Stage` ==
  "Final Destination")] %in% c("Omega", "Battlefield")))

# Check that CPU, Stamina, Time Mode, Smash Meter, Smash Balls, and Items
# columns contain only TRUE or FALSE
print(typeof(data_without_errors$CPU) == "logical")
print(typeof(data_without_errors$Stamina) == "logical")
print(typeof(data_without_errors$`Time Mode`) == "logical")
print(typeof(data_without_errors$`Smash Meter`) == "logical")
print(typeof(data_without_errors$`Smash Balls`) == "logical")
print(typeof(data_without_errors$Items) == "logical")


# Check Result column for invalid values
print(unique(data_without_errors$Result))

# Find the instance(s) where the match result is "--1"
which(data_without_errors$Result == "--1")

# Replace that "--1" with "-1"
data_without_errors$Result[9237] <- "-1"

# Confirm that there are no more matches with a result of "--1"
print(!("--1" %in% unique(data_without_errors$Result)))


# View possible values in Other Notes column
print(unique(data_without_errors$`Other Notes`))


# End of finding and fixing errors




# Start of cleaning verification - non-NA values were not erroneously altered


# Check that non-NA values in the Date and Location columns
# for the raw data are unchanged in the cleaned data
print(all(data_without_errors$Date[!is.na(raw_data$Date)] ==
  raw_data$Date[!is.na(raw_data$Date)]))
print(all(data_without_errors$Location[!is.na(raw_data$Location)] ==
  raw_data$Location[!is.na(raw_data$Location)]))

# Check that non-NA values in the P1 and P2 columns for the raw data
# are unchanged in the cleaned data, excluding entries with *s
p1_entries_with_star <- str_detect(raw_data$P1, "\\*")
p1_entries_with_star[is.na(p1_entries_with_star)] <- FALSE
print(all(data_without_errors$P1[!is.na(raw_data$P1) & !p1_entries_with_star] ==
  raw_data$P1[!is.na(raw_data$P1) & !p1_entries_with_star]))
p2_entries_with_star <- str_detect(raw_data$P2, "\\*")
p2_entries_with_star[is.na(p2_entries_with_star)] <- FALSE
print(all(data_without_errors$P2[!is.na(raw_data$P2) & !p2_entries_with_star] ==
  raw_data$P2[!is.na(raw_data$P2) & !p2_entries_with_star]))

# Check that non-NA values in the RCS Character column
# for the raw data are unchanged in the cleaned data
print(all(data_without_errors$`RCS Character`[!is.na(raw_data$
  `RCS Character`)] == raw_data$`RCS Character`[!is.na(raw_data$
  `RCS Character`)]))

# Check that non-NA values in the Team (#) column for the raw data
# are unchanged in the cleaned data, excluding the erroneous Team #6292
print(all(data_without_errors$`Team #`[!is.na(raw_data$Team)] == raw_data$Team[
  !is.na(raw_data$Team)] | raw_data$Team[!is.na(raw_data$Team)] == 6292))

# Check that non-NA values in the P3 Character column for the raw data
# are unchanged in the cleaned data, excluding the erroneous "RIchter"
print(all(data_without_errors$`P3 Character`[!is.na(raw_data$`P3 Character`)] ==
  raw_data$`P3 Character`[!is.na(raw_data$`P3 Character`)] |
  raw_data$`P3 Character`[!is.na(raw_data$`P3 Character`)] == "RIchter"))

# Check that non-NA values in the P4 Character, P3 Color, P4 Color, and
# Match (#) columns for the raw data are unchanged in the cleaned data
print(all(data_without_errors$`P4 Character`[!is.na(raw_data$`P4 Character`)] ==
  raw_data$`P4 Character`[!is.na(raw_data$`P4 Character`)]))
print(all(data_without_errors$`P3 Color`[!is.na(raw_data$`P3 Color`)] ==
  raw_data$`P3 Color`[!is.na(raw_data$`P3 Color`)]))
print(all(data_without_errors$`P4 Color`[!is.na(raw_data$`P4 Color`)] ==
  raw_data$`P4 Color`[!is.na(raw_data$`P4 Color`)]))
print(all(data_without_errors$`Match #` == raw_data$Match))

# Check that values in the Result column for the raw data are
# unchanged in the cleaned data, excluding rows that contained
# newlines or the erroneous "--1"
results_with_newlines <- str_detect(raw_data$Result, "\n")
print(all(data_without_errors$Result[!results_with_newlines] ==
  raw_data$Result[!results_with_newlines] |
  raw_data$Result[!results_with_newlines] == "--1"))

# Check that values in the (Stage) Form, (Desired Stage/Wanted) Form,
# and Stage columns for the raw data are unchanged in the cleaned data
print(all(data_without_errors$`Stage Form` == raw_data$Form))
print(all(data_without_errors$`Desired Stage Form` == raw_data$`Wanted Form`))
print(all(data_without_errors$Stage == raw_data$Stage))

# Check that non-NA values in the Other Notes column for the raw data
# are unchanged in the cleaned data, excluding rows that contained newlines
other_notes_with_newlines <- str_detect(raw_data$`Other Notes`, "\n")
print(all(data_without_errors$`Other Notes`[!is.na(raw_data$`Other Notes`) &
  !other_notes_with_newlines] == raw_data$`Other Notes`[
  !is.na(raw_data$`Other Notes`) & !other_notes_with_newlines]))


# End of cleaning verification - non-NA values were not erroneously altered




# Start of cleaning verification - NA values were altered correctly


# Check that NA values in the Date, Location, P1, P2,
# and Team (#) columns for the data are changed to match
# the value in the previous row in the cleaned data
print(all(data_without_errors$Date[which(is.na(raw_data$Date))] ==
  data_without_errors$Date[which(is.na(raw_data$Date)) - 1]))
print(all(data_without_errors$Location[which(is.na(raw_data$Location))] ==
  data_without_errors$Location[which(is.na(raw_data$Location)) - 1]))
print(all(data_without_errors$P1[which(is.na(raw_data$P1))] ==
  data_without_errors$P1[which(is.na(raw_data$P1)) - 1]))
print(all(data_without_errors$P2[which(is.na(raw_data$P2))] ==
  data_without_errors$P2[which(is.na(raw_data$P2)) - 1]))
print(all(data_without_errors$`Team #`[which(is.na(raw_data$Team))] ==
  data_without_errors$`Team #`[which(is.na(raw_data$Team)) - 1]))

# Check that NA values in the RCS Character and Other Notes columns
# for the raw data are changed to "N/A" in the cleaned data
print(all(data_without_errors$`RCS Character`[
  which(is.na(raw_data$`RCS Character`))] == "N/A"))
print(all(data_without_errors$`Other Notes`[
  which(is.na(raw_data$`Other Notes`))] == "N/A"))

# Check that NA values in the P3 Character and P4 Character columns for the raw
# data are changed to match the value in the previous row in the cleaned data
print(all(data_without_errors$`P3 Character`[which(is.na(
  raw_data$`P3 Character`))] == data_without_errors$`P3 Character`[
  which(is.na(raw_data$`P3 Character`)) - 1]))
print(all(data_without_errors$`P4 Character`[which(is.na(
  raw_data$`P4 Character`))] == data_without_errors$`P4 Character`[
  which(is.na(raw_data$`P4 Character`)) - 1]))

# Check that NA values in the P4 Color column for the raw data are either
# changed to "Default" or the value in the previous row in the cleaned data
print(all(data_without_errors$`P4 Color`[which(is.na(
  raw_data$`P4 Color`))] == "Default" |
  data_without_errors$`P4 Color`[which(is.na(raw_data$`P4 Color`))] ==
  data_without_errors$`P4 Color`[which(is.na(raw_data$`P4 Color`)) - 1]))

# Check that NA values in the P3 Color column for the raw data are either
# changed to "Default" or the value in the previous row in the cleaned data;
# ensure to work around the fact that the first two entries were NA
print(data_without_errors$`P3 Color`[1] == "Default" &
  data_without_errors$`P3 Color`[2] == "Default")
print(all(data_without_errors$`P3 Color`[3:19271][which(is.na(
  raw_data$`P3 Color`[3:19271]))] == "Default" |
  data_without_errors$`P3 Color`[3:19271][which(is.na(
  raw_data$`P3 Color`[3:19271]))] == data_without_errors$`P3 Color`[3:19271][
  which(is.na(raw_data$`P3 Color`[3:19271])) - 1]))


# Check that all matches where CPU is TRUE in the clean data had "CPU" marked
# in one of the Common Notes columns in the raw data; similarly,
# check that all matches where CPU is FALSE in the clean data didn't have
# "CPU" in any of the Common Notes columns in the raw data
print(all(
  !is.na(raw_data$`Common Notes`[which(data_without_errors$CPU)]) &
  raw_data$`Common Notes`[which(data_without_errors$CPU)] == "CPU" |
  !is.na(raw_data$`...18`[which(data_without_errors$CPU)]) &
  raw_data$`...18`[which(data_without_errors$CPU)] == "CPU" |
  !is.na(raw_data$`...19`[which(data_without_errors$CPU)]) &
  raw_data$`...19`[which(data_without_errors$CPU)] == "CPU" |
  !is.na(raw_data$`...20`[which(data_without_errors$CPU)]) &
  raw_data$`...20`[which(data_without_errors$CPU)] == "CPU" |
  !is.na(raw_data$`...21`[which(data_without_errors$CPU)]) &
  raw_data$`...21`[which(data_without_errors$CPU)] == "CPU" |
  !is.na(raw_data$`...22`[which(data_without_errors$CPU)]) &
  raw_data$`...22`[which(data_without_errors$CPU)] == "CPU" |
  !is.na(raw_data$`...23`[which(data_without_errors$CPU)]) &
  raw_data$`...23`[which(data_without_errors$CPU)] == "CPU" |
  !is.na(raw_data$`...24`[which(data_without_errors$CPU)]) &
  raw_data$`...24`[which(data_without_errors$CPU)] == "CPU"))
print(all(
  (is.na(raw_data$`Common Notes`[which(!data_without_errors$CPU)]) |
  raw_data$`Common Notes`[which(!data_without_errors$CPU)] != "CPU") &
  (is.na(raw_data$`...18`[which(!data_without_errors$CPU)]) |
  raw_data$`...18`[which(!data_without_errors$CPU)] != "CPU") &
  (is.na(raw_data$`...19`[which(!data_without_errors$CPU)]) |
  raw_data$`...19`[which(!data_without_errors$CPU)] != "CPU") &
  (is.na(raw_data$`...20`[which(!data_without_errors$CPU)]) |
  raw_data$`...20`[which(!data_without_errors$CPU)] != "CPU") &
  (is.na(raw_data$`...21`[which(!data_without_errors$CPU)]) |
  raw_data$`...21`[which(!data_without_errors$CPU)] != "CPU") &
  (is.na(raw_data$`...22`[which(!data_without_errors$CPU)]) |
  raw_data$`...22`[which(!data_without_errors$CPU)] != "CPU") &
  (is.na(raw_data$`...23`[which(!data_without_errors$CPU)]) |
  raw_data$`...23`[which(!data_without_errors$CPU)] != "CPU") &
  (is.na(raw_data$`...24`[which(!data_without_errors$CPU)]) |
  raw_data$`...24`[which(!data_without_errors$CPU)] != "CPU")))

# (Perform similar checks as above but for the Stamina, Time Mode,
# Smash Meter, Smash Balls, and Items columns; code is not included here
# so these checks don't take up half of this file)


# End of cleaning verification - NA values were altered correctly

