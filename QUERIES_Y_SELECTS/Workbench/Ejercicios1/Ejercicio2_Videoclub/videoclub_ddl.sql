create database videoclub;
use videoclub;

create table ciudad (
	id int primary key,
    nombre varchar(50)
);
create table socio (
	id int primary key,
    nombre varchar(50),
    apellido1 varchar(50),
    apellido2 varchar(50) null,
    telefono varchar(12),
    direccion varchar(65),
    dni varchar(9),
    localidad int,
    constraint fk_socio_ciudad foreign key (localidad) references ciudad(id)
);
create table pelicula (
	id int primary key,
    titulo varchar(55)
);
create table alquila (
	socio int,
    pelicula int,
    f_inicio datetime,
    primary key (socio,pelicula,f_inicio),
    f_final datetime null,
    constraint fk_alquila_socio foreign key (socio) references socio(id),
    constraint fk_alquila_pelicula foreign key (pelicula) references pelicula(id)
);
create table casting (
	id int primary key,
    nombre varchar(50),
    apellido1 varchar(50),
    apellido2 varchar(50) null
);
create table tipo (
	id int primary key auto_increment,
    nombre varchar(35) unique
);
create table participa (
	pelicula int,
    casting int,
    tipo int,
    primary key (pelicula,casting,tipo),
    constraint fk_participa_pelicula foreign key (pelicula) references pelicula(id),
    constraint fk_participa_casting foreign key (casting) references casting(id),
    constraint fk_participa_tipo foreign key (tipo) references tipo(id)
);

/* inserts */

insert into ciudad values (1,'Porto Cristo');
insert into ciudad values (2,'Albacete');
insert into socio values (1,'Antonio Paco','Valle-Inclán','del Bosque',671532900,'Patrons Camel·los, 2','67154482Y',1);
insert into socio values (2,'Octavio Wilson','Praderas',null,472232502,'Lorzas, 14 B','91852252E',2);
insert into pelicula values (1,'Sharknado');
insert into pelicula values (2,'Shrek');
insert into alquila values (1,1,'2020-02-29 13:05:26',null);
insert into alquila values (2,2,'2021-10-04 19:20:50','2021-10-11 09:07:44');
insert into casting values (1,'Joseba','de Carglass',null);
insert into casting values (2,'Malenia','Trump',null);
insert into tipo values (1,'actor');
insert into tipo values (2,'director');
insert into participa values (1,1,1);
insert into participa values (2,2,2);

/* exercicis DDL */

/* 1- Afegir que DNI a soci sigui una unique key. */

alter table socio modify dni varchar(50) unique;

/* 2- Afegeix una columna anomenada email a la taula de socis. Aquesta columna ha de ser 
un varchar(30) i pot contenir valors nulls. */
 
alter table socio add column email varchar(30);

/* 3- Afegeix una columna anomenada data_naixement a la taula de socis.
Aquesta columna ha de ser un date i ha de ser not null. */

alter table socio add column data_naixement date;
update socio set data_naixement='1974-05-12' where id=1;
update socio set data_naixement='1989-10-03' where id=2;
alter table socio modify data_naixement date not null;

/* 4- Modifica els registres de la taula de socis per tal de que cada un d’ells 
contingui la seva data de naixement corresponent. */

/* ^ ja està fet al 3 ^ */

/* 5- Imagina que ara has decidit que basta desar l’any de naixement , no la data sencera. */

alter table socio modify data_naixement year;

/* 6- Afegeix un camp tipus a la taula de socis . Ha de ser un int. Serà de tipus 1 
tots els clients que són VIP i de tipus 2 els clients normals. 
Modifica alguns registres de la taula per tal que alguns siguin VIP i altres clients normals. */

alter table socio add column tipo int not null check(tipo=1 or tipo=2);
update socio set tipo=1 where id=1;
update socio set tipo=2 where id=2;

/* 7- Imagina que ara vols que aquest valor enlloc de ser 1,2 sigui VIP, NORMAL. */
alter table socio change tipo tipo enum('VIP','NORMAL') not null;

