/*   REPASAR EJERCICIOS Queries damunt DB classicmodels   */
USE `classicmodels`;

/*1. Per a cada client treure els seus pagaments.*/
SELECT payments.*
FROM customers, payments
WHERE customers.customerNumber = payments.customerNumber;

/*2. Per a cada client treure les seves factures.*/
SELECT customers.customerNumber, orderdetails.*
FROM customers, orderdetails, orders
WHERE customers.customerNumber = orders.customerNumber
AND orders.orderNumber = orderdetails.orderNumber;

/*3. Per a cada client treure les seves factures d’aquest any.*/
SELECT customers.customerNumber, orderdetails.*, YEAR(orders.orderDate) AS anio
FROM customers, orderdetails, orders
WHERE customers.customerNumber = orders.customerNumber
AND orders.orderNumber = orderdetails.orderNumber
AND YEAR(orders.orderDate) = 2005;

/*4. Treim els clients amb les dades dels seus pagaments si en tenen. Sinó tenen 
pagaments que tregui les dades dels clients.*/
SELECT customers.*
FROM customers
LEFT JOIN payments ON customers.customerNumber = payments.customerNumber;

/*5. Treim un llistat de: per a cada client les dades del seu empleat responsable 
de vendes.*/
SELECT customers.customerNumber, customers.customerName, employees.employeeNumber
FROM customers, employees
WHERE customers.salesRepEmployeeNumber = employees.employeeNumber
ORDER BY customers.customerNumber;

/*6. Treim un llistat on aparegui el nombre de factura i el seu total.*/
SELECT * FROM orderdetails;
SELECT orders.orderNumber, sum(orderdetails.priceEach * orderdetails.quantityOrdered) AS total
FROM orders, orderdetails
WHERE orders.orderNumber = orderdetails.orderNumber
GROUP BY orders.orderNumber;

/*7. Treim un llistat on aparegui el nombre de factura i el seu total però 
sols si aquest total és major de 150 euros.*/
SELECT orders.orderNumber, sum(orderdetails.priceEach * orderdetails.quantityOrdered) AS total
FROM orders, orderdetails
WHERE orders.orderNumber = orderdetails.orderNumber
GROUP BY orders.orderNumber
HAVING total > 150;

/*8. Treim un llistat on aparequi les factures d’un producte amb un nom determinat.*/
SELECT * FROM products;
SELECT orders.orderNumber, products.productName
FROM orders, orderdetails, products
WHERE orders.orderNumber = orderdetails.orderNumber
AND orderdetails.productCode = products.productCode
AND products.productName = "2001 Ferrari Enzo";

/*9. Treim un listat on aparegui per a cada client el seu total de factures (quantitat 
de factures).*/
SELECT customers.customerNumber, count(orders.orderNumber) AS total
FROM customers, orders
WHERE customers.customerNumber = orders.customerNumber
GROUP BY customers.customerNumber;

/*10. Treim un llistat on aparegui per a cada client el seu total de factures (import de 
totes les factures).*/
SELECT customers.customerNumber, sum(orders.orderNumber) AS total
FROM customers, orders
WHERE customers.customerNumber = orders.customerNumber
GROUP BY customers.customerNumber;

/*11. Treim un llistat on aparegui per a cada client el seu total de factures (import de 
totes les factures) però sols dels clients que són d’’Alemanya o França.*/
SELECT * FROM customers;
SELECT customers.customerNumber, sum(orders.orderNumber) AS total, customers.country
FROM customers, orders
WHERE customers.customerNumber = orders.customerNumber
AND customers.country = 'France' OR customers.country = 'Germany'
GROUP BY customers.customerNumber
ORDER BY customers.customerNumber;

/*12. Treu el codi i nom dels productes que el seu preu de venta actual (buyPrice)  és el 
mínim (exemple: si el preu mínim és 100, treure aquells productes que el seu preu és 100)*/
SELECT * FROM products;
SELECT products.productCode, products.productName, products.buyPrice
FROM products
WHERE products.buyPrice = (
SELECT min(buyPrice)
FROM products);

/*13. Treu el preu mínim, preu màxim i preu mitjà d’entre els preus de les ventes.*/
SELECT MIN(sub.total) as minimo, MAX(sub.total) as maximo, AVG(sub.total) as media
FROM (SELECT SUM(quantityOrdered * priceEach) as total
FROM orderdetails
GROUP BY orderNumber) as sub;

