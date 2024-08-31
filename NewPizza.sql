--Retrive the total order placed
select count(order_id) as Total_Orders from Pizza_Sale.dbo.orders

--Total revenue generated from pizza sale
SELECT 
    round(sum(od.quantity * p.price),2) AS revenue
FROM 
    Pizza_Sale.dbo.order_details AS od
INNER JOIN 
    Pizza_Sale.dbo.pizzas AS p ON od.pizza_id = p.pizza_id;

--Identify the quantity pizzas order
select quantity,count(order_details_id) as cnt
from order_details group by quantity

--Highest price of the pizza with name
SELECT TOP 1 pt.name, p.price
FROM pizza_types AS pt
INNER JOIN pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
ORDER BY p.price DESC;

--List the top 5 most ordered pizza types along with their qualities
SELECT TOP 5 
  pt.name, 
  SUM(od.quantity) AS total_quantity
FROM pizza_types AS pt
INNER JOIN pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
INNER JOIN order_details AS od ON p.pizza_id = od.pizza_id
GROUP BY pt.name
ORDER BY total_quantity DESC; 

--Join the necessary table to find the each pizza category order
Select pizza_types.category , sum(order_details.quantity) as quantity from
pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id
inner join order_details on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category 
order by quantity

--Distribution on based on hours
SELECT DATEPART(HOUR, orders.time) AS OrderHour, COUNT(order_id) AS OrderCount
FROM orders
GROUP BY DATEPART(HOUR, orders.time);

--Category wise distribution of pizzas
select pizza_types.category,count(name) as cnt from pizza_types group by category

--Group the order by date and calculate the average number of pizzas order by day
select avg(quantity) as Average from
(select orders.date ,sum(order_details.quantity) as quantity from orders
join order_details on orders.order_id = order_details.order_id group by orders.date) as orderQunatity

--Top 3 most ordered pizzas based on revenues
select top 3 pizza_types.name, sum(order_details.quantity*pizzas.price) as revenue
from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id 
join order_details on order_details.pizza_id =pizzas.pizza_id group by pizza_types.name
order by revenue desc

--Common size of pizzas ordered
select pizzas.size ,count(distinct order_details.order_id) as quantityOrdered from pizzas 
join order_details on order_details.pizza_id=pizzas.pizza_id  group by pizzas.size 
