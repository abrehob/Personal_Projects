-- Copy the raw data into a new table which will contain no nulls
CREATE TABLE DataWithoutNulls AS
SELECT *
FROM RawData;

-- (Change Team and Match columns to INTEGER
-- data types in the database structure)


/* Start of data cleaning - removing null values */


-- Use more descriptive column names
ALTER TABLE DataWithoutNulls
RENAME COLUMN Team TO TeamNum;
ALTER TABLE DataWithoutNulls
RENAME COLUMN Match TO MatchNum;
ALTER TABLE DataWithoutNulls
RENAME COLUMN Form TO StageForm;
ALTER TABLE DataWithoutNulls
RENAME COLUMN WantedForm TO DesiredStageForm;

-- Temporarily rename Common Notes columns
ALTER TABLE DataWithoutNulls
RENAME COLUMN CommonNotes TO CommonNote1;
ALTER TABLE DataWithoutNulls
RENAME COLUMN field18 TO CommonNote2;
ALTER TABLE DataWithoutNulls
RENAME COLUMN field19 TO CommonNote3;
ALTER TABLE DataWithoutNulls
RENAME COLUMN field20 TO CommonNote4;
ALTER TABLE DataWithoutNulls
RENAME COLUMN field21 TO CommonNote5;
ALTER TABLE DataWithoutNulls
RENAME COLUMN field22 TO CommonNote6;
ALTER TABLE DataWithoutNulls
RENAME COLUMN field23 TO CommonNote7;
ALTER TABLE DataWithoutNulls
RENAME COLUMN field24 TO CommonNote8;

-- Remove newlines from cells in Result and OtherNotes columns
UPDATE DataWithoutNulls
SET Result = REPLACE(Result, CHAR(10), ' ');
UPDATE DataWithoutNulls
SET OtherNotes = REPLACE(OtherNotes, CHAR(10), ' ');

-- (Remove 'OTCharacter' column by editing database structure)

-- Transform Common Notes data into a set of booleans
ALTER TABLE DataWithoutNulls
ADD CPU BOOL;
UPDATE DataWithoutNulls
SET CPU =
	(CommonNote1 IS NOT NULL AND CommonNote1 = 'CPU' OR
	CommonNote2 IS NOT NULL AND CommonNote2 = 'CPU' OR
	CommonNote3 IS NOT NULL AND CommonNote3 = 'CPU' OR
	CommonNote4 IS NOT NULL AND CommonNote4 = 'CPU' OR
	CommonNote5 IS NOT NULL AND CommonNote5 = 'CPU' OR
	CommonNote6 IS NOT NULL AND CommonNote6 = 'CPU' OR
	CommonNote7 IS NOT NULL AND CommonNote7 = 'CPU' OR
	CommonNote8 IS NOT NULL AND CommonNote8 = 'CPU' );
ALTER TABLE DataWithoutNulls
ADD Stamina BOOL;
UPDATE DataWithoutNulls
SET Stamina =
	(CommonNote1 IS NOT NULL AND CommonNote1 = 'Stam' OR
	CommonNote2 IS NOT NULL AND CommonNote2 = 'Stam' OR
	CommonNote3 IS NOT NULL AND CommonNote3 = 'Stam' OR
	CommonNote4 IS NOT NULL AND CommonNote4 = 'Stam' OR
	CommonNote5 IS NOT NULL AND CommonNote5 = 'Stam' OR
	CommonNote6 IS NOT NULL AND CommonNote6 = 'Stam' OR
	CommonNote7 IS NOT NULL AND CommonNote7 = 'Stam' OR
	CommonNote8 IS NOT NULL AND CommonNote8 = 'Stam' );
ALTER TABLE DataWithoutNulls
ADD TimeMode BOOL;
UPDATE DataWithoutNulls
SET TimeMode =
	(CommonNote1 IS NOT NULL AND CommonNote1 = 'Time' OR
	CommonNote2 IS NOT NULL AND CommonNote2 = 'Time' OR
	CommonNote3 IS NOT NULL AND CommonNote3 = 'Time' OR
	CommonNote4 IS NOT NULL AND CommonNote4 = 'Time' OR
	CommonNote5 IS NOT NULL AND CommonNote5 = 'Time' OR
	CommonNote6 IS NOT NULL AND CommonNote6 = 'Time' OR
	CommonNote7 IS NOT NULL AND CommonNote7 = 'Time' OR
	CommonNote8 IS NOT NULL AND CommonNote8 = 'Time' );
