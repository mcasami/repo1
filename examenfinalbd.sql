
/*1.1. Crear tipus t_venedor*/

CREATE TYPE t_venedor AS OBJECT(

  id INTEGER,
  nom VARCHAR2(25),
  cognom VARCHAR2(30)
);

/*1.2. Crear taula objectes venedor*/

CREATE TABLE venedor OF t_venedor ( id PRIMARY KEY );

/*1.3. Tipus objecte foto*/

CREATE TYPE t_foto AS OBJECT(
  descripcio VARCHAR2(50),
  url VARCHAR2(50)
);

/*1.4 tipus col·lecció de t_foto 5 elements maxim*/

create type t_fotos as varray(5) of t_foto;

/*1.5 Tipus taula de números*/

CREATE TYPE t_preus AS TABLE OF NUMBER(8,2);

/*1.6 Tipus objecte local. En aquest punt reviseu el que es demana sobre implementar la funcio preuMetreQuadrat*/
/*3. Implementar funcio preuMetreQuadrat */

CREATE OR REPLACE TYPE t_local as object
(
  id INTEGER,
  adreça VARCHAR2(100),
  venedor REF t_venedor,
  m2 INTEGER,
  preus t_preus,
  alta DATE,
  fotos t_fotos,
  
   MEMBER FUNCTION preuMetreQuadrat RETURN NUMBER
)NOT FINAL;

/*1.7 Tipus objecte parquing*/

CREATE OR REPLACE TYPE t_parquing under t_local(
  planta INTEGER);

/*1.8 Tipus objecte habitatge*/

CREATE OR REPLACE TYPE t_habitatge under t_local(
  nombrehabitacions INTEGER,
  nombrebanys INTEGER);

/*1.9 Taula objectes parquing */

//CREATE TABLE parquing OF t_parquing ;

CREATE TABLE parquing(
preus t_preus,
fotos t_fotos)
nested table preus store as nestedpreus9097;

/*1.10 Taula objectes habitatge */ 

//CREATE TABLE habitatge OF t_habitatge ;

CREATE TABLE habitatge(
preus t_preus,
fotos t_fotos)
nested table preus store as preusnested2;



/*2.1. Afegir 2 venedors*/

INSERT INTO venedor
VALUES(1,'Marc','CM');

INSERT INTO venedor
VALUES(2,'Joan','MB');

/*2.2 Afegir 1 parquing amb 2 fotos i 3 preus*/

INSERT INTO parquing

select * from parquing;

/*2.3 Afegir 1 habitatge amb 3 fotos i 2 preus*/


/*Opcional per vosaltres: provar la funcio preuMetreQuadrat*/

CREATE OR REPLACE TYPE BODY t_local AS

  MEMBER FUNCTION preuMetreQuadrat RETURN NUMBER IS
    BEGIN
      RETURN m2 * t_preus[];
    END;
END;
/*Exemple: suposant que hagiu seguit l'esquema de noms i que existeixi un habitatge amb id = 2*/
select h.preuMetreQuadrat() from habitatge h where h.id = 2;