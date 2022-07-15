/* Question 1: What are the most and least popular characters? */


-- Create a new table which contains the data with only the first row per team
-- Note: This makes use of a hack(?) where 'SELECT *... GROUP BY'
-- automatically returns only the first row for each group
CREATE TABLE OneMatchPerTeam AS
	SELECT *
	FROM DataWithoutErrors
	GROUP BY TeamNum;

-- Count the frequency of P3 and P4 characters
CREATE TABLE P3Frequency AS
	SELECT P3Character, COUNT(P3Character) AS Frequency
	FROM OneMatchPerTeam
	GROUP BY P3Character;
CREATE TABLE P4Frequency AS
	SELECT P4Character, COUNT(P4Character) AS Frequency
	FROM OneMatchPerTeam
	GROUP BY P4Character;

-- Confirm that all 86 characters are played at some point by
-- both P3 and P4 (so frequencies can be summed successfully)
SELECT COUNT(*)
FROM P3Frequency;
SELECT COUNT(*)
FROM P4Frequency;

-- ***** ANSWER *****
-- Combine the frequencies of P3 and P4 characters and
-- add a column representing their percent occurrence
CREATE TABLE Question1 AS
	WITH CharacterTotal AS
		(SELECT 2 * MAX(TeamNum) AS Total
		FROM OneMatchPerTeam)
	SELECT P3Frequency.P3Character AS Character,
		(P3Frequency.Frequency + P4Frequency.Frequency) AS Frequency,
		ROUND((P3Frequency.Frequency + P4Frequency.Frequency) /
		CAST(CharacterTotal.Total AS REAL) * 100, 2) AS PercentOccurrence
	FROM P3Frequency, P4Frequency, CharacterTotal
	WHERE P3Frequency.P3Character = P4Frequency.P4Character
	ORDER BY Frequency DESC;

-- Validate a sample of the results
SELECT
	(SELECT COUNT(*)
	FROM OneMatchPerTeam
	WHERE P3Character = 'Ganondorf') +
	(SELECT COUNT(*)
	FROM OneMatchPerTeam
	WHERE P4Character = 'Ganondorf') AS GanonCount
FROM OneMatchPerTeam
WHERE MatchNum = 1;
SELECT
	(SELECT COUNT(*)
	FROM OneMatchPerTeam
	WHERE P3Character = 'Olimar') +
	(SELECT COUNT(*)
	FROM OneMatchPerTeam
	WHERE P4Character = 'Olimar') AS OlimarCount
FROM OneMatchPerTeam
WHERE MatchNum = 1;

DROP TABLE P3Frequency;
DROP TABLE P4Frequency;


/* End of Question 1 */




/* Question 2: What are the most popular character pairings? */


-- Create a table which holds the frequencies of character
-- combinations in forward and reverse alphabetical order
CREATE TABLE OrderedPairingFreqs AS
	SELECT P3Character AS FirstChar, P4Character AS SecondChar,
		COUNT(*) AS Frequency
	FROM OneMatchPerTeam
	WHERE P3Character <= P4Character
	GROUP BY P3Character, P4Character;
CREATE TABLE ReversedPairingFreqs AS
	SELECT P4Character AS FirstChar, P3Character AS SecondChar,
		COUNT(*) AS Frequency
	FROM OneMatchPerTeam
	WHERE P3Character > P4Character
	GROUP BY P4Character, P3Character;

-- Since frequencies can only be summed if the character pairing appears in
-- both the 'ordered' and 'reversed' table, the frequencies must be split
-- according to their presence (or lack thereof) in the two tables
CREATE TABLE FreqsOnlyInOrderedPairings AS
	SELECT OrderedPairingFreqs.FirstChar, OrderedPairingFreqs.SecondChar,
		OrderedPairingFreqs.Frequency
	FROM OrderedPairingFreqs
	LEFT JOIN ReversedPairingFreqs ON
		OrderedPairingFreqs.FirstChar = ReversedPairingFreqs.FirstChar AND
		OrderedPairingFreqs.SecondChar = ReversedPairingFreqs.SecondChar
	WHERE ReversedPairingFreqs.Frequency IS NULL;
