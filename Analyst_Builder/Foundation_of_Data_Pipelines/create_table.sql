DROP TABLE earthquake;

CREATE TABLE earthquake(
	ts VARCHAR(100),
	place VARCHAR(100),
	magnitude NUMERIC(32,8),
	longitude NUMERIC(32,8),
	latitude NUMERIC(32,8),
	depth NUMERIC(32,8),
	filename VARCHAR(255)
);

DELETE FROM earthquake;

SELECT * FROM earthquake;