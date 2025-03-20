DROP TABLE stage_earthquake;

CREATE TABLE stage_earthquake(
	ts TIMESTAMP,
    dt DATE,
    place VARCHAR(100),
    magnitude NUMERIC(32,8),
    longitude NUMERIC(32,8),
    latitude NUMERIC(32,8),
    depth NUMERIC(32,8)
);

SELECT COUNT(*) FROM stage_earthquake;

DELETE FROM stage_earthquake;

SELECT * FROM stage_earthquake;