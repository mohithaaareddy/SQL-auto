--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

Select * from auto_insurance_risk;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- QUESTION. NO. 1 --

SELECT
	COUNT(IDpol) AS Total_Policies,
	SUM(CASE WHEN ClaimNb >= 1 THEN 1 ELSE 0 END) AS Total_Claimed,	
	SUM(CASE WHEN ClaimNb >= 1 THEN 1 ELSE 0 END)/6780.13  AS Claimed_Percent
FROM auto_insurance_risk;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- QUESTION. NO. 2.1 --

ALTER TABLE Auto_insurance_risk 
ADD COLUMN claim_flag int;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- QUESTION. NO. 2.2 --

UPDATE Auto_insurance_risk
	SET claim_flag = CASE WHEN ClaimNb > 0 THEN 1 ELSE 0 END;
	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
		
-- QUESTION. NO. 3.1 --	

SELECT 
	AVG(Exposure) AS Average_Exposure
	FROM auto_insurance_risk
	WHERE claim_flag IN (1);
	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
		
-- QUESTION. NO. 3.2 --	

SELECT 
	claim_flag, AVG(Exposure) AS Average_Exposure
	FROM auto_insurance_risk
	GROUP BY claim_flag ;
	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
	
-- QUESTION. NO. 4.1 --	

SELECT 
	CASE 
		WHEN Exposure >= 0 AND Exposure <=0.25 THEN "E1"
		WHEN Exposure >= 0.26 AND Exposure <=0.50 THEN "E2"
		WHEN Exposure >= 0.51 AND Exposure <=0.75 THEN "E3"
		ELSE "E4"
		END AS Exposure_Buckets,
	SUM(ClaimNb) AS No_of_Claims,
	COUNT(IDpol) AS No_of_Policies,
	SUM(ClaimNb)*100/COUNT(IDpol) AS Percent_Claim
FROM auto_insurance_risk
	GROUP BY CASE 
		WHEN Exposure >= 0 AND Exposure <=0.25 THEN "E1"
		WHEN Exposure >= 0.26 AND Exposure <=0.50 THEN "E2"
		WHEN Exposure >= 0.51 AND Exposure <=0.75 THEN "E3"
		ELSE "E4"
		END;
		
		
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
	
-- QUESTION. NO. 5 --		

SELECT 
	Area,
	AVG(ClaimNb) as Average_Claims,
	SUM(ClaimNb) as No_of_Claims, 
	COUNT(IDpol) as No_of_Policies,
	SUM(ClaimNb)*100/COUNT(IDpol) AS Percent_Claim
FROM auto_insurance_risk
	GROUP BY Area
	ORDER BY AVG(ClaimNb) DESC;	
	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
	
-- QUESTION. NO. 6 --

SELECT 
	Area,
	CASE 
		WHEN Exposure >= 0 AND Exposure <=0.25 THEN "E1"
		WHEN Exposure >= 0.26 AND Exposure <=0.50 THEN "E2"
		WHEN Exposure >= 0.51 AND Exposure <=0.75 THEN "E3"
		ELSE "E4"
		END AS Exposure_Buckets,
	SUM(ClaimNb) AS No_of_Claims,
	COUNT(IDpol) AS No_of_Policies,
	SUM(ClaimNb)*100/COUNT(IDpol) AS Percent_Claim
FROM auto_insurance_risk
	GROUP BY Area,
	CASE 
		WHEN Exposure >= 0 AND Exposure <=0.25 THEN "E1"
		WHEN Exposure >= 0.26 AND Exposure <=0.50 THEN "E2"
		WHEN Exposure >= 0.51 AND Exposure <=0.75 THEN "E3"
		ELSE "E4"
		END
ORDER BY SUM(ClaimNb)*100/COUNT(IDpol) DESC;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
	
-- QUESTION. NO. 7.1 --

SELECT 
	claim_flag,
	AVG(VehAge)
FROM auto_insurance_risk
GROUP BY claim_flag;
	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
	
-- QUESTION. NO. 7.2 --

SELECT 
	Area,
	AVG(VehAge)
FROM auto_insurance_risk
GROUP BY Area
HAVING claim_flag = 1;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
	
-- QUESTION. NO. 8 --

SELECT 
	CASE 
		WHEN Exposure >= 0 AND Exposure <=0.25 THEN "E1"
		WHEN Exposure >= 0.26 AND Exposure <=0.50 THEN "E2"
		WHEN Exposure >= 0.51 AND Exposure <=0.75 THEN "E3"
		ELSE "E4"
		END AS Exposure_Buckets,
		claim_flag,
		AVG(VehAge)
