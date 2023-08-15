CREATE DATABASE practicar_videoclub;
USE practicar_videoclub;

CREATE TABLE Ciudad(
id int auto_increment,
nombre varchar(20) not null,
primary key(id)
);

CREATE TABLE Casting(
id int auto_increment,
nombre varchar(20) not null,
apellido1 varchar(20) not null,
apellido2 varchar(20),
primary key(id)
);

CREATE TABLE Tipo(
id int auto_increment,
nombre varchar(20) not null,
primary key(id)
);

CREATE TABLE Pelicula(
id int auto_increment,
titol varchar(20) not null,
primary key(id)
);

CREATE TABLE Socio(
id int auto_increment,
dni varchar(15) not null,
nombre varchar(20) not null,
apellido1 varchar(20) not null,
apellido2 varchar(20),
telefono varchar(15) not null,
direccion varchar(50) not null,
primary key(id),
idCiudad int,
foreign key(idCiudad) references Ciudad(id)
);

CREATE TABLE Alquila(
idSocio int,
idPelicula int,
f_inicio int,
primary key(idSocio, idPelicula, f_inicio),
foreign key(idSocio) references Socio(id),
foreign key(idPelicula) references Pelicula(id)
);
ALTER TABLE Alquila MODIFY f_inicio datetime;
ALTER TABLE Alquila ADD f_final datetime null;

CREATE TABLE Participa(
idPelicula int,
idCasting int,
idTipo int,
primary key(idPelicula, idCasting, idTipo),
foreign key(idPelicula) references Pelicula(id),
foreign key(idCasting) references Casting(id),
foreign key(idTipo) references Tipo(id)
);

SHOW TABLES;
SELECT * FROM Socio;
SHOW CREATE TABLE Socio;
SELECT * FROM Ciudad;

/*EJERCICIO 1*/
ALTER TABLE Socio MODIFY dni int unique;

/*EJERCICIO 2*/
ALTER TABLE Socio ADD email varchar(100);
ALTER TABLE Socio MODIFY email varchar(30);

/*EJERCICIO 3*/
ALTER TABLE Socio ADD data_naixement date not null;

/*EJERCICIO 4*/
INSERT INTO Ciudad() VALUES("", "Palma");
INSERT INTO Ciudad() VALUES("", "Sevilla");

INSERT INTO Socio(id, dni, nombre, apellido1, apellido2, telefono, direccion, idCiudad, email, data_naixement) VALUES("", "12332112A", "Sergio", "Cobo", "García", "634865786", "Via Majorica, 23", 1, "sergio@gmail.com", "2000-08-10");
INSERT INTO Socio(id, dni, nombre, apellido1, apellido2, telefono, direccion, idCiudad, email, data_naixement) VALUES("", "36666667F", "Jose", "Perez", "Coronado", "643985708", "Rambla Rei en Jaume, 12", 2, "jperez@gmail.com", "2011-11-04");

UPDATE Socio set data_naixement = "2022-01-02" where id=1;
UPDATE Socio set data_naixement = "1999-10-20" where id=2;

/*EJERCICIO 5*/
ALTER TABLE Socio MODIFY data_naixement year;
ALTER TABLE Socio ADD any_naixement year;
set sql_safe_updates = 0;
UPDATE Socio set any_naixement = year(data_naixement);
ALTER TABLE Socio DROP data_naixement;

/*EJERCICIO 6*/
ALTER TABLE Socio ADD tipus int;
UPDATE Socio set tipus = 1 where id = 1;
UPDATE Socio set tipus = 2 where id = 2;

/*EJERCICIO 7*/
ALTER TABLE Socio MODIFY tipus varchar(10);
UPDATE Socio set tipus = "VIP" where id = 1;
UPDATE Socio set tipus = "NORMAL" where id = 2;

/*EJERCICIO 8*/
CREATE TABLE Pais(
id int primary key,
nombre varchar(40)
);

INSERT INTO Pais VALUES(1, "Francia");
INSERT INTO Pais VALUES(2, "Alemania");

ALTER TABLE Casting
ADD pais int not null ,
ADD FOREIGN KEY(Pais) REFERENCES Pais(id) ON UPDATE CASCADE;
SELECT * FROM Casting;

/*EJERCICIO 9*/
insert into Casting values (1,'Joseba','de Carglass',null, 2);
insert into Casting values (2,'Malenia','Trump',null, 2);

UPDATE Casting set Pais=1 WHERE id=1;
UPDATE Casting set Pais=1 WHERE id=2;
DELETE FROM Pais WHERE id=1;
SELECT * FROM Pais;

