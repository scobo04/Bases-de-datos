use sakila;

select * from language;
select * from film;

show create table film;
show create table language;


/*EJERCICIO 1 CLASE
Crea un procediment que torni quantes pel·lícules hi ha amb un idioma original 
passat per paràmetres.*/
DELIMITER $$

create procedure OcurrenciasIdiomaPasado (
	in idioma varchar(30)
)
BEGIN
	select count(film.language_id) as total, idioma
    from film, language
    where film.language_id = language.language_id
    and language.name = idioma;
END $$

DELIMITER ;

select count(film_id) from film;

drop procedure OcurrenciasIdiomaPasado;
CALL OcurrenciasIdiomaPasado("English");


/*EJERCICIO 2 CLASE
Crea un procediment que rebi per paràmetre el nom d’una pel·lícula i i el codi de 
la tenda i ens torni YES si la pel·lícula està a la tenda , NO en cas contrari.*/
select * from inventory;

DELIMITER $$

CREATE PROCEDURE TiendaCoincidePelicula (
  IN pelicula VARCHAR(50),
  IN codigoTienda INT(5)
)
BEGIN
  SELECT distinct inventory.film_id, film.title, 'Yes' AS answer, count(film.film_id) as cantidad
  FROM inventory
  JOIN film ON inventory.film_id = film.film_id
  WHERE film.title = pelicula AND inventory.store_id = codigoTienda
  GROUP BY film.film_id;
END $$

DELIMITER ;

select * from film;
drop procedure TiendaCoincidePelicula;
CALL TiendaCoincidePelicula("ACADEMY DINOSAUR", 1);


/*EJERCICIO 3 CLASE
Crear un procediment que li passam una data en aquest format (dia/mes/any) i ens 
torna la data girada (any/mes/dia).*/
select * from inventory;

DELIMITER $$

CREATE PROCEDURE ModificarFormatoFecha (
	in fecha VARCHAR(14),
	out resultado date
)
BEGIN
    declare anio VARCHAR(4);
    declare mes VARCHAR(2);
    declare dia VARCHAR(2);
    
	select substring_index(fecha, "-", -1) into anio;
	select substring_index(substring_index(fecha, "-", 2), "-", -1) into mes;
	select substring_index(fecha, "-", 1) into dia;
        
	set resultado = concat(anio, "-", mes, "-", dia);
	select resultado;
END $$

DELIMITER ;

select * from film;
drop procedure ModificarFormatoFecha;
CALL ModificarFormatoFecha("20-09-2022", @fechaCambiada);


/*EJERCICIO 4 CLASE
Imagina que tens una taula que conté el nom d’una persona i la data de naixement 
(varchar en format d/m/any). Fer un procediment que modifiqui tots els registres 
d’aquesta taula convertint la data de naixement de cada registre a a/m/d. Una 
vegada executat el procediment canviar el camp de la taula a date. Aquest 
procediment s’hagués pogut emprar amb la importació de dades a la base de dades 
normalitzada de futbol (exercici import/export i normalitzar).*/ 
select * from inventory;

create table persona(
	nombre varchar(11),
	fecha_nacimiento varchar(11)
);

insert into persona (nombre,fecha_nacimiento) values ("A","17-05-2004");
insert into persona (nombre,fecha_nacimiento) values ("B","17-05-2004");
insert into persona (nombre,fecha_nacimiento) values ("C","17-05-2004");
insert into persona (nombre,fecha_nacimiento) values ("D","17-05-2004");
drop table persona;
select * from persona;

DELIMITER $$

CREATE PROCEDURE ModificarFormatoFechaPersona ()
BEGIN
    declare finite int(1) default 0;
    declare contar int(11) default 0; 
    declare fechaParaCambiar varchar(11);
    declare idPersona varchar(11);
    
	declare curFecha cursor for (select fecha_nacimiento from persona);
    declare curNom cursor for (select nombre from persona);
    
	declare continue handler for not found set finite = 1;
	
    open curFecha;
	open curNom;
	cambioFecha : loop 
		fetch curFecha into fechaParaCambiar;
		fetch curNom into idPersona;
		if finite = 1 then
			leave cambioFecha;
		end if;    
                
		call ModificarFormatoFecha(fechaParaCambiar,@cambiada);
		update persona
		set fecha_nacimiento = @cambiada
		where nombre = idPersona;
                
	end loop;
                
	close curNom;
	close curFecha;
    
	alter table persona modify fecha_nacimiento date;
	
