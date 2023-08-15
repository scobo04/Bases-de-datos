create database jugadors_desnormalizada;

use jugadors_desnormalizada;

create table jugadors(
    jugador varchar(200),
    data_naixament date,
    pais varchar(200),
    seleccion varchar(200),
    mejor_partido1 varchar(300),
    mejor_partido2 varchar(300),
    mejor_partido3 varchar(300),
    mejor_partido4 varchar(300),
    mejor_partido5 varchar(300)
);

create table equipos(
    equips varchar(200),
    temporada varchar(200),
    nombreGols int,
    titol1 varchar(200),
    titol2 varchar(200),
    titol3 varchar(200),
    titol4 varchar(200),
    titol5 varchar(200)
);

insert into jugadors (jugador,data_naixament,pais,seleccion,mejor_partido1,mejor_partido2,mejor_partido3,mejor_partido4,mejor_partido5) values ("Mbappe","1998-11-11","Francia","Francia","PSG-Argentina,2002-10-10,1,3-0","Madrid-PSG,2002-11-10,2,1-4",null,null,null);
insert into jugadors (jugador,data_naixament,pais,seleccion,mejor_partido1,mejor_partido2,mejor_partido3,mejor_partido4,mejor_partido5) values ("Messi","1988-10-11","Argentina","Argentina","Argentina-Madrid,2001-12-16,1,8-0","Francia-Argentina,2000-11-20,2,1-4",null,null,null);

insert into equipos (equips,temporada,nombreGols,titol1,titol2,titol3,titol4,titol5) values ("PSG","21-22",29,"LLiga 2018","Chanpions League 2023","Champions League 2009",null,null);
insert into equipos (equips,temporada,nombreGols,titol1,titol2,titol3,titol4,titol5) values ("Argentina","20-21",49,"LLiga 2019","Chanpions League 2022","Champions League 2010",null,null);

insert into equipos (equips,temporada,nombreGols,titol1,titol2,titol3,titol4,titol5) values ("Madrid","10-11",38,"LLiga 2020","Chanpions League 2020","Champions League 2017",null,null);