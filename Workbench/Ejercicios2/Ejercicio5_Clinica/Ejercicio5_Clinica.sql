use Ejercicio5_Clinica;
show tables;
select * from Provincia;
INSERT INTO Provincia() VALUES(1, "Islas Baleares");
INSERT INTO Provincia() VALUES(2, "Sevilla");

select * from Poblacion;
INSERT INTO Poblacion() VALUES(1, "Manacor", 1);
INSERT INTO Poblacion() VALUES(2, "Alcalá de Guadaira", 2);

select * from Persona;
INSERT INTO Persona() VALUES(1, "Jorge", "Estelrich", "", "656578975", 1);
INSERT INTO Persona() VALUES(2, "Petra", "Sánchez", "Pizjuán", "623947562", 2);

select * from Paciente;
INSERT INTO Paciente() VALUES(1, "Jorge", "Estelrich", "", "Rambla Rei en Jaume", "07500", "656578975", "1974-11-02", 1);
INSERT INTO Paciente() VALUES(2, "Pepe", "Navarro", "Jiménez", "Via Portugal", "07500", "620346604", "1999-05-16", 2);

select * from Especialidad;
INSERT INTO Especialidad() VALUES(1, "Pediatra");
INSERT INTO Especialidad() VALUES(2, "Odontólogo");

select * from Medico;
INSERT INTO Medico() VALUES(1, "Enrique", "López", "Pardo", "625316752", 1, 1);
INSERT INTO Medico() VALUES(2, "Antonia", "Gutiérrez", "", "610283476", 2 , 2);

select * from Ingreso;
INSERT INTO Ingreso() VALUES(1, 293, 2, "2022-09-20", "2022-09-21");
INSERT INTO Ingreso() VALUES(2, 121, 1, "2022-10-13", "2022-10-20");

select * from Sufre;
INSERT INTO Sufre() VALUES(1, 2, 1);
INSERT INTO Sufre() VALUES(2, 1, 2);