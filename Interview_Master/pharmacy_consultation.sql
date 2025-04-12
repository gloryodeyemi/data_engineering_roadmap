-- Pharmacy Consultation Privacy for Patient Comfort

/*
You are a Data Analyst on the Walmart Pharmacy team tasked with evaluating patient consultation privacy concerns. Your team is focused on 
understanding how different consultation room types and their associated privacy levels affect patient comfort and confidentiality. 
By analyzing consultation frequencies, room types, and privacy scores, you will recommend improvements to enhance patient privacy in 
pharmacy consultation spaces.

Question 1 of 3
What are the names of the 3 pharmacies that conducted the fewest number of consultations in July 2024? This will help us identify locations 
with potentially less crowded consultation spaces.
*/
SELECT pharmacy_name, COUNT(consultation_id)
FROM fct_consultations
WHERE consultation_date BETWEEN '2024-07-01' and '2024-07-31'
GROUP BY pharmacy_name
ORDER BY COUNT(consultation_id)
LIMIT 3;

-- Question 2 of 3
-- For the pharmacies identified in the previous question (i.e., the 3 pharmacies with the fewest consultations in July 2024), what is the 
-- uppercase version of the consultation room types available? Understanding the room types can provide insights into the privacy features 
-- offered.
SELECT DISTINCT UPPER(consultation_room_type)
FROM fct_consultations
WHERE pharmacy_name IN (
  SELECT pharmacy_name
  FROM fct_consultations
  WHERE consultation_date BETWEEN '2024-07-01' and '2024-07-31'
  GROUP BY pharmacy_name
  ORDER BY COUNT(consultation_id)
  LIMIT 3
);

-- Question 3 of 3
-- So far, we have identified the 3 pharmacies with the fewest consultations in July 2024. Among these 3 pharmacies, what is the minimum 
-- privacy level score for each consultation room type in July 2024?
SELECT consultation_room_type, MIN(privacy_level_score)
FROM fct_consultations
WHERE pharmacy_name IN (
  SELECT pharmacy_name
  FROM fct_consultations
  WHERE consultation_date BETWEEN '2024-07-01' and '2024-07-31'
  GROUP BY pharmacy_name
  ORDER BY COUNT(consultation_id)
  LIMIT 3
)
  AND consultation_date BETWEEN '2024-07-01' and '2024-07-31'
GROUP BY consultation_room_type;