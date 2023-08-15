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

/*EJERCICIOS DE QUERY*/
/*EJERCICIO 1: Selecciona el dni dels socis que el seu email és null.*/
ALTER TABLE socio ADD COLUMN email VARCHAR(30);
UPDATE socio SET email="maria@gmai.com" WHERE id=1;
SELECT dni FROM socio WHERE email IS NULL;

/*EJERCICIO 2: Selecciona el dni dels socis que el seu nom conté la paraula Joan.*/
SELECT dni FROM socio WHERE nombre LIKE "%Joan%";
SELECT dni FROM socio WHERE nombre LIKE "%Migue%";
SELECT dni FROM socio WHERE nombre LIKE "%Maria%";

/*EJERCICIO 3: Selecciona el dni dels socis que el seu nom és Joan.*/
SELECT dni FROM socio WHERE nombre LIKE "Joan";
SELECT dni FROM socio WHERE nombre LIKE "Maria";

/*EJERCICIO 4: Selecciona el dni dels socis que el seu nom és Joan i el llinatge1 és Mora.*/
SELECT dni FROM socio WHERE nombre LIKE "Migue";
INSERT INTO socio(id,nombre,ape1,ape2,tlf,direccion,dni,id_ciudad,email) VALUES(3,"Miguel Ángel","Porras","Rodríguez","625466566","Calle Lorenzo 2","34276943G",1, "miguelangel@gmail.com");
SELECT * FROM socio;
SELECT dni FROM socio WHERE nombre="Miguel Angel" AND ape1 LIKE "Porras";
SELECT dni FROM socio WHERE nombre="Migue" AND ape1 LIKE "Morena";
SELECT dni FROM socio WHERE nombre="Maria" AND ape1 LIKE "Morena";

/*EJERCICIO 5: Selecciona l’identificador i títol de les pel·lícules. Ordena per nom de 
pel·lícula.*/
SELECT id,titulo FROM pelicula ORDER BY titulo;

/*EJERCICIO 6: Selecciona l’identificador i títol de les pel·lícules. Ordena per preu de 
la pel·lícula.*/
ALTER TABLE pelicula ADD COLUMN preu FLOAT;
SELECT * FROM pelicula;
UPDATE pelicula SET preu=25.90 WHERE id=1;
UPDATE pelicula SET preu=12.5 WHERE id=2;
SELECT id,titulo FROM pelicula ORDER BY preu;

/*EJERCICIO 7: Selecciona els socis que tenen telefon.*/
SHOW CREATE TABLE socio;
ALTER TABLE socio MODIFY COLUMN tlf varchar(45);
UPDATE socio SET tlf= null WHERE id=2;
SELECT * FROM socio;
SELECT * FROM socio WHERE tlf IS NOT NULL;

/*EJERCICIO 8: Selecciona els lloguer de pel·lícules on la data de devolució sigui inferior 
a 1/1/2022. Mostra sols els 3 primers registres.*/
SELECT * FROM alquila;
INSERT INTO alquila VALUES(3,1,"2021/01/01","2021/06/01");
SELECT * FROM alquila WHERE f_final < "2022/01/01" LIMIT 3;

/*EJERCICIO 9: Mostra el preu mínim de les pel·lícules introduïdes.*/
SELECT * FROM pelicula;
SELECT MIN(preu) FROM pelicula; 

/*EJERCICIO 10: Mostra el preu màxim de les pel·lícules introduïdes.*/
SELECT * FROM pelicula;
SELECT MAX(preu) FROM pelicula; 

/*EJERCICIO 11: Mostra la mitjana de preus de les pel·lícules introduïdes.*/
SELECT * FROM pelicula;
SELECT AVG(preu) FROM pelicula; 

/*EJERCICIO 12: Mostra el nombre de pel·lícules que tenim.*/
SELECT * FROM pelicula;
SELECT COUNT(preu) FROM pelicula; 

/*EJERCICIO 13: Mostra la suma dels preus de les pel·lícules.*/
SELECT * FROM pelicula;
SELECT SUM(preu) FROM pelicula; 

