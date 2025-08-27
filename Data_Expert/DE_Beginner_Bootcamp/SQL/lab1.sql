-- get old players
SELECT * FROM bootcamp.nba_player_seasons 
WHERE age > 40
LIMIT 50;

-- count number of rows
SELECT COUNT(*)
FROM bootcamp.nba_player_seasons;

-- join tables
SELECT
  games.games_date_est,
  games.season,
  details.player_name,
  details.pts
FROM bootcamp.nba_game_details AS details
JOIN bootcamp.nba_games AS games
  ON details.game_id = games.game_id;