ALTER TABLE DataWithoutNulls
ADD SmashMeter BOOL;
UPDATE DataWithoutNulls
SET SmashMeter =
	(CommonNote1 IS NOT NULL AND CommonNote1 = 'SM' OR
	CommonNote2 IS NOT NULL AND CommonNote2 = 'SM' OR
	CommonNote3 IS NOT NULL AND CommonNote3 = 'SM' OR
	CommonNote4 IS NOT NULL AND CommonNote4 = 'SM' OR
	CommonNote5 IS NOT NULL AND CommonNote5 = 'SM' OR
	CommonNote6 IS NOT NULL AND CommonNote6 = 'SM' OR
	CommonNote7 IS NOT NULL AND CommonNote7 = 'SM' OR
	CommonNote8 IS NOT NULL AND CommonNote8 = 'SM' );
ALTER TABLE DataWithoutNulls
ADD SmashBalls BOOL;
UPDATE DataWithoutNulls
SET SmashBalls =
	(CommonNote1 IS NOT NULL AND CommonNote1 = 'SB' OR
	CommonNote2 IS NOT NULL AND CommonNote2 = 'SB' OR
	CommonNote3 IS NOT NULL AND CommonNote3 = 'SB' OR
	CommonNote4 IS NOT NULL AND CommonNote4 = 'SB' OR
	CommonNote5 IS NOT NULL AND CommonNote5 = 'SB' OR
	CommonNote6 IS NOT NULL AND CommonNote6 = 'SB' OR
	CommonNote7 IS NOT NULL AND CommonNote7 = 'SB' OR
	CommonNote8 IS NOT NULL AND CommonNote8 = 'SB' );
ALTER TABLE DataWithoutNulls
ADD Items BOOL;
UPDATE DataWithoutNulls
SET Items =
	(CommonNote1 IS NOT NULL AND (CommonNote1 = 'AT' OR
		CommonNote1 = 'PB' OR CommonNote1 = 'I' OR
		CommonNote1 = 'SF' OR CommonNote1 = 'DD') OR
	CommonNote2 IS NOT NULL AND (CommonNote2 = 'AT' OR
		CommonNote2 = 'PB' OR CommonNote2 = 'I' OR
		CommonNote2 = 'SF' OR CommonNote2 = 'DD') OR
	CommonNote3 IS NOT NULL AND (CommonNote3 = 'AT' OR
		CommonNote3 = 'PB' OR CommonNote3 = 'I' OR
		CommonNote3 = 'SF' OR CommonNote3 = 'DD') OR
	CommonNote4 IS NOT NULL AND (CommonNote4 = 'AT' OR
		CommonNote4 = 'PB' OR CommonNote4 = 'I' OR
		CommonNote4 = 'SF' OR CommonNote4 = 'DD') OR
	CommonNote5 IS NOT NULL AND (CommonNote5 = 'AT' OR
		CommonNote5 = 'PB' OR CommonNote5 = 'I' OR
		CommonNote5 = 'SF' OR CommonNote5 = 'DD') OR
	CommonNote6 IS NOT NULL AND (CommonNote6 = 'AT' OR
		CommonNote6 = 'PB' OR CommonNote6 = 'I' OR
		CommonNote6 = 'SF' OR CommonNote6 = 'DD') OR
	CommonNote7 IS NOT NULL AND (CommonNote7 = 'AT' OR
		CommonNote7 = 'PB' OR CommonNote7 = 'I' OR
		CommonNote7 = 'SF' OR CommonNote7 = 'DD') OR
	CommonNote8 IS NOT NULL AND (CommonNote8 = 'AT' OR
		CommonNote8 = 'PB' OR CommonNote8 = 'I' OR
		CommonNote8 = 'SF' OR CommonNote8 = 'DD'));

-- (Remove all Common Note columns by editing database structure)


-- (Check that Match # column is sorted using an external method since it's
-- difficult in SQL and will serve as an ID for the following queries)

-- Replace every NULL date with the previous non-NULL date
CREATE TABLE MatchesWithDates AS
	SELECT MatchNum, Date
	FROM DataWithoutNulls
	WHERE Date IS NOT NULL;
CREATE TABLE DatesForAllMatches AS
	SELECT Data.MatchNum, MWD.Date
	FROM DataWithoutNulls AS Data, MatchesWithDates AS MWD
	WHERE MWD.MatchNum =
		(SELECT MAX(MWD.MatchNum)
		FROM MatchesWithDates AS MWD
		WHERE Data.MatchNum >= MWD.MatchNum);
UPDATE DataWithoutNulls
SET Date =
	(SELECT DatesForAllMatches.Date
	FROM DatesForAllMatches
	WHERE DatesForAllMatches.MatchNum = DataWithoutNulls.MatchNum);
DROP TABLE MatchesWithDates;
DROP TABLE DatesForAllMatches;