/*EJERCICIO 14: Mostra els lloguers fets els anys 2022 i 2021.*/
SELECT * FROM alquila;
SELECT * FROM alquila WHERE f_inicio >= "2021-01-01" AND f_inicio < "2023-01-01";

/*EJERCICIO 15: Mostra el tamany del títol de les pel·lícules i ordena per aquest tamany, 
de major a menor.*/
SELECT * FROM pelicula;
SELECT CHAR_LENGTH(titulo) FROM pelicula ORDER BY titulo DESC;

/*EJERCICIO 16: Mostra el tamany màxim del títol de les pel·lícules.*/
SELECT * FROM pelicula;
SELECT CHAR_LENGTH(MAX(titulo)) FROM pelicula;

/*EJERCICIO 17: Mostra les pelicules que el seu títol està compost per menys de 20 caràcters.*/
SELECT * FROM pelicula;
SELECT * FROM pelicula WHERE(CHAR_LENGTH(titulo)<20);

/*EJERCICIO 18: Mostra el una sola columna l’id de la película i el nom. Separats per un guió.*/
SELECT * FROM pelicula;
SELECT CONCAT(id, " - ", titulo) AS PELICULA FROM pelicula;

/*EJERCICIO 19: Substitueix tots els correus de socis que tens que son gmail.es per gmail.com.*/
SELECT * FROM socio;
UPDATE socio SET email='maria@gmail.es' WHERE id=1;
UPDATE socio SET email=REPLACE(email, '.es', '.com') WHERE email LIKE '%gmail.es' AND id='%';
SHOW CREATE TABLE socio;

/*EJERCICIO 20: Mostra quants registres tens a socis que el camp adreça comença per c/.*/
SELECT * FROM socio;
SELECT COUNT(id) FROM socio WHERE direccion LIKE 'C/%';

/*EJERCICIO 21: Afegeix un camp contrasenya a la taula de socis. Emplena aquest camp amb el 
nom del soci al reves un guió i els nombre 12345678*/
ALTER TABLE socio ADD COLUMN contraseña VARCHAR(50);
SET sql_safe_updates = 0;
UPDATE socio SET contraseña=CONCAT(REVERSE(nombre),' - ', 12345678);
SELECT * FROM socio;

/*EJERCICIO 22: Mostra l’id, el nom de la película i els 30 primers caràcters de la seva 
descripció. Ordena per id.*/
SELECT * FROM pelicula;
ALTER TABLE pelicula ADD COLUMN descripcion VARCHAR(60);
UPDATE pelicula SET descripcion="Pelicula ilustrada en hechos reales." WHERE id=1;
SELECT id,titulo,SUBSTRING(descripcion, 1,30) AS Pelicula FROM pelicula ORDER BY id;

/*EJERCICIO 23: Afegeix a totes les adreces de socis el “c/” a davant de tot.*/
SELECT * FROM socio;
UPDATE socio SET direccion=CONCAT('c/', direccion);

/*EJERCICIO 24: Modifica els registres per tal d’eliminar a tots els c/.*/
UPDATE socio SET direccion=REPLACE(direccion,"c/","");
SELECT * FROM socio;

/*EJERCICIO 25: Modifica el camp preu de película perque sigui un nombre decimal.*/
SELECT * FROM pelicula;
ALTER TABLE pelicula MODIFY preu double;
SHOW CREATE TABLE pelicula;

/*EJERCICIO 26: Modifica els registres de preu de pelicula perque el preu sigui un decimal 
(procura que hi hagi nombres > .5 i <.5).*/
SELECT * FROM pelicula;
UPDATE pelicula SET preu=RAND(2)*(10-2);
UPDATE pelicula SET preu=12.2 WHERE preu<=12.5;

/*EJERCICIO 27: Arrodoneix els preus fent que cada preu sigui el seu sencer major més proper.*/
SELECT * FROM pelicula;
UPDATE pelicula SET preu=ROUND(preu,0);