END $$

DELIMITER ;

select * from film;
drop procedure ModificarFormatoFechaPersona;
CALL ModificarFormatoFechaPersona;


/*EJERCICIO 5 CLASE
Crear un procediment que ens torna una cadena de texte amb els actors d’una 
pel·lícula que li hem passat com a paràmetre.*/
select * from actor;
select * from film_actor;

DELIMITER $$

CREATE PROCEDURE ActoresDeUnaPelicula (
  IN pelicula VARCHAR(30)
)
BEGIN
  select actor.actor_id, actor.first_name, actor.last_name, pelicula
  from actor, film_actor, film
  where film.film_id = film_actor.film_id
  and film_actor.actor_id = actor.actor_id
  and film.title = pelicula;
END $$

DELIMITER ;

select * from film;
select count(film_id) from film_actor where film_id = 2;

drop procedure ActoresDeUnaPelicula;
CALL ActoresDeUnaPelicula("ACE GOLDFINGER");


/*EJERCICIO 6 CLASE
Fer un procediment que ens borri una categoria passada com a paràmetre. Si s’ha 
borrat la categoria ens ha de tornar com a paràmetre categoria borrada. Sinó ens 
ha de tornar categoria no trobada. Sinó vols borrar dades de la Sakila (les dades 
inicialment carregades) afegeix una categoria assigna-la a una pel·lícula i borra 
aquesta categoria.*/
/*NO FUNCIONAAAAAAAA*/
select * from category;

DELIMITER $$

CREATE PROCEDURE BorrarCategoria (
	categoria VARCHAR(30),
    resultado VARCHAR(30) OUTPUT
)
AS
BEGIN
	if exists (select * from sakila.category where name = categoria)
    BEGIN
		delete from sakila.category where name = categoria
        set resultado = 'Categoría borrada'
	END
    ELSE
    BEGIN
		set resultado = 'Categoría no encontrada'
	END
END

DELIMITER ;

drop procedure BorrarCategoria;
CALL BorrarCategoria("Action");


/*EJERCICIO 7 CLASE
Fes un procediment que torni la mitjana de pagaments dels clients. 
Empra un cursor per a tornar el que ha pagat cada client. A 
continuació recorr el cursor per treure la mitjana.*/
select * from payment;

DELIMITER $$

CREATE PROCEDURE MediaPagosClientes (
	OUT mediaTotal float
)
BEGIN
	declare media int default 0;
	DECLARE finished INTEGER DEFAULT 0;
    DECLARE mediaDinero int (20);
	declare contador int default 1;
    
	DECLARE curDinero 
		CURSOR FOR 
			SELECT sum(amount) from payment
            group by customer_id;
	DECLARE CONTINUE HANDLER
    FOR NOT FOUND SET finished = 1;
    
	OPEN curDinero;
    
    getMedia: LOOP
		fetch curDinero INTO mediaDinero;
		if finished = 1 THEN
			LEAVE getMedia;
		END IF;
        
        set media = media + mediaDinero;
        set contador = contador + 1;
	END LOOP getMedia;
    CLOSE curDinero;
    
    set mediaTotal = media / contador;
    
END $$
DELIMITER ;

drop procedure MediaPagosClientes;
call MediaPagosClientes(@media);
select @media;


/*EJERCICIO 8 CLASE
Fes un procediment que assigni les pel·lícules a cada una de les 
categories existents.  O sigui, si la categoria 1 està assignada a 
la pel·lícula 1 però apart hi ha les categories 2,3,4 , s’han 
d’assignar les categories 2,3,4 a la pel·lícula 1.*/
select * from film;

DELIMITER $$
CREATE PROCEDURE AsignarPeliculasACategoria ()
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
    DECLARE categoriaID int (20);
    DECLARE peliculaID int (20);
    
    DECLARE curPelicula
		CURSOR FOR
			SELECT f1.film_id, c1.category_id from film as f1, category as c1
            where not exists
				(select f2.film_id, f2.category_id from film_category as f2 
                where f2.film_id = f1.film_id and f2.category_id = c1.category_id );
		DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;
        
        OPEN curPelicula;
        
		setPelicula: LOOP
			FETCH curPelicula INTO peliculaID, categoriaID;
            if finished > 0
            then
				leave setPelicula;
			end if;
				insert into film_category (film_id,category_id) values 
                ( peliculaID, categoriaID );
		END LOOP;
        
		CLOSE curPelicula;
        
