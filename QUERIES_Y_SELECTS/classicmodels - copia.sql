/*QUERIES DAMUNT DB classicmodels*/
/*1. Per a cada client treure els seus pagaments.*/
SELECT * FROM payments;
SELECT * FROM customers;
SELECT customers.customerNumber, customers.customerName, payments.amount
FROM customers
INNER JOIN payments ON customers.customerNumber = payments.customerNumber;

/*2. Per a cada client treure les seves factures.*/
SELECT * FROM customers;
SELECT customers.customerNumber, customers.customerName, orders.orderNumber
FROM customers
INNER JOIN orders ON customers.customerNumber = orders.customerNumber;

/*3. Per a cada client treure les seves factures d’aquest any.*/
SELECT * FROM orders;
SELECT customers.customerNumber, customers.customerName, orders.orderDate
FROM customers
INNER JOIN orders ON customers.customerNumber = orders.customerNumber
AND YEAR(orderDate) = 2005;

/*4. Treim els clients amb les dades dels seus pagaments si en tenen. Sinó que tregui 
les dades dels clients. */
SELECT * FROM payments;
SELECT customers.customerNumber, payments.amount
FROM customers
LEFT JOIN payments ON customers.customerNumber = payments.customerNumber;

/*5. Treim un llistat de: per  a cada client les dades del seu empleat responsable de 
vendes.*/
SELECT * FROM employees;
SELECT * FROM customers;
SELECT customers.customerNumber, customers.customerName, customers.contactFirstName, 
customers.contactLastName, employees.employeeNumber, employees.firstName, employees.lastName
FROM customers
INNER JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber;

/*6. Treim un llistat on aparegui el nombre de factura i el seu total.*/
SELECT * FROM orders;
select orders.orderNumber, sum(orderdetails.priceEach * orderdetails.quantityOrdered) as total
from orders, orderdetails
where orders.orderNumber = orderdetails.orderNumber
group by orders.orderNumber order by orders.orderNUmber;

/*7. Treim un llistat on aparegui el nombre de factura i el seu total però sols si 
aquest total és major de 150 euros*/
SELECT * FROM orders;
select orders.orderNumber, sum(orderdetails.priceEach * orderdetails.quantityOrdered) as total
from orders, orderdetails
where orders.orderNumber = orderdetails.orderNumber
group by orders.orderNumber 
having total > 150;

/*8. Treim un llistat on aparequi les factures d’un producte amb un nom determinat.*/
SELECT * FROM products;
SELECT orderdetails.*, products.productName
FROM products
INNER JOIN orderdetails ON products.productCode = orderdetails.productCode
AND products.productName="1996 Moto Guzzi 1100i";

/*9. Treim un listat on aparegui per a cada client el seu total de factures (nombre de 
factures).*/
select customers.customerName, customers.contactFirstName, customers.contactLastName,
count(orders.orderNumber) as totalFacturas
from customers, orders
where customers.customerNumber = orders.customerNumber
group by customers.customerNumber order by customers.customerName;

/*10. Treim un llistat on aparegui per a cada client el seu total de factures (import de 
totes les factures).*/
select customers.customerName, customers.contactFirstName, customers.contactLastName, 
sum(orderdetails.priceEach * orderdetails.quantityOrdered) as total
from customers, orders, orderdetails
where customers.customerNumber = orders.customerNumber
and orders.orderNumber = orderdetails.orderNumber
group by customers.customerNumber order by customers.customerName;

/*11. Treim un llistat on aparegui per a cada client el seu total de factures (import de 
totes les factures) però sols dels clients que són d’’Alemanya o França.*/
select customers.customerName, customers.contactFirstName, customers.contactLastName, customers.country,
sum(orderdetails.priceEach * orderdetails.quantityOrdered) as total
from customers, orders, orderdetails
where customers.customerNumber = orders.customerNumber
and orders.orderNumber = orderdetails.orderNumber
and customers.country in ('France','Germany')/*o and customers.country = 'France' or customers.country = 'Germany' */
group by customers.customerNumber order by customers.customerName;

/*12. Treu el codi i nom dels productes que el seu preu és el mínim (exemple: si el preu 
mínim és 100, treure aquells productes que el seu preu és 100).*/
SELECT * FROM payments;
SELECT products.productCode, products.buyPrice
FROM products
WHERE products.buyPrice = (SELECT MIN(buyPrice) FROM products);