/*14. Selecciona el nombre de comanda, el nom del producte i la quantitat comanada de cada un 
dels productes, de totes aquelles comandes que no han estat servides.*/
SELECT * FROM orders;
SELECT orderdetails.orderNumber, productName, quantityOrdered, status
FROM orderdetails, products, orders
WHERE orderdetails.productCode = products.productCode
AND orders.status = 'on hold';

/*15. Selecciona el nombre de comanda, el nom del producte i la quantitat comanada de cada un 
dels productes, de totes aquelles comandes que no han estat servides i que la quantitat del 
producte en stock és menor a 3300 (imaginam que 3300 és la quantitat que sempre solen tenir com 
a garantia de poder servir les comandes).*/
SELECT * FROM products;
SELECT orderdetails.orderNumber, productName, quantityOrdered, status, quantityInStock
FROM orderdetails, products, orders
WHERE orderdetails.productCode = products.productCode
AND orders.status = 'on hold'
AND quantityInStock < 3300
GROUP BY products.productCode;

/*16. Selecciona el nombre de comandes (total de comandes) de cada un dels anys. O sigui: 
per cada any el total de comandes d’aquell any. ORDERS*/
SELECT COUNT(orderNumber) as total, YEAR(orderDate) as any
FROM orders
GROUP BY YEAR(orderDate);

/*17. Selecciona per a cada any el total venut (el que s’ha cobrat). Ha de sortir ordenat per 
any. PAYMENTS*/
SELECT SUM(amount) as total, YEAR(paymentDate) as any
FROM payments
GROUP BY YEAR(paymentDate)
ORDER BY any;

/*18. La mateixa consulta que abans , però sols ha de treure els anys en que els ingressos 
superen els 1800000.*/
SELECT SUM(amount) as total, YEAR(paymentDate) as any
FROM payments
GROUP BY YEAR(paymentDate)
HAVING total > 1800000
ORDER BY any;

/*19. Mostra els empleats que varen vendre algun producte el 2005. Suposarem que a un client 
sempre li ven l’empleat que és responsable d’ell (salesRepEmployeeNumber).*/
SELECT * FROM orders;
SELECT distinct customers.salesRepEmployeeNumber
FROM customers
WHERE EXISTS ( SELECT customerNumber
FROM orders
WHERE orders.customerNumber = customers.customerNumber
AND YEAR(orders.orderDate) = 2005);

/*20. Selecciona cada empleat quants de clients té. Ordena de major a menor nombre de clients. 
O sigui primer ha de sortir l’empleat que té més clients.*/
SELECT employeeNumber, COUNT(customerNumber) as nClientes
FROM employees, customers
WHERE customers.salesRepEmployeeNumber = employees.employeeNumber
GROUP BY employees.employeeNumber
ORDER BY COUNT(customers.customerNumber) DESC;

/*21. Mostra per a cada producte (codi, nom) el total que s’ha venut (els ingressos per aquest 
producte) l’any 2005.*/
SELECT products.productCode, products.productName, sum(quantityOrdered * priceEach) as total
FROM products, orderdetails, orders
WHERE products.productCode = orderdetails.productCode
AND orderdetails.orderNumber = orders.orderNumber
AND YEAR(orders.orderDate) = 2005
GROUP BY products.productCode;

/*22. Mostra el nom dels clients que varen comprar el producte S10_1678.*/
SELECT distinct customers.customerNumber, customers.customerName, products.productCode
FROM customers, orderdetails, products, orders
WHERE orderdetails.productCode = products.productCode
AND orderdetails.orderNumber = orders.orderNumber
AND customers.customerNumber = orders.customerNumber
AND products.productCode = "S10_1678";

/*23. Selecciona els empleats que no tenen cap client assignat.*/
SELECT employees.employeeNumber, count(customers.customerNumber) as total
FROM employees
LEFT JOIN customers ON customers.salesRepEmployeeNumber = employees.employeeNumber
GROUP BY employees.employeeNumber
HAVING total = 0;

/*24. Selecciona la informació de customers i el seu employee associat (en cas que en tinguin). 
Han d’apareixer tant aquells customers que tenen un employee associat com els que no els tenen.*/
SELECT * FROM customers
LEFT JOIN employees ON employees.employeeNumber = customers.salesRepEmployeeNumber;

