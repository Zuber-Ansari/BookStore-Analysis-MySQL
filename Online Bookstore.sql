-- create database for the project
create database bookstore_db;

-- select the database
use bookstore_db;

-- customer master table
create table customers (
    customer_id int primary key,
    name varchar(100),
    country varchar(50),
    signup_date date
);

-- books catalog
create table books (
    book_id int primary key,
    title varchar(150),
    genre varchar(50),
    price decimal(8,2)
);

-- orders placed by customers
create table orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    foreign key (customer_id) references customers(customer_id)
);

-- order details (many-to-many relationship)
create table order_items (
    order_item_id int primary key,
    order_id int,
    book_id int,
    quantity int,
    foreign key (order_id) references orders(order_id),
    foreign key (book_id) references books(book_id)
);

-- insert sample customers
insert into customers values
(1,'aman','india','2023-01-10'),
(2,'riya','india','2023-02-15'),
(3,'john','usa','2023-03-01'),
(4,'sara','uk','2023-03-20');

-- insert book records
insert into books values
(101,'atomic habits','non-fiction',15.99),
(102,'1984','fiction',9.99),
(103,'deep work','non-fiction',14.50),
(104,'harry potter','fiction',29.99);

-- insert customer orders
insert into orders values
(1001,1,'2023-04-01'),
(1002,2,'2023-04-05'),
(1003,1,'2023-05-10'),
(1004,3,'2023-05-15');

-- insert order items
insert into order_items values
(1,1001,101,1),
(2,1001,102,2),
(3,1002,103,1),
(4,1003,104,1),
(5,1004,102,1);

-- total revenue
select sum(b.price * oi.quantity) as total_revenue
from order_items oi
join books b on oi.book_id = b.book_id;

-- revenue by genre
select b.genre, sum(b.price * oi.quantity) as revenue
from order_items oi
join books b on oi.book_id = b.book_id
group by b.genre;

-- bestselling books by quantity
select b.title, sum(oi.quantity) as total_sold
from order_items oi
join books b on oi.book_id = b.book_id
group by b.title
order by total_sold desc;

-- top customers by total spending
select c.name, sum(b.price * oi.quantity) as total_spent
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
join books b on oi.book_id = b.book_id
group by c.name
order by total_spent desc;

-- repeat customers
select customer_id, count(order_id) as order_count
from orders
group by customer_id
having count(order_id) > 1;

-- monthly revenue trend
select date_format(o.order_date,'%y-%m') as month,
       sum(b.price * oi.quantity) as revenue
from orders o
join order_items oi on o.order_id = oi.order_id
join books b on oi.book_id = b.book_id
group by month
order by month;

-- rank books by revenue within genre
select genre, title, revenue,
rank() over (partition by genre order by revenue desc) as genre_rank
from (
    select b.genre, b.title, sum(b.price * oi.quantity) as revenue
    from order_items oi
    join books b on oi.book_id = b.book_id
    group by b.genre, b.title
) t;