/*13. Treu el preu mínim, preu màxim i preu mitjà d’entre els preus de les ventes.*/
SELECT MIN(sub.total) as minimo, floor(AVG(sub.total)) as medio, MAX(sub.total) as maximo
FROM (SELECT sum(orderdetails.priceEach * orderdetails.quantityOrdered) as total
FROM orderdetails
GROUP BY orderdetails.orderNumber) as sub;

/*14. Selecciona el nombre de comanda, el nom del producte i la quantitat comanada de cada 
un dels productes, de totes aquelles comandes que no han estat servides.*/
SELECT * FROM orders;
SELECT orders.orderNumber, products.productName, orderdetails.quantityOrdered, orders.status
FROM orders
INNER JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
INNER JOIN products ON orderdetails.productCode = products.productCode
WHERE orders.status = 'on hold';

/*15. Selecciona el nombre de comanda, el nom del producte i la quantitat comanada de cada 
un dels productes, de totes aquelles comandes que no han estat servides i que la quantitat 
del producte en stock és menor a 3300 (imaginam que 3300 és la quantitat que sempre solen 
tenir com a garantia de poder servir les comandes).*/
SELECT orders.orderNumber, products.productName, orderdetails.quantityOrdered, orders.status
FROM orders
INNER JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
INNER JOIN products ON orderdetails.productCode = products.productCode
WHERE orders.status = 'on hold' 
AND products.quantityInStock < 3300;

/*16. Selecciona el nombre de comandes (total de comandes) de cada un dels anys. O sigui: 
per cada any el total de comandes d’aquell any. ORDERS*/
SELECT * from orders;
SELECT YEAR(orderDate) as año, count(orders.orderNumber) as total
FROM orders
GROUP BY YEAR(orderDate);

/*17. Selecciona per a cada any el total venut (el que s’ha cobrat). Ha de sortir ordenat per 
any. PAYMENTS*/
SELECT * FROM payments;
SELECT YEAR(paymentDate) as fecha, sum(amount)
FROM payments
GROUP BY year(paymentDate)
ORDER BY(fecha);

/*18. La mateixa consulta que abans , però sols ha de treure els anys en que els ingressos 
superen els 1800000.*/
SELECT * FROM payments;
SELECT YEAR(paymentDate) as fecha, sum(amount) as suma
FROM payments
GROUP BY year(paymentDate)
HAVING suma > 180000
ORDER BY(fecha);

/*19. Mostra els empleats que varen vendre algun producte el 2005. Suposarem que a un client 
sempre li ven l’empleat que és responsable d’ell (salesRepEmployeeNumber).*/
SELECT * FROM employees;
SELECT * FROM customers;
SELECT distinct salesRepEmployeeNumber as empleado
FROM customers
/*INNER JOIN orders ON customers.customerNumber = orders.customerNumber*/
WHERE EXISTS(SELECT customerNumber from orders where orders.customerNumber = customers.customerNumber AND YEAR(orderDate) = '2005');


/*20. Selecciona cada empleat quants de clients té. Ordena de major a menor nombre de clients. 
O sigui primer ha de sortir l’empleat que té més clients.*/
SELECT employees.employeeNumber, count(customerNumber) as nClients
FROM customers, employees
WHERE salesRepEmployeeNumber = employees.employeeNumber
GROUP BY employees.employeeNumber;

/*21. Mostra per a cada producte (codi, nom) el total que s’ha venut (els ingressos per aquest 
producte) l’any 2005.*/
SELECT * FROM orderdetails;
SELECT products.productCode as codigo, products.productName as producto, sum(orderdetails.priceEach * orderdetails.quantityOrdered) as total
FROM orderdetails, products, orders
WHERE products.productCode = orderdetails.productCode
AND orders.orderNumber = orderdetails.orderNumber
AND YEAR(orders.orderDate) = '2005'
GROUP BY codigo;

/*22. Mostra el nom dels clients que varen comprar el producte S10_1678.*/
SELECT distinct customers.customerName as cliente, products.productCode
FROM customers, orders, products, orderdetails
WHERE products.productCode = orderdetails.productCode
AND orders.orderNumber = orderdetails.orderNumber
AND customers.customerNumber = orders.customerNumber
AND products.productCode = "S10_1678";

/*23. Selecciona els empleats que no tenen cap client assignat.*/
SELECT * FROM customers;
SELECT employeeNumber as empleado, count(customers.customerNumber) as total
FROM employees
LEFT JOIN customers ON employees.employeeNumber = customers.salesRepEmployeeNumber
GROUP BY employees.employeeNumber
HAVING total = 0;
/*
SELECT employees.*
FROM employee
WHERE NOT EXISTS(SELECT * FROM customers WHERE customers.salesRepEmployeeNumber = employees.employeeNumber);
*/

