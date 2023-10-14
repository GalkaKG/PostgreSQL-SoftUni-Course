1.1. Database Design
  
CREATE TABLE towns(
	id SERIAL PRIMARY KEY,
	name VARCHAR(45) NOT NULL
);

CREATE TABLE stadiums(
	id SERIAL PRIMARY KEY,
	name VARCHAR(45) NOT NULL,
	capacity INT NOT NULL,
	CONSTRAINT stadiums_capacity_check CHECK(capacity > 0),
	town_id INT NOT NULL,
	CONSTRAINT fk_stadiums_towns
	FOREIGN KEY (town_id) REFERENCES towns(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

CREATE TABLE teams(
	id SERIAL PRIMARY KEY,
	name VARCHAR(45) NOT NULL,
	established DATE NOT NULL,
	fan_base INT DEFAULT 0 NOT NULL,
	CONSTRAINT teams_fan_base_check CHECK(fan_base >= 0),
	stadium_id INT NOT NULL,
	CONSTRAINT fk_teams_stadiums
	FOREIGN KEY (stadium_id) REFERENCES stadiums(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

CREATE TABLE coaches(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(10) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	salary NUMERIC(10, 2) DEFAULT 0 NOT NULL,
	CONSTRAINT coaches_salary_check CHECK(salary >= 0),
	coach_level INT DEFAULT 0 NOT NULL,
	CONSTRAINT coaches_coach_level_check CHECK(coach_level >= 0)
);

CREATE TABLE skills_data(
	id SERIAL PRIMARY KEY,
	dribbling INT DEFAULT 0,
	CONSTRAINT skills_data_dribbling_check CHECK(dribbling >= 0),
	pace INT DEFAULT 0,
	CONSTRAINT skills_data_pace_check CHECK(pace >= 0),
	passing INT DEFAULT 0,
	CONSTRAINT skills_data_passing_check CHECK(passing >= 0),
	shooting INT DEFAULT 0,
	CONSTRAINT skills_data_shooting_check CHECK(shooting >= 0),
	speed INT DEFAULT 0,
	CONSTRAINT skills_data_speed_check CHECK(speed >= 0),
	strength INT DEFAULT 0,
	CONSTRAINT skills_data_strength_check CHECK(strength >= 0)
);

CREATE TABLE players(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(10) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	age INT DEFAULT 0 NOT NULL,
	CONSTRAINT players_age_check CHECK(age >= 0),
	position CHAR(1) NOT NULL,
	salary NUMERIC(10, 2) DEFAULT 0 NOT NULL,
	CONSTRAINT players_salary_check CHECK(salary >= 0),
	hire_date TIMESTAMP,
	skills_data_id INT NOT NULL,
	CONSTRAINT fk_players_skills_data 
	FOREIGN KEY (skills_data_id) REFERENCES skills_data(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	team_id INT,
	CONSTRAINT fk_players_teams 
	FOREIGN KEY (team_id) REFERENCES teams(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

CREATE TABLE players_coaches(
	player_id INT,
	CONSTRAINT fk_players_coaches_players
	FOREIGN KEY (player_id) REFERENCES players(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	coach_id INT,
	CONSTRAINT fk_players_coaches_coaches
	FOREIGN KEY (coach_id) REFERENCES coaches(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);




2.2 Insert

INSERT INTO coaches (first_name, last_name, salary, coach_level)
SELECT 
    p.first_name,
    p.last_name,
    p.salary * 2,
    LENGTH(p.first_name)
FROM players p
WHERE p.hire_date < '2013-12-13 07:18:46';

2.3. Update

UPDATE coaches AS c
SET salary = c.salary * c.coach_level
WHERE first_name LIKE 'C%'
AND c.id IN (SELECT DISTINCT pc.coach_id FROM players_coaches AS pc)

2.4. Delete

DELETE FROM players
WHERE hire_date < '2013-12-13 07:18:46';

2.5. Players

SELECT 
	CONCAT(first_name, ' ', last_name) AS full_name,
	age,
	hire_date
FROM
	players
WHERE first_name LIKE 'M%'
ORDER BY age DESC, full_name;

3.6. Offensive Players without Team

SELECT
    p.id,
    CONCAT(p.first_name, ' ', p.last_name) AS full_name,
    p.age,
    p.position,
    p.salary,
    sd.pace,
    sd.shooting
FROM players p
LEFT JOIN skills_data sd
ON p.skills_data_id = sd.id
WHERE p.position = 'A'
    AND (sd.pace + sd.shooting) > 130
    AND p.team_id IS NULL;

3.7. Teams with Player Count and Fan Base

SELECT
	t.id AS team_id,
	t.name AS team_name,
	COUNT(p.id) AS player_count,
	t.fan_base
FROM
	teams AS t
LEFT JOIN 
	players AS p
ON
	p.team_id = t.id
WHERE	
	t.fan_base > 30000
GROUP BY
	t.id,
	t.name,
	t.fan_base
ORDER BY
	player_count DESC,
	fan_base DESC;

3.8. Coaches, Players Skills and Teams Overview

SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS coach_full_name,
    CONCAT(p.first_name, ' ', p.last_name) AS player_full_name,
    t.name AS team_name,
    s.passing,
    s.shooting,
    s.speed
FROM
    coaches AS c
JOIN
    players_coaches AS pc ON c.id = pc.coach_id
JOIN
    players AS p ON pc.player_id = p.id
JOIN
    teams AS t ON p.team_id = t.id
JOIN
    skills_data AS s ON p.skills_data_id = s.id
ORDER BY
    coach_full_name ASC, player_full_name DESC;

4.9. Stadium Teams Information

CREATE OR REPLACE FUNCTION fn_stadium_team_name(stadium_name VARCHAR(30))
RETURNS TABLE (team_name VARCHAR(45)) AS $$
BEGIN
    RETURN QUERY
    SELECT name
    FROM teams
    WHERE stadium_id = (SELECT id FROM stadiums WHERE name = stadium_name)
    ORDER BY name;

    RETURN;
END;
$$ LANGUAGE plpgsql;

4.10. Player Team Finder

CREATE OR REPLACE PROCEDURE sp_players_team_name(player_name VARCHAR(50), OUT team_name VARCHAR(45))
LANGUAGE plpgsql AS $$
BEGIN
    SELECT t.name
    INTO team_name
    FROM players AS p
    LEFT JOIN teams AS t ON p.team_id = t.id
    WHERE CONCAT(p.first_name, ' ', p.last_name) = player_name;

    IF team_name IS NULL THEN
        team_name := 'The player currently has no team';
    END IF;
END;
$$;
