###################################################################
###################################################################
-- Goal: Exploring Different SQL String Functions to Clean Data
###################################################################
###################################################################


-- CREATE Database and call it The Office


##############################################################
-- Task One: Creating Our Tables
-- We will be creating two tables, one called series and the 
-- second called actors.
##############################################################

-- 1.1 - Create the series table and import the data.
CREATE TABLE series
(	Series_id SERIAL PRIMARY KEY,
	Season CHAR(1), 
	EpisodeTitle VARCHAR(255), 
	About VARCHAR(1000), 
	Ratings NUMERIC, 
	Votes INTEGER, 
	Viewership NUMERIC, 
	Duration INTEGER, 
	Dates DATE,
	GuestStars VARCHAR(255), 
	Director VARCHAR(255), 
	Writers VARCHAR(255) 
);
-- Then the data was imported via a CSV file. 
-- Next, I retreived the series table to ensure data was imported. 
SELECT * FROM series

-- 1.2 - Create the actor table and import the data. 
CREATE TABLE actors (
	actor_id SERIAL PRIMARY KEY, 
	Main_char VARCHAR(255),
	First_name VARCHAR(255),
	Last_name VARCHAR(255),
	Age INTEGER, 
	Gender CHAR(1), 
	Birthday DATE
);

SELECT * FROM actors

-- Import data via CSV file into actors table and then retrieve table to ensure data was imported sucessfully.
SELECT * FROM actors

-- 1.3 - Create the character table and import the data. 
CREATE TABLE character (
	actor_id SERIAL PRIMARY KEY,
	char_id CHAR(6),
	Main_char VARCHAR(255),
	First_name VARCHAR(255),
	Last_name VARCHAR(255),
	Age INTEGER, 
	Gender CHAR(1), 
	Birthday DATE
);

-- Import data via CSV file into character table and then retrieve table to ensure data was imported sucessfully.
SELECT * FROM character


-- 1.4 - Create the middlename table and import the data. 
CREATE TABLE middlename (
	actor_id SERIAL PRIMARY KEY,
	First_name VARCHAR(255),
	Middle_name VARCHAR(255),
	Last_name VARCHAR(255),
	Age INTEGER, 
	Gender CHAR(1)
);

-- Import data via CSV file into middlename table and then retrieve table to ensure data was imported sucessfully.
SELECT * FROM middlename

#################################################################################################
-- Task Two: Using the LENGTH, LEFT, and RIGHT Functions
-- In this task, we will be using the LENGTH function to return the 
-- length of a specified string, expressed as the number of characters.
-- In addition, we will be using the LEFT/RIGHT functions to pull a certain number of characters 
-- from the left or right side of a string and present them as a separate string.
#################################################################################################

-- 2.1: Retrieve data from the series table
SELECT * FROM actors;

-- 2.2: Find the length of the first name of the male actors
SELECT first_name, length(first_name) AS character_num, gender
FROM actors
WHERE gender = 'M'

-- 2.3: Find the length of the first name of the male actors
-- where the length of the first name is greater than 5
SELECT first_name, length(first_name) AS character_num, gender
FROM actors
WHERE gender = 'M'
AND length(first_name) > 5
ORDER by length(first_name)

-- 2.4: Retrieve the first letter of each main character. 
SELECT main_char, LEFT(main_char, 1) AS char_letter
FROM actors

-- 2.5: Retrieve a main character's first name only!
-- NOTE: we are retreiving Michael Scott's first name only.
SELECT main_char, LEFT(main_char, 7) AS char_letter
FROM actors
WHERE main_char = 'Michael Scott'

-- 2.6: Retrieve a main character's last name only!
-- NOTE: we are retreiving Michael Scott's first name only.
SELECT main_char, RIGHT(main_char, 5) AS char_letter
FROM actors
WHERE main_char = 'Michael Scott'

SELECT * FROM actors

-- 2.7: Retrieve the length of the main character column
SELECT main_char, LENGTH(main_char)
FROM actors

-- 2.8: Retrieve first name of the main character using LEFT/RIGHT and LENGTH.
-- using Michael Scott only. 
SELECT main_char, LEFT(main_char, LENGTH(main_char)-6) AS first_name 
FROM actors
WHERE main_char = 'Michael Scott'
--OR
SELECT main_char, Right(main_char, LENGTH(main_char)-8) AS first_name 
FROM actors
WHERE main_char = 'Michael Scott'


###############################################################################
-- Task Three: Using the UPPER & LOWER Functions
-- In this task, we will be using the UPPER and LOWER functions to convert all 
-- characters in the specified string to uppercase or lowercase.
###############################################################################

-- 3.1: Change The Office to uppercase letters
SELECT UPPER ('The Office')

-- 3.2: Change The Office to lowercase letters
SELECT LOWER ('THE OFFICE')

-- 3.3: Retrieve the details of only the first actor. 
SELECT * FROM actors
WHERE actor_id = '1'

-- Start a transaction
BEGIN;

-- 3.4: Change the first name of the first actor to uppercase letters
UPDATE actors
SET first_name = UPPER(first_name)
WHERE actor_id = '1'

-- Rollback to the previous step
ROLLBACK;


####################################################################
-- Task Four: Using the REPLACE Function
-- In this task, we will use the REPLACE function to replace all
-- occurrences of a specified string. 
####################################################################

-- 4.1: Change M to Male in the gender column of the actors table
SELECT first_name, last_name, gender, REPLACE (gender, 'M', 'Male') AS actor_gender
FROM actors