/*EJERCICIO 28: Modifica els registres de preu de pelicula perque el preu tengui 3 decimals 
(procura que hi hagi de tot).*/
SELECT * FROM pelicula;
UPDATE pelicula SET preu=26.746 WHERE id=1;
UPDATE pelicula SET preu=12.12 WHERE id=2;
UPDATE pelicula SET preu=ROUND(preu,3);

/*EJERCICIO 29: Modifica els registres de preu de pelicula perque el preu quedi arrodonit a 2 
decimals.*/
SELECT * FROM pelicula;
UPDATE pelicula SET preu=ROUND(preu,2);

/*EJERCICIO 30: Modifica els registres de preu de pelicula perque el preu sigui un decimal 
(procura que hi hagi nombres > .5 i <.5).*/
SELECT * FROM pelicula;
UPDATE pelicula SET preu=26.633 WHERE id=1;
UPDATE pelicula SET preu=ROUND(preu,1);

/*EJERCICIO 31: Modifica els registres de preu de pelicula perque el preu sigui el seu sencer 
menor més proper.*/
SELECT * FROM pelicula;
UPDATE pelicula SET preu=FLOOR(preu);

/*EJERCICIO 32: Has decidit que ampliaràs la data de devolució de les películes i a totes 
aquelles que no s’han tornat els ampliaràs el termini a 10 dies més.*/
SELECT * FROM alquila;
UPDATE alquila SET f_final=DATE_ADD(f_final, interval 10 day) WHERE f_final IS NOT NULL;
/*(TENDRIAMOS QUE HABER CREADO f_final_real)*/

/*EJERCICIO 33: Modifica la taula de lloguers de pelicules per a que el camp data_lloguer 
prengui sempre per defecte la data del dia que s’efectua el lloguer.*/
SELECT * FROM alquila;
ALTER TABLE alquila MODIFY COLUMN f_inicio date DEFAULT(CURRENT_DATE());

/*EJERCICIO 34: Modifica la taula de lloguers de pelicules per a que el camp data_lloguer 
no sols contingui la data sinó que també contingui l’hora, minuts, …*/
SELECT * FROM alquila;
ALTER TABLE alquila MODIFY COLUMN f_inicio datetime DEFAULT(CURRENT_DATE());

/*EJERCICIO 35: Fes una consulta que torni el nombre de dies de cada un dels lloguers.*/
SELECT datediff(f_final,f_inicio) FROM alquila;
SELECT * FROM alquila;

/*EJERCICIO 36: Fes una consulta que torni els lloguers que la data en que s’han 
tornat respecte a la data en que teòricament s’havien de tornar supera els 10 dies.*/
/*HAY QUE CREAR f_final_teorica para que funcione*/ SELECT * FROM alquila WHERE datediff(f_final_real,f_final_teorica) > 10;

/*EJERCICIO 37: Treu les reserves que s’han fet en dilluns al llarg d’aquest any.*/
SELECT * FROM alquila WHERE year(f_final)=year(current_date()) AND weekday(f_inicio) = 0;

/*EJERCICIO 38: Mostra el nom complet dels socis en el format llinatge1 “espai” llinatge2 
“coma”, nom.*/
SELECT concat(ape1, " " ape2, " " nombre) FROM socio; /*NO FUNCIONA*/

/*EJERCICIO 39: Mostra el nom del correu sense el domini de les adreces de correu dels socis.*/
SELECT substring(email,1,locate("@",email)-1) FROM socio;
SELECT * FROM socio;

/*EJERCICIO 40: Mostra els dominis dels correus que tens introduïts. Eliminar repetits.*/
SELECT DISTINCT substring(email, locate("@", email)+1, length(email)) FROM socio;

/*EJERCICIO 41: Mostra si tenc algun correu que no sigui de gmail.com.*/
SELECT * FROM socio WHERE email NOT LIKE "%gmail.com";

/*EJERCICIO 42: Mostra l’hora de les reserves fetes avui.*/
SELECT hour(f_inicio) FROM alquila WHERE f_inicio=current_date();