CREATE TABLE FreqsOnlyInReversedPairings AS
	SELECT ReversedPairingFreqs.FirstChar, ReversedPairingFreqs.SecondChar,
		ReversedPairingFreqs.Frequency
	FROM ReversedPairingFreqs
	LEFT JOIN OrderedPairingFreqs ON
		OrderedPairingFreqs.FirstChar = ReversedPairingFreqs.FirstChar AND
		OrderedPairingFreqs.SecondChar = ReversedPairingFreqs.SecondChar
	WHERE OrderedPairingFreqs.Frequency IS NULL;
CREATE TABLE FreqsInBothPairings AS
	SELECT OrderedPairingFreqs.FirstChar, OrderedPairingFreqs.SecondChar,
		(OrderedPairingFreqs.Frequency + 
		ReversedPairingFreqs.Frequency) AS Frequency
	FROM OrderedPairingFreqs
	INNER JOIN ReversedPairingFreqs ON
		OrderedPairingFreqs.FirstChar = ReversedPairingFreqs.FirstChar AND
		OrderedPairingFreqs.SecondChar = ReversedPairingFreqs.SecondChar;
	
-- ***** ANSWER *****
-- Combine all character pair frequencies and
-- add a column representing their percent occurrence
CREATE TABLE Question2 AS
	WITH MatchTotal AS
		(SELECT MAX(TeamNum) AS Total
		FROM OneMatchPerTeam)
	SELECT FirstChar, SecondChar, FirstChar || ', ' || SecondChar AS CharPair,
		Frequency, ROUND(Frequency / CAST(
		MatchTotal.Total AS REAL) * 100, 2) AS PercentOccurrence
	FROM FreqsOnlyInOrderedPairings, MatchTotal
	UNION
	SELECT FirstChar, SecondChar, FirstChar || ', ' || SecondChar AS CharPair,
		Frequency, ROUND(Frequency / CAST(
		MatchTotal.Total AS REAL) * 100, 2) AS PercentOccurrence
	FROM FreqsOnlyInReversedPairings, MatchTotal
	UNION
	SELECT FirstChar, SecondChar, FirstChar || ', ' || SecondChar AS CharPair,
		Frequency, ROUND(Frequency / CAST(
		MatchTotal.Total AS REAL) * 100, 2) AS PercentOccurrence
	FROM FreqsInBothPairings, MatchTotal
	ORDER BY Frequency DESC;

-- Validate a sample of the results
SELECT COUNT(*) AS DKDKCount
FROM OneMatchPerTeam
WHERE P3Character = 'Donkey Kong' AND P4Character = 'Donkey Kong';
SELECT COUNT(*) AS GanonGanonCount
FROM OneMatchPerTeam
WHERE P3Character = 'Ganondorf' AND P4Character = 'Ganondorf';
SELECT COUNT(*) AS LucasNessCount
FROM OneMatchPerTeam
WHERE P3Character = 'Lucas' AND P4Character = 'Ness' OR
	P3Character = 'Ness' AND P4Character = 'Lucas';
SELECT COUNT(*) AS HeroHeroCount
FROM OneMatchPerTeam
WHERE P3Character = 'Hero' AND P4Character = 'Hero';

DROP TABLE FreqsOnlyInOrderedPairings;
DROP TABLE FreqsOnlyInReversedPairings;
DROP TABLE FreqsInBothPairings;
DROP TABLE OrderedPairingFreqs;
DROP TABLE ReversedPairingFreqs;


/* End of Question 2 */




/* Start of preparation for win-rate questions */


CREATE TABLE ValidData AS
SELECT *
FROM DataWithoutErrors;

