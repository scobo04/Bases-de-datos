USE classicmodels;

/*1. Crea un usuari local (usuari1).*/
CREATE user IF NOT EXISTS usuari1@localhost identified by '12345678';
SELECT user from mysql.user;

/*2. Fes que aquest usuari local (usuari1) pugui accedir a la base de dades 
classicmodels (all privileges).*/
GRANT all privileges on classicmodels.* to usuari1@localhost;

/*3. Fes un usuari (usuari2) que pugui sols consultar les dades de la base 
de dades classicmodels.*/
CREATE user IF NOT EXISTS usuari2@localhost identified by '12345678';
SELECT user from mysql.user;

GRANT SELECT
ON classicmodels.*
TO usuari2@localhost;

/*4. Ara fes que aquest usuari (usuari2) puguis apart de consultar inserir, 
modificar i eliminar dades.*/
GRANT all privileges on classicmodels.* to usuari2@localhost;

/*5. Elimina els permisos de: inserir, modificar, eliminar dades de 
l’usuari (usuari2).*/
REVOKE INSERT, UPDATE, DELETE
ON classicmodels.*
FROM usuari2@localhost;

/*6. Crea un rol: aquest rol ha de permetre consultar, inserir, modificar i 
eliminar dades de la base de dades classicmodels. */
SHOW GRANTS FOR usuari2@localhost;

create role writer;
SHOW GRANTS FOR writer;
GRANT SELECT, INSERT, UPDATE, DELETE ON classicmodels.* TO writer@localhost;

/*7. Assigna aquest rol anterior a 2 usuaris nous que has de crear (usuari3 
i usuari 4).*/
CREATE USER IF NOT EXISTS usuari3, usuari4;

/* OTRA FORMA
GRANT PROXY
ON root@localhost
TO usuari3@localhost;
GRANT PROXY
ON root@localhost
TO usuari3@localhost;
*/

GRANT writer TO usuari3, usuari4;
SHOW GRANTS FOR usuari3;
SHOW GRANTS FOR usuari4;

/*8. Elimina del rol anterior el permís de poder eliminar dades.*/
REVOKE DELETE ON classicmodels.* FROM writer@localhost;

/*9. Comprova que l’usuari3 i l’usuari4 no poden eliminar dades ara.*/


/*10. Borra els usuari3 i usuari4.*/
DROP USER IF EXISTS usuari3, usuari4;

/*11. Borra el rol.*/
DROP ROLE writer;

/*12. Fes un usuari root_meu que tingui els mateixos permisos que el root.*/
CREATE USER IF NOT EXISTS root_meu;

GRANT PROXY ON mroot TO root_meu;

/*13. Fes una compte usuari21 a partir de l’usuari2 . Fes que sigui una còpia 
de l’usuari2 (en el sentit que heredi tots els seus privilegis).*/
CREATE USER IF NOT EXISTS usuari21@localhost;

GRANT PROXY ON usuari2@localhost TO usuari21@localhost;

/*14. Canvia la contrasenya a l’usuari2.*/
ALTER USER usuari2@localhost IDENTIFIED BY '12345678';

/*15. Executa alguna sentència per saber l’usuari amb el que estàs connectat.*/
SELECT current_user();

/*16. Canvia el nom a l’usuari2.*/
RENAME USER usuari2@localhost TO user2@localhost;

SELECT user from mysql.user;

/*17. Bloqueja l’usuari2.*/
ALTER USER user2@localhost ACCOUNT LOCK;

/*SELECT user, host, account_locked
FROM mysql.user
WHERE user = 'user2' AND host = 'localhost';*/

/*18. Desbloqueja l’usuari2.*/
ALTER USER user2@localhost ACCOUNT UNLOCK;


/*EJERCICIO CLASE*/
CREATE USER IF NOT EXISTS "dani@172.16.50.234" IDENTIFIED BY '12345678';
GRANT all privileges on classicmodels.* to "dani@172.16.50.234";

CREATE USER IF NOT EXISTS "mario@10.100.80.3" IDENTIFIED BY '12345678';
GRANT all privileges on classicmodels.* to "mario@10.100.80.3";

SELECT user from mysql.user;