/*25. Treu el codi i nom dels empleats que no tenen cap client associat.*/
SELECT employees.employeeNumber, count(customers.customerNumber) as total
FROM employees
LEFT JOIN customers ON customers.salesRepEmployeeNumber = employees.employeeNumber
GROUP BY employees.employeeNumber
HAVING total = 0;

/*26. Treu els empleats que tenen clients associats però aquests clients no han fet cap comanda.*/
SELECT employees.employeeNumber
FROM employees, customers
WHERE customers.salesRepEmployeeNumber = employees.employeeNumber
AND NOT EXISTS ( SELECT * FROM orders
WHERE customers.customerNumber = orders.customerNumber);

/*27. Mostra el codi de client i “Menor”, “Major” en funció de si el seu límit de crèdit és major o 
menor a 100000.*/
SELECT customerNumber,
CASE WHEN creditLimit < 100000 THEN "Menor"
WHEN creditLimit > 100000 THEN "Major"
ELSE "Es igual a 100000"
END AS creditLimitText
FROM customers;

/*28. Selecciona el nombre de client i les seves dues adreces. Les seves adreces han de sortir en una 
sola columna separades per els caràcters **. Alerta que hi ha camps que poden ser null.*/
SELECT customers.customerNumber, CONCAT(addressLine1, "**", ifnull(addressLine2, "")) as direccion 
FROM customers;

/*29. Fes una taula que contingui un resum de les vendes. Camps: codi client, import_total (import del 
total venut: orders, ordersdetails), any.*/


/*30. Quins clients tenen el seu creditLimit per damunt del credit limit de qualsevol client del 
representant 1165.*/
SELECT customers.*
FROM customers
WHERE customers.creditLimit > (
SELECT max(creditLimit)
FROM customers
WHERE customers.salesRepEmployeeNumber = 1165);

/*31. Mostra els clients que tenen el seu creditLimit per damunt d’algun dels clients del 
representant 1165.*/
SELECT customers.*
FROM customers
WHERE customers.creditLimit > ANY (
SELECT creditLimit
FROM customers, employees
WHERE customers.salesRepEmployeeNumber = 1165);

/*32. Mostra en un sol llistat:  els codis, noms dels clients que han fet algun pagament 
i els codis, noms dels clients que han fet una comanda.  No ha de mostrar els repetits.*/
SELECT distinct payments.customerNumber
FROM payments
UNION ALL
SELECT distinct orders.customerNumber
FROM orders;

/* OTRA FORMA DE INTERPRETARLO
SELECT * FROM payments;
SELECT distinct customers.customerNumber, customers.customerName
FROM customers, payments
WHERE customers.customerNumber = payments.customerNumber
HAVING count(payments.checkNumber) > 0
UNION
SELECT distinct customers.customerNumber, customers.customerName
FROM customers, orders
WHERE customers.customerNumber = orders.customerNumber
HAVING count(orders.orderNumber) > 0;
*/

/*33. Mostra en un sols llistat:  els codis, noms dels clients que han fet algun pagament 
i els codis, noms dels clients que han fet una comanda.  A devora els clients de pagament 
ha de posar pagament i a devora els d’orders ha de posar orders.*/
SELECT distinct payments.customerNumber, "pagament"
FROM payments
UNION ALL
SELECT distinct orders.customerNumber, "orders"
FROM orders;

/*34. Treu per a cada employee el nombre de clients que té. També has de treure el total.*/
SELECT employees.employeeNumber, employees.firstName, count(customers.customerNumber) as total
FROM customers, employees
WHERE customers.salesRepEmployeeNumber = employees.employeeNumber
GROUP BY employees.employeeNumber;

/*35. Selecciona les comandes (orders) de l’oficina de la ciutat de San Francisco.*/
SELECT * FROM productlines;
SELECT distinct orders.orderNumber, offices.city
FROM orders, offices, employees
WHERE employees.officeCode = offices.officeCode
AND offices.city = "San Francisco";

/*36. Selecciona les comandes (orders) de l’oficina de San Francisco del producte 
Motorcycles.*/
SELECT orders.orderNumber, offices.city, productlines.productLine
FROM orders, offices, products, employees, productlines, customers
WHERE employees.employeeNumber = customers.salesRepEmployeeNumber
AND orders.customerNumber = customers.customerNumber
AND productlines.productLine = products.productLine
AND offices.city = "San Francisco"
AND productlines.productLine = "Motorcycles";

