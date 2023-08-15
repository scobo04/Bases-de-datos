create database Ejercicio2_Campamento;
use Ejercicio2_Campamento;

CREATE TABLE Region(
id int AUTO_INCREMENT, 
nombre varchar (20) NOT NULL UNIQUE, 
area decimal(8,1) NOT NULL CHECK(area>=0), habitantes int NOT NULL CHECK(habitantes>=0), PRIMARY KEY(id));
select * from Region;

CREATE TABLE Actividades(
id int NOT NULL AUTO_INCREMENT, 
nombre varchar (20) NOT NULL UNIQUE, 
PRIMARY KEY(id));
select * from Actividades;

CREATE TABLE Niños(
id int NOT NULL, 
nombre varchar (20) NOT NULL, 
apellido1 varchar (20) NOT NULL, 
apellido2 varchar (20), 
telefono_padres varchar (12) NOT NULL, 
idRegion int NOT NULL, 
PRIMARY KEY(id), 
FOREIGN KEY (idRegion) REFERENCES Region(id));
select * from Niños;

CREATE TABLE Summer_camp(
id int NOT NULL, 
nombre varchar (20) NOT NULL UNIQUE, 
capacidad int NOT NULL CHECK(capacidad>=0), 
idRegion int NOT NULL, 
PRIMARY KEY(id),
FOREIGN KEY(idRegion) REFERENCES Region(id));
select * from Summer_camp;

CREATE TABLE Tiene(
rate int NOT NULL CHECK(rate>=0), 
idSummer_camp int, 
idActividades int, 
FOREIGN KEY(idSummer_camp) REFERENCES Summer_camp(id), 
FOREIGN KEY(idActividades) REFERENCES Actividades(id));
select * from Tiene;

CREATE TABLE Van(
data_inici date NOT NULL,
data_fi date, 
idNiños int,
idSummer_camp int,
PRIMARY KEY(idNiños, data_inici),
FOREIGN KEY(idNiños) REFERENCES Niños(id), 
FOREIGN KEY(idSummer_camp) REFERENCES Summer_camp(id),
CHECK(data_inici is null or data_inici <= data_fi)
);
select * from Van;
show tables;


/*ACTIVIDAD CLASE 15/11*/
/*Punto 0*/
alter table Region modify column id int;
/*1.*/
show create table Summer_camp;
alter table Summer_camp drop constraint summer_camp_ibfk_1;
alter table Summer_camp add foreign key (idRegion) references region(id)
on delete cascade on update cascade;
/*2.*/
select * from Region;
SET SQL_SAFE_UPDATES=0; /* Tenc una region introduïda i la vull borrar*/
delete from Region; /* Borr la region */
/* Insert una regió i un summer_camp */
insert into Region (id,nombre,area,habitantes) values (1,"Llevant",200,1000);
describe Summer_camp;
insert into Summer_camp values (1,"Summer Manacor",100,1);
/*3.*/ 
/* Modificam d'una regió que té summers però no childs*/
update Region set id=3 where id=1;
select * from Region; 
select * from Summer_camp; /* Me modifica la region i el region dins summer_camp */
 /* Modificar una regió que té summers i child */
 describe Niños;
 insert into Niños (id,nombre,apellido1,apellido2,telefono_padres,idRegion)
 values (1,"Joan","Adrover","Mora","666666666",3);
 update Region set id=4 where id=3;  /* No me deixa perque té Niños */
 /*4.*/
 /* Borrar una regió que té summers però no té child */
 delete from Niños where id=1;
 delete from Region where id=3; /* Me deixa */
 select * from Summer_camp;
/* Borrar una regió que té summers i niños  */
insert into Region (id,nombre,area,habitantes) values (1,"Llevant",200,1000);
insert into Summer_camp values (1,"Summer Manacor",100,1);
insert into Niños (id,nombre,apellido1,apellido2,telefono_padres,idRegion)
 values (1,"Joan","Adrover","Mora","666666666",1);
 delete from Region where id=1;  /* No me deixa perque hi ha Niños*/
 


