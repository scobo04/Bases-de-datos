USE `classicmodels`;

/*1*/
describe customers;
describe payments;

select customers.customerName, customers.contactFirstName, 
customers.contactLastName, payments.checkNumber, payments.paymentDate,payments.amount
from customers, payments
where customers.customerNumber = payments.customerNumber;

/*2*/
describe customers;
describe orders;
describe orderdetails;
describe products;

select customers.customerName, customers.contactFirstName, 
customers.contactLastName, products.productName, orderdetails.quantityOrdered, orderdetails.priceEach
from customers, products, orderdetails, orders
where customers.customerNumber = orders.customerNumber
and orders.orderNumber = orderdetails.orderNumber
and orderdetails.productCode = products.productCode;

select customers.customerName, customers.contactFirstName, 
customers.contactLastName, orders.orderNumber
from customers, orders
where customers.customerNumber = orders.customerNumber;

/*3*/
describe customers;
describe orders;
describe orderdetails;
describe products;

select customers.customerName, customers.contactFirstName, 
customers.contactLastName, products.productName, orders.orderDate ,orderdetails.quantityOrdered, orderdetails.priceEach
from customers, products, orderdetails, orders
where customers.customerNumber = orders.customerNumber
and orders.orderNumber = orderdetails.orderNumber
and orderdetails.productCode = products.productCode
and year(orders.orderDate) = "2004";
/* and year(orders.orderDate ) =  year(curdate()); Pondriamos esto para aparezca los de este año pero 
no hay ninguno por eso voy a poner uno especifico*/

select customers.customerName, customers.contactFirstName, 
customers.contactLastName, orders.orderNumber , orders.orderDate
from customers, orders
where customers.customerNumber = orders.customerNumber
and year(orders.orderDate) = "2004";

/* and year(orders.orderDate ) =  year(curdate()); Pondriamos esto para aparezca los de este año pero 
no hay ninguno por eso voy a poner uno especifico*/

/*4*/
describe customers;
describe payments;

select customers.customerName, customers.contactFirstName, customers.contactLastName,
payments.checkNumber, payments.paymentDate, payments.amount
from customers
left join payments
on customers.customerNumber = payments.customerNumber;

/*5*/
describe customers;
describe employees;

select customers.customerName, customers.contactFirstName, customers.contactLastName,
employees.firstName as employee_Number , employees.lastName as employee_LastName, employees.extension, employees.officeCode
from customers, employees
where customers.salesRepEmployeeNumber = employees.employeeNumber order by customers.customerName;

/*6*/
select * from orders;
select * from orderdetails;

select orders.orderNumber, sum(orderdetails.priceEach * orderdetails.quantityOrdered) as total
from orders, orderdetails
where orders.orderNumber = orderdetails.orderNumber
group by orders.orderNumber order by orders.orderNUmber;

/*7*/
select * from orderdetails;
select orders.orderNumber, sum(orderdetails.priceEach * orderdetails.quantityOrdered) as total
from orders, orderdetails
where orders.orderNumber = orderdetails.orderNumber
group by orders.orderNumber 
having total > 150;

/*No se por que el alias total no me sirve en el where. Preguntar profe
Porque se tenia que usar el having.
*/


/*8*/
describe orderdetails;

select products.productName, orderdetails.orderNUmber
from products, orderdetails
where orderdetails.productCode = products.productCode
and products.productName = 'collectable wooden train'
order by orderdetails.orderNumber;

/*9*/
describe customers;
describe orders;

select customers.customerName, customers.contactFirstName, customers.contactLastName,
count(orders.orderNumber) as totalFacturas
from customers, orders
where customers.customerNumber = orders.customerNumber
group by customers.customerNumber order by customers.customerName;

/*10*/
select customers.customerName, customers.contactFirstName, customers.contactLastName, 
sum(orderdetails.priceEach * orderdetails.quantityOrdered) as total
from customers, orders, orderdetails
where customers.customerNumber = orders.customerNumber
and orders.orderNumber = orderdetails.orderNumber
group by customers.customerNumber order by customers.customerName;

/*11*/

select customers.customerName, customers.contactFirstName, customers.contactLastName, customers.country,
sum(orderdetails.priceEach * orderdetails.quantityOrdered) as total
from customers, orders, orderdetails
where customers.customerNumber = orders.customerNumber
and orders.orderNumber = orderdetails.orderNumber
and customers.country in ('France','Germany')/*o and customers.country = 'France' or customers.country = 'Germany' */
group by customers.customerNumber order by customers.customerName;

/*12*/
select * from orderdetails;

/*Si te rrefieres al precio minimo*/
select products.productCode, products.productName, products.buyprice
from products
where products.buyprice in (select min(buyprice) from products)
group by products.productCode;

/*Si te refieres al numero minimo de cada producto*/
select products.productCode, products.productName, min(orderdetails.priceEach) as minimo
from products, orderdetails
where products.productCode = orderdetails.productCode
group by products.productCode order by minimo;


select products.productCode, products.buyPrice as minimo
from products as p
where products.buyPrice = (select min (p1.buyPrice) from products as p1 );

/*13*/
select min(orderdetails.priceEach * orderdetails.quantityOrdered) as minimo , 
max(orderdetails.priceEach * orderdetails.quantityOrdered) as maximo, 
avg(orderdetails.priceEach * orderdetails.quantityOrdered) as media
from orderdetails;

/*14*/
select * from orders where status = "On hold";
describe orders;

select orders.orderNumber, products.productName, orderdetails.quantityOrdered
from orderdetails, products, orders
where products.productCode = orderdetails.productCode
and orderdetails.orderNumber = orders.orderNumber
and orders.status = "on hold";

/*15*/
select orders.orderNumber, products.productName, orderdetails.quantityOrdered, products.quantityInStock
from orderdetails, products, orders
where products.productCode = orderdetails.productCode
and orderdetails.orderNumber = orders.orderNumber
and orders.status = "on hold"
and products.quantityInStock < 3300;