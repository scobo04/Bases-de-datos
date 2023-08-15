create database jugadors;

use jugadors;

create table pais(
    id int auto_increment,
    nom varchar(200),
    PRIMARY KEY (id)
);

create table equip (
    id int auto_increment,
    nom varchar(200),
    tipus enum('sel','normal'),
    national_team int,
    PRIMARY KEY (id),
    Foreign Key (national_team) REFERENCES pais(id)
);

create table jugador (
    id int auto_increment,
    nom varchar(200),
    llinatge1 varchar(200),
    llinatge2 varchar(200),
    data_naixament date,
    id_equip int,
    id_pais int,
    PRIMARY KEY (id),
    Foreign Key (id_equip) REFERENCES equip(id),
    Foreign Key (id_pais) REFERENCES pais(id)
);

create table temporada (
    id int auto_increment,
    anyo varchar(200),
    PRIMARY KEY (id)
);

create table temporada_equip (
    id_equip int,
    id_temporada int,
    num_gols int,
    Foreign Key (id_equip) REFERENCES equip(id),
    Foreign Key (id_temporada) REFERENCES temporada(id)
);

create table titol(
    id int auto_increment,
    nom VARCHAR(200),
    id_equip int,
    PRIMARY KEY (id),
    Foreign Key (id_equip) REFERENCES equip(id)
);

create table partit(
    id int auto_increment,
    data_partit date,
    resultado VARCHAR(200),
    equip_local int,
    equip_visitant int,
    PRIMARY KEY (id),
    Foreign Key (equip_local) REFERENCES equip(id),
    Foreign Key (equip_visitant) REFERENCES equip(id)
);

create table millorPartit(
    id_jugador int,
    id_partit int,
    equip enum('1','2'),
    Foreign Key (id_partit) REFERENCES partit(id),
    Foreign Key (id_jugador) REFERENCES jugador(id)
);

insert into jugadors.temporada (anyo) 
select DISTINCT equipos.temporada from jugadors_desnormalizada.equipos;

insert into jugadors.pais (nom)
select DISTINCT jugadors.pais from jugadors_desnormalizada.jugadors;

insert into jugadors.jugador (nom, data_naixement, )

/*càrrega de seleccions*/
insert into jugadors.equip (nom, tipus, jugadors.pais.id)
select DISTINCT jugadors_desnormalizada.jugadors.seleccion, "sel", jugadors.pais.id
FROM jugadors, pais
where jugadors.pais = jugadors.pais.nom;

/*càrrega d'equips normals*/
insert into jugadors.equip (nom, tipus)
select DISTINCT jugadors.equip, "normal"
FROM jugadors_desnormalizada, pais
where jugadors.pais = jugadors.pais.nom;
