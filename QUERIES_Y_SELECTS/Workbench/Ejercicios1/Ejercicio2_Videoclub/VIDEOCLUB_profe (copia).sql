create database videoclub_2_1;
use videoclub_2_1;

create table pelicula (
id int,
titulo varchar(45) not null,
primary key (id)
);

create table cast1 (
id int,
nombre varchar(45) not null,
ape1 varchar(45) not null,
ape2 varchar(45),
primary key (id)
);

show tables;

create table tipo (
id int auto_increment,
nombre varchar(45) not null,
primary key (id)
);

create table ciudad (
id int auto_increment,
nombre varchar(45) not null,
primary key (id)
);

create table socio (
id int,
nombre varchar(45) not null,
ape1 varchar(45) not null,
ape2 varchar(45),
tlf varchar(45) not null,
direccion varchar(45) not null,
dni varchar(45) not null,
id_ciudad int,
primary key (id),
foreign key (id_ciudad) references ciudad(id)
);

create table alquila (
id_socio int,
id_pelicula int,
f_inicio date,
f_final date,
primary key (id_socio,id_pelicula,f_inicio),
foreign key (id_socio) references socio(id),
foreign key (id_pelicula) references pelicula(id)
);

select * from alquila;
show create table alquila;

create table participa (
id_pelicula int,
id_cast1 int,
id_tipo int,
primary key (id_pelicula,id_cast1,id_tipo),
foreign key (id_pelicula) references pelicula(id),
foreign key (id_cast1) references cast1(id),
foreign key (id_tipo) references tipo(id)
);

show create table participa;

select * from pelicula;
insert into pelicula (id,titulo) value (1,"Matrix");
insert into pelicula (id,titulo) value (2,"Titanes");

select * from cast1;
insert into cast1 (id,nombre,ape1,ape2) value (1,"Keanu","Reeves",null);
insert into cast1 (id,nombre,ape1,ape2) value (2,"Denzel","Hayes","Washington");

select * from tipo;
insert into tipo (nombre) value ("actua");
insert into tipo (nombre) value ("dirige");

select * from ciudad;
insert into ciudad (id,nombre) value (1,"Menorca");
insert into ciudad (id,nombre) value (2,"Tenerife");

select * from socio;
insert into socio (id,nombre,ape1,ape2,tlf,direccion,dni,id_ciudad) value (1,"Maria","Morena","Ruiz","600600600","Calle Cano 1","12345678H",1);
insert into socio (id,nombre,ape1,ape2,tlf,direccion,dni,id_ciudad) value (2,"Migue","Martin","Roman","620920920","Calle Puerto 25","24242424R",2);

select * from alquila;
insert into alquila (id_socio,id_pelicula,f_inicio,f_final) value (1,2,"2022-12-01",null);
insert into alquila (id_socio,id_pelicula,f_inicio,f_final) value (2,1,"2022-11-15","2022-11-25");

select * from participa;
insert into participa (id_pelicula,id_cast1,id_tipo) value (1,1,1);
insert into participa (id_pelicula,id_cast1,id_tipo) value (2,2,2);