/*24. Selecciona la informació de customers i el seu employee associat (en cas que en tinguin). 
Han d’apareixer tant aquells customers que tenen un employee associat com els que no els tenen.*/
SELECT distinct customers.*
FROM customers
LEFT JOIN employees ON  customers.salesRepEmployeeNumber = employees.employeeNumber;

/*25. Treu el codi i nom dels empleats que no tenen cap client associat.*/


/*26. Treu els empleats que tenen clients associats però aquests clients no han fet cap comanda.*/
SELECT employees.employeeNumber 
FROM employees, customers
WHERE employees.employeeNumber = customers.salesRepEmployeeNumber
AND NOT EXISTS(SELECT  *FROM orders
WHERE orders.customerNUmber = customers.customerNumber);

/*29. Fes una taula que contingui un resum de les vendes. Camps: codi client, import_total (import del 
total venut: orders, ordersdetails), any.*/
SELECT orders.customerNumber, year(orders.orderDate), sum(orderdetails.priceEach * orderdetails.quantityOrdered)
FROM orders, orderdetails
WHERE orders.orderNumber = orderdetails.orderNumber
GROUP BY orders.customerNumber, orders.orderDate;

/*27. Mostra el codi de client i “Menor”, “Major” en funció de si el seu límit de crèdit és major o 
menor a 100000.*/
SELECT customerNumber,
CASE WHEN creditLimit < 100000 THEN 'Menor'
WHEN creditLimit > 100000 THEN 'Major'
ELSE 'Es igual a 100000'
END AS creditLimitText
FROM customers;

/*28. Selecciona el nombre de client i les seves dues adreces. Les seves adreces han de sortir en una 
sola columna separades per els caràcters **. Alerta que hi ha camps que poden ser null.*/
SELECT customerNumber, concat(addressLine1, "**", ifnull(addressLine2, ""))
FROM customers;

/*30. Quins clients tenen el seu creditLimit per damunt del credit limit de qualsevol client del 
representant 1165.*/
SELECT * FROM customers;
SELECT customerNumber, creditLimit
FROM customers as c1
WHERE creditLimit > ALL
  (SELECT creditLimit
  FROM customers as c2
  WHERE salesRepEmployeeNumber = 1165); 

/*31. Mostra els clients que tenen el seu creditLimit per damunt d’algun dels clients del 
representant 1165.*/
SELECT * FROM customers;
SELECT customerNumber, creditLimit
FROM customers as c1
WHERE creditLimit > ANY
  (SELECT creditLimit
  FROM customers as c2
  WHERE salesRepEmployeeNumber = 1165); 

/*32. Mostra en un sol llistat:  els codis, noms dels clients que han fet algun pagament 
i els codis, noms dels clients que han fet una comanda.  No ha de mostrar els repetits.*/
SELECT DISTINCT payments.customerNumber
FROM payments
UNION ALL 
SELECT DISTINCT orders.customerNumber
FROM orders;

/*33. Mostra en un sols llistat:  els codis, noms dels clients que han fet algun pagament 
i els codis, noms dels clients que han fet una comanda.  A devora els clients de pagament 
ha de posar pagament i a devora els d’orders ha de posar orders.*/
SELECT DISTINCT payments.customerNumber, "pagament"
FROM payments
UNION
SELECT DISTINCT orders.customerNumber, "ordres"
FROM orders;

/*34. Treu per a cada employee el nombre de clients que té. També has de treure el total.*/
SELECT employeeNumber as empleado, count(customers.customerNumber) AS total
FROM employees
INNER JOIN customers ON employees.employeeNumber = customers.salesRepEmployeeNumber
GROUP BY employees.employeeNumber WITH ROLLUP;

/*35. Selecciona les comandes (orders) de l’oficina de la ciutat de San Francisco.*/
SELECT * FROM orders;
SELECT orders.orderNumber, offices.city
from orders, employees, offices, customers
WHERE employees.employeeNumber = customers.salesRepEmployeeNumber
AND orders.customerNumber = customers.customerNumber
AND offices.city = "San Francisco";

/*36. Selecciona les comandes (orders) de l’oficina de San Francisco del producte 
Motorcycles.*/
SELECT * FROM products;
SELECT orders.orderNumber, productlines.productLine, offices.city
from orders, employees, offices, customers, products, productlines
WHERE employees.employeeNumber = customers.salesRepEmployeeNumber
AND orders.customerNumber = customers.customerNumber
AND products.productLine = productlines.productLine
AND offices.city = "San Francisco"
AND products.productLine = "Motorcycles";

