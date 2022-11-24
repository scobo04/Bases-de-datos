use Ejercicio4;
show tables;

select * from Empleado;
INSERT INTO Empleado(idEmpleado, nombre, apellido1, apellido2, telefono, Puesto_IdPuesto) VALUES(1, 'Jose', 'Pérez', 'López', '683019271', 1);
INSERT INTO Empleado(idEmpleado, nombre, apellido1, apellido2, telefono, Puesto_IdPuesto) VALUES(2, 'Antonia', 'Jiménez', '', '623827857', 2);

select * from Puesto;
INSERT INTO Puesto(idPuesto, nombre) VALUES(1, 'Dependiente');
select * from Puesto;
select * from Empleado;
select * from Cliente;
INSERT INTO Cliente(idCliente, nombre, apellido1, apellido2, telefono) VALUES(1,'Pepito','García','','647834973');
select * from Cliente;