FROM auto_insurance_risk
	GROUP BY CASE 
		WHEN Exposure >= 0 AND Exposure <=0.25 THEN "E1"
		WHEN Exposure >= 0.26 AND Exposure <=0.50 THEN "E2"
		WHEN Exposure >= 0.51 AND Exposure <=0.75 THEN "E3"
		ELSE "E4"
		END,
		claim_flag;	
		

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
	
-- QUESTION. NO. 9.1 --	
	
SELECT 
CASE 
	WHEN ClaimNb = 0 THEN "No Claims"
	WHEN ClaimNb = 1 THEN "1 Claim"
	WHEN ClaimNb > 1 THEN "MT 1 Claims"
	END as Claim_Ct,
	AVG(BonusMalus)
FROM auto_insurance_risk
GROUP BY CASE 
	WHEN ClaimNb = 0 THEN "No Claims"
	WHEN ClaimNb = 1 THEN "1 Claim"
	WHEN ClaimNb > 1 THEN "MT 1 Claims"
	END;


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
	
-- QUESTION. NO. 10.1 --	
	
SELECT 
CASE 
	WHEN ClaimNb = 0 THEN "No Claims"
	WHEN ClaimNb = 1 THEN "1 Claim"
	WHEN ClaimNb > 1 THEN "MT 1 Claims"
	END as Claim_Ct,
	AVG(Density) AS Average_Density
FROM auto_insurance_risk
GROUP BY CASE 
	WHEN ClaimNb = 0 THEN "No Claims"
	WHEN ClaimNb = 1 THEN "1 Claim"
	WHEN ClaimNb > 1 THEN "MT 1 Claims"
	END;
	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
	
-- QUESTION. NO. 11.1 --	
	
SELECT 
	VehBrand,
	VehGas,
	AVG(ClaimNb)
FROM auto_insurance_risk
GROUP BY VehBrand, VehGas
ORDER BY AVG(ClaimNb) DESC
Limit 1;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
	
-- QUESTION. NO. 12 --
	
SELECT 
	CASE 
		WHEN Exposure >= 0 AND Exposure <=0.25 THEN "E1"
		WHEN Exposure >= 0.26 AND Exposure <=0.50 THEN "E2"
		WHEN Exposure >= 0.51 AND Exposure <=0.75 THEN "E3"
		ELSE "E4"
		END AS Exposure_Buckets,
	Region,
	SUM(claim_flag) AS No_of_Claim_flag,
	COUNT(IDpol) AS No_of_Policies,
	SUM(claim_flag)*100/COUNT(IDpol) AS Claim_Rate
FROM auto_insurance_risk
	GROUP BY Region,
	CASE 
		WHEN Exposure >= 0 AND Exposure <=0.25 THEN "E1"
		WHEN Exposure >= 0.26 AND Exposure <=0.50 THEN "E2"
		WHEN Exposure >= 0.51 AND Exposure <=0.75 THEN "E3"
		ELSE "E4"
		END
ORDER BY SUM(claim_flag)*100/COUNT(IDpol) DESC
Limit 5;

	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
	
-- QUESTION. NO. 13.1 --

SELECT count(*)
FROM auto_insurance_risk
where DrivAge < 18;


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
	
-- QUESTION. NO. 13.2 --

SELECT 
CASE 
	WHEN DrivAge = 18 THEN "1 - Beginner"
	WHEN DrivAge > 18 and DrivAge <=30 THEN "2 - Junior"
	WHEN DrivAge > 30 and DrivAge <=45 THEN "3 - Middle Age"
	WHEN DrivAge > 45 and DrivAge <=60 THEN "4 - Mid Senior"
	WHEN DrivAge > 60 THEN "5 - Senior"
	END as Age_Group, 
	avg(BonusMalus) as Average_BonusMalus
FROM auto_insurance_risk
GROUP BY CASE 
	WHEN DrivAge = 18 THEN "1 - Beginner"
	WHEN DrivAge > 18 and DrivAge <=30 THEN "2 - Junior"
	WHEN DrivAge > 30 and DrivAge <=45 THEN "3 - Middle Age"
	WHEN DrivAge > 45 and DrivAge <=60 THEN "4 - Mid Senior"
	WHEN DrivAge > 60 THEN "5 - Senior"
	END; 	
	
	
	
	
	
	
	
	
	
	
	