-- 4.2: Change F to Female in the gender column of the actors table
SELECT first_name, last_name, gender, REPLACE (gender, 'F', 'Female') AS actor_gender
FROM actors

-- 4.3: Retrieve data from the series table
SELECT * FROM series;

-- 4.4: Change Pilot to one in the episodetitle column of the actors table 
-- (if you can't tell if the casing is upper or lower, you can do as demonstrated below to change the casing)
SELECT season, episodetitle, REPLACE (LOWER(episodetitle), 'pilot', 'One')
FROM series


##############################################################
-- Task Five: Using the TRIM, RTRIM,and LTRIM Function
-- In this task, we will be using the TRIM functions to remove
-- all specified characters either parts of a string.
##############################################################

-- 5.1: Trim the word The Office using 'leading'
SELECT TRIM(leading ' ' FROM ' The Office ')

-- 5.2: Trim the word The Office using 'trailing'
SELECT TRIM(trailing ' ' FROM ' The Office ')

-- 5.3: Trim the word The Office using 'both'
SELECT TRIM(both ' ' FROM ' The Office ')

-- 5.4: Trim the word The Office using just 'trim'
-- NOTE: using just 'trim' is the same as when using 'both'.
SELECT TRIM(' The Office ')

-- 5.5: Right trim the word The Office
-- NOTE: using 'Right' trim is the same as using 'trailing' trim.
SELECT RTRIM(' The Office ')

-- 5.6: Left trim the word The Office
-- NOTE: using 'Left' trim is the same as using 'leading' trim.
SELECT LTRIM(' The Office ')

-- 5.7: Retrieve data from the customers table
SELECT * FROM series;

-- 5.8: Remove the word 'Day' from the title in the episodetitle column
SELECT episodetitle, RTRIM(episodetitle, 'Day') AS no_day
FROM series
WHERE series_id = '2'


##############################################
-- Task Six: Using the Concatenation Function
-- In this task, we will join or concatenate 
-- two or more strings together
##############################################

-- 6.1: Create a new column called Full_Name from the first_name and last_name of the actors
SELECT actor_id, first_name, last_name, first_name||' '||last_name AS full_name 
FROM actors

SELECT * FROM series

-- 6.2: Create a new column called episode from the season, episodetitle, and about of the series table
SELECT series_id, season||', '||episodetitle||' - '|| about AS episode
FROM series

-- 6.3: Create a column called desc_age (description of age) from the actors first_name and age
SELECT actor_id, CONCAT(first_name, ' is ', age, ' years old.') AS age_desc
FROM actors


############################################
-- Task Seven: Using the SUBSTRING Function
-- In this task, we will learn extract a
-- substring from a string
############################################

-- 7.1: Retrieve data from the character table
SELECT * FROM character;

-- 7.2: Retrieve the character group, main_char, first_name, and last_name.
-- Hint: Use the char_id column to retrieve the character group.
SELECT char_id, main_char, first_name, last_name,
SUBSTRING (char_id FOR 2) AS char_group
FROM character

-- 7.3: Retrieve the IDs, names of main characters in the character group 'BG'
SELECT char_id, main_char, 
SUBSTRING (char_id FOR 2) AS char_group
FROM character
WHERE SUBSTRING (char_id FOR 2) = 'BG'

-- 7.4: Retrieve the IDs, names of main characters, and character number of char_id in the character group 'BG'
SELECT char_id, main_char, 
SUBSTRING (char_id FROM 4 FOR 3) AS char_num
FROM character
WHERE SUBSTRING (char_id FOR 2) = 'BG'

-- 7.5: Retrieve the year of birth for all the actors
-- NOTE: we must CAST birthday as it's datatype is currently Date.
-- REMEBER: the inner-most function will be executed first. 
SELECT actor_id, main_char,  
SUBSTRING (CAST(birthday AS CHAR(10)) FOR 4) AS birth_year
FROM actors


######################################################
-- Task Eight: Using the String Aggregation Function
-- In this task, we will be using string aggregation 
-- to join strings together, separated by delimiter
######################################################

-- 8.1: Retrieve data from the series table
SELECT * FROM series;

-- 8.2: Retrieve a list of all episode titles for seasons
SELECT season, STRING_AGG(episodetitle, ', ') AS episodes
FROM series
GROUP BY season
ORDER BY season

-- 8.3: Retrieve data from the series table
SELECT * FROM series;

-- 8.4: Retrieve a list of all directors that directed an episode in each season
SELECT season, STRING_AGG(director, ', ') AS all_directors
FROM series
GROUP BY season
ORDER BY season


##############################################
-- Task Nine: Using the COALESCE Function
-- In this task, we will be using COALESCE
-- to fill null values with actual values
#############################################

-- 9.1: Retrieve data from the middlename table
SELECT * FROM middlename;

-- 9.2: Replace all missing middlenames with the last_name
SELECT actor_id, first_name,  
COALESCE (middle_name, last_name) AS middlename, last_name
FROM middlename

-- 9.3: Change every missing middlename to 'No Middle Name' 
SELECT actor_id, first_name,
COALESCE(middle_name, 'No Middle Name') AS Middlename,
last_name
FROM middlename

-- 9.4: Replace a missing middlename with the lastname, or No name
SELECT * FROM middlename;

SELECT actor_id, first_name, 
COALESCE(middle_name, last_name, 'no name') AS name
FROM middlename


		#####################################
					-- THE END --
		#####################################