-- Only include matches with me (OT) and Justin (RCS) as participants
DELETE FROM ValidData
WHERE NOT ((P1 = 'OT' AND P2 = 'RCS') OR (P1 = 'RCS' AND P2 = 'OT'));

-- View all possible results
SELECT DISTINCT Result
FROM ValidData;

-- Remove matches with invalid results
DELETE FROM ValidData
WHERE Result = 'RCS 1' OR Result = 'Connection Error';

-- Convert match results to booleans
ALTER TABLE ValidData
ADD Win BOOL;
UPDATE ValidData
SET Win =
	NOT (Result = '-1' OR Result = '-1 out of 2' OR Result = '-1 out of 4' OR
	Result = '-1 to +1' OR Result = '-2' OR Result = '-2 out of 2' OR
	Result = '-2 out of 4' OR Result = '-2 to 0' OR Result = '-3' OR
	Result = '-3 out of 4' OR Result = '-3 to +3' OR Result = '-3 to 0' OR
	Result = '-4' OR Result = '-4 to +5' OR Result = '-5' OR Result = '-6' OR
	Result = '0 to 0 at time, SD Lose' OR Result = '1 to 1 at time, SD Lose' OR
	Result = '1 to 1 out of 4 at time, SD Lose' OR Result = '1 to 2 at time' OR
	Result = '1 to 2 out of 4 at time' );

-- View all possible values in the 'OtherNotes' column
SELECT DISTINCT OtherNotes
FROM ValidData;

-- Remove all matches where one team wasn't trying to win
DELETE FROM ValidData
WHERE CPU = 1;
DELETE FROM ValidData
WHERE OtherNotes = 'Opponents only teabagged' OR
	OtherNotes = "P4 didn't move for 29 seconds??" OR
	OtherNotes = 'After 30 seconds, opponents did nothing' OR
	OtherNotes = "Opponents sometimes didn't input anything" OR
	OtherNotes = 'Unplayable lag, we SDd' OR
	OtherNotes = "P4 didn't move for 25 seconds" OR
	OtherNotes = 'Unplayable lag, opponents SDd' OR
	OtherNotes = 'Opponents self-destructed' OR
	OtherNotes = 'Opponents self-destructed immediately' OR
	OtherNotes = 'Oppponents self-destructed immediately' OR
	OtherNotes = 'Opponents immediately self-destructed';
	
-- Verify changes
SELECT DISTINCT P1, P2
FROM ValidData;
SELECT Result
FROM ValidData
WHERE Result = 'Connection Error';
SELECT Result
FROM ValidData
WHERE Result = 'RCS 1';
SELECT DISTINCT CPU
FROM ValidData;


/* End of preparation for win-rate questions */




/* Question 3: Which characters do we struggle against the most?
    Which are the easiest for us to defeat?*/


-- Count the number of wins and matches played
-- against each P3 and P4 character
CREATE TABLE P3CharacterMatches AS
	SELECT P3Character AS Character, COUNT(*) AS MatchCount
	FROM ValidData
	GROUP BY P3Character;
CREATE TABLE P4CharacterMatches AS
	SELECT P4Character AS Character, COUNT(*) AS MatchCount
	FROM ValidData
	GROUP BY P4Character;
CREATE TABLE WinsAgainstP3Character AS
	SELECT P3Character AS Character, COUNT(Win) AS WinCount
	FROM ValidData
	WHERE Win = 1
	GROUP BY P3Character;
CREATE TABLE WinsAgainstP4Character AS
	SELECT P4Character AS Character, COUNT(Win) AS WinCount
	FROM ValidData
	WHERE Win = 1
	GROUP BY P4Character;
	