/*37. Selecciona quantes comandes hi ha per cada oficina fetes l’any 2005.*/
SELECT * FROM offices;
SELECT offices.officeCode, count(orders.orderNumber)
FROM orders, offices, employees, customers
WHERE offices.officeCode = employees.officeCode
AND employees.employeeNumber = customers.salesRepEmployeeNumber
AND customers.customerNumber = orders.customerNumber
AND YEAR(orders.orderDate) = '2005'
GROUP BY officeCode
ORDER BY officeCode;

/*38. Mostra quines comandes tenen més de 3 productes distints.*/
SELECT * FROM orderdetails;
SELECT orderdetails.orderNumber, count(orderdetails.productCode) as product
FROM orderdetails
GROUP BY orderdetails.orderNumber
HAVING product > 3;

/*39. Mostra per a cada producte la quantitat comanada (suma de les 
quantitats comanades) . Sols s’ha de fer per les comandes no servides. A més 
sols hem de mostrar aquells productes que la quantitat en stock està per davall 
la quantitat demanada.*/
SELECT * FROM orderdetails;
SELECT orderdetails.productCode, products.quantityInStock, sum(orderdetails.quantityOrdered) as comanadas
FROM orderdetails, orders, products
WHERE products.productCode = orderdetails.productCode
AND orderdetails.orderNumber = orders.orderNumber
AND orders.shippedDate is null
GROUP BY orderdetails.productCode
HAVING comanadas > products.quantityInStock;

/*40. Treu la mitjana d’empleats d’oficines.*/
SELECT floor(AVG(sub.totalEmpleados)) as mediaEmpleados
FROM (SELECT count(employees.employeeNumber) as totalEmpleados
FROM employees, offices
WHERE offices.officeCode = employees.officeCode
GROUP BY employees.employeeNumber) as sub;

/*41. Mostra les factures del client Atelier graphique.*/
SELECT * FROM customers;
SELECT * FROM orders;
SELECT orders.orderNumber, customers.customerNumber
FROM orders, customers
WHERE customers.customerNumber = orders.customerNumber
AND customers.customerName = "Atelier graphique";

/*42. Selecciona per a cada client de l’oficina de San Francisco 
la quantitat de comandes fetes.*/
SELECT customers.customerNumber, offices.city, orders.status, count(orders.orderNumber)
FROM orders, customers, employees, offices
WHERE employees.officeCode = offices.officeCode
AND customers.salesRepEmployeeNumber = employees.employeeNumber
AND orders.customerNumber = customers.customerNumber
AND offices.city = "San Francisco"
AND orders.status = "Shipped"
GROUP BY customers.customerNumber;

/*43. Selecciona per a cada oficina i any el seu nombre de comandes 
sempre i quan l’oficina no sigui la de San Francisco. Ordena per 
oficina i any. */
SELECT * FROM offices;
SELECT offices.officeCode as oficina, YEAR(orders.orderDate) as any, count(orders.orderNumber) as suma
FROM offices, orders, employees, customers
WHERE offices.city NOT LIKE "San Francisco"
AND offices.officeCode = employees.officeCode
AND employees.employeeNumber = customers.salesRepEmployeeNumber
AND customers.customerNumber = orders.customerNumber
GROUP BY offices.officeCode, YEAR(orders.orderDate)
ORDER BY offices.officeCode, orders.orderDate;

/*44. Selecciona si hi ha alguna oficina que no té comandes fetes el 2005.*/
SELECT * FROM offices;
SELECT offices.officeCode
FROM offices, orders, employees, customers
WHERE NOT EXISTS (SELECT orders.orderNumber
FROM employees, customers, orders
WHERE offices.officeCode = employees.officeCode
AND employees.employeeNumber = customers.salesRepEmployeeNumber
AND customers.customerNumber = orders.customerNumber
AND YEAR(orders.orderDate) NOT LIKE '2005');

/*45. Selecciona per a cada client el total de productes comprats. El nom 
del client s’ha de mostrar en una sola columna. Sols s’han de tenir en compte 
els productes comprats el 2005 que el seu preu està per damunt 100000.*/
SELECT customers.customerName, count(orderdetails.productCode), YEAR(orders.orderDate)
FROM customers, orders, orderdetails
WHERE customers.customerNumber = orders.customerNumber
AND orders.orderNumber = orderdetails.orderNumber
AND orderdetails.priceEach > 100
AND YEAR(orders.orderDate) = '2005'
GROUP BY customers.customerNumber;

