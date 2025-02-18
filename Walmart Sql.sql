SELECT * FROM classdb.`walmartsalesdata.csv`;
Rename table `walmartsalesdata.csv` to walmart_sales_data;
select * from walmart_sales_data;

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

select* from walmart_sales_data;

-- unique
-- 1. How many unique cities doe the data have
select count(distinct city) from walmart_sales_data;

-- 2. In which city is each branch?
select distinct city, Branch from walmart_sales_data;
-- Products
-- 1.	How many unique product lines does the data have?
select distinct(product_line) as Unique_product from walmart_sales_data;
select count(distinct(Product_line)) as unique_product from walmart_sales_data;

-- 2.	What is the most common payment method?
select payment, count(payment) as common_payment from walmart_sales_data
group by payment
order by common_payment desc
limit 1;

-- 3.	What is the most selling product line?
select product_line, sum(Quantity) as total_quantity from walmart_sales_data
group by product_line
order by total_quantity desc
limit 1;

-- 4.	What is the total revenue by month?
select monthname(Date) as Month, month(date) as month_number, concat("$"," ",round(sum(Total),2)) as total_revenue from walmart_sales_data
group by monthname(Date),month(date) 
order by month(date);

-- 5.	What month had the largest COGS?
select round(sum(COGS),2) as total_cogs, monthname(date) as Month from walmart_sales_data
group by month
order by total_cogs desc
limit 1;
 
-- 6.	What product line had the largest revenue?
select product_line, round(sum(total),2) as total_revenue from walmart_sales_data
group by product_line
order by total_revenue desc
limit 1;

-- 7.	What is the city with the largest revenue?
select city, round(sum(Total),2) as max_revenue from walmart_sales_data
group by city
order by max_revenue desc
limit 1;

-- 8.	What product line had the largest VAT?
select product_line, concat("$", " ", round(sum(Tax),2)) as largest_vat from walmart_sales_data
group by product_line
order by largest_vat desc
limit 1;

-- 9.	Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
select product_line, round(avg(total),2) as average_sales,
					case when avg(total) > (select avg(total) from walmart_sales_data) then "good"
						else "bad"
                        end as Product
from walmart_sales_data
group by product_line;

select product_line, round(avg(cogs),2) as average_sales,
					case when round(avg(cogs),2) >  307.587380  then "good"
						else "bad"
                        end as Product
from walmart_sales_data
group by product_line;

-- 10.	Which branch sold more products than average product sold?
select avg(Quantity) as overall_avg from walmart_sales_data;
select branch, avg(quantity) as Avg_Quantity from walmart_sales_data
group by Branch
having Avg_quantity > 5.5100;

-- 11.	What is the most common product line by gender?
select gender,  product_line, count(product_line) as common_Product from walmart_sales_data
group by gender, product_line
order by common_product desc
limit 1;

-- 12.	What is the average rating of each product line?
select product_line, round(avg(rating),2) as avg_rating from walmart_sales_data
group by product_line;

-- Sales
select * from walmart_sales_data;
-- 1.	Number of sales made in each time of the day per weekday
select min(time), max(time) from walmart_sales_data;
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
                
select Time_of_day, count(quantity) as sales_made
from walmart_sales_data
where dayname(Date) not in ("Sunday","Saturday")
group by Time_of_day order by sales_made desc;

-- 2.	Which of the customer types brings the most revenue?
select customer_Type, concat("$", " ",round(sum(Total),2)) as total_revenue from walmart_sales_data
group by customer_type
order by total_revenue desc
limit 1;
-- 3.	Which city has the largest tax percent/ VAT (Value Added Tax)? Assuming vat to be 10%
select city, round(sum(tax),2) as largest_tax from walmart_sales_data
group by city
order by largest_tax desc
limit 1;

-- 4.	Which customer type pays the most in VAT?
select customer_type, round(sum(tax),2) as most_tax from walmart_sales_data
group by customer_type
order by most_tax desc
limit 1;

-- Customer
-- 1. How many unique customer types does the data have?
select distinct(customer_type) from walmart_sales_data;
select count(distinct(customer_type)) from walmart_sales_data;

-- 2.	How many unique payment methods does the data have?
select distinct(payment) from walmart_sales_data;
select count(distinct(payment)) from walmart_sales_data;

-- 3.	What is the most common customer type?
select customer_type, count(customer_type) as count_customer from walmart_sales_data
group by Customer_Type
order by count_customer desc
limit 1;

-- 4.	Which customer type buys the most?
select customer_type, round(sum(quantity),2) as total_sales from walmart_sales_data
group by Customer_Type
order by total_sales desc
limit 1;

-- 5.	What is the gender of most of the customers?
select gender, count(customer_type) as count_customer from walmart_sales_data
group by gender
order by count_customer desc
limit 1;

-- 6.	What is the gender distribution per branch?
select gender, branch, count(gender) as gender_distribution from walmart_sales_data
group by gender, branch;

-- 7.Which time of the day do customers give most ratings?
select time_of_day, round(avg(rating),2) as avg_rating from walmart_sales_data
group by time_of_day
order by avg_rating desc
limit 1;

-- 8.	Which time of the day do customers give most ratings per branch?
select  time_of_day,branch, round(avg(rating),2) as avg_rating from walmart_sales_data
group by branch, time_of_day
order by avg_rating desc
limit 1;
-- 9.	Which day of the week has the best avg ratings?
select round(avg(rating),2) as avg_rating, dayname(date) as day_of_week from walmart_sales_data
group by dayname(date)
order by avg(rating) desc
limit 1;

-- 10.	Which day of the week has the best average ratings per branch?
select branch, round(avg(rating),2) as avg_rating, dayname(date) as day_of_week from walmart_sales_data
group by branch,day_of_week
order by avg(rating) desc
limit 1;