-- ***** ANSWER *****
-- Combine wins and matches against each player
-- character and calculate our win percentage
CREATE TABLE Question3 AS
	SELECT P3CM.Character, 
		(WAP3C.WinCount + WAP4C.WinCount) AS WinCount,
		(P3CM.MatchCount + P4CM.MatchCount) AS MatchCount,
		ROUND(100 * (WAP3C.WinCount + WAP4C.WinCount) / CAST(
		(P3CM.MatchCount + P4CM.MatchCount) AS REAL), 2) AS WinPercent
	FROM P3CharacterMatches AS P3CM, P4CharacterMatches AS P4CM,
		WinsAgainstP3Character AS WAP3C, WinsAgainstP4Character AS WAP4C
	WHERE P3CM.Character = P4CM.Character AND
		P3CM.Character = WAP3C.Character AND
		P3CM.Character = WAP4C.Character
	ORDER BY WinPercent ASC;

-- Validate a sample of the results
SELECT
	(SELECT COUNT(*)
	FROM ValidData
	WHERE Win = 1 AND P3Character = 'Wii Fit Trainer') +
	(SELECT COUNT(*)
	FROM ValidData
	WHERE Win = 1 AND P4Character = 'Wii Fit Trainer') AS WinsVsWiiFit
FROM ValidData
WHERE MatchNum = 1;
SELECT
	(SELECT COUNT(*)
	FROM ValidData
	WHERE P3Character = 'Duck Hunt') +
	(SELECT COUNT(*)
	FROM ValidData
	WHERE P4Character = 'Duck Hunt') AS MatchesVsDuckHunt
FROM ValidData
WHERE MatchNum = 1;

DROP TABLE P3CharacterMatches;
DROP TABLE P4CharacterMatches;
DROP TABLE WinsAgainstP3Character;
DROP TABLE WinsAgainstP4Character;


/* End of Question 3 */




/* Question 4: How has our win-rate changed over time? */


-- Count the number of wins and matches per month
CREATE TABLE MatchesPerMonth AS
SELECT Date, STRFTIME('%Y', Date) AS Year,
	STRFTIME('%m', Date) AS Month, COUNT(*) AS MatchCount
FROM ValidData
GROUP BY STRFTIME('%Y %m', Date);
CREATE TABLE WinsPerMonth AS
SELECT Date, STRFTIME('%Y', Date) AS Year,
	STRFTIME('%m', Date) AS Month, COUNT(*) AS WinCount
FROM ValidData
WHERE Win = 1
GROUP BY STRFTIME('%Y %m', Date);

-- ***** ANSWER *****
-- Calculate our win percent per month
CREATE TABLE Question4 AS
	SELECT MPM.Date, MPM.Year, MPM.Month, WPM.WinCount,
		MPM.MatchCount, ROUND(100 * WPM.WinCount /
		CAST(MPM.MatchCount AS REAL), 2) AS WinPercent
	FROM MatchesPerMonth AS MPM, WinsPerMonth AS WPM
	WHERE MPM.Year = WPM.Year AND MPM.Month = WPM.Month;

-- Validate a sample of the results
SELECT COUNT(*) AS WinsInDec2018
FROM ValidData
WHERE Win = 1 AND STRFTIME('%Y', Date) = '2018'
	AND STRFTIME('%m', Date) = '12';
SELECT COUNT(*) AS MatchesInDec2018
FROM ValidData
WHERE STRFTIME('%Y', Date) = '2018'
	AND STRFTIME('%m', Date) = '12';
SELECT COUNT(*) AS WinsInApr2022
FROM ValidData
WHERE Win = 1 AND STRFTIME('%Y', Date) = '2022'
	AND STRFTIME('%m', Date) = '04';
SELECT COUNT(*) AS MatchesInApr2022
FROM ValidData
WHERE STRFTIME('%Y', Date) = '2022'
	AND STRFTIME('%m', Date) = '04';
	
DROP TABLE MatchesPerMonth;
DROP TABLE WinsPerMonth;


/* End of Question 4 */




/* Question 5: What are Justin's best characters?  What are his worst? */