/*46. Selecciona per a cada client el total de productes comprats sempre i quan aquest 
total estigui per damunt 4. S’ha de tenir en compte el nombre de productes distints no 
el nombre d’unitats de producte. El nom del client s’ha de mostrar en una sola columna. 
Sols s’han de tenir en compte els productes comprats el 2005 que el seu preu està per 
damunt 1000.*/
SELECT * FROM orderdetails;
SELECT customers.customerNumber, count(orderdetails.productCode) AS producto
FROM customers, orderdetails, orders, products
WHERE customers.customerNumber = orders.customerNumber
AND orders.orderNumber = orderdetails.orderNumber
AND YEAR(orders.orderDate) = '2005'
AND orderdetails.priceEach > 1000
GROUP BY customers.customerNumber, orderdetails.productCode
HAVING count(products.productCode) > 4;

/*47. Selecciona quins clients han comprat alguns dels productes que ha comprat el 
client 103. El llistat ha de sortir ordenat per customerNumber.*/
SELECT DISTINCT customers.customerNumber
FROM customers, orders, orderdetails
WHERE customers.customerNumber = orders.customerNumber
AND orders.orderNumber = orderdetails.orderNumber
AND orderdetails.productCode IN (
SELECT products.productCode 
FROM orders, orderdetails, products
WHERE orders.orderNumber = orderdetails.orderNumber
AND orders.customerNumber = 103)
ORDER BY customers.customerNumber;

/*48. Selecciona quants de empleats són de l’oficina de San Francisco i quants 
d’empleats no són de l’oficina de San Francisco. Ha de sortir en una mateixa consulta.*/
SELECT * FROM employees;
SELECT count(employees.employeeNumber) as empleados
FROM employees, offices
WHERE employees.officeCode = offices.officeCode
AND offices.city = "San Francisco"
UNION
SELECT count(employees.employeeNumber) 
FROM employees, offices
WHERE employees.officeCode = offices.officeCode
AND offices.city != "San Francisco";

/*49. Selecciona quins empleats no tenen cap client amb comandes fetes i estan a la 
mateixa oficina que l’empleat 1.*/
SELECT e1.employeeNumber
FROM employees as e1, offices
WHERE e1.officeCode IN (
SELECT offices.officeCode 
FROM employees as e2
WHERE e2.employeeNumber = 1)
AND NOT EXISTS (
SELECT * 
FROM customers, orders
WHERE e1.employeeNumber = customers.salesRepEmployeeNumber
AND customers.customerNumber = orders.customerNumber)
AND e1.employeeNumber != 1;

/*50. Selecciona quins clients no han fet cap comanda el 2005 i sí n’han fetes el 2004.*/
SELECT * FROM orders;
SELECT orders.*
FROM customers, orders
WHERE customers.customerNumber = orders.customerNumber
AND YEAR(orders.orderDate) = 2004
AND customers.customerNumber NOT IN (
SELECT orders.customerNumber
FROM orders
WHERE YEAR(orders.orderDate) = 2005
);

/*51. Selecciona quines línies de productes tenen més productes que la línia Motorcycles.*/
SELECT * FROM productlines;
SELECT productlines.productLine
FROM productlines, products
WHERE productlines.productLine = products.productLine
AND products.productLine != "Motorcycles"
GROUP BY productlines.productLine
HAVING count(products.productCode) > (
SELECT count(products.productCode)
FROM products
WHERE products.productLine = "Motorcycles");

/*52. Selecciona el nom dels productes que varen ser comanats més vegades l’any 2005 i els 
productes que varen ser comenats menys vegades l’any 2005.*/
select productCode, sum(quantityordered)
from orderdetails, orders
where orderdetails.orderNumber= orders.orderNumber
and year(orders.orderDate)=2005
group by productCode
order by sum(quantityordered) desc
limit 10;

select productCode, sum(quantityordered)
from orderdetails, orders
where orderdetails.orderNumber= orders.orderNumber
and year(orders.orderDate)=2005
group by productCode
order by sum(quantityordered) asc
limit 10;

/*53. Selecciona quines línies de productes tenen més de 10 productes.*/
SELECT * FROM products;
SELECT productLine, count(products.productCode) AS contar
FROM products
GROUP BY productLine
HAVING contar > 10;

/*54. Selecciona quins clients no tenen cap empleats associat però tenen comandes.*/
SELECT * FROM customers;
SELECT customers.*
FROM customers
WHERE customers.salesRepEmployeeNumber IS NULL
AND customers.customerNumber IN (
SELECT DISTINCT customers.customerNumber
FROM orders);