/*EJERCICIO 10*/
SHOW CREATE TABLE Pais;
ALTER TABLE Casting DROP CONSTRAINT casting_ibfk_1;
ALTER TABLE Pais MODIFY id varchar(3);
ALTER TABLE Casting MODIFY pais varchar(3);
ALTER TABLE Casting ADD CONSTRAINT casting_ibfk_1 foreign key(pais) REFERENCES Pais(id) ON UPDATE CASCADE;

/*EJERCICIO 11*/
ALTER TABLE Pelicula ADD COLUMN descripcio varchar(100) not null;
SELECT * FROM Pelicula;

/*EJERCICIO 12*/
ALTER TABLE Pelicula MODIFY titol varchar(20) UNIQUE;
SHOW CREATE TABLE Pelicula;

/*EJERCICIO 13*/
ALTER TABLE Pelicula ADD COLUMN preu int check(preu<0);
ALTER TABLE Pelicula ADD COLUMN valoracio int check(valoracio<0 && valoracio<10);
ALTER TABLE Pelicula MODIFY preu int check(preu>0);
ALTER TABLE Pelicula MODIFY valoracio int check(valoracio>0 && valoracio<10);
ALTER TABLE Pelicula MODIFY preu int not null check(preu>0);
ALTER TABLE Pelicula MODIFY valoracio int not null check(valoracio>0 && valoracio<10);
INSERT INTO Pelicula() VALUES("", "El mundo", "Novela inspiradora de reflexión", 30, 2);
INSERT INTO Pelicula() VALUES("", "Los tres cerditos", "Los tres vivían bien", 50, 7);

/*EJERCICIO 14*/
SELECT * FROM Socio;
UPDATE Socio set id=100 where id=2;
ALTER TABLE Socio ADD tarifa int not null;
UPDATE Socio set tarifa = 100 where id = 1;
UPDATE Socio set tarifa = 100 where id = 2;
UPDATE Socio set tarifa = 0 where id = 1;
UPDATE Socio set tarifa = 0 where id = 100;
UPDATE Socio set tarifa = 100;
UPDATE Socio set tarifa = 0 where id = 1;
UPDATE Socio set tarifa = 0 where id = 100;
INSERT INTO Socio(id, dni, nombre, apellido1, apellido2, telefono, direccion, idCiudad, email, any_naixement) VALUES("2", "63478676S", "Maria", "Robles", "Sánchez", "632454655", "Rambla Rei en Jaume, 22", 1, "larobles@gmail.com", "1960-04-22");
DELETE FROM Socio WHERE id=2;
INSERT INTO Socio(id, dni, nombre, apellido1, apellido2, telefono, direccion, idCiudad, email, any_naixement) VALUES("", "63478676S", "Maria", "Robles", "Sánchez", "632454655", "Rambla Rei en Jaume, 22", 1, "larobles@gmail.com", "1960-04-22");
DELETE FROM Socio WHERE id=102;
INSERT INTO Socio(id, dni, nombre, apellido1, apellido2, telefono, direccion, idCiudad, email, any_naixement, tipus, tarifa) VALUES("", "63478676S", "Maria", "Robles", "Sánchez", "632454655", "Rambla Rei en Jaume, 22", 1, "larobles@gmail.com", "1960-04-22", "NORMAL", 100);

/*EJERCICIO 15*/
UPDATE Socio set tarifa = tarifa*1.1;

/*EJERCICIO 16*/
insert into alquila values (1,1,'2020-02-29 13:05:26',null);
ALTER TABLE Alquila DROP CONSTRAINT alquila_ibfk_1;
insert into alquila values (2,2,'2021-10-04 19:20:50','2021-10-11 09:07:44');
ALTER TABLE Alquila ADD CONSTRAINT alquila_ibfk_1 foreign key(idSocio) references Socio(id); /*FALTA AÑADIR FOREIGN KEY*/
SHOW CREATE TABLE Alquila;

/*EJERCICIO 17*/
show create table alquila;
show create table casting;
show create table ciudad;
show create table pais;
show create table participa;
show create table pelicula;
show create table socio;
show create table tipo;

/*EJERCICIO 18*/
alter table casting drop foreign key casting_ibfk_1;
alter table casting add constraint foreign key casting_ibfk_1 (pais) references pais(id);

/*EJERCICIO 19*/
/* Database > Reverse engineer */

/*EJERCICIO 20*/
alter table alquila modify column f_final datetime check(f_final >= f_inicio);


