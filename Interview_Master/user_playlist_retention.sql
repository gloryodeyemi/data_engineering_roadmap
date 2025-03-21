-- User Playlist Retention and Discovery Rates

-- You are a Data Scientist on the Apple Music Personalization Team, tasked with evaluating the effectiveness of recommendation algorithms in engaging users with new music. 
-- Your goal is to analyze user playlist interactions to determine how many users add recommended tracks to their playlists, the average number of recommended tracks added 
-- per user, and identify users who add non-recommended tracks. This analysis will help your team decide if the recommendation engine needs refinement to enhance user 
-- engagement and retention.

-- Question 1 of 3
-- How many unique users have added at least one recommended track to their playlists in October 2024?
SELECT COUNT(DISTINCT user_id)
FROM tracks_added
WHERE added_date BETWEEN '2024-10-01' AND '2024-10-31'
AND is_recommended = 1;

-- Question 2
-- Among the users who added recommended tracks in October 2024, what is the average number of tracks added to their playlists? Please round this to 1 decimal place for better readability.
SELECT ROUND(AVG(num_tracks), 1) AS average_track
FROM (
  SELECT user_id, COUNT(track_id) AS num_tracks
  FROM tracks_added
  WHERE added_date BETWEEN '2024-10-01' AND '2024-10-31'
    AND is_recommended = 1
  GROUP BY user_id
);

-- Question 3
-- Can you give us the name(s) of users who added a non-recommended track to their playlist on October 2nd, 2024?
SELECT DISTINCT users.user_name
FROM tracks_added
JOIN users
USING(user_id)
WHERE tracks_added.added_date = '2024-10-02'
  AND tracks_added.is_recommended = 0;