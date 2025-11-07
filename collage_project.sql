
CREATE DATABASE IF NOT EXISTS carmaze30;
USE carmaze30;

/* *************************************
   ✅ CREATE LEADERBOARD TABLE
************************************* */
CREATE TABLE IF NOT EXISTS leaderboard (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player VARCHAR(100) NOT NULL,
    maze VARCHAR(100),
    score INT,
    time FLOAT,
    played_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/* *************************************
   ✅ INSERT SAMPLE DATA
************************************* */
INSERT INTO leaderboard (player, maze, score, time)
VALUES
('Alice', 'Forest Small', 1200, 82.4),
('Bob', 'Forest Small', 1100, 95.2),
('Charlie', 'Dense Grove', 980, 101.5),
('DemoBot', 'Old Track', 700, 210.1);

/* *************************************
   ✅ SHOW TABLE DATA
************************************* */
SELECT * FROM leaderboard;

/* *************************************
   ✅ ALTER EXAMPLES
************************************* */
-- Add column
ALTER TABLE leaderboard
ADD COLUMN difficulty VARCHAR(50) DEFAULT 'Medium';

ALTER TABLE leaderboard
ADD COLUMN country VARCHAR(50) DEFAULT 'IN';

-- Modify existing column
ALTER TABLE leaderboard
MODIFY COLUMN score INT NOT NULL;

/* *************************************
   ✅ CREATE INDEXES
************************************* */
CREATE INDEX idx_score ON leaderboard(score);
CREATE INDEX idx_player_time ON leaderboard(player, time);

/* *************************************
   ✅ USER TABLE
************************************* */
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) UNIQUE,
    email VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/* *************************************
   ✅ ADD RELATION (FOREIGN KEY)
************************************* */
ALTER TABLE leaderboard
ADD COLUMN user_id INT,
ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id);

/* *************************************
   ✅ UPDATE DATA
************************************* */
UPDATE leaderboard
SET difficulty = 'Hard'
WHERE score > 900;

/* *************************************
   ✅ DELETE LOW SCORE
************************************* */
DELETE FROM leaderboard
WHERE score < 300;

/* *************************************
   ✅ ADVANCED READS
************************************* */

-- Top 5
SELECT player, maze, score, time
FROM leaderboard
ORDER BY score DESC, time ASC
LIMIT 5;

-- Best score per maze
SELECT maze, MAX(score) AS best_score
FROM leaderboard
GROUP BY maze;

-- Total players
SELECT COUNT(*) AS total_players
FROM leaderboard;