/*55. Selecciona el client que ens ha gastat més (pot ser n’hi hagi més d’un).*/
select o.customerNumber, sum(d.priceEach*d.quantityOrdered) total
from orders o , orderdetails d
where o.orderNumber = d.orderNumber
group by o.customerNumber
having total = ( select max(total)
from (select o.customerNumber idclient, sum(d.priceEach*d.quantityOrdered) total
from orders o , orderdetails d
where o.orderNumber = d.orderNumber
group by idclient) taula2
);

/*SEGUNDA VERSIÓN PROFE*/
CREATE VIEW totalGastat AS 
select o.customerNumber idclient, sum(d.priceEach*d.quantityOrdered) total
from orders o , orderdetails d
where o.orderNumber = d.orderNumber
group by idclient;

select idclient, total
from totalGastat
where total = (select max(total) from totalGastat);

/*56. Selecciona els 3 clients que ens han comprat més.*/
SELECT customers.customerNumber, sum(orderdetails.quantityOrdered*orderdetails.priceEach) AS compradoMas
FROM orderdetails, orders, customers
WHERE orders.orderNumber = orderdetails.orderNumber
AND customers.customerNumber = orders.customerNumber
GROUP BY customers.customerNumber
ORDER BY compradoMas DESC
LIMIT 3;


CREATE VIEW totalComprado AS 
select customers.customerNumber, sum(orderdetails.priceEach*orderdetails.quantityOrdered) total
from orders, orderdetails, customers
where orders.orderNumber = orderdetails.orderNumber
group by customers.customerNumber;

select customers.customerNumber, total
from totalComprado
where total = (select max(total) from totalGastat);

/*58. Selecciona quins clients ens deuen doblers (han comprat més que no pagat).*/
/* MÍO
SELECT orders.customerNumber, sum(orderdetails.quantityOrdered*orderdetails.priceEach) AS total, sum(total - sum(payments.amount)) AS pagado
FROM orderdetails, orders
WHERE orders.orderNumber = orderdetails.orderNumber
GROUP BY orders.customerNumber
having total > (select orders.customerNumber, sum(orderdetails.quantityOrdered*orderdetails.priceEach) AS total, sum(total - sum(payments.amount)) AS pagado
from orders, orderdetails
where orders.orderNumber = orderdetails.orderNumber
group by customers.customerNumber);
*/

SELECT payments.customerNumber, sum(payments.amount) as pagado
FROM payments
GROUP BY payments.customerNumber
HAVING pagado < (SELECT total
FROM totalGastat
WHERE customers.customerNumber = payments.customerNumber);

/*59. Treu un llistat d’empleats juntament amb els empleats que depenen d’ells.*/
SELECT concat(employees.firstName, " ", employees.lastName) as e1, concat(employees.firstName, " ", employees.lastName) as e2
FROM employees AS e1, employees AS e2
WHERE e1.salesRepEmployeeNumber = e2.employeeNumber
ORDER BY e2;

/*60. Quina diferència hi ha entre el productes comprats pel client 103 i el 112 
(quants de productes ha comprat més el 103 que el 112 o al revés). a) Treim la 
diferència de la quantitat b) Treim quins codis ha comprat un que no ha comprat l’altre.*/

/*a)*/
SELECT
(SELECT COUNT(orderdetails.productCode)
FROM orders, orderdetails
WHERE orders.orderNumber = orderdetails.orderNumber
AND orders.customerNumber = 103)
-
(SELECT COUNT(orderdetails.productCode)
FROM orders, orderdetails
WHERE orders.orderNumber = orderdetails.orderNumber
AND orders.customerNumber = 112);

/*b)*/
SELECT COUNT(orderdetails.productCode)
FROM orders, orderdetails
WHERE orders.orderNumber = orderdetails.orderNumber
AND orders.customerNumber = 103
AND orderdetails.productCode NOT IN (
SELECT orderdetails.productCode
FROM orders, orderdetails
WHERE orders.orderNumber = orderdetails.orderNumber
AND orders.customerNumber = 112
);

SELECT COUNT(productCode)
FROM orders as o1, orderdetails as od1
WHERE o1.orderNumber = od1.orderNumber
AND o1.customerNumber = 103
AND NOT EXISTS (
SELECT *
FROM orders as o2, orderdetails as od2
WHERE o2.orderNumber = od2.orderNumber
AND o2.customerNumber = 112
AND od1.productCode = od2.productCode
);