-- Replace every NULL location with the previous non-NULL location
CREATE TABLE MatchesWithLocations AS
	SELECT MatchNum, Location
	FROM DataWithoutNulls
	WHERE Location IS NOT NULL;
CREATE TABLE LocationsForAllMatches AS
	SELECT Data.MatchNum, MWL.Location
	FROM DataWithoutNulls AS Data, MatchesWithLocations AS MWL
	WHERE MWL.MatchNum =
		(SELECT MAX(MWL.MatchNum)
		FROM MatchesWithLocations AS MWL
		WHERE Data.MatchNum >= MWL.MatchNum);
UPDATE DataWithoutNulls
SET Location =
	(SELECT LocationsForAllMatches.Location
	FROM LocationsForAllMatches
	WHERE LocationsForAllMatches.MatchNum = DataWithoutNulls.MatchNum);
DROP TABLE MatchesWithLocations;
DROP TABLE LocationsForAllMatches;

-- Replace every NULL team # with the previous non-NULL team #
CREATE TABLE MatchesWithTeamNums AS
	SELECT MatchNum, TeamNum
	FROM DataWithoutNulls
	WHERE TeamNum IS NOT NULL;
CREATE TABLE TeamNumsForAllMatches AS
	SELECT Data.MatchNum, MWTN.TeamNum
	FROM DataWithoutNulls AS Data, MatchesWithTeamNums AS MWTN
	WHERE MWTN.MatchNum =
		(SELECT MAX(MWTN.MatchNum)
		FROM MatchesWithTeamNums AS MWTN
		WHERE Data.MatchNum >= MWTN.MatchNum);
UPDATE DataWithoutNulls
SET TeamNum =
	(SELECT TeamNumsForAllMatches.TeamNum
	FROM TeamNumsForAllMatches
	WHERE TeamNumsForAllMatches.MatchNum = DataWithoutNulls.MatchNum);
DROP TABLE MatchesWithTeamNums;
DROP TABLE TeamNumsForAllMatches;

-- Replace every NULL P3 character with the previous non-NULL P3 character
CREATE TABLE MatchesWithP3Characters AS
	SELECT MatchNum, P3Character
	FROM DataWithoutNulls
	WHERE P3Character IS NOT NULL;
CREATE TABLE P3CharactersForAllMatches AS
	SELECT Data.MatchNum, MWP3C.P3Character
	FROM DataWithoutNulls AS Data, MatchesWithP3Characters AS MWP3C
	WHERE MWP3C.MatchNum =
		(SELECT MAX(MWP3C.MatchNum)
		FROM MatchesWithP3Characters AS MWP3C
		WHERE Data.MatchNum >= MWP3C.MatchNum);
UPDATE DataWithoutNulls
SET P3Character =
	(SELECT P3CharactersForAllMatches.P3Character
	FROM P3CharactersForAllMatches
	WHERE P3CharactersForAllMatches.MatchNum = DataWithoutNulls.MatchNum);
DROP TABLE MatchesWithP3Characters;
DROP TABLE P3CharactersForAllMatches;

-- Replace every NULL P4 character with the previous non-NULL P4 character
CREATE TABLE MatchesWithP4Characters AS
	SELECT MatchNum, P4Character
	FROM DataWithoutNulls
	WHERE P4Character IS NOT NULL;
CREATE TABLE P4CharactersForAllMatches AS
	SELECT Data.MatchNum, MWP4C.P4Character
	FROM DataWithoutNulls AS Data, MatchesWithP4Characters AS MWP4C
	WHERE MWP4C.MatchNum =
		(SELECT MAX(MWP4C.MatchNum)
		FROM MatchesWithP4Characters AS MWP4C
		WHERE Data.MatchNum >= MWP4C.MatchNum);
UPDATE DataWithoutNulls
SET P4Character =
	(SELECT P4CharactersForAllMatches.P4Character
	FROM P4CharactersForAllMatches
	WHERE P4CharactersForAllMatches.MatchNum = DataWithoutNulls.MatchNum);
DROP TABLE MatchesWithP4Characters;
DROP TABLE P4CharactersForAllMatches;


-- For every cell in the P1 column, replace every '*' with an empty string
-- (ex. 'OT*' becomes 'OT'), replace all cells that contain just an empty string
-- with NULL, and fill all NULLs with the previous non-NULL value
UPDATE DataWithoutNulls
SET P1 = SUBSTR(P1, 1, INSTR(P1, '*') - 1)
WHERE P1 LIKE '%*';
UPDATE DataWithoutNulls
SET P1 = NULL
WHERE P1 = '';
CREATE TABLE MatchesWithP1s AS
	SELECT MatchNum, P1
	FROM DataWithoutNulls
	WHERE P1 IS NOT NULL;