-- Count the number of wins and matches per RCSCharacter
CREATE TABLE MatchesPerRCSCharacter AS
SELECT RCSCharacter, COUNT(*) AS MatchCount
FROM ValidData
GROUP BY RCSCharacter;
CREATE TABLE WinsPerRCSCharacter AS
SELECT RCSCharacter, COUNT(*) AS WinCount
FROM ValidData
WHERE Win = 1
GROUP BY RCSCharacter;

-- ***** ANSWER *****
-- Calculate Justin's win percent per character
CREATE TABLE Question5 AS
	SELECT MPRCSC.RCSCharacter, WPRCSC.WinCount, MPRCSC.MatchCount,
		ROUND(100 * WPRCSC.WinCount /
		CAST(MPRCSC.MatchCount AS REAL), 2) AS WinPercent
	FROM MatchesPerRCSCharacter AS MPRCSC,
		WinsPerRCSCharacter AS WPRCSC
	WHERE MPRCSC.RCSCharacter = WPRCSC.RCSCharacter
	ORDER BY WinPercent DESC;

-- Validate a sample of the matches
SELECT COUNT(*) AS RCSSamusWins
FROM ValidData
WHERE Win = 1 AND RCSCharacter = 'Samus';
SELECT COUNT(*) AS RCSSamusMatches
FROM ValidData
WHERE RCSCharacter = 'Samus';
SELECT COUNT(*) AS RCSTerryWins
FROM ValidData
WHERE Win = 1 AND RCSCharacter = 'Terry';
SELECT COUNT(*) AS RCSTerryMatches
FROM ValidData
WHERE RCSCharacter = 'Terry';

DROP TABLE MatchesPerRCSCharacter;
DROP TABLE WinsPerRCSCharacter;


/* End of Question 5 */




/* Question 6a: What is our win-rate when Items, Smash Balls, or
    Smash Meter are present in a match?  How does that compare
	with our win-rate when they aren't present? */


-- Count wins and matches when items are and aren't present
CREATE TABLE NumMatchesWithItems AS
	SELECT COUNT(*) AS NumMatches
	FROM ValidData
	WHERE SmashBalls = 1 OR SmashMeter = 1 OR Items = 1;
CREATE TABLE NumWinsWithItems AS
	SELECT COUNT(*) AS NumWins
	FROM ValidData
	WHERE Win = 1 AND (SmashBalls = 1
		OR SmashMeter = 1 OR Items = 1);
CREATE TABLE NumMatchesWithoutItems AS
	SELECT COUNT(*) AS NumMatches
	FROM ValidData
	WHERE SmashBalls = 0 AND SmashMeter = 0 AND Items = 0;
CREATE TABLE NumWinsWithoutItems AS
	SELECT COUNT(*) AS NumWins
	FROM ValidData
	WHERE Win = 1 AND (SmashBalls = 0
		AND SmashMeter = 0 AND Items = 0);
	
-- ***** ANSWER *****
-- Display our win-rates with and without items
CREATE TABLE Question6a AS
	SELECT ROUND(100 * ItemWins.NumWins / CAST(
		ItemMatches.NumMatches AS REAL), 2) AS WinPercentWithItems,
		ROUND(100 * NoItemWins.NumWins / CAST(
		NoItemMatches.NumMatches AS REAL), 2) AS WinPercentWithoutItems
	FROM NumMatchesWithItems AS ItemMatches,
		NumWinsWithItems AS ItemWins,
		NumMatchesWithoutItems AS NoItemMatches,
		NumWinsWithoutItems AS NoItemWins;

DROP TABLE NumMatchesWithItems;
DROP TABLE NumWinsWithItems;
DROP TABLE NumMatchesWithoutItems;
DROP TABLE NumWinsWithoutItems;


/* End of Question 6a */




/* Question 6b: What is our win-rate on a non-standard stage form?
     How does that compare with our win-rate on a standard stage form? */


-- Count wins and matches on standard and non-standard stages
CREATE TABLE NumStandardMatches AS
	SELECT COUNT(*) AS NumMatches
	FROM ValidData
	WHERE StageForm = 'Battlefield' OR StageForm = 'Omega' OR
		StageForm = 'Small Battlefield';