/*61. Imagina que has arribat a la conclusió que estaria bé tenir una vista que 
tingués la següent informació: any_compra, codi client, producte comprat, total 
(sum de quantity * price). Fes aquesta vista i després implementa 2 consultes damunt 
d’aquesta vista. Afegeix registres a la taula (fent ús del rollback, per tal que no 
deixar-los desats) i comprova que la vista s’actualitza automàticament.*/
CREATE VIEW comprasClientes AS 
SELECT YEAR(orders.orderDate) as any1, orders.customerNumber as cliente1, orderdetails.productCode as producto1, 
orderdetails.quantityOrdered * orderdetails.priceEach as total1
FROM orders, orderdetails
WHERE orderdetails.orderNumber = orders.orderNumber
GROUP BY any1, cliente1, producto1;

/*Total comprat el 2005 pel client 101*/
SELECT sum(total1) FROM comprasClientes WHERE any1=2005 AND cliente1=101;

/*Treure la mithana de compres en euros per any*/
SELECT avg(total2) FROM (SELECT any2, sum(total1) as total2
FROM comprasCliente /*hay que crear otra vista*/
GROUP BY any2) as t1;

/*62. Assigna als clients que no tenen cap empleat assignat un empleat aleatori 
de l’oficina de San Francisco.*/
SELECT * FROM customers;

UPDATE customers
SET salesRepEmployeeNumber = (SELECT emp.employeeNumber FROM employees AS emp,
offices as off
WHERE emp.officeCode = off.officeCode AND off.city = 'San Francisco'
ORDER BY RAND() LIMIT 1)
WHERE customers.salesRepEmployeeNumber IS NULL;


SELECT customers.customerNumber
FROM customers, employees
WHERE customers.salesRepEmployeeNumber IS NULL
GROUP BY customers.customerNumber
ORDER BY customers.customerNumber;



/*   REPASO QUERIES EN CLASE 8M   */

/*1. Treure els pagaments de la oficina1 .*/
SELECT * FROM employees;
SELECT payments.* 
FROM payments, customers, employees
WHERE employees.employeeNumber = customers.salesRepEmployeeNumber
AND customers.customerNumber = payments.customerNumber
AND employees.officeCode = 1;

/*2. Treure els customers que no tenen cap pagament fet.*/
SELECT cust.* 
FROM customers as cust
WHERE NOT EXISTS (
SELECT customers.customerNumber 
FROM payments, customers
WHERE payments.customerNumber = cust.customerNumber
);

/*3. Treure els customers i els seus pagaments si en tenen, sino
sols les dades del customers.*/
SELECT customers.*, payments.*
FROM customers
LEFT JOIN payments
ON customers.customerNumber = payments.customerNumber
ORDER BY customers.customerNumber;

/*4. Treure un llistat de productes. Ha de sortir el nom del producte, 
id. > 100 si stock > 100 i <= 100 si stock <= 100.*/
SELECT products.productCode,
CASE WHEN products.quantityInStock > 100 THEN '> 100'
WHEN products.quantityInStock <= 100 THEN '<= 100'
END AS Texto
FROM products;

SELECT products.productName, "> 100"
FROM products
WHERE products.quantityInStock > 100
UNION
SELECT products.productName, "<= 100"
FROM products
WHERE products.quantityInStock <= 100;

/*5. Customers que tenen més de tres pagaments en el 2005 i son de
la oficina1.*/
SELECT customers.customerNumber, count(payments.checkNumber) as cantidad
FROM customers, payments, employees
WHERE customers.salesRepEmployeeNumber = employees.employeeNumber
AND payments.customerNumber = customers.customerNumber
AND employees.officeCode = 1
AND YEAR(payments.paymentDate) = 2005
GROUP BY customers.customerNumber
HAVING count(payments.customerNumber) >= 2;

/*6. Customer que tenen totes les seves comandes fora servir.*/
SELECT * FROM orders;

SELECT customers.customerNumber
FROM customers
WHERE customers.customerNumber = ALL 
(SELECT customers.customerNumber
FROM customers, orders
WHERE orders.status != 'Shipped');

/*7. Selecciona els productes que tenen la quantitat en stock que coincideix
amb la máxima.*/
SELECT products.*
FROM products
WHERE products.quantityInStock = (
SELECT max(products.quantityInStock)
FROM products
);

/*8. Clients que son de la mateixa oficina que el client1.*/
SELECT * FROM customers;
SELECT customers.*
FROM customers, employees
WHERE customers.salesRepEmployeeNumber = employees.employeeNumber
AND employees.officeCode =
(SELECT offices.officeCode
FROM offices, customers, employees
WHERE customers.customerNumber = 1
AND customers.salesRepEmployeeNumber = employees.employeeNumber);