/*37. Selecciona quantes comandes hi ha per cada oficina fetes l’any 2005.*/
SELECT offices.officeCode, count(orders.orderNumber)
FROM orders, offices, employees, customers
WHERE offices.officeCode = employees.officeCode
AND employees.employeeNumber = customers.salesRepEmployeeNumber
AND customers.customerNumber = orders.customerNumber
AND YEAR(orders.orderDate) = '2005'
GROUP BY officeCode
ORDER BY officeCode;















/*38. Mostra quines comandes tenen més de 3 productes distints.*/
SELECT orderNumber, count(productCode) as total
FROM orderdetails
GROUP BY orderNumber
HAVING total > 3;

/*39. Mostra per a cada producte la quantitat comanada (suma de les 
quantitats comanades) . Sols s’ha de fer per les comandes no servides. A més 
sols hem de mostrar aquells productes que la quantitat en stock està per davall 
la quantitat demanada.*/
SELECT * FROM orders;
SELECT products.productCode, products.quantityInStock, sum(quantityOrdered * priceEach) as total
FROM products, orderdetails, orders
WHERE products.productCode = orderdetails.productCode 
AND orderdetails.orderNumber = orders.orderNumber
AND shippedDate = null
GROUP BY products.productCode
HAVING total > products.quantityInStock;

/*40. Treu la mitjana d’empleats d’oficines.*/
SELECT AVG(total) as media
FROM (
    SELECT offices.officeCode, COUNT(employees.employeeNumber) AS total
    FROM offices, employees
    WHERE offices.officeCode = employees.officeCode
    GROUP BY offices.officeCode
) t1;

/*41. Mostra les factures del client Atelier graphique.*/
SELECT orders.*
FROM orders, customers
WHERE customers.customerNumber = orders.customerNumber
AND customers.customerName = "Atelier graphique";

/*42. Selecciona per a cada client de l’oficina de San Francisco 
la quantitat de comandes fetes.*/
SELECT customers.customerNumber, count(orders.orderNumber) as total
FROM orders, customers, employees, offices
WHERE customers.salesRepEmployeeNumber = employees.employeeNumber
AND employees.officeCode = offices.officeCode
AND customers.customerNumber = orders.customerNumber
AND offices.city = "San Francisco"
GROUP BY customers.customerNumber;

/*43. Selecciona per a cada oficina i any el seu nombre de comandes 
sempre i quan l’oficina no sigui la de San Francisco. Ordena per 
oficina i any. */


/*44. Selecciona si hi ha alguna oficina que no té comandes fetes el 2005.*/


/*45. Selecciona per a cada client el total de productes comprats. El nom 
del client s’ha de mostrar en una sola columna. Sols s’han de tenir en compte 
els productes comprats el 2005 que el seu preu està per damunt 100000.*/


/*46. Selecciona per a cada client el total de productes comprats sempre i quan aquest 
total estigui per damunt 4. S’ha de tenir en compte el nombre de productes distints no 
el nombre d’unitats de producte. El nom del client s’ha de mostrar en una sola columna. 
Sols s’han de tenir en compte els productes comprats el 2005 que el seu preu està per 
damunt 1000.*/


/*47. Selecciona quins clients han comprat alguns dels productes que ha comprat el 
client 103. El llistat ha de sortir ordenat per customerNumber.*/


/*48. Selecciona quants de empleats són de l’oficina de San Francisco i quants 
d’empleats no són de l’oficina de San Francisco. Ha de sortir en una mateixa consulta.*/


/*49. Selecciona quins empleats no tenen cap client amb comandes fetes i estan a la 
mateixa oficina que l’empleat 1.*/


/*50. Selecciona quins clients no han fet cap comanda el 2005 i sí n’han fetes el 2004.*/


/*51. Selecciona quines línies de productes tenen més productes que la línia Motorcycles.*/


/*52. Selecciona el nom dels productes que varen ser comanats més vegades l’any 2005 i els 
productes que varen ser comenats menys vegades l’any 2005.*/


/*53. Selecciona quines línies de productes tenen més de 10 productes.*/


