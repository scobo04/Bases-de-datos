use Ejercicio6;
show tables;
select * from Ciudad;
INSERT INTO Ciudad(idCiudad, nombre) VALUES(1, 'Manacor');
INSERT INTO Ciudad(idCiudad, nombre) VALUES(2, 'Palma');

select * from Empleado;
INSERT INTO Empleado(idEmpleado, nombre, apellido1, apellido2, direccion, telefono, Ciudad_idCiudad, Empleado_idEmpleadoJefe) VALUES(1, 'Pepe', 'Navarro', '', 'Via Portugal, 23', '684726103', 1, 1);
INSERT INTO Empleado(idEmpleado, nombre, apellido1, apellido2, direccion, telefono, Ciudad_idCiudad, Empleado_idEmpleadoJefe) VALUES(2, 'Antonio', 'Olmo', '', 'Rambla Rei en Jaume, 40', '645345436', 2, 2);