CREATE TABLE P1sForAllMatches AS
	SELECT Data.MatchNum, MWP1.P1
	FROM DataWithoutNulls AS Data, MatchesWithP1s AS MWP1
	WHERE MWP1.MatchNum =
		(SELECT MAX(MWP1.MatchNum)
		FROM MatchesWithP1s AS MWP1
		WHERE Data.MatchNum >= MWP1.MatchNum);
UPDATE DataWithoutNulls
SET P1 =
	(SELECT P1sForAllMatches.P1
	FROM P1sForAllMatches
	WHERE P1sForAllMatches.MatchNum = DataWithoutNulls.MatchNum);
DROP TABLE MatchesWithP1s;
DROP TABLE P1sForAllMatches;

-- For every cell in the P2 column, replace every '*' with an empty string
-- (ex. 'OT*' becomes 'OT'), replace all cells that contain just an empty string
-- with NULL, and fill all NULLs with the previous non-NULL value
UPDATE DataWithoutNulls
SET P2 = SUBSTR(P2, 1, INSTR(P2, '*') - 1)
WHERE P2 LIKE '%*';
UPDATE DataWithoutNulls
SET P2 = NULL
WHERE P2 = '';
CREATE TABLE MatchesWithP2s AS
	SELECT MatchNum, P2
	FROM DataWithoutNulls
	WHERE P2 IS NOT NULL;
CREATE TABLE P2sForAllMatches AS
	SELECT Data.MatchNum, MWP2.P2
	FROM DataWithoutNulls AS Data, MatchesWithP2s AS MWP2
	WHERE MWP2.MatchNum =
		(SELECT MAX(MWP2.MatchNum)
		FROM MatchesWithP2s AS MWP2
		WHERE Data.MatchNum >= MWP2.MatchNum);
UPDATE DataWithoutNulls
SET P2 =
	(SELECT P2sForAllMatches.P2
	FROM P2sForAllMatches
	WHERE P2sForAllMatches.MatchNum = DataWithoutNulls.MatchNum);
DROP TABLE MatchesWithP2s;
DROP TABLE P2sForAllMatches;


-- For every cell containing NULL in the P3Color column,
-- fill it with 'Default' if the previous non-NULL value is from a row with
-- a different Team #, otherwise fill it with the previous non-NULL value
CREATE TABLE P3ColorPerTeam AS
	SELECT TeamNum, P3Color
	FROM DataWithoutNulls
	WHERE P3Color IS NOT NULL;
UPDATE DataWithoutNulls
SET P3Color = 'Default'
WHERE TeamNum NOT IN
	(SELECT TeamNum
	FROM P3ColorPerTeam);
UPDATE DataWithoutNulls
SET P3Color =
	(SELECT P3ColorPerTeam.P3Color
	FROM P3ColorPerTeam
	WHERE P3ColorPerTeam.TeamNum = DataWithoutNulls.TeamNum)
WHERE P3Color IS NULL;
DROP TABLE P3ColorPerTeam;

-- For every cell containing NULL in the P4Color column,
-- fill it with 'Default' if the previous non-NULL value is from a row with
-- a different Team #, otherwise fill it with the previous non-NULL value
CREATE TABLE P4ColorPerTeam AS
	SELECT TeamNum, P4Color
	FROM DataWithoutNulls
	WHERE P4Color IS NOT NULL;
UPDATE DataWithoutNulls
SET P4Color = 'Default'
WHERE TeamNum NOT IN
	(SELECT TeamNum
	FROM P4ColorPerTeam);
UPDATE DataWithoutNulls
SET P4Color =
	(SELECT P4ColorPerTeam.P4Color
	FROM P4ColorPerTeam
	WHERE P4ColorPerTeam.TeamNum = DataWithoutNulls.TeamNum)
WHERE P4Color IS NULL;
DROP TABLE P4ColorPerTeam;


-- Replace every NULL in the RCSCharacter and OtherNotes columns
-- with the string, 'N/A'
UPDATE DataWithoutNulls
SET RCSCharacter = 'N/A'
WHERE RCSCharacter IS NULL;
UPDATE DataWithoutNulls
SET OtherNotes = 'N/A'
WHERE OtherNotes IS NULL;


/* End of data cleaning - removing null values */




/* Start of data cleaning - finding and fixing errors */


-- Copy the data without nulls into a new table which will contain no errors
CREATE TABLE DataWithoutErrors AS
SELECT *
FROM DataWithoutNulls;

-- Check that all dates are within range and are always non-strictly increasing
SELECT MatchNum, MIN(Date)
FROM DataWithoutErrors;
SELECT MatchNum, MAX(Date)
FROM DataWithoutErrors;
SELECT D1.MatchNum AS Match1, D1.Date AS Date1,
	D2.MatchNum AS Match2, D2.Date AS Date2
