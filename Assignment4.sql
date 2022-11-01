# --- QUESTION NO. 1 ----
#Create a simple procedure that will return a table that returns a left join of employees and offices.
#This table should only have employees whose job title is sales rep and be ordered by officecode
#the procedure can be called GetEmpOfficeRep()

DELIMITER $$

CREATE PROCEDURE GetEmpOfficeRep()
BEGIN

	SELECT * FROM employees e
LEFT JOIN offices USING (officeCode) 
WHERE jobTitle = "Sales Rep" 
ORDER BY officeCode;    

END$$

DELIMITER ;

CALL GetEmpOfficeRep();


# ---- QUESTION NO. 2 ----
#Create a procedure with cursor to create a list of the different office cities in offices table with commas between.
#Exclude the remote office with city as remote.
#The out put should look like this: St. Paul, London, Sydney, Tokyo, Paris, NYC, Boston, San Francisco,
#This output will come when something like these queries are run:
# SET @cityList = ""; 
# CALL createOfficeCityList(@cityList); 
# SELECT @cityList;

DELIMITER $$
CREATE PROCEDURE createOfficeCityList (
	INOUT cityList varchar(4000)
)
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE cities varchar(100) DEFAULT "";

	-- declare cursor
	DECLARE curCity 
		CURSOR FOR 
			SELECT city FROM offices where not city="Remote";

	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;

	OPEN curCity;

	getCity: LOOP
		FETCH curCity INTO cities;
		IF finished = 1 THEN 
			LEAVE getCity;
		END IF;
		-- build city list
		SET cityList = CONCAT(cities,", ",cityList);
	END LOOP getCity;
	CLOSE curCity;

END$$
DELIMITER ;

SET @cityList = ""; 
CALL createOfficeCityList(@cityList); 
SELECT @cityList;