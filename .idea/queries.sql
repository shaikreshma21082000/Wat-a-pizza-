create database pizzahub;

create table pizzahub.crust(
crid integer primary key,
crustname varchar(20),
price integer);
insert into pizzahub.crust values (1,'Wheat Thin Crust',60);
insert into pizzahub.crust values (2,'Fresh Pan Base',80);
insert into pizzahub.crust values (3,'Hand Tossed',70);

create table pizzahub.Toppings(
tid integer primary key,
toppingsname varchar(20),
price integer);
insert into pizzahub.toppings values (1,'Extra Cheese',80);
insert into pizzahub.toppings values (2,'Veg Toppings',120);


create table pizzahub.customer(
cuid integer primary key,
name varchar(20),
city varchar(20),
phonenumber long,
email varchar(30));
insert into pizzahub.customer values (1001,'Reshma','Manuguru',7386768425,'shaikreshma@gmail.com');
insert into pizzahub.customer values (1002,'Puja','Khammam',7386476609,'nallamothupuja@gmai.com');
insert into pizzahub.customer values (1004,'Anu','Hyderabad',9866595850,'anugnya@gmail.com');
insert into pizzahub.customer values (1005,'akhila','suryapeta',9059165245,'akhila@gmail.com');
insert into pizzahub.customer values (1006,'lavanya','warangal',9550846712,'lavanya@gmail.com');

create table pizzahub.menu(
pid integer primary key,
pizzaname varchar(25),
RegularSize integer,
MediumSize integer,
LargeSize integer,
PizzaType varchar(10)); 
insert into pizzahub.menu(pid,pizzaname,mediumsize,largesize,pizzatype) values(1001,'African Peri Peri Veg',350,450,'veg');
insert into pizzahub.menu(pid,pizzaname,mediumsize,largesize,pizzatype) values(1002,'Barbecue Veg',300,400,'veg');
insert into pizzahub.menu values(1003,'Jamaican Jerk Veg',250,350,450,'non-veg');
insert into pizzahub.menu values(1004,'What-a-pizza Exotic',200,300,400,'non-veg'); 
insert into pizzahub.menu values(1005,'english Cheddar',175,375,500,'non-veg'); 


select * from pizzahub.crust;
select * from pizzahub.toppings;
select * from menu;
select * from customer;


create table  pizzahub.orders (
orderid integer,
pid integer,foreign key(pid) references menu(pid),
crid integer,foreign key(crid) references crust(crid),
tid integer,foreign key(tid) references toppings(tid),
cuid integer,foreign key(cuid) references customer(cuid),
quantity integer,
size varchar(10),
orderdate Date,
bill integer,
primary key(orderid,pid),
deliverytype varchar(20)
);

insert into pizzahub.orders(orderid,pid,crid,tid,cuid,quantity,size,orderdate,bill,deliverytype) values(1,1001,1,1,1001,2,'large','2022-01-18',1180,'home delivery');
insert into pizzahub.orders values(2,1003,2,2,1002,3,'Medium','2022-01-13',1580,'take away');
insert into pizzahub.orders values(4,1005,3,1,1006,1,'large','2022-01-10',650,'home delivery');


#5.Include a category of Non-Veg pizza to the menu.
insert into pizzahub.menu values(1006,'chick pizza',200,300,400,'non-veg');

#6. Add an additional crust choice of cheese burst to the existing crust choices.
insert into pizzahub.crust values(4,'cheese burst',90);

#7. List all the menu items in the pizza outlet.
select * from menu;


#8. List all the customers who had ordered large sized pizza.
select customer.*,orders.size from orders
left join customer on
orders.cuid=customer.cuid
where orders.size='large';

#9. Find the most preferred topping.
select * from toppings
where tid in (select tid from pizzahub.orders
group by tid
order by count desc limit 1);



#10. Find the customer who has the highest bill amount.
select customer.name,orders.bill customer from customer
right join orders on
Orders.cuid=customer.cuid
where bill=(select max(bill) from orders);

 

#11. List the number of home deliveries.
select count(deliverytype) as count from orders 
where deliverytype='home delivery';

#12. Give 10 percent discount on the total bill to all customers who had ordered a large pizza. Update their bill amount accordingly.
select * from orders;
set sql_safe_updates=0;
update pizzahub.orders
set orders.bill=orders.bill-(orders.bill*0.1)
where orders.size='large';
select * from orders;




