FROM DataWithoutErrors AS D1, DataWithoutErrors AS D2
WHERE D1.MatchNum + 1 = D2.MatchNum AND D1.Date > D2.Date;

-- Check Location, P1, P2, and RCS Character columns for invalid values
SELECT DISTINCT Location
FROM DataWithoutErrors;
SELECT DISTINCT P1
FROM DataWithoutErrors;
SELECT DISTINCT P2
FROM DataWithoutErrors;
SELECT DISTINCT RCSCharacter
FROM DataWithoutErrors;


-- Check that all Team #s are within range and are always non-strictly increasing
SELECT MatchNum, MIN(TeamNum)
FROM DataWithoutErrors;
SELECT MatchNum, MAX(TeamNum)
FROM DataWithoutErrors;
SELECT D1.MatchNum AS Match1, D1.TeamNum AS TeamNum1,
	D2.MatchNum AS Match2, D2.TeamNum AS TeamNum2
FROM DataWithoutErrors AS D1, DataWithoutErrors AS D2
WHERE D1.MatchNum + 1 = D2.MatchNum AND D1.TeamNum > D2.TeamNum;

-- Team # decreases from index 10181 to 10182, so find the exact culprit
SELECT MatchNum, TeamNum
FROM DataWithoutErrors
WHERE MatchNum >= 10180 AND MatchNum <= 10183;

-- Team #6929 was incorrectly recorded as #6292, so fix that
UPDATE DataWithoutErrors
SET TeamNum = 6929
WHERE MatchNum = 10182;

-- Check that the data is now sorted
SELECT D1.MatchNum AS Match1, D1.TeamNum AS TeamNum1,
	D2.MatchNum AS Match2, D2.TeamNum AS TeamNum2
FROM DataWithoutErrors AS D1, DataWithoutErrors AS D2
WHERE D1.MatchNum + 1 = D2.MatchNum AND D1.TeamNum > D2.TeamNum;


-- Check P3Character and P4Character columns for invalid values
SELECT DISTINCT P3Character
FROM DataWithoutErrors;
SELECT DISTINCT P4Character
FROM DataWithoutErrors;

-- There is at least one 'RIchter' in the P3Character column,
-- replace it/them with 'Richter'
UPDATE DataWithoutErrors
SET P3Character = 'Richter'
WHERE P3Character = 'RIchter';

-- Confirm that there are now only 86 unique characters for P3
SELECT COUNT(DISTINCT P3Character)
FROM DataWithoutErrors;


-- View possible P3 and P4 colors
SELECT DISTINCT P3Color
FROM DataWithoutErrors;
SELECT DISTINCT P4Color
FROM DataWithoutErrors;

-- Check Stage Form and Desired Stage Form columns for invalid values
SELECT DISTINCT StageForm
FROM DataWithoutErrors;
SELECT DISTINCT DesiredStageForm
FROM DataWithoutErrors;

-- Check that Stage column contains only valid values, Small Battlefield stage
-- always has Small Battlefield form, and Battlefield and Final Destination only
-- have Battlefield or Omega forms
SELECT DISTINCT Stage
FROM DataWithoutErrors;
SELECT Stage, StageForm
FROM DataWithoutErrors
WHERE Stage = 'Small Battlefield' AND StageForm <> 'Small Battlefield';
SELECT Stage, StageForm
FROM DataWithoutErrors
WHERE (Stage = 'Battlefield' AND StageForm <> 'Battlefield' AND
	StageForm <> 'Omega') OR (Stage = 'Final Destination' AND
	StageForm <> 'Battlefield' AND StageForm <> 'Omega');

-- (Check that CPU, Stamina, Time Mode, Smash Meter, Smash Balls, and Items
-- columns are of type BOOL according to the database structure)


-- Check Result column for invalid values
SELECT DISTINCT Result
FROM DataWithoutErrors;

-- At least one match has a result of '--1', replace it/them with '-1'
UPDATE DataWithoutErrors
SET Result = '-1'
WHERE Result = '--1';

-- Confirm that there are no more matches with a result of '--1'
SELECT MatchNum, Result
FROM DataWithoutErrors
WHERE Result = '--1';


-- View possible values in OtherNotes column
SELECT DISTINCT OtherNotes
FROM DataWithoutErrors;


/* End of data cleaning - finding and fixing errors */




/* Start of cleaning verification -
non-NULL values were not erroneously altered */


-- Check that non-NULL values in the Date and Location columns
-- for the raw data are unchanged in the cleaned data
SELECT RD.Date AS OldDate, DWE.Date AS NewDate
FROM RawData AS RD, DataWithoutErrors DWE
WHERE RD.Match = DWE.MatchNum AND
	RD.Date IS NOT NULL AND RD.Date <> DWE.Date;