/*54. Selecciona quins clients no tenen cap empleats associat però tenen comandes.*/


/*55. Selecciona el client que ens ha gastat més (pot ser n’hi hagi més d’un).*/




/* EJERCICIOS REPASO */

/* SIN SUBSELECTS */
/*1. Realiza un select que muestre los nombres de los clientes que han realizado compras por un valor mayor a 10.000 dólares y que estén ubicados en países de habla hispana.*/
SELECT * FROM customers;
SELECT customers.customerNumber, sum(quantityOrdered * priceEach) as total
FROM customers, orderdetails, orders
WHERE orderdetails.orderNumber = orders.orderNumber
AND customers.customerNumber = orders.customerNumber
AND customers.country = "Spain"
GROUP BY customers.customerNumber
HAVING total > 10000;

/*2. Haz un select que muestre los nombres de los empleados que han realizado ventas por un valor mayor a 50.000 dólares y que trabajen en oficinas ubicadas en Estados Unidos.*/
SELECT * FROM offices;
SELECT employees.firstName, sum(quantityOrdered * priceEach) as total, offices.country
FROM employees, orderdetails, offices, customers, orders
WHERE customers.salesRepEmployeeNumber = employees.employeeNumber
AND customers.customerNumber = orders.customerNumber
AND orders.orderNumber = orderdetails.orderNumber
AND employees.officeCode = offices.officeCode
AND offices.country = "USA"
GROUP BY employees.employeeNumber
HAVING total > 50000;

/*3. Crea un select que muestre los nombres de los clientes que no hayan realizado compras en los últimos 6 meses.*/
/*USA FUNCIONES QUE NO HEMOS VISTO*/

/*4. Haz un select que muestre los nombres de los productos que han sido ordenados al menos 3 veces en los últimos 3 meses.*/
/*USA FUNCIONES QUE NO HEMOS VISTO*/

/*5. Realiza un select que muestre los nombres de los empleados que tengan ventas pendientes por un valor mayor a 10.000 dólares*/
SELECT * FROM orders;
SELECT employees.employeeNumber, sum(quantityOrdered * priceEach) as total
FROM employees, orderdetails, customers, orders
WHERE customers.salesRepEmployeeNumber = employees.employeeNumber
AND customers.customerNumber = orders.customerNumber
AND orders.orderNumber = orderdetails.orderNumber
AND orders.status IN ("On hold", "In process")
GROUP BY employees.employeeNumber
HAVING total > 10000;




/* CON SUBSELECTS (SOLO EL 1 Y 5) */
/*1. Obtener los nombres de los clientes que realizaron una compra superior al promedio de todas las compras realizadas en la base de datos.*/
SELECT distinct customers.customerNumber, p1.amount
FROM customers, payments p1
WHERE customers.customerNumber = p1.customerNumber
AND p1.amount > (
SELECT AVG(p2.amount)
FROM payments p2)
ORDER BY amount ASC;

SELECT AVG(payments.amount) FROM payments;

/*2. Mostrar el nombre del empleado y la cantidad de clientes que tiene asignados. Solo se deben incluir aquellos empleados que tienen asignados más de 10 clientes.*/
SELECT employees.employeeNumber, count(customers.customerNumber) clientes
FROM employees
LEFT JOIN customers ON customers.salesRepEmployeeNumber = employees.employeeNumber
GROUP BY employees.employeeNumber
HAVING clientes > 10;

/*3. Mostrar el nombre del cliente, su ciudad y el número de pedidos realizados en el año 2004. Solo se deben incluir aquellos clientes que hayan realizado más de 5 pedidos en ese año.*/
SELECT customers.customerNumber, customers.city, count(orders.orderNumber) as cantidadPedidos, year(orders.orderDate) as fecha
FROM customers, orders
WHERE customers.customerNumber = orders.customerNumber
AND YEAR(orders.orderDate) = 2004
GROUP BY customers.customerNumber
HAVING cantidadPedidos > 5;

/*4. Mostrar el nombre del cliente y el número de productos que ha comprado en la categoría "Planes de regalo". Solo se deben incluir aquellos clientes que hayan comprado más de 10 productos en esta categoría.*/
SELECT * FROM products;
SELECT distinct customers.customerNumber, count(products.productCode) as cantidad
FROM customers, products, productlines, orders, orderdetails
WHERE productlines.productLine = products.productLine
AND customers.customerNumber = orders.customerNumber
AND orders.orderNumber = orderdetails.orderNumber
AND products.productLine = "Planes"
GROUP BY customers.customerNumber
HAVING cantidad > 10;

