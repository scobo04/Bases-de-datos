create database fultbol;

use fultbol;

create table pais (
id int auto_increment primary key ,
nom varchar (45)
);

create table temporada (
id int auto_increment primary key,
nom varchar (45)
);
alter table temporada modify column nom varchar (45) not null;

show create table equipo;
create table equipo (
id int primary key,
nom varchar (45),
tipos varchar (45),
id_pais int,
foreign key (id_pais) references pais(id)
);
alter table equipo modify column tipos enum ("SEL","NORMAL") ;
alter table equipo modify column nom varchar (45) not null ;
alter table equipo modify column id int not null auto_increment ;
SET FOREIGN_KEY_CHECKS = 0;

create table jugador (
id int auto_increment primary key,
nom varchar (45),
llinatge1 varchar (45),
llinatge2 varchar (45),
data_naixement date,
id_pais int,
id_equipo int,
foreign key (id_pais) references pais(id),
foreign key (id_equipo) references equipo(id)
);
alter table jugador modify column id_pais int not null;
alter table jugador modify column llinatge1 varchar (45);
alter table jugador modify column data_naixement varchar (45);

create table titol(
id int auto_increment primary key,
nom varchar (45),
id_equipo int,
foreign key (id_equipo) references equipo(id)
);
alter table titol modify column nom varchar (200) not null ;
alter table titol modify column id_equipo int not null ;

create table gols (
id int auto_increment,
id_equipo int not null,
id_temporada int unique,
numero_gols int,
primary key (id, id_equipo, id_temporada) ,
foreign key (id_equipo) references equipo(id),
foreign key (id_temporada) references temporada(id)
);
show create table gols;

create table partit (
id int auto_increment primary key,
id_equipo_local int ,
id_equipo_visitant int ,
data date ,
resultat varchar(45),
foreign key (id_equipo_local) references equipo(id),
foreign key (id_equipo_visitant) references equipo(id)
);
alter table partit modify column id_equipo_local int unique not null ;
alter table partit modify column id_equipo_visitant int unique not null ;
alter table partit modify column data varchar (45) not null ;
/*alter table partit drop index data;*/


create table millor_Partit (
id_partit int,
id_jugador int,
equipo enum ('1','2'),
foreign key (id_partit) references partit(id),
foreign key (id_jugador) references jugador(id)
);
alter table millor_Partit add id_millor_partit int auto_increment primary key;
alter table millor_Partit modify column id_jugador int not null;
alter table millor_Partit modify column id_partit int not null;




#pais 
select * from pais;
insert into pais (nom) select distinct pais from jugadors; 
SET SQL_SAFE_UPDATES = 0;
insert into pais(nom) value ("Argentina");


#equipo      
select * from equipo;
insert into equipo (nom, tipos) select distinct equips, "NORMAL" from equipos ;

insert into equipo (nom, tipos, id_pais) select distinct seleccion, "SEL", pais.id from jugadors, pais
where jugadors.pais = pais.nom ;


#temporada      
select * from temporada;
insert into temporada (nom) select distinct temporada from equipos;



#Falta por hacer  
show tables;
select * from Equipo;
insert into jugadors (jugador, pais, seleccion, mejor_partido1, mejor_partido2, data_naixament) 
values ("messi", "Argentina", "Argentina", "Barça-PSG,2-5-2015,1,1-0", "Barça-PSG,2-5-2015,1,1-0","16-01-2020");

select * from jugador; 
show create table jugador;

insert into jugador(nom, data_naixement, id_pais, id_equipo) 
select players.jugador, players.data_naixament, pais.id, equipo.id 
from jugadors as players, pais, equipo 
where players.pais = pais.nom
and players.seleccion = equipo.nom;

 
 
# titol
select * from titol;
show create table titol;
insert into titol(nom, id_equipo) select distinct  titol1, equipo.id from equipos, equipo where equipos.equips = equipo.nom;
insert into titol(nom, id_equipo) select distinct  titol2, equipo.id from equipos, equipo where equipos.equips = equipo.nom;
insert into titol(nom, id_equipo) select distinct  titol3, equipo.id from equipos, equipo where equipos.equips = equipo.nom;

#gols
select * from gols;
 show create table gols;
  
insert into gols (id_equipo, id_temporada, numero_gols) select equipo.id, temporada.id, equipos.nombreGols from equipo, temporada, equipos
where equipos.temporada = temporada.nom
and equipos.equips = equipo.nom;
alter table gols add foreign key (id_temporada) references temporada(id);

#partit 
select * from partit;  
select * from equipo;
select * from jugadors;
select * from jugador; 

/*NO*/
insert into partit (id_equipo_local, id_equipo_visitant, data, resultat)
select 
	(select equipo.id from equipo where equipo.nom = substring_index(mejor_partido1, "-", 1)) as equipo1,
	(select equipo.id from equipo where equipo.nom = substring_index(substring_index(mejor_partido1, ",", 1), "-", -1)) as equipo2,
	(select substring_index(substring_index(mejor_partido1, ",", 2), ",", -1)) as fecha,
	(select substring_index(mejor_partido1, ",", -1)) as resultado
from jugadors;

/*
insert into partit(id_equipo_local, id_equipo_visitant, resultat, data)
select (select equipo.id from equipo where equipo.nom = SUBSTRING_INDEX(jugadors.mejor_partido2, '-', 1)) AS equipo1,
(select equipo.id from equipo where equipo.nom = SUBSTRING_INDEX(SUBSTRING_INDEX(jugadors.mejor_partido2, ',', 1), '-', -1)) as equipo2,
(select SUBSTRING_INDEX(jugadors.mejor_partido2, ',', -1)) as resultado,
(select SUBSTRING_INDEX(SUBSTRING_INDEX(jugadors.mejor_partido2, ',', 2),',',-1)) as fecha
from jugadors;
*/

delete from partit where id = 8;

select * from millor_Partit;
show create table millor_Partit;

select * from jugador;
select * from jugadores;
select * from partit;


#este seria para los locales
select 

(select partit.id from partit, equipo where partit.id_equipo_local = equipo.id
 and equipo.nom = substring_index(jugadors.mejor_partido1, "-",1) 
 and partit.data = substring_index(substring_index(jugadors.mejor_partido1,",",2),",",-1)) as partido,
 
(select jugador.id from jugador where jugador.nom = jugadors.jugador) as jugador,

(select "1" where substring_index(substring_index(mejor_partido1,",",3),",",-1) = 1)

from jugadors;
 
 
 #este seria para los visitantes
 select 

(select partit.id from partit, equipo where partit.id_equipo_visitant = equipo.id
 and equipo.nom = substring_index(jugadors.mejor_partido1, "-",1) 
 and partit.data = substring_index(substring_index(jugadors.mejor_partido1,",",2),",",-1)) as partido,
 
(select jugador.id from jugador where jugador.nom = jugadors.jugador) as jugador,

(select "2" where substring_index(substring_index(mejor_partido1,",",3),",",-1) = 2)
from jugadors;
 

create table jugador ( id int auto_increment primary key, nom varchar (45), llinatge1 varchar (45), llinatge2 varchar (45), data_naixement date, id_pais int, id_equipo int, foreign key (id_pais) references pais(id), foreign key (id_equipo) references equipo(id) )