END $$
DELIMITER ;

/*EJERCICIO 9 CLASE
Fes un procediment que dongui d’alta una pel·lícula a cada tenda 
(store) en cas que no hi estàs donada d’alta.*/
select * from film;
select distinct film_id, store_id, inventory.last_update from inventory order by film_id, store_id;

DELIMITER $$
CREATE PROCEDURE AsignarPeliculasACategoria ()
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
    DECLARE id_film int(10);
    DECLARE id_store int(10);
    
    DECLARE curPeliStore
		CURSOR FOR
			SELECT film.film_id, store.store_id from film, store
            where not exists
				(select inventory_id from inventory
                where film.film_id = inventory.film_id and inventory.store_id = store.store_id );
	DECLARE CONTINUE HANDLER
    FOR NOT FOUND SET finished = 1;
    
    OPEN curPeliStore;
    
    setPeliStore: LOOP
		FETCH curPeliStore INTO id_film, id_store;
        if finished = 1 THEN 
			LEAVE setPeliStore;
		end if;
			insert into inventory (film_id, store_id, last_update) values (id_film, id_store, now());
	END LOOP;
    CLOSE curPeliStore;
        
END $$
DELIMITER ;

drop procedure AsignarPeliculasACategoria;
call AsignarPeliculasACategoria();


/*EJERCICIO 10 CLASE
Fes una funció que rebi per paràmetre un any i torni 1 si el total de pel·lícules 
d’aquell any està entre 1 i 100, 2 si està entre 101 i 200, 3 si ès major a 200. Fes una 
funció rebi per paràmetre una pel·lícula i torni 0 si la pel·lícula no està a cap tenda o 
torni 1 si la pel·lícula està a alguna tenda.*/

DELIMITER $$
CREATE FUNCTION MediaEnAnyos(
	anyo int(4)
)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE mediaEnAnyos INT DEFAULT 0;
    DECLARE total int;
    
    SELECT count(film.release_year) into total
    from film
    where film.release_year = anyo;
    
    IF total >= 1 && total <= 100
    THEN
		SET mediaEnAnyos = 1;
	ELSEIF total > 100 && total <= 200
	THEN
		SET mediaEnAnyos = 2;
	ELSE 
		SET mediaEnAnyos = 3;
	END IF;

	RETURN (mediaEnAnyos);

END$$
DELIMITER ;

SELECT MediaEnAnyos(2005);
DROP FUNCTION MediaEnAnyos;

/*EJERCICIO 11 CLASE
Fes una funció rebi per paràmetre una pel·lícula i torni 0 si la pel·lícula no està a cap 
tenda o torni 1 si la pel·lícula està a alguna tenda.*/

DELIMITER $$
CREATE FUNCTION PeliculaEnStock (
	pelicula varchar(30)
)
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
	declare contador int default 0;
    
    if exists (select * from film where title = pelicula)
	then
		set contador = 1;
	else
		set contador = 0;
	end if;
    
    return (contador);
    
END $$
DELIMITER ;

SELECT PeliculaEnStock("ACADEMY DINOSAUR");
DROP FUNCTION PeliculaEnStock;
SELECT * FROM film;

/*EJERCICIO 12 CLASE
Fes una funció que inserti dins la taula pel·lícula les pel·lícules de la 1000 a la 2000 en 
cas que no hi siguin. Has de decidir quin valor rebran els camps obligatoris dels registres 
que inseriràs. Aquesta funció ha de retornar el nombre de registres inserits (recorda que 
si el registre ja hi és no l’ha d’inserir).*/

DELIMITER $$
CREATE FUNCTION InsertarPeliculas()

returns int

BEGIN
	declare inicio int default 1000;
    declare final int default 2000;
    declare total int default 0;
    
    while inicio <= final
    do
		if not exists (select film.film_id from film where film_id = inicio)
        then
			insert into film(film_id, title, language_id) values (inicio, film, 2);
            set inicio = inicio + 1;
            set total = total + 1;
		else
			set inicio = inicio + 1;
		end if;
	end while;
    
    return total

END //
DELIMITER ;

select InsertarPeliculas();
DROP FUNCTION InsertarPeliculas();