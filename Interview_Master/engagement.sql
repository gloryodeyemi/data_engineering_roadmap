-- User Engagement in Interactive Content

-- As a Data Scientist on the Interactive Content team, you are tasked with understanding viewer engagement with our choose-your-own-adventure shows. Your team aims to analyze 
-- unique viewer interactions, preferences in choices made, and specific interaction types to enhance the design and user experience of future interactive content. By leveraging 
-- data insights, you will help inform storytelling strategies that foster deeper viewer engagement.

-- Question 1 of 3
-- The Interactive Content team wants to know how many unique viewers have interacted with any interactive content in October 2024. Can you find out the number of distinct viewers?
SELECT COUNT(DISTINCT viewer_id) AS number_of_unique_viewers
FROM viewer_interactions
WHERE interaction_date BETWEEN '2024-10-01' AND '2024-10-31';

-- Question 2
-- To understand viewer preferences, the team wants a list of all the unique choices made by viewers in November 2024. Can you provide this list sorted by choice description alphabetically?
SELECT DISTINCT choice_description
FROM choices_made
WHERE choice_date BETWEEN '2024-11-01' AND '2024-11-30'
ORDER BY choice_description;

-- Question 3
-- The team is interested in understanding which viewers interacted with content by pausing the video in December 2024. Can you provide a list of viewer IDs who did this action?
SELECT DISTINCT viewer_id
FROM viewer_interactions
WHERE interaction_type = 'pause'
AND interaction_date BETWEEN '2024-12-01' AND '2024-12-31';