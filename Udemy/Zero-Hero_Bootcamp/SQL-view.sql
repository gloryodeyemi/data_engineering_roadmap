-- VIEW
-- a database object that is of a stored query.
-- it can be accessed as a virtual table in PostgreSQL.
-- you can update and alter existing views.

CREATE VIEW customer_info AS
	SELECT first_name, last_name, address
	FROM customer
	INNER JOIN address
	ON customer.address_id = address.address_id;

SELECT * FROM customer_info;

-- ALTER VIEW
CREATE OR REPLACE VIEW customer_info AS
	SELECT first_name, last_name, address, district
	FROM customer
	INNER JOIN address
	ON customer.address_id = address.address_id;

-- change VIEW name
ALTER VIEW customer_info RENAME TO c_info;

SELECT * FROM c_info;

-- remove VIEW
DROP VIEW IF EXISTS c_info;