/* 8- Imagina que ara decideixes que dels actors i directors vols desar el país. 
Aquest camp ha de ser obligatori. Vols que quan es borri un país els actors i directors 
d’aquest país si té directors o actors no t’ho deixi fer. 
I si es modifica un pais vols que es modifiqui el país dels actors i directors associats. */

create table pais (
	id int primary key,
    nombre varchar(40)
);

insert into pais values (1,'Russia');
insert into pais values (2,'Australia');

alter table casting
	add column pais int not null,
    add constraint fk_casting_pais foreign key (pais) references pais(id) on update cascade;

/* 9- Fes la prova de les claus forànies de l’exercici anterior. 
Intenta eliminar un país que té actors o directors associats i comprova que no et deixa. 
Modifica un país que té actors o directors associats i comprova que la modificació es propaga. */ 
 
update casting set pais=1 where id=1;
update casting set pais=1 where id=2;
delete from pais where id=1;

/* 10- T’has equivocat amb la taula país. Has posat que la seva clau primària sigui un int , 
però ara decideixes que la clau primària ha de ser un varchar(3) , 
3 dígits que representen el país. Duu a terme les modificacions. */
 
alter table casting drop constraint fk_casting_pais;
alter table pais modify id varchar(3);
alter table casting modify pais varchar(3);
alter table casting add constraint fk_casting_pais foreign key (pais) references pais(id) on update cascade;

/* 11- Afegeix un camp descripció a la taula pelicula. Aquest camp ha de ser not null. */

alter table pelicula add column descripció varchar(120) not null;

/* 12- Se t’havia oblidat control·lar que no hi pot haver dues pel·lícules amb el mateix nom. */

alter table pelicula modify titulo varchar(55) not null unique;

/* 13- Se t’havia oblidat guardar el preu de la pelicula i una valoracio. 
El preu ha de ser un nombre sencer major que 0. 
La valoracio ha de poder prendre un valor de l’1 al 10.Ambdós camps han de ser obligatoris. */

alter table pelicula add column preu int not null check(preu > 0);
alter table pelicula add column valoracio int not null check(valoracio > 1 && valoracio < 11);

update pelicula set valoracio=6 where id=1;
update pelicula set preu=3 where id=1;

/* 14- Imagina que vols fixar una tarifa als socis. 
A tots els socis que tens fins al moment els vols posar una tarifa de 100 euros anuals, 
però als socis 1 i 100 per ser el soci 1 i 100 els vols posar una tarifa de 0 euros. */

alter table socio add column tarifa int default(100);
update socio set tarida=0 where id=1;
update socio set tarifa=0 where id=2;
insert into socio (id,nombre,apellido1,apellido2,telefono,direccion,dni,localidad,email,data_naixement,tipo)
	values (102,'Olgierd','Von Everec',null,292412562,'Lorzas, 12','22842687G',2,null,1990,2);

/* 15- Ara imagina que ha passat un any i deicideixes augmentar la tarifa un 10%. 
Ja has introduït nous registres i ja no tots els registres tenen la tarifa 0 ò 100 euros. 
LLavors, tu vols que es modifiqui un 10 per cent totes les tarifes sigui quin sigui el seu preu. */

update socio set tarifa=tarifa*1.1;

/* 16- Borra aquells socis que no tenen cap lloguer fet */

delete from socio where id = 102;

/* 17- Necessites saber com tens definides totes les taules de la base de dades perque se t’ha oblidat
si vares donar nom a les foreign … */

show create table alquila;
show create table casting;
show create table ciudad;
show create table pais;
show create table participa;
show create table pelicula;
show create table socio;
show create table tipo;

/* 18- Ara decideixes que quan algú modifiqui el codi d’un país no vols que es modifiquin 
els registres amb valors associats a aquell pais. */

alter table casting drop foreign key fk_casting_pais;
alter table casting add constraint foreign key fk_casting_pais (pais) references pais(id);

/* 19- Has fet moltes modificacions a la base de dades i t’interessa tenir 
el diagrama de taules actualitzat . Com fer-ho? */

/* Database > Reverse engineer */

/* 20- Afegeix una restricció que digui que no pots posar un lloguer amb data de devolució major 
que data de lloguer */

alter table alquila modify column f_final datetime check(f_final >= f_inicio);