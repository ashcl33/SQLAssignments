# ---- QUESTION NO. 1 ----
#Use in built MySql functions to display how many years ago a classicmodels order was shipped (shipped date) as "Years Ago". 
#Only count orders that are "shipped" status and order by Years Ago oldest to newest. 
#Inlcude order number and customer number. Hint: look at Age example

SELECT orderNumber, customerNumber, timestampdiff(YEAR, shippedDate,CURDATE()) AS "Years Ago"
FROM orders WHERE STATUS="Shipped" order by timestampdiff(YEAR,shippedDate, CURDATE()) desc;

# ---- QUESTION NO. 2 ----
#Use in built MySql functions to query from the classicmodels payments table with four columns.
# One being unchanged amount column, amount rounded up, amount rounded down, and amount in pesos. 
#Use 1 dollar = 20.63 pesos, make sure this is formatted to two decimals. Inlcude aliases

SELECT amount AS "Amount in $", CEILING(amount) AS "Amount Rounded Up",
Floor(amount) AS "Amount Rounded Down",
FORMAT((amount*20.63),2) AS "Amount in Pesos" from payments;

# ---- QUESTION NO. 3 ----
#Create a custom function to display profit return ratings (returnRating(MSRP,buyPrice)) for classic models products using MSRP minus buyPrice for profit margin. 
#Use this function to display this profit margin price amount, product name, and output rating from the function on the same table.
# 0 to 25 as Very Low Return
# 25+ to 50 as Low Return
# 50+ to 75 as Medium Return
# 75+ to 100 as High Return
# 100+ as Very High Return

Select max(buyPrice),min(buyPrice),max(MSRP),min(MSRP),max(MSRP-buyPrice),min(MSRP-buyPrice) from products;

DELIMITER $$

CREATE FUNCTION returnRating(
	msrp DECIMAL(10,2),
	buyprice DECIMAL(10,2)
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
	DECLARE returnRating VARCHAR(20);
	DECLARE margin DECIMAL(10,2);
   SET margin = msrp - buyprice;
    IF margin > 100 THEN
		SET returnRating = 'Very High Return';
	ELSEIF(margin > 75 AND
		   margin <= 100) THEN
	   SET returnRating = 'High Return';
        ELSEIF(margin > 50 AND 
			   margin <= 75) THEN
	   SET returnRating = 'Medium Return';
        ELSEIF(margin > 25 AND
			  margin <= 50) THEN
	   SET returnRating = 'Low Return';
     ELSEIF margin <= 25 THEN
		SET returnRating = 'Very Low Return';
	 END IF;
     
	  RETURN (returnRating);
END$$
DELIMITER ;
Select productName,(MSRP-buyPrice),returnRating(MSRP,buyPrice) from products;

# ---- QUESTION NO. 4 ----
#Create two views, one as ratings_view and the other as productline_view
#ratings_view should have three columns, 
#the return rating from the function created previously, number of products (count), and average profit margin(avg of msrp-buyprice) with corresponding aliases
#this should be grouped by the return rating function and ordered by the average profit margin in descending order.
#productline_view should be similar to ratings view, except you will replace the return rating column with productline abd group by productline.

CREATE VIEW ratings_view AS
SELECT returnRating(MSRP,buyPrice) AS "Return Rating", 
count(productName) AS "Number of Products",
AVG(MSRP-buyPrice) AS "Average Profit Margin" 
FROM products 
GROUP BY returnRating(MSRP,buyPrice) 
ORDER BY AVG(MSRP-buyPrice) DESC;

SELECT * FROM ratings_view;

CREATE VIEW productline_view AS
SELECT productLine AS "Product Line", 
count(productName) AS "Number of Products",
AVG(MSRP-buyPrice) AS "Average Profit Margin" 
FROM products 
GROUP BY productLine
ORDER BY AVG(MSRP-buyPrice) DESC;

SELECT * FROM productline_view;







