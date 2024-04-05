
--Lag & Lead function lag indicate previous record,and lead for next record
select first_name,last_name,salary,hire_date,lag(salary) over(order by hire_date),lead(salary) over(order by hire_date) 
from employees;

select * from sales2;

select product_id,sale_date,
lag(revenue) over(order by sale_date) as prev_rev,
revenue as current_revenue,
lead(revenue) over(order by sale_date) as next_date
from sales2;

select product_id,sale_date,
lag(revenue) over(partition by product_id order by sale_date) as prev_rev,
revenue as current_revenue,
lead(revenue) over(partition by product_id order by sale_date) as next_date
from sales2;

select product_id,sale_date,lag(revenue) over(order by sale_date) as prev_rev,
revenue as current_revenue,
lead(revenue) over(order by sale_date) as next_date,
case
when revenue> lag(revenue) over(partition by product_id order by sale_date) and
revenue > lead(revenue) over(partition by product_id order by sale_date) then 'high'
when revenue < lag(revenue)over(partition by product_id order by sale_date) and
revenue < lead(revenue) over(partition by product_id order by sale_date) then 'low'
else 'average' end revenue_status
from sales2;

--nvl and coalesce

select employee_id,first_name,commission_pct,manager_id from employees
where employee_id in(100,101,159,160);

select employee_id,first_name,nvl(commission_pct,0),manager_id from employees
where employee_id in(100,101,159,160);

select employee_id,first_name,nvl(commission_pct,0),coalesce(manager_id,commission_pct,employee_id) from employees
where employee_id in(100,101,159,160