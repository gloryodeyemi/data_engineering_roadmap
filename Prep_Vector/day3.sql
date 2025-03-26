-- Single vs Repeat Job Posters

CREATE TABLE job_postings (
    id INT PRIMARY KEY,
    user_id INT,
    job_id INT,
    posted_date DATETIME
);

INSERT INTO job_postings (id, user_id, job_id, posted_date) VALUES
    (1, 1, 101, '2024-01-01'),
    (2, 1, 102, '2024-01-02'),
    (3, 2, 201, '2024-01-01'),
    (4, 2, 201, '2024-01-15'),
    (5, 2, 202, '2024-01-03'),
    (6, 3, 301, '2024-01-01'),
    (7, 4, 401, '2024-01-01'),
    (8, 4, 401, '2024-01-15'),
    (9, 4, 402, '2024-01-02'),
    (10, 4, 402, '2024-01-16'),
    (11, 5, 501, '2024-01-05'),
    (12, 5, 502, '2024-01-10');

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema

WITH user_job_counts AS (
    -- Count how many times each user posted each job
    SELECT user_id, job_id, COUNT(*) AS post_count
    FROM job_postings
    GROUP BY user_id, job_id
),
user_categories AS (
    -- Categorize users based on whether they have repeated jobs or not
    SELECT user_id,
           MAX(CASE WHEN post_count > 1 THEN 1 ELSE 0 END) AS has_repeated_jobs
    FROM user_job_counts
    GROUP BY user_id
)
SELECT 
    SUM(CASE WHEN has_repeated_jobs = 0 THEN 1 ELSE 0 END) AS single_post_users,
    SUM(CASE WHEN has_repeated_jobs = 1 THEN 1 ELSE 0 END) AS multiple_post_users
FROM user_categories;