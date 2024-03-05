---------------------  Querys -------------------------------

-- Q1 what is the total amount each customer spent on zomato ?

SELECT a.userid, sum(b.price) as Total_amount_spend
from sales a
INNER JOIN product b
on a.product_id = b.product_id
GROUP BY a.userid;


-- Q2 how many days has each customer visited zomato ?

SELECT userid, COUNT(DISTINCT created_date) as distinct_days
from sales
GROUP by userid


-- Q3 what was the first product purchased by each customer ?

SELECT * FROM 
(SELECT *, rank() over(partition by userid ORDER by created_date) rank from sales) 
WHERE rank = 1;


-- Q4 what is the most purchased item on the menu and how many times was it purchased by all customers?demo

-- most purchased products 
SELECT product_id, COUNT(product_id)  
from sales
GROUP by product_id
ORDER by COUNT(product_id) DESC;


-- purchased by customer

SELECT userid, count(product_id) as cnt 
from sales
WHERE product_id = ( SELECT product_id  
                    from sales
                    GROUP by product_id
                    ORDER by COUNT(product_id) DESC)
GROUP by userid;


-- Q5 what item was the most popular fro each customer?

SELECT * from (
SELECT *, rank() over(partition by userid order by cnt DESC) as rnk
from ( SELECT userid, product_id, COUNT(product_id) as cnt
      from sales
      GROUP by userid, product_id))
where rnk = 1;


-- Q6 which item was purchased first by the customer after they became a member?

SELECT * from
(SELECT c.*, rank() over(partition by userid order by created_date) rnk 
from 
(SELECT a.userid, a.created_date, a.product_id, b.gold_signup_date
from sales a
INNER JOIN goldusers_signup b 
on a.userid = b.userid 
and created_date >= gold_signup_date) c)
WHERE rnk = 1;
                                 

-- Q7 which item was purchased just before the customer  became a member?

SELECT * from
(SELECT c.*, rank() over(partition by userid order by created_date DESC) rnk 
from 
(SELECT a.userid, a.created_date, a.product_id, b.gold_signup_date
from sales a
INNER JOIN goldusers_signup b 
on a.userid = b.userid 
and created_date <= gold_signup_date) c)
WHERE rnk = 1;



-- Q8 what is the total order and amount spent for each member before they became a member?

SELECT userid, COUNT(created_date) as order_purchased, sum(price) as total_apent from 
(SELECT c.*, d.price from
(SELECT a.userid, a.created_date, a.product_id, b.gold_signup_date
from sales a
INNER JOIN goldusers_signup b 
on a.userid = b.userid 
and created_date <= gold_signup_date) c 
INNER join product d
on c.product_id = d.product_id)
GROUP by userid;



-- Q9 rank all the transaction of the customers

SELECT *, rank() over(partition by userid ORDER by created_date) rnk 
from sales;



-- Q10  rank all the transaction for each member whenever they are a zomato gold member for every non gold member tranction mark as NA

SELECT e.*, CASE when rnk = 0 then 'NA' else rnk and  as rnkk from
(SELECT c.*, CAST(CASE when gold_signup_date is NULL then 0 else rank() over(partition by userid order by created_date desc ) end)  as varchar) as rnk from
(SELECT a.userid, a.created_date, a.product_id, b.gold_signup_date
from sales a
LEFT JOIN goldusers_signup b 
on a.userid = b.userid 
and created_date >= gold_signup_date) c) e;


