-- create schema 
-- create schema cricket_db

-- use schema
USE cricket_db;

-- create Users table
create table Users (
	id int primary key auto_increment,
    username varchar(50) not null unique,
    email varchar(100) not null unique,
    password varchar(255) not null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp
);

create table Teams (
	id int primary key auto_increment,
	name varchar(100) not null,
	captain_id int,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (captain_id) REFERENCES Players(id) ON DELETE SET NULL
);

create table Players (
	id int primary key auto_increment,
    name varchar(100) not null unique,
    profile_picture varchar(100),
    date_of_birth date,
    role enum('batsman','bowler','batting-allrounder','bowling-allrounder','wicket-keeper') not null default 'batting-allrounder',
    team_id int,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (team_id) references Teams(id) on delete set null
);

CREATE TABLE Matches (
  id INT PRIMARY KEY AUTO_INCREMENT,
  match_date DATE NOT NULL,
  match_time TIME NOT NULL,
  location VARCHAR(100) NOT NULL,
  status ENUM('in_progress', 'completed') NOT NULL DEFAULT 'upcoming',
  team1_id INT NOT NULL,
  team2_id INT NOT NULL,
  winner_id INT,
  result VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (team1_id) REFERENCES Teams(id) ON DELETE CASCADE,
  FOREIGN KEY (team2_id) REFERENCES Teams(id) ON DELETE CASCADE,
  FOREIGN KEY (winner_id) REFERENCES Teams(id) ON DELETE SET NULL
);

CREATE TABLE Match_Statistics (
  id INT PRIMARY KEY AUTO_INCREMENT,
  match_id INT NOT NULL,
  toss_winner_id INT,
  match_result VARCHAR(50),
  match_type VARCHAR(20),
  man_of_the_match_id INT,
  total_runs INT,
  total_wickets INT,
  total_overs FLOAT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (match_id) REFERENCES Matches(id) ON DELETE CASCADE,
  FOREIGN KEY (toss_winner_id) REFERENCES Teams(id) ON DELETE SET NULL,
  FOREIGN KEY (man_of_the_match_id) REFERENCES Players(id) ON DELETE SET NULL
);

CREATE TABLE Scorecards (
  id INT PRIMARY KEY AUTO_INCREMENT,
  match_id INT NOT NULL,
  team_id INT NOT NULL,
  innings INT NOT NULL,
  total_runs INT,
  total_wickets INT,
  total_overs FLOAT,
  run_rate FLOAT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (match_id) REFERENCES Matches(id) ON DELETE CASCADE,
  FOREIGN KEY (team_id) REFERENCES Teams(id) ON DELETE CASCADE
);

CREATE TABLE Batting_Scorecards (
  id INT PRIMARY KEY AUTO_INCREMENT,
  scorecard_id INT NOT NULL,
  player_id INT NOT NULL,
  runs INT,
  balls INT,
  fours INT,
  sixes INT,
  strike_rate FLOAT,
  dismissal ENUM(
    'bowled',
    'lbw',
    'caught',
    'stumped',
    'run_out',
    'hit_wicket',
    'handled_ball',
    'obstructing_the_field',
    'hit_the_ball_twice',
    'not_out'
  ),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (scorecard_id) REFERENCES Scorecards(id) ON DELETE CASCADE,
  FOREIGN KEY (player_id) REFERENCES Players(id) ON DELETE CASCADE
);

CREATE TABLE Bowling_Scorecards (
  id INT PRIMARY KEY AUTO_INCREMENT,
  scorecard_id INT NOT NULL,
  player_id INT NOT NULL,
  overs FLOAT,
  maidens INT,
  runs INT,
  wickets INT,
  economy_rate FLOAT,
  average FLOAT,
  strike_rate FLOAT,
  dismissal ENUM(
    'bowled',
    'lbw',
    'caught',
    'stumped',
    'run_out',
    'hit_wicket',
    'handled_ball',
    'obstructing_the_field',
    'hit_the_ball_twice',
    'not_out'
  ),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (scorecard_id) REFERENCES Scorecards(id) ON DELETE CASCADE,
  FOREIGN KEY (player_id) REFERENCES Players(id) ON DELETE CASCADE
);

CREATE TABLE Fielding_Scorecards (
  id INT PRIMARY KEY AUTO_INCREMENT,
  scorecard_id INT NOT NULL,
  player_id INT NOT NULL,
  catches INT,
  stumpings INT,
  run_outs INT,
  missed_catches INT,
  missed_stumpings INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (scorecard_id) REFERENCES Scorecards(id) ON DELETE CASCADE,
  FOREIGN KEY (player_id) REFERENCES Players(id) ON DELETE CASCADE
);





