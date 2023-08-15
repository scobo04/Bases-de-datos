/*   REPASAR EJERCICIOS SELECTS SENCILLOS   */
USE `videoclub_2_1`;

/*1. Selecciona el dni dels socis que el seu email és null.*/
SELECT * FROM socio;
SELECT socio.dni
FROM socio
WHERE socio.email IS NULL;

/*2. Selecciona el dni dels socis que el seu nom conté la paraula Joan.*/
SELECT socio.dni
FROM socio
WHERE socio.nombre LIKE '%Miguel%';

/*3. Selecciona el dni dels socis que el seu nom és Joan .*/
SELECT socio.dni
FROM socio
WHERE socio.nombre = 'Maria';

/*4. Selecciona el dni dels socis que el seu nom és Joan i el llinatge1 és Mora.*/
SELECT socio.dni
FROM socio
WHERE socio.nombre = 'Maria'
AND socio.ape1 = 'Morena';

/*5. Selecciona l’identificador i títol de les pel·lícules. Ordena per nom de pel·lícula.*/
SELECT pelicula.id, pelicula.titulo
FROM pelicula
ORDER BY pelicula.titulo;

/*6. Selecciona l’identificador i títol de les pel·lícules. Ordena per preu de la pel·lícula.*/
SELECT pelicula.id, pelicula.titulo, pelicula.preu
FROM pelicula
ORDER BY pelicula.preu;

/*7. Selecciona els socis que tenen telefon.*/
SELECT socio.*
FROM socio
WHERE socio.tlf IS NOT NULL;

/*8. Selecciona els lloguer de pel·lícules on la data de devolució sigui inferior a 1/1/2022. 
Mostra sols els 3 primers registres. */
SELECT * FROM alquila;
SELECT alquila.*
FROM alquila
WHERE alquila.f_final < '2022/01/01'
LIMIT 3;

/*9. Mostra el preu mínim de les pel·lícules introduïdes.*/
SELECT min(pelicula.preu) AS minimo
FROM pelicula;

/*10. Mostra el preu màxim de les pel·lícules introduïdes.*/
SELECT max(pelicula.preu) AS maximo
FROM pelicula;

/*11. Mostra la mitjana de preus de les pel·lícules introduïdes.*/
SELECT avg(pelicula.preu) AS media
FROM pelicula;

/*12. Mostra el nombre de pel·lícules que tenim.*/
SELECT count(pelicula.id) AS cantidad
FROM pelicula;

/*13. Mostra la suma dels preus de les pel·lícules.*/
SELECT sum(pelicula.preu) AS suma
FROM pelicula;

/*14. Mostra els lloguers fets els anys 2022 i 2021.*/
SELECT alquila.*
FROM alquila
WHERE alquila.f_inicio >= '2021-01-01' AND alquila.f_inicio <= '2022-12-31';

/*15. Mostra el tamany del títol de les pel·lícules i ordena per aquest tamany, de major a menor.*/
SELECT * FROM pelicula;
SELECT length(pelicula.titulo) AS longitud
FROM pelicula
ORDER BY longitud DESC;

/*16. Mostra el tamany màxim del títol de les pel·lícules.*/
SELECT max(length(pelicula.titulo)) AS lomax
FROM pelicula;

/*17. Mostra les pelicules que el seu títol està compost per menys de 20 caràcters.*/
SELECT pelicula.*
FROM pelicula
WHERE length(pelicula.titulo) < 20;

/*18. Mostra en una sola columna l’id de la película i el nom. Separats per un guió.*/
SELECT concat(pelicula.id, ' - ', pelicula.titulo) AS info
FROM pelicula;

/*19. Substitueix tots els correus de socis que tens que son gmail.es per gmail.com.*/
SELECT * FROM socio;
SET sql_safe_updates = 0;
UPDATE socio SET email=REPLACE(email, '.es', '.com') WHERE email LIKE '%gmail.es';

/*20. Mostra quants registres tens a socis que el camp adreça comença per c/.*/
SELECT * FROM socio;
UPDATE socio SET email='migue@gmail.es' WHERE id = 3;
SELECT count(socio.id) 
FROM socio
WHERE socio.direccion LIKE 'c/%';

/*21. Afegeix un camp contrasenya a la taula de socis. Emplena aquest camp amb el nom 
del soci al reves un guió i els nombre 12345678.*/
ALTER TABLE socio
DROP COLUMN contraseña;

ALTER TABLE socio
ADD COLUMN contraseña varchar(30);

UPDATE socio SET contraseña=CONCAT(REVERSE(socio.nombre), " - ", 12345678);