CREATE TABLE NumStandardWins AS
	SELECT COUNT(*) AS NumWins
	FROM ValidData
	WHERE Win = 1 AND (StageForm = 'Battlefield' OR
		StageForm = 'Omega' OR StageForm = 'Small Battlefield');
CREATE TABLE NumNonStandardMatches AS
	SELECT COUNT(*) AS NumMatches
	FROM ValidData
	WHERE StageForm = 'Regular' OR StageForm = 'No Hazards' OR
		StageForm = 'No Hazards?';
CREATE TABLE NumNonStandardWins AS
	SELECT COUNT(*) AS NumWins
	FROM ValidData
	WHERE Win = 1 AND (StageForm = 'Regular' OR
		StageForm = 'No Hazards' OR StageForm = 'No Hazards?');
	
-- ***** ANSWER *****
-- Display our win-rates on non-standard and standard stages
CREATE TABLE Question6b AS
	SELECT ROUND(100 * NSWins.NumWins / CAST(
		NSMatches.NumMatches AS REAL), 2) AS NonStandardWinPercent,
		ROUND(100 * SWins.NumWins / CAST(
		SMatches.NumMatches AS REAL), 2) AS StandardWinPercent
	FROM NumNonStandardMatches AS NSMatches,
		NumNonStandardWins AS NSWins,
		NumStandardMatches AS SMatches,
		NumStandardWins AS SWins;

DROP TABLE NumNonStandardMatches;
DROP TABLE NumNonStandardWins;
DROP TABLE NumStandardMatches;
DROP TABLE NumStandardWins;


/* End of Question 6b */




/* Question 6c: Which of the standard stage
    forms do we perform the best on? */


-- Count wins and matches per standard stage form
CREATE TABLE NumBMatches AS
	SELECT COUNT(*) AS NumMatches
	FROM ValidData
	WHERE StageForm = 'Battlefield';
CREATE TABLE NumBWins AS
	SELECT COUNT(*) AS NumWins
	FROM ValidData
	WHERE Win = 1 AND StageForm = 'Battlefield';
CREATE TABLE NumSBMatches AS
	SELECT COUNT(*) AS NumMatches
	FROM ValidData
	WHERE StageForm = 'Small Battlefield';
CREATE TABLE NumSBWins AS
	SELECT COUNT(*) AS NumWins
	FROM ValidData
	WHERE Win = 1 AND StageForm = 'Small Battlefield';
CREATE TABLE NumOMatches AS
	SELECT COUNT(*) AS NumMatches
	FROM ValidData
	WHERE StageForm = 'Omega';
CREATE TABLE NumOWins AS
	SELECT COUNT(*) AS NumWins
	FROM ValidData
	WHERE Win = 1 AND StageForm = 'Omega';
	
-- ***** ANSWER *****
-- Display our win-rates for each stage form
CREATE TABLE Question6c AS
	SELECT ROUND(100 * BWins.NumWins / CAST(
		BMatches.NumMatches AS REAL), 2) AS BattlefieldWinPercent,
		ROUND(100 * SBWins.NumWins / CAST(
		SBMatches.NumMatches AS REAL), 2) AS SmallBattlefieldWinPercent,
		ROUND(100 * OWins.NumWins / CAST(
		OMatches.NumMatches AS REAL), 2) AS OmegaWinPercent
	FROM NumBMatches AS BMatches, NumBWins AS BWins,
		NumSBMatches AS SBMatches, NumSBWins AS SBWins,
		NumOMatches AS OMatches, NumOWins AS OWins;
	
DROP TABLE NumBMatches;
DROP TABLE NumBWins;
DROP TABLE NumSBMatches;
DROP TABLE NumSBWins;
DROP TABLE NumOMatches;
DROP TABLE NumOWins;


/* End of Question 6c */



DROP TABLE OneMatchPerTeam;
