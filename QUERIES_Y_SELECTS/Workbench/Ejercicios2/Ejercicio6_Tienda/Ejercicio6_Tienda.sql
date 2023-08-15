use Ejercicio6_Tienda;
show tables;
select * from Poblacion;
INSERT INTO Poblacion(idPoblacion, nombre, idProvincia) VALUES(1, 'Sevilla', 1);
INSERT INTO Poblacion(idPoblacion, nombre, idProvincia) VALUES(2, 'Palma', 2);

select * from Provincia;
INSERT INTO Provincia(idProvincia, nombre) VALUES(1, 'Sevilla');
INSERT INTO Provincia(idProvincia, nombre) VALUES(2, 'Baleares');

select * from Cliente;
INSERT INTO Cliente(idCliente, nombre, apellido1, apellido2, direccion, telefono, idPoblacion) VALUES(1, 'Sergio', 'Gutiérrez', 'García', 'Calle cinamomo', '684347474', 1);
INSERT INTO Cliente(idCliente, nombre, apellido1, apellido2, direccion, telefono, idPoblacion) VALUES(2, 'Alberto', 'Gúzman', 'López', 'Calle espliego', '646573623', 2);

select * from Producto;
INSERT INTO Producto() VALUES(1, "Este es el producto1", 1, 1);
INSERT INTO Producto() VALUES(2, "Este es el producto2", 2, 2);

select * from Compra; //SOLUCIONAR PROBLEMA
INSERT INTO Compra() VALUES(1, 1, 1);
INSERT INTO Compra() VALUES(2, 2, 2);

select * from Fecha;
INSERT INTO Fecha() VALUES('2004-03-12');
INSERT INTO Fecha() VALUES('2000-09-28');

select * from Proveedor;
INSERT INTO Proveedor() VALUES(1, "Jose", "Pascual", "García", "Calle Tramuntana", 1);
INSERT INTO Proveedor() VALUES(2, "Antonio", "Palomero", "Ribagorda", "Calle Cursach", 2);

select * from Suministro;
INSERT INTO Suministro() VALUES(1, 2);
INSERT INTO Suministro() VALUES(2, 1);