SELECT RD.Location AS OldLocation, DWE.Location AS NewLocation
FROM RawData AS RD, DataWithoutErrors DWE
WHERE RD.Match = DWE.MatchNum AND
	RD.Location IS NOT NULL AND RD.Location <> DWE.Location;

-- Check that non-NULL values in the P1 and P2 columns for the raw data
-- are unchanged in the cleaned data, excluding entries with *s
SELECT RD.P1 AS OldP1, DWE.P1 AS NewP1
FROM RawData AS RD, DataWithoutErrors DWE
WHERE RD.Match = DWE.MatchNum AND RD.P1 IS NOT NULL AND
	RD.P1 NOT LIKE  '%*' AND RD.P1 <> DWE.P1;
SELECT RD.P2 AS OldP2, DWE.P2 AS NewP2
FROM RawData AS RD, DataWithoutErrors DWE
WHERE RD.Match = DWE.MatchNum AND RD.P2 IS NOT NULL AND
	RD.P2 NOT LIKE  '%*' AND RD.P2 <> DWE.P2;

-- Check that non-NULL values in the RCSCharacter column
-- for the raw data are unchanged in the cleaned data
SELECT RD.RCSCharacter AS OldRCSCharacter,
	DWE.RCSCharacter AS NewRCSCharacter
FROM RawData AS RD, DataWithoutErrors DWE
WHERE RD.Match = DWE.MatchNum AND
	RD.RCSCharacter IS NOT NULL AND
	RD.RCSCharacter <> DWE.RCSCharacter;

-- Check that non-NULL values in the Team(Num) column for the raw data
-- are unchanged in the cleaned data, excluding the erroneous Team #6292
SELECT RD.Team AS OldTeamNum, DWE.TeamNum AS NewTeamNum
FROM RawData AS RD, DataWithoutErrors DWE
WHERE RD.Match = DWE.MatchNum AND RD.Team <> 6292 AND
	RD.Team IS NOT NULL AND RD.Team <> DWE.TeamNum;

-- Check that non-NULL values in the P3Character column for the raw data
-- are unchanged in the cleaned data, excluding the erroneous 'RIchter'
SELECT RD.P3Character AS OldP3Character,
	DWE.P3Character AS NewP3Character
FROM RawData AS RD, DataWithoutErrors DWE
WHERE RD.Match = DWE.MatchNum AND RD.P3Character <> 'RIchter' AND
	RD.P3Character IS NOT NULL AND RD.P3Character <> DWE.P3Character;

-- Check that non-NULL values in the P4Character, P3Color, and P4Color
-- columns for the raw data are unchanged in the cleaned data
SELECT RD.P4Character AS OldP4Character,
	DWE.P4Character AS NewP4Character
FROM RawData AS RD, DataWithoutErrors DWE
WHERE RD.Match = DWE.MatchNum AND
	RD.P4Character IS NOT NULL AND RD.P4Character <> DWE.P4Character;
SELECT RD.P3Color AS OldP3Color, DWE.P3Color AS NewP3Color
FROM RawData AS RD, DataWithoutErrors DWE
WHERE RD.Match = DWE.MatchNum AND
	RD.P3Color IS NOT NULL AND RD.P3Color <> DWE.P3Color;
SELECT RD.P4Color AS OldP4Color, DWE.P4Color AS NewP4Color
FROM RawData AS RD, DataWithoutErrors DWE
WHERE RD.Match = DWE.MatchNum AND
	RD.P4Color IS NOT NULL AND RD.P4Color <> DWE.P4Color;

-- Check that values in the Result column for the raw data are
-- unchanged in the cleaned data, excluding rows that contained
-- newlines or the erroneous '--1'
SELECT RD.Result AS OldResult, DWE.Result AS NewResult
FROM RawData AS RD, DataWithoutErrors DWE
WHERE RD.Match = DWE.MatchNum AND
	RD.Result NOT LIKE '%' || X'0A' || '%' AND RD.Result <> '--1' AND
	RD.Result IS NOT NULL AND RD.Result <> DWE.Result;

-- Check that values in the (Stage)Form, (DesiredStage/Wanted)Form,
-- and Stage columns for the raw data are unchanged in the cleaned data
SELECT RD.Form AS OldStageForm, DWE.StageForm AS NewStageForm
FROM RawData AS RD, DataWithoutErrors DWE
WHERE RD.Match = DWE.MatchNum AND RD.Form <> DWE.StageForm;
SELECT RD.WantedForm AS OldDesiredForm,
	DWE.DesiredStageForm AS NewDesiredForm