/*22. Mostra l’id, el nom de la película i els 30 primers caràcters de la seva 
descripció. Ordena per id.*/
SELECT * FROM pelicula;
SELECT pelicula.id, pelicula.titulo, SUBSTRING(pelicula.descripcion, 1, 30)
FROM pelicula;

/*23. Afegeix a totes les adreces de socis el “c/” a davant de tot.*/
UPDATE socio SET direccion=CONCAT("c/", direccion);

/*24. Modifica els registres per tal d’eliminar a tots els c/.*/
UPDATE socio SET direccion= REPLACE(direccion, "c/", "");

/*25. Modifica el camp preu de película perque sigui un nombre decimal.*/
ALTER TABLE pelicula
MODIFY preu float;

/*26. Modifica els registres de preu de pelicula perque el preu sigui un 
decimal (procura que hi hagi nombres > .5 i <.5).*/
SELECT * FROM pelicula;
UPDATE pelicula SET preu=12.8 WHERE id=2;
UPDATE pelicula SET preu=27.3 WHERE id=1;

/*27.Arrodoneix els preus fent que cada preu sigui el seu sencer major més proper.*/
UPDATE pelicula SET preu=ROUND(pelicula.preu, 0);

/*28. Modifica els registres de preu de pelicula perque el preu tengui 3 
decimals (procura que hi hagi de tot).*/
UPDATE pelicula SET preu=13.345 WHERE id=1;
UPDATE pelicula SET preu=27.789 WHERE id=2;

/*29. Modifica els registres de preu de pelicula perque el preu quedi 
arrodonit a 2 decimals.*/
UPDATE pelicula SET preu=ROUND(pelicula.preu, 2);

/*30. Modifica els registres de preu de pelicula perque el preu sigui un 
decimal (procura que hi hagi nombres > .5 i <.5).*/
UPDATE pelicula SET preu=ROUND(pelicula.preu, 1);

/*31. Modifica els registres de preu de pelicula perque el preu sigui el 
seu sencer menor més proper.*/
UPDATE pelicula SET preu=ROUND(pelicula.preu, 0);

/*32. Has decidit que ampliaràs la data de devolució de les películes i a 
totes aquelles que no s’han tornat els ampliaràs el termini a 10 dies més.*/
SELECT * FROM alquila;
UPDATE alquila SET f_final=DATE_ADD(f_final, INTERVAL 10 DAY);

/*33. Modifica la taula de lloguers de pelicules per a que el camp data_lloguer 
prengui sempre per defecte la data del dia que s’efectua el lloguer.*/
ALTER TABLE alquila
MODIFY f_inicio date DEFAULT(CURRENT_DATE());

ALTER TABLE alquila
MODIFY f_final date DEFAULT(CURRENT_DATE());

/*34. Modifica la taula de lloguers de pelicules per a que el camp data_lloguer 
no sols contingui la data sinó que també contingui l’hora, minuts, …*/
SHOW CREATE TABLE alquila;
ALTER TABLE alquila
MODIFY f_inicio datetime DEFAULT(CURRENT_DATE);
ALTER TABLE alquila
MODIFY f_final datetime DEFAULT(CURRENT_DATE);

SELECT * FROM alquila;

/*35. Fes una consulta que torni el nombre de dies de cada un dels lloguers.*/
SELECT datediff(f_final,f_inicio) FROM alquila;

/*36. Fes una consulta que torni els lloguers que  la data en que s’han tornat 
respecte a la data en que teòricament s’havien de tornar supera els 10 dies.*/

/*37. Treu les reserves que s’han fet en dilluns al llarg d’aquest any.*/
SELECT * FROM alquila
WHERE year(f_final)=year(current_date()) AND weekday(f_inicio) = 0;

/*38. Mostra el nom complet dels socis en el format llinatge1 “espai” llinatge2 
“coma”, nom.*/
SELECT CONCAT(socio.ape1, " ", socio.ape2, ", ", socio.nombre) as Nombre_Completo
FROM socio;

/*39. Mostra el nom del correu sense el domini de les adreces de correu dels socis.*/
SELECT substring(email,1,locate("@",email)-1) FROM socio;
SELECT * FROM socio;

/*40. Mostra els dominis dels correus que tens introduïts. Eliminar repetits.*/
SELECT DISTINCT substring(email, locate("@", email)+1, length(email)) FROM socio; 

/*41. Mostra si tenc algun correu que no sigui de gmail.com.*/
SELECT * FROM socio WHERE email NOT LIKE "%gmail.com";

/*42. Mostra l’hora de les reserves fetes avui.*/
SELECT hour(f_inicio) FROM alquila WHERE f_inicio=current_date();