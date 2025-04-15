-- User Playlist Engagement for Discovery

/*
You are a Data Analyst on the Amazon Music Recommendation Team focused on understanding the impact of playlists on user engagement. Your team wants to identify how 
the number of tracks in a playlist and user listening time correlate to optimize playlist recommendations. The end goal is to enhance user experience by tailoring 
playlists that maximize listening time and music discovery.

Question 1 of 3
The Amazon Music Recommendation Team wants to know which playlists have the least number of tracks. Can you find out the playlist with the minimum number of tracks?
*/
SELECT playlist_id, playlist_name, number_of_tracks
FROM playlists
ORDER BY number_of_tracks
LIMIT 1;

-- Question 2
-- We are interested in understanding the engagement level of playlists. Specifically, we want to identify which playlist has the lowest average listening time per track. 
-- This means calculating the total listening time for each playlist in October 2024 and then normalizing it by the number of tracks in that playlist. Can you provide the 
-- name of the playlist with the lowest value based on this calculation?
SELECT playlist_name, SUM(listening_time_minutes)/number_of_tracks AS avg_listening_time_per_track
FROM playlists
JOIN playlist_engagement
USING(playlist_id)
WHERE engagement_date BETWEEN '2024-10-01' AND '2024-10-31'
GROUP BY playlist_name
ORDER BY avg_listening_time_per_track
LIMIT 1;

-- Question 3
-- To optimize our recommendations, we need the average monthly listening time per listener for each playlist in October 2024. For readability, please round down the average 
-- listening time to the nearest whole number.
SELECT
  playlist_id,
  FLOOR(SUM(listening_time_minutes) / COUNT(DISTINCT user_id)) AS avg_monthly_listening_time
FROM playlist_engagement
WHERE engagement_date BETWEEN '2024-10-01' AND '2024-10-31' 
GROUP BY playlist_id;