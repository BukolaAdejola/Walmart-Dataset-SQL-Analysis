# Walmart Dataset SQL Analysis


![download](https://github.com/user-attachments/assets/d8aa5251-c749-49fb-8f45-c08876028ce2)
## Table of Content
- [Introduction](#Introduction)

- [Dataset Overview](#Dataset-Overview)

- [Project Objective](#Project-Objective)

- [Data cleaning](#Data-Cleaning)

- [Data Discovery](#Data-Discovery)

- [Recommendation](#Recommendation)

- [Conclusion](#Conclusion)

## Introduction
  
Walmart, a global retail leader, offers a diverse range of products catering to various aspects of life. 
This dataset encompasses key categories, showcasing the breadth and depth of Walmart's inventory. 
From Health and Beauty products that enhance wellness,Electronic Accessories that complement modern gadgets,
and Home and Lifestyle essentials that make living spaces more comfortable, to Sports and Travel gear for active lifestyles, 
Food and Beverages ensuring nutritional needs are met,and Fashion and Accessories keeping customers stylish—this dataset
provides invaluable insights into Walmart's comprehensive product offerings.

## Dataset Overview

This dataset comprises of 18 columns and 1000 rows:
-	Invoice ID: A unique key for each customer in the supermarket.
- Branch: The branch patronized by individual customers.
- City: The city of purchase.
-	Customer-Type: The type of customers that patronized the supermarket.
-	Gender: The gender that patronized the supermarket.
-	Product-line: Type of product bought.
-	Unit-Price: The price of each product bought.
-	Quantity: The total quantity of products bought.
-	Tax: Tax on a product.
-	Total: Total revenue of products bought.
-	Date: The date of purchase.
-	Time: The time of purchase.
-	Payment: The method of payment.
-	Cogs: Cost of goods bought.
-	Gross-Margin-Per:
-	Gross-Income:
-	Rating: Rating of the goods bought.
-	Time of day: Time of the day of purchase.

<img width="839" alt="Walmart Screenshot" src="https://github.com/user-attachments/assets/ca12f2ac-9672-4eac-8996-4c9531f5e0bd" />




## Project Objective

- Generic Question
1.	How many unique cities does the data have?
2.	In which city is each branch?
- Product
1.	How many unique product lines does the data have?
2.	What is the most common payment method?
3.	What is the most selling product line?
4.	What is the total revenue by month?
5.	What month had the largest COGS?
6.	What product line had the largest revenue?
7.	What is the city with the largest revenue?
8.	What product line had the largest VAT?
9.	Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
10.	Which branch sold more products than average product sold?
11.	What is the most common product line by gender?
12.	What is the average rating of each product line?
- Sales
1.	Number of sales made in each time of the day per weekday
2.	Which of the customer types brings the most revenue?
3.	Which city has the largest tax percent/ VAT (Value Added Tax)?
4.	Which customer type pays the most in VAT?
- Customer
1.	How many unique customer types does the data have?
2.	How many unique payment methods does the data have?
3.	What is the most common customer type?
4.	Which customer type buys the most?
5.	What is the gender of most of the customers?
6.	What is the gender distribution per branch?
7.	Which time of the day do customers give most ratings?
8.	Which time of the day do customers give most ratings per branch?
9.	Which day of the week has the best avg ratings?
10.	Which day of the week has the best average ratings per branch?

## Data Cleaning
- Renaming Table and other selected Columns
```sql
Rename table `walmartsalesdata.csv` to walmart_sales_data;

Alter table walmart_sales_data
rename column `Invoice ID` to Invoice_ID;

Alter table walmart_sales_data
rename column `Customer type` to Customer_Type;

Alter table walmart_sales_data
rename column `Product line` to Product_line;

Alter table walmart_sales_data
rename column `Unit price` to Unit_Price;

Alter table walmart_sales_data
rename column `gross margin percentage`to gros_margin_per; 

Alter table walmart_sales_data
rename column `gross income`to gross_income; 

Alter table walmart_sales_data
rename column `Tax 5%`to Tax;
```
- Add Column "Time of the day"
 ```
select Time, case 
		 when time between "00:00:00" and "12:00:00" then "Morning"
                           when time between "12:00:01" and "16:00:00" then "Afternoon"
                           else "Evening"
		end as Time_of_day
from walmart_sales_data;

alter table walmart_sales_data
add column Time_of_day text;

set SQL_SAFE_UPDATES = 0;
update walmart_sales_data
set Time_of_day = case 
			when time between "00:00:00" and "12:00:00" then "Morning"
                		when time between "12:00:01" and "16:00:00" then "Afternoon"
               		 else "Evening"
			end;
```
## Data Discovery
- Generic Question
1.	How many unique cities does the data have?
Discovery: The data has three unique cities.
2.	In which city is each branch?
Discovery: Yangon is to branch A, Naypyitaw is to branch C while Mandalay is to branch B.
- Product
1.	How many unique product lines does the data have?
Discovery: Six unique product-line.
2.	What is the most common payment method?
Discovery: Ewallet is the most common method.
3.	What is the most selling product line?
Discovery: Electronic accessories sell most
4.	What is the total revenue by month?
Discovery: January has a total revenue of $116291.87
February has a total revenue of $97219.37 while that of march is $109455.51.
5.	What month had the largest COGS?
Discovery: January
6.	What product line had the largest revenue?
Discovery: Food and beverages have the largest revenue.
7.	What is the city with the largest revenue?
Discovery: Naypyitaw 
8.	What product line had the largest VAT?
Discovery: Food and beverages have the largest VAT
9.	Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales.
Discovery: Health and beauty		Good
	        Electronic accessories	Bad
	        Home and lifestyle		Good
	        Sports and Travel		Good
	        Food and Beverages	Bad
	        Fashion Accessories	Bad
10.	Which branch sold more products than average product sold?
Discovery: Branch C sold more products.
11.	What is the most common product line by gender?
Discovery: Fashion accessories for female gender.
12.	What is the average rating of each product line?
Discovery: there are six unique product lines
-	Health and beauty have average rating of 7.00
-	Electronic accessories have 6.92
-	Home and lifestyle have 6.84
-	Sports and travel have 6.92
-	Food and beverages have 7.11
-	Fashion accessories have 7.03
- Sales
1.	Number of sales made in each time of the day per weekday
Discovery: Morning		141 sales made
	        Afternoon		269 sales made
	        Evening		293 sales made
2.	Which of the customer types brings the most revenue?
Discovery: Normal customers bring the most revenue.
3.	Which city has the largest tax percent/ VAT (Value Added Tax)?
Discovery: Naypyitaw has the largest tax.
4.	Which customer type pays the most in VAT?
Discovery: Member customer type.
- Customer
1.	How many unique customer types does the data have?
Discovery: Two unique customer types.
2.	How many unique payment methods does the data have?
Discovery: Three unique payment method.
3.	What is the most common customer type?
Discovery: Member customer type.
4.	Which customer type buys the most?
Discovery: Member customer type.
5.	What is the gender of most of the customers?
Discovery: Female gender.
6.	What is the gender distribution per branch?
Discovery: Branch A has the gender distribution of 161 females and 179 males,
branch B have 162 females and 170 males while branch C 178 females and 179 males.
7.	Which time of the day do customers give most ratings?
Discovery: Customers give the most ratings in the Afternoon.
8.	Which time of the day do customers give most ratings per branch?
Discovery: Branch A gives the most ratings in the afternoon.
9.	Which day of the week has the best avg ratings?
Discovery: Monday has the best average ratings.
10.	Which day of the week has the best average ratings per branch?
Discovery: Branch B has the best average ratings on Monday.

## Recommendation
1.	Focus on High-Performing Cities and Branches:
o	Naypyitaw has the highest revenue and tax percentage/VAT. Branch C, located in Naypyitaw,
sold more products than the average. Consider investing more resources and marketing efforts
 in this city and branch to maximize profits.
2.	Optimize Product Line Offerings:
o	The Food and Beverages product line generates the largest revenue and VAT, despite being labeled as "Bad"
in terms of sales performance. Evaluate the pricing, marketing, and availability of these products to improve their performance.
o	Focus on product lines with good sales performance, such as Health and Beauty, Home and Lifestyle,
and Sports and Travel. These lines have shown better-than-average sales and could benefit from additional promotion and inventory.
3.	Enhance Customer Experience for Member Customers:
o	Member customers bring the most revenue and pay the most in VAT. Develop loyalty programs,
 personalized offers, and exclusive benefits to encourage more member sign-ups and repeat purchases.
4.	Improve Sales During Non-Peak Times:
o	While the evening has the highest sales, there is an opportunity to boost sales during the morning and afternoon.
 Consider targeted promotions, special offers, or events during these times to attract more customers.
5.	Leverage Popular Payment Methods:
o	With Ewallet being the most common payment method, ensure that the checkout process is seamless and
 that there are incentives for using Ewallet. This could include discounts, cashback offers, or loyalty points.
6.	Address Gender Preferences:
o	Fashion accessories are the most common product line for female customers. Tailor marketing campaigns and product
assortments to cater to this demographic. Additionally, consider expanding the range of fashion accessories to meet demand.

## Conclusion

This data analysis has provided valuable insights into the performance of different cities, branches, product lines, customer types,
and sales patterns. By focusing on high-performing areas,optimizing product offerings, enhancing customer experiences, and leveraging 
popular payment methods, you can drive revenue growth and improve overall business performance. Regularly reviewing and analyzing your 
data will help you stay ahead of market trends and make informed decisions that align with your business goals.