/*5. Mostrar el nombre de los productos que hayan sido comprados más de 50 veces. Debes utilizar un subselect para obtener la cantidad total de compras de cada producto.*/
SELECT products.productName
FROM products
WHERE products.productCode IN (
SELECT orderdetails.productCode
FROM orderdetails
GROUP BY productCode
HAVING SUM(quantityOrdered) > 50);




/* EJERCICIOS VISTAS */
/*1. Crea una vista que muestre el nombre del producto y su precio de venta, pero solo para los productos cuyo precio de venta sea superior a 100 dólares.*/
SELECT * FROM products;
CREATE VIEW productoPrecioMasCien AS 
SELECT products.productName, products.buyPrice
FROM products
HAVING products.buyPrice > 100;

SELECT * FROM productoPrecioMasCien;

/*2. Crea una vista que muestre el nombre de los clientes y su país de residencia, pero solo para los clientes que han realizado al menos una compra en el último año.*/
CREATE VIEW alMenosUnaCompra AS
SELECT customers.customerNumber, customers.customerName, customers.country, count(orders.orderNumber) as cantidad
FROM customers, orders
WHERE customers.customerNumber = orders.customerNumber
GROUP BY customers.customerNumber, customers.customerName, customers.country
HAVING cantidad > 0;

SELECT * FROM alMenosUnaCompra;

/*3. Crea una vista que muestre el número de orden, la fecha de la orden y el precio total de cada orden, pero solo para las órdenes cuyo precio total supere los 500 dólares.*/
CREATE VIEW precioOrdenMayorQuinientos AS
SELECT orders.orderNumber, orders.orderDate, sum(quantityOrdered * priceEach) as total
FROM orders, orderdetails
WHERE orders.orderNumber = orderdetails.orderNumber
GROUP BY orders.orderNumber
HAVING total > 500;

SELECT * FROM precioOrdenMayorQuinientos;

/*4. Crea una vista que muestre el nombre del producto, el nombre del fabricante y la cantidad de unidades en stock, pero solo para los productos que tengan menos de 50 unidades en stock.*/
CREATE VIEW stockProductosMenosCincuenta AS
SELECT products.productName, products.productVendor, products.quantityInStock as stock
FROM products
HAVING stock < 50;

SELECT * FROM stockProductosMenosCincuenta;

/*5. Crea una vista que muestre el nombre del empleado, el nombre del cliente y el total de ventas realizadas por cada empleado a cada cliente en el último trimestre.*/
CREATE VIEW totalVentasEmpleados AS 
SELECT employees.employeeNumber, employees.firstName, customers.customerName, count(orders.orderNumber) as totalCantidad, sum(quantityOrdered * priceEach) as totalVenta
FROM employees, customers, orders, orderdetails
WHERE customers.salesRepEmployeeNumber = employees.employeeNumber
AND customers.customerNumber = orders.customerNumber
AND orders.orderNumber = orderdetails.orderNumber
GROUP BY customers.customerName, employees.firstName;

SELECT * FROM totalVentasEmpleados;




/* UPDATES A PARTIR DE SELECTS */
/*1. Actualiza el precio de cada producto en un 10% si su stock está por debajo de la cantidad mínima.*/
SELECT * FROM products;
UPDATE products
SET products.buyPrice = products.buyPrice * 1.1
WHERE products.quantityInStock < (
SELECT min(products.quantityInStock)
FROM products);

SELECT min(products.quantityInStock) FROM products;

/*2. Actualiza la cantidad en stock de cada producto con el número de unidades vendidas en los últimos 30 días.*/
/*HAY QUE USAR LA FUNCIÓN DATE_SUB*/


/*3. Actualiza la fecha de vencimiento de cada orden pendiente en 30 días.*/


/*4. Actualiza el nombre de cada cliente que ha realizado una compra en el último mes para que incluya un prefijo de "VIP".*/


/*5. Actualiza la cantidad en stock de cada producto que se haya vendido en una orden que se haya enviado en el último mes, restando la cantidad de unidades vendidas de la cantidad en stock actual.*/