/*   REPASO QUERIES EN CLASE 24 MARZO   */

/*1. Selecciona de forma aleatoria tres oficinas que no tengan 
empleados.*/
SELECT offices.officeCode
FROM offices
WHERE NOT EXISTS (
SELECT offices.officeCode
FROM offices
ORDER BY RAND() LIMIT 3);

/*2. Los customers que tengan el crédito límite menor a 10 les 
tenemos que asignar el crédito límite máximo. Además para hacer 
la prueba pero no guardar cambios.*/
SET AUTOCOMMIT = 0;
set sql_safe_updates = 0;

UPDATE customers 
SET creditLimit = (SELECT tb1.maximo FROM (
SELECT MAX(customers.creditLimit) as maximo FROM customers) as tb1)
WHERE customers.creditLimit < 10;

rollback;
SET AUTOCOMMIT = 1;

/*3. Los pagos mayores a 1000 euros de los clientes que su 
empleado asociado es de la misma oficina que el empleado 1002.*/
SELECT * FROM payments;

SELECT payments.amount, customers.customerNumber
FROM customers, payments, employees, offices
WHERE customers.customerNumber = payments.customerNumber
AND customers.salesRepEmployeeNumber = employees.employeeNumber
AND employees.officeCode = offices.officeCode
AND payments.amount > 1000
AND employees.officeCode = (
SELECT officeCode
FROM employees
WHERE employees.employeeNumber = 1002)
ORDER BY payments.amount;

/*4. Para cada empleado y producto saca el total comprado (euros).
Ordenado por empleado y producto.*/
SELECT employees.employeeNumber, orderdetails.productCode, 
sum(orderdetails.quantityOrdered * orderdetails.priceEach)
FROM orderdetails, employees, orders, customers
WHERE orderdetails.orderNumber = orders.orderNumber
AND orders.customerNumber = customers.customerNumber
AND customers.salesRepEmployeeNumber = employees.employeeNumber
GROUP BY employees.employeeNumber, orderdetails.productCode
ORDER BY employees.employeeNumber, orderdetails.productCode;

/*5. Que compran (en euros) a cada empleado de media.*/
SELECT AVG(t1.total)
FROM (
SELECT employees.employeeNumber, sum(quantityOrdered * priceEach) as total
FROM employees, customers, orders, orderdetails
WHERE employees.employeeNumber = customers.salesRepEmployeeNumber
AND customers.customerNumber = orders.customerNumber
AND orders.orderNumber = orderdetails.orderNumber
GROUP BY employeeNumber) as t1;

USE classicmodels;

/*6. Que orderdetails la quantityOrdered está por encima de la media de 
quantityOrdered de ese producto.*/
SELECT * FROM orderdetails;
SELECT orderdetails.*
FROM orderdetails
WHERE orderdetails.quantityOrdered > 
(SELECT AVG(orderdetails.quantityOrdered)
FROM orderdetails);

SELECT AVG(orderdetails.quantityOrdered)
FROM orderdetails;

/*codigo fatima
select o1.* from orderdetails o1
where o1.quantityOrdered > (
select avg(o2.quantityOrdered)
from orderdetails as o2 where o2.productCode = o1.productCode);
*/

/*7. Que productos se piden siempre más de 10 unidades.*/
SELECT p1.*
FROM products as p1
WHERE p1.productCode = ALL (
SELECT o1.productCode
FROM orderdetails as o1
WHERE o1.productCode = p1.productCode
AND o1.quantityOrdered > 10);

/*8. El total(total ordenes) de comandas por producto y oficina.*/
CREATE VIEW comandasOficina AS
SELECT count(orders.orderNumber) as total
FROM products, orders, employees, customers, orderdetails
WHERE orders.customerNumber = customers.customerNumber
AND orderdetails.orderNumber = orders.orderNumber
AND customers.salesRepEmployeeNumber = employees.employeeNumber
GROUP BY orderdetails.productCode, employees.officeCode;

SELECT * FROM comandasOficina;

/*9.*//*NO FUNCIONA*/
SELECT products.productName, comandasOficina.officeCode, comandasOficina.total
FROM products, comandasOficina
WHERE comandasOficina.productCode = products.productCode;

/*10. Cuales son los productos/oficina más pedidos (que coincide con el máximo).*/
SELECT * FROM comandasOficina
WHERE total = (SELECT max(total) as max 
FROM comandasOficina);

/*11. A las ordenes del 2005 le tenemos que asignar la fecha máxima del 2005.*/
set autocommit = 0;


