create database futbol;

use futbol;

select * from equips;

select * from jugadors;
select * from equips;


create table pais (
id int auto_increment primary key ,
nom varchar (45)
);

create table temporada (
id int auto_increment primary key,
nom varchar (45)
);
alter table temporada modify column nom varchar (45) not null;

create table jugador (
id int auto_increment primary key,
nom varchar (45),
llinatge1 varchar (45),
llinatge2 varchar (45),
data_naixement date,
id_pais int,
id_equip int,
foreign key (id_pais) references pais(id),
foreign key (id_equip) references equip(id)
);
alter table jugador modify column id_pais int not null;


show create table equip;
create table equip (
id int primary key,
nom varchar (45),
tipus varchar (45),
id_pais int,
foreign key (id_pais) references pais(id)
);
alter table equip modify column tipus enum ("SEL","NORMAL") ;
alter table equip modify column nom varchar (45) not null ;
alter table equip modify column id int not null auto_increment;
set FOREIGN_KEY_CHECKS = 0;

create table titol(
id int auto_increment primary key,
nom varchar (45),
id_equip int,
foreign key (id_equip) references equip(id)
);
alter table titol modify column nom varchar (45) null ;
alter table titol modify column id_equip int not null ;
show create table titol;

create table gols (
id int auto_increment primary key,
id_equip int not null,
id_temporada int not null unique,
numero_gols int not null, 
foreign key (id_equip) references equip(id),
foreign key (id_temporada) references temporada(id)
);
/*alter table gols modify column id_equip int not null ;
alter table gols modify column id_temporada int not null ;
alter table gols modify column numero_gols int not null ;
alter table gols add id int auto_increment primary key;
alter table gols drop primary key;*/
show create table gols;

create table partit (
id int auto_increment primary key,
id_equip_local int ,
id_equip_visitant int ,
data date ,
resultat varchar(45),
foreign key (id_equip_local) references equip(id),
foreign key (id_equip_visitant) references equip(id)
);
alter table partit modify column id_equip_local int unique not null ;
alter table partit modify column id_equip_visitant int unique not null ;
alter table partit modify column data date not null ;


create table millor_Partit (
id_partit int,
id_jugador int,
equip enum ('1','2'),
foreign key (id_partit) references partit(id),
foreign key (id_jugador) references jugador(id)
);
alter table millor_Partit add id_millor_partit int auto_increment primary key;
alter table millor_Partit modify column id_jugador int not null;
alter table millor_Partit modify column id_partit int not null;


show tables;


select * from equips;
select * from jugadors; /*tabla desnormalizada*//*es taula1*/
drop table pais;
select * from equip;
select * from jugador;


/*INSERTS SELECT*/

/*SI*/
insert into pais (nom) 
select distinct País 
from jugadors;

/*NO*/
insert into jugador (nom,data_naixement,id_pais,id_equip) 
select jugadors.Jugador,jugadors.Data_naixement,pais.id, equip.id 
from jugadors, pais, equip, equips
where equips.equip = equip.nom
and jugadors.Seleccio_que_juga = pais.nom;
describe jugador;
alter table jugadors modify column Data_naixement date not null;

show tables;
select * from equip;

/*SI*/
insert into equip (nom, tipus, id_pais) 
select distinct jugadors.Seleccio_que_juga, "SEL", pais.id 
from pais, jugadors
where jugadors.País = pais.nom;
delete from equips where Temporada is null;
set sql_safe_updates = 0;

insert into equip (nom, tipus)
select distinct equips.Equip, "NORMAL"
from equips;

/*SI*/
insert into titol (id_equip, nom) 
select distinct equip.id, equips.titol1 
from equips, equip 
where equips.equip = equip.nom;

/*SI*/
insert into titol (id_equip, nom) 
select distinct equip.id, equips.titol2 
from equips, equip 
where equips.equip = equip.nom;

/*SI*/
insert into titol (id_equip, nom) 
select distinct equip.id, equips.titol3 
from equips, equip 
where equips.equip = equip.nom;

/*SI*/
insert into temporada (nom)
select distinct equips.Temporada 
from equips;

/*SI*/
insert into gols (id_equip, id_temporada, numero_gols)
select distinct equip.id, temporada.id, equips.NombreGols 
from equip, temporada, equips;

show create table gols;
alter table gols drop index id_temporada;

set sql_safe_updates = 0;
delete from temporada where id is not null;
create index id_tem on temporada(id);
alter table gols drop index id_tem;
alter table gols add foreign key (id_temporada) references temporada(id);

/*NO*/
insert into partit (id_equip_local, id_equip_visitant, data, resultat)
select 
	(select equip.id from equipo where equip.nom = substring_index(Millor_partit_1, "-", 1)) as equip1,
	(select equip.id from equipo where equip.nom = substring_index(substring_index(Millor_partit_1, ",", 1), "-", -1)) as equip2,
	substring_index(substring_index(Millor_partit_1, ",", 2), ",", -1) as fecha,
	substring_index(Millor_partit_1, ",", -1) as resultat
from jugadors;


