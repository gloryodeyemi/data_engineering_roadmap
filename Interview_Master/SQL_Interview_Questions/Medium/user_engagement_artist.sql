-- User Engagement with Artist Recommendations

/*
You are a Data Analyst on the Apple Music Personalization Team. Your team is focused on evaluating the effectiveness of the recommendation algorithm for artist discovery. 
The goal is to analyze user interactions with recommended artists to enhance the recommendation engine and improve user engagement.

Question 1 of 3
How many unique users have streamed an artist on or after the date it was recommended to them?
*/
SELECT COUNT(DISTINCT us.user_id)
FROM user_streams us
LEFT JOIN artist_recommendations ar
ON us.user_id = ar.user_id
  AND us.artist_id = ar.artist_id
WHERE stream_date >= recommendation_date;

/*
Question 2
What is the average number of times a recommended artist is streamed by users in May 2024? Similar to the previous question, 
only include streams on or after the date the artist was recommended to them.
*/
WITH stream_count AS (
  SELECT 
        ar.user_id,
        ar.artist_id,
        COUNT(us.stream_id) AS no_streams
    FROM artist_recommendations ar
    LEFT JOIN user_streams us
        ON ar.user_id = us.user_id
        AND ar.artist_id = us.artist_id
        AND us.stream_date >= ar.recommendation_date
        AND us.stream_date BETWEEN '2024-05-01' AND '2024-05-31'
    GROUP BY ar.user_id, ar.artist_id
)
SELECT AVG(no_streams)
FROM stream_count;

/*
Question 3
Across users who listened to at least one recommended artist, what is the average number of distinct recommended artists they listened to? As in the previous question, 
only include streams that occurred on or after the date the artist was recommended to the user.
*/
WITH artist_count AS (
  SELECT 
        ar.user_id,
        COUNT(DISTINCT us.artist_id) AS distinct_artist
    FROM artist_recommendations ar
    LEFT JOIN user_streams us
        ON ar.user_id = us.user_id
        AND ar.artist_id = us.artist_id
        AND us.stream_date >= ar.recommendation_date
        AND us.stream_date BETWEEN '2024-05-01' AND '2024-05-31'
    GROUP BY ar.user_id
      HAVING COUNT(stream_id) > 0
)
SELECT AVG(distinct_artist)
FROM artist_count;