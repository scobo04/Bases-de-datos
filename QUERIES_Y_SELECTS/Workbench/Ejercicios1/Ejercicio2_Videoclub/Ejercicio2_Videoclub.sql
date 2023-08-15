use Ejercicio2_Videoclub;

create table Ciudad(
id int auto_increment,
nombre varchar(20) not null,
primary key(id)
);

create table Casting(
id int,
nombre varchar(20) not null,
apellido1 varchar(20) not null,
apellido2 varchar(20),
primary key(id)
);

create table Tipo(
id int auto_increment,
nombre varchar(20) not null unique,
primary key(id)
);
select * from Tipo;

create table Pelicula(
id int,
titulo varchar(20) not null,
primary key(id)
);

create table Socio(
id int,
dni varchar(15) not null unique,
nombre varchar(20) not null,
apellido1 varchar(20) not null,
apellido2 varchar(20),
telefono varchar(15) not null,
direccion varchar (50) not null,
primary key(id),
idCiudad int,
foreign key(idCiudad) references Ciudad(id)
);
select * from Socio;

create table Alquila(
f_inicio date not null,
f_final date not null,
idSocio int,
idPelicula int,
primary key(idSocio, idPelicula, f_inicio),
foreign key(idSocio) references Socio(id),
foreign key(idPelicula) references Pelicula(id)
);

create table Participa(
idPelicula int,
idTipo int,
idCasting int,
foreign key(idPelicula) references Pelicula(id),
foreign key(idTipo) references Tipo(id),
foreign key(idCasting) references Casting(id)
);

show tables;
/*INSERTS DE CIUDAD*/
insert into Ciudad() values(1, "Valencia");
insert into Ciudad() values(2, "Palma");
select * from Ciudad;

/*INSERTS DE CASTING*/
insert into Casting() values(1, "Antonio", "López", "");
insert into Casting() values(2, "Geronimo", "Stilton", "Vázquez");
select * from Casting;

/*INSERTS DE TIPO*/ /*OPCIONES: actua o dirige*/
insert into Tipo() values(1, "dirige");
insert into Tipo() values(2, "actua");
select * from Tipo;

/*INSERTS DE PELICULA*/
insert into Pelicula() values(1, "La ciudad perdida");
insert into Pelicula() values(2, "Jaula");
select * from Pelicula;

/*INSERTS DE SOCIO*/
insert into Socio() values(1, "43479567B", "Jose", "Palomero", "", "653786348", "Plaça de la concordia", 1);
insert into Socio() values(2, "42304685F", "Pedro", "Jackson", "Jiménez", "677872022", "Calle Cinamomo", 2);
select * from Socio;

/*INSERTS DE ALQUILA*/
insert into Alquila() values("2022-09-25", "2022-10-09", 1, 2);
insert into Alquila() values("2022-10-30", "2022-11-09", 2, 1);
select * from Alquila;

/*INSERTS DE PARTICIPA*/
insert into Participa() values(1, 2, 2);
insert into Participa() values(2, 2, 2);
select * from Participa;

/*EXERCICI DDL VIDEOCLUB*/

/*EJERCICIO 2*/
alter table Socio
add email varchar(30);

/*EJERCICIOS 3 I 4*/
alter table Socio
add data_naixement date;
update Socio set data_naixement = "2022-01-22" where id=1;
update Socio set data_naixement = "2022-01-22" where id=2;
select * from Socio;
alter table Socio
modify data_naixement date not null;
show create table Socio;

/*EJERCICIO 5*/
set sql_safe_updates=0;
alter table Socio add any_naixement year;
update Socio set any_naixement = year (data_naixement);
alter table Socio drop column data_naixement;
select * from Socio;

/*EJERCICIO 6*/
alter table Socio
add tipus int;
select * from Socio;
update Socio set tipus = 1 where id=1;
update Socio set tipus = 2 where id=2;

/*EJERCICIO 7*/
alter table Socio
modify tipus varchar(10);
update Socio set tipus = "VIP" where id=1;
update Socio set tipus = "Normal" where id=2;

/*EJERCICIO 8*/
create table Pais(
id int auto_increment,
nombre varchar(20) not null,
primary key(id)
);

select * from Pais;
alter table Casting/*NO FUNCIONA*/
add idPais int,
add foreign key(idPais) references Pais(id) on delete no action on update cascade;

insert into Pais(nombre) values("España");
insert into Pais(nombre) values("Francia");
update Casting
set idPais = 1
where id = 1;
update Casting
set idPais = 2
where id = 2;

/*EJERCICIO 9*/
delete from Pais where id = 1;

/*EJERCICIO 10*/
set sql_safe_updates=0;
alter table Casting
drop constraint casting_ibfk_1;
alter table Pais
modify id varchar(3);
show create table Pais;
show create table Casting;
alter table Casting
modify idPais varchar(3);

alter table Casting 
add foreign key(idPais) references Pais(id);

/*EJERCICIO 11*/
alter table Pelicula
add descripcio char;
alter table Pelicula
modify descripcio char not null;
select * from Pelicula;

/*EJERCICIO 12*/
alter table Pelicula
add column descripcio varchar(60) not null;
alter table Pelicula
add unique(descripcio); /*NO DEJA AÑADIR UNIQUE*/
show create table Pelicula;

/*EJERCICIO 13*/
alter table Pelicula
add column preu int not null;
alter table Pelicula
add column valoracio int not null;
alter table Pelicula
modify preu int not null check(preu>=1); /*PUEDE SER 0.11 O A PARTIR DE 1*/
update Pelicula set preu=100 where id =1;
update Pelicula set preu=200 where id =2;
alter table Pelicula
modify valoracio int not null check(valoracio>=1);

/*EJERCICIO 14*//*NO FUNCIONA*/
alter table Socio
add column tarifa int;
update Socio set tarifa=100;
update Socio set tarifa=0 where id=1 or id=1academiasacademias00;
select * from Socio;
show create table Socio;

/*EJERCICIO 15*//*NO FUNCIONA*/
update Socio set tarifa=(tarifa*0.1)+tarifa;

/*AÑADIR LOS EJERCICIOS QUE FALTAN*/
