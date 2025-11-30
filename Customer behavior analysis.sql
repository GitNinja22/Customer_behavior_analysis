select * from customer;
--Q1 What is the total revenue generated from male and female

select gender,sum(purchase_amount) as revenue from customer group by gender

--Q2 Which customer use discount code and still spent more that than average purchase amount

select customer_id, purchase_amount
from customer where discount_applied = 'Yes' and purchase_amount >= (select avg(purchase_amount) from customer)

--Q3 Which is top 5 product with highest average review rating
select item_purchased,round(avg(review_rating)::numeric,2) as average_product_rating 
from customer 
group by item_purchased 
order by avg(review_rating) desc
limit 5;

--Q4 Compare the average purchase amount between standar and express shipping
select shipping_type,round(avg(purchase_amount),2)
from customer
where shipping_type in ('Standard','Express')
group by shipping_type

--Q5 Do subscribed customers spend more?
--Compare average spend and total revenue between subscribed and non-subscribed customers

select subscription_status,count(customer_id) as customers,round(avg(purchase_amount),2) as avg_spend,round(sum(purchase_amount))
as total_revenue from customer
group by subscription_status
order by total_revenue ,avg_spend desc;

--Q6 Which 5 product have highest percentage of purchases with discount applied 

select item_purchased,
round(100*sum(case when discount_applied = 'Yes' then 1 else 0 end)/count(*),2) as discount_rate
from customer
group by item_purchased
order by discount_rate desc
limit 5;

--Q7 Segment customer into new,returning and loyal based on their total no. of previous purchase \
--show the count of each segment

with customer_type as (
select customer_id,previous_purchases,
case
	when previous_purchases  = 1 then 'New'
	when previous_purchases between 2 and 10 then 'Returning' else 'Loyal'end as customer_segment 
from customer
)
select customer_segment, count(*) as "Number of customers" from customer_type
group by customer_segment

select age_group,sum(purchase_amount) as total_revenue from customer
group by age_group
order by total_revenue desc;
	