FROM RawData AS RD, DataWithoutErrors DWE
WHERE RD.Match = DWE.MatchNum AND
	RD.WantedForm <> DWE.DesiredStageForm;
SELECT RD.Stage AS OldStage, DWE.Stage AS NewStage
FROM RawData AS RD, DataWithoutErrors DWE
WHERE RD.Match = DWE.MatchNum AND RD.Stage <> DWE.Stage;

-- Check that non-NULL values in the Other Notes column for the raw data
-- are unchanged in the cleaned data, excluding rows that contained newlines
SELECT RD.OtherNotes AS OldOtherNotes,
	DWE.OtherNotes AS NewOtherNotes
FROM RawData AS RD, DataWithoutErrors DWE
WHERE RD.Match = DWE.MatchNum AND
	RD.OtherNotes NOT LIKE '%' || X'0A' || '%' AND
	RD.OtherNotes IS NOT NULL AND RD.OtherNotes <> DWE.OtherNotes;


/* End of cleaning verification - 
non-NULL values were not erroneously altered */




/* Start of cleaning verification - NULL values were altered correctly */


-- Check that NULL values in the Date, Location, P1, P2,
-- and Team(Num) columns for the data are changed to match
-- the value in the previous row in the cleaned data
SELECT DWE2.Date AS PrevDate, DWE1.Date
FROM RawData AS RD, DataWithoutErrors DWE1,
	DataWithoutErrors DWE2
WHERE RD.Match = DWE1.MatchNum AND RD.Date IS NULL AND
	DWE1.MatchNum = DWE2.MatchNum + 1 AND DWE1.Date <> DWE2.Date;
SELECT DWE2.Location AS PrevLocation, DWE1.Location
FROM RawData AS RD, DataWithoutErrors DWE1,
	DataWithoutErrors DWE2
WHERE RD.Match = DWE1.MatchNum AND RD.Location IS NULL AND
	DWE1.MatchNum = DWE2.MatchNum + 1 AND
	DWE1.Location <> DWE2.Location;
SELECT DWE2.P1 AS PrevP1, DWE1.P1
FROM RawData AS RD, DataWithoutErrors DWE1,
	DataWithoutErrors DWE2
WHERE RD.Match = DWE1.MatchNum AND RD.P1 IS NULL AND
	DWE1.MatchNum = DWE2.MatchNum + 1 AND DWE1.P1 <> DWE2.P1;
SELECT DWE2.P2 AS PrevP2, DWE1.P2
FROM RawData AS RD, DataWithoutErrors DWE1,
	DataWithoutErrors DWE2
WHERE RD.Match = DWE1.MatchNum AND RD.P2 IS NULL AND
	DWE1.MatchNum = DWE2.MatchNum + 1 AND DWE1.P2 <> DWE2.P2;
SELECT DWE2.TeamNum AS PrevTeamNum, DWE1.TeamNum
FROM RawData AS RD, DataWithoutErrors DWE1,
	DataWithoutErrors DWE2
WHERE RD.Match = DWE1.MatchNum AND RD.Team IS NULL AND
	DWE1.MatchNum = DWE2.MatchNum + 1 AND
	DWE1.TeamNum <> DWE2.TeamNum;

-- Check that NULL values in the RCSCharacter and OtherNotes columns
-- for the raw data are changed to 'N/A' in the cleaned data
SELECT DWE.RCSCharacter
FROM RawData AS RD, DataWithoutErrors DWE
WHERE RD.Match = DWE.MatchNum AND
	RD.RCSCharacter IS NULL AND DWE.RCSCharacter <> 'N/A';
SELECT DWE.OtherNotes
FROM RawData AS RD, DataWithoutErrors DWE
WHERE RD.Match = DWE.MatchNum AND
	RD.OtherNotes IS NULL AND DWE.OtherNotes <> 'N/A';

-- Check that NULL values in the P3Character and P4Character columns for the
-- raw data are changed to match the value in the previous row in the cleaned data
SELECT DWE2.P3Character AS PrevP3Character, DWE1.P3Character
FROM RawData AS RD, DataWithoutErrors DWE1,
	DataWithoutErrors DWE2
WHERE RD.Match = DWE1.MatchNum AND RD.P3Character IS NULL AND
	DWE1.MatchNum = DWE2.MatchNum + 1 AND
	DWE1.P3Character <> DWE2.P3Character;
SELECT DWE2.P4Character AS PrevP4Character, DWE1.P4Character
FROM RawData AS RD, DataWithoutErrors DWE1,
	DataWithoutErrors DWE2
WHERE RD.Match = DWE1.MatchNum AND RD.P4Character IS NULL AND
	DWE1.MatchNum = DWE2.MatchNum + 1 AND
	DWE1.P4Character <> DWE2.P4Character;