/*PRACTICAR SELECTS EN CLASE PROFE*/
SELECT socio.nombre, socio.ape1, socio.ape2, ciudad.nombre 
FROM socio,ciudad 
WHERE socio.id_ciudad=ciudad.id;

SELECT pelicula.titulo, cast1.nombre, cast1.ape1, cast1.ape2, tipo.nombre 
FROM pelicula,participa,cast1,tipo
WHERE pelicula.id=participa.id_pelicula
AND participa.id_cast1=cast1.id
AND participa.id_tipo=tipo.id
ORDER BY pelicula.titulo ASC, tipo.nombre DESC;


/*cuantas pelis tiene un determinado actor*/
SELECT COUNT(*) 
FROM pelicula,participa,cast1,tipo
WHERE pelicula.id=participa.id_pelicula
AND participa.id_cast1=cast1.id
AND participa.id_tipo=tipo.id
AND tipo.nombre="dirige"
AND cast1.nombre="Denzel";


SELECT * FROM cast1;
describe cast1;
INSERT INTO cast1 VALUES(5,"Penelope", " ", " ");/*PEDIR COMANDO COMPLETO*/

/*LEFT JOIN*/
SELECT cast1 .*, participa.*
FROM cast1
LEFT JOIN participa
ON cast1.id=participa.id_cast1;


/*RIGHT JOIN*/
SELECT * FROM ciudad;
SELECT socio.*, ciudad.*
FROM socio
RIGHT JOIN ciudad
ON ciudad.id=socio.id_ciudad;

/*UNION*/
SELECT socio.nombre, socio.ape1, socio.ape2
FROM socio
UNION
SELECT cast1.nombre, cast1.ape1, cast1.ape2
FROM cast1;

/*ESTE NO FUNCIONA PORQUE NO EXISTE MANACOR*/
SELECT socio.nombre, socio.ape1, socio.ape2
FROM socio, ciudad
WHERE socio.id_ciudad=ciudad.id
AND ciudad.nombre="Manacor"
UNION
SELECT cast1.nombre, cast1.ape1, cast1.ape2
FROM cast1;

/*GROUP BY*/
SELECT COUNT(socio.id), ciudad.nombre
FROM socio,ciudad
WHERE socio.id_ciudad=ciudad.id
GROUP BY ciudad.nombre;


/*SUM*/
ALTER TABLE alquila ADD COLUMN price float;
SET SQL_SAFE_UPDATES = 0;
UPDATE alquila SET price=10;
UPDATE alquila SET id_socio=1;
SELECT * FROM alquila;
SELECT socio.id, socio.nombre, socio.ape1, socio.ape2, sum(alquila.price)
FROM socio, alquila
WHERE alquila.id_socio=socio.id
GROUP BY (socio.id);


/*HAVING*/
SELECT socio.id, socio.nombre, socio.ape1, socio.ape2, sum(alquila.price) AS total
FROM socio, alquila
WHERE alquila.id_socio=socio.id
GROUP BY (socio.id)
HAVING total>1000;

/*peliculas que han participado menos de 3 personas*/
SELECT pelicula.id, pelicula.titulo, count(participa.id_pelicula) AS total
WHERE pelicula.id=participa.id_pelicula
GROUP BY (pelicula.id)
HAVING total<3;

/*EXISTS*/
/*los socios que no tienen ningun alquiler*/
SELECT socio.*
FROM socio
WHERE NOT EXISTS (SELECT * FROM alquila WHERE socio.id=alquila.id_socio);

/*los socios que tienen algun alquiler*/
SELECT socio.*
FROM socio
WHERE EXISTS (SELECT * FROM alquila WHERE socio.id=alquila.id_socio);

/*los socios que todavia no han alquilado Avatar*/
SELECT socio.*
FROM socio
WHERE NOT EXISTS (SELECT * FROM alquila, pelicula WHERE socio.id=alquila.id_socio 
AND 
alquila.id_pelicula=pelicula.id AND pelicula.titulo="Avatar") 
AND socio.id_ciudad=ciudad.id AND ciudad.nombre="Manacor";