-- Check that NULL values in the P3Color and P4Color columns for the raw data
-- are either changed to 'Default' or the value in the previous row in the cleaned data
SELECT DWE2.P3Color AS PrevP3Color, DWE1.P3Color,
	DWE1.MatchNum, DWE1.TeamNum
FROM RawData AS RD, DataWithoutErrors DWE1,
	DataWithoutErrors DWE2
WHERE RD.Match = DWE1.MatchNum AND RD.P3Color IS NULL AND
	DWE1.MatchNum = DWE2.MatchNum + 1 AND
	DWE1.P3Color <> 'Default' AND DWE1.P3Color <> DWE2.P3Color;
SELECT DWE2.P4Color AS PrevP4Color, DWE1.P4Color
FROM RawData AS RD, DataWithoutErrors DWE1,
	DataWithoutErrors DWE2
WHERE RD.Match = DWE1.MatchNum AND RD.P4Color IS NULL AND
	DWE1.MatchNum = DWE2.MatchNum + 1 AND
	DWE1.P4Color <> 'Default' AND DWE1.P4Color <> DWE2.P4Color;

-- An interesting error has been revealed!  Match #10182 has P3Color set to
-- 'White' instead of 'Default'.  This is because the process for setting
-- NULL P3Colors involves checking the color associated with another match
-- with the same Team #, and Match #10182 originally had an incorrect
-- Team # of 6292 instead of 6929.  Turns out I should have resolved errors
-- before resolving NULLs!  Here's the fix:
UPDATE DataWithoutErrors
SET P3Color = 'Default'
WHERE MatchNum = 10182;

-- Check that the fix solved the issue
SELECT DWE2.P3Color AS PrevP3Color, DWE1.P3Color
FROM RawData AS RD, DataWithoutErrors DWE1,
	DataWithoutErrors DWE2
WHERE RD.Match = DWE1.MatchNum AND RD.P3Color IS NULL AND
	DWE1.MatchNum = DWE2.MatchNum + 1 AND
	DWE1.P3Color <> 'Default' AND DWE1.P3Color <> DWE2.P3Color;


-- Check that all matches where CPU is TRUE in the clean data had 'CPU' marked
-- in one of the Common Notes columns in the raw data.  Similarly,
-- check that all matches where CPU is FALSE in the clean data didn't have
-- 'CPU' in any of the Common Notes columns in the raw data
SELECT RD.Match, RD.CommonNotes, RD.field18, RD.field19,
	RD.field20, RD.field21, RD.field22, RD.field23, RD.field24, DWE.CPU
FROM RawData AS RD, DataWithoutErrors DWE
WHERE RD.Match = DWE.MatchNum AND DWE.CPU AND
	(RD.CommonNotes IS NULL OR RD.CommonNotes <> 'CPU') AND
	(RD.field18 IS NULL OR RD.field18 <> 'CPU') AND
	(RD.field19 IS NULL OR RD.field19 <> 'CPU') AND
	(RD.field20 IS NULL OR RD.field20 <> 'CPU') AND
	(RD.field21 IS NULL OR RD.field21 <> 'CPU') AND
	(RD.field22 IS NULL OR RD.field22 <> 'CPU') AND
	(RD.field23 IS NULL OR RD.field23 <> 'CPU') AND
	(RD.field24 IS NULL OR RD.field24 <> 'CPU');
SELECT RD.Match, RD.CommonNotes, RD.field18, RD.field19,
	RD.field20, RD.field21, RD.field22, RD.field23, RD.field24, DWE.CPU
FROM RawData AS RD, DataWithoutErrors DWE
WHERE RD.Match = DWE.MatchNum AND NOT DWE.CPU AND
	((RD.CommonNotes IS NOT NULL AND RD.CommonNotes = 'CPU') OR
	(RD.field18 IS NOT NULL AND RD.field18 = 'CPU') OR
	(RD.field19 IS NOT NULL AND RD.field19 = 'CPU') OR
	(RD.field20 IS NOT NULL AND RD.field20 = 'CPU') OR
	(RD.field21 IS NOT NULL AND RD.field21 = 'CPU') OR
	(RD.field22 IS NOT NULL AND RD.field22 = 'CPU') OR
	(RD.field23 IS NOT NULL AND RD.field23 = 'CPU') OR
	(RD.field24 IS NOT NULL AND RD.field24 = 'CPU'));

-- (Perform similar checks as above but for the Stamina, TimeMode,
-- SmashMeter, SmashBalls, and Items columns.  Queries are not included
-- here so these checks don't take up 1/3 of this file)


/* End of cleaning verification - NULL values were altered correctly */
