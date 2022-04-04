--drop table alumno_asignatura;
--drop table asignatura;
--drop table alumno;
--drop table profesor;
--drop table persona;
--drop table titulacion;

--alter session set "_oracle_script"=true;  
--CREATE USER EjUni IDENTIFIED BY EjUni;
--GRANT CONNECT, RESOURCE, DBA TO EjUni;


Create table titulacion (
Idtitulacion varchar2(6) primary key,
Nombre varchar2(30)
);


Create table persona (
dni varchar2(11) primary key,
Nombre varchar2(30),
Apellido varchar2(30),
Ciudad varchar2(15),
Direccioncalle varchar2(30),
Direccionnum number,
Telefono varchar2(9),
Fecha_nacimiento date,
Varon number
);

create table alumno (
idalumno varchar2(7) primary key,
dni varchar2(11),
foreign key (dni) references persona(dni)
);

Create table profesor (
Idprofesor varchar2(4) primary key,
Dni varchar2(11),
Foreign key(dni) references persona(dni)
);

Create table asignatura (
Idasignatura varchar2(6) primary key,
Nombre varchar2(20),
Creditos number,
Cuatrimestre number,
Costebasico number,
Idprofesor varchar2(4),
Idtitulacion varchar2(6),
Curso number,
Foreign key(idprofesor) references profesor(idprofesor),
Foreign key (idtitulacion) references titulacion(idtitulacion)
);

Create table  alumno_asignatura (
Idalumno varchar2(7),
Idasignatura varchar2(6),
Numeromatricula number,
  PRIMARY KEY(idalumno,idasignatura,numeromatricula),
Foreign key(idalumno) references alumno(idalumno),
Foreign key(idasignatura) references asignatura(idasignatura)
);


insert into persona values ('16161616A','Luis','Ramirez','Haro','Pez','34','941111111',to_date('1/1/1969','dd/mm/yyyy'),'1');
insert into persona values ('17171717A','Laura','Beltran','Madrid','Gran Va','23','912121212',to_date('8/8/1974','dd/mm/yyyy'),'0');
insert into persona values ('18181818A','Pepe','Perez','Madrid','Percebe','13','913131313',to_date('2/2/1980','dd/mm/yyyy'),'1');
insert into persona values ('19191919A','Juan','Sanchez','Bilbao','Melancola','7','944141414',to_date('3/2/1966','dd/mm/yyyy'),'1');
insert into persona values ('20202020A','Luis','Jimenez','Najera','Cigea','15','941151515',to_date('3/3/1979','dd/mm/yyyy'),'1');
insert into persona values ('21212121A','Rosa','Garcia','Haro','Alegra','16','941161616',to_date('4/4/1978','dd/mm/yyyy'),'0');
insert into persona values ('23232323A','Jorge','Saenz','Sevilla','Luis Ulloa','17','941171717',to_date('9/9/1978','dd/mm/yyyy'),'1');
insert into persona values ('24242424A','Mara','Gutierrez','Sevilla','Avda. de la Paz','18','941181818',to_date('10/10/1964','dd/mm/yyyy'),'0');
insert into persona values ('25252525A','Rosario','Diaz','Sevilla','Percebe','19','941191919',to_date('11/11/1971','dd/mm/yyyy'),'0');
insert into persona values ('26262626A','Elena','Gonzalez','Sevilla','Percebe','20','941202020',to_date('5/5/1975','dd/mm/yyyy'),'0');


insert into alumno values ('A010101','21212121A');
insert into alumno values ('A020202','18181818A');
insert into alumno values ('A030303','20202020A');
insert into alumno values ('A040404','26262626A');
insert into alumno values ('A121212','16161616A');
insert into alumno values ('A131313','17171717A');


insert into profesor values ('P101','19191919A');
insert into profesor values ('P117','25252525A');
insert into profesor values ('P203','23232323A');
insert into profesor values ('P204','26262626A');
insert into profesor values ('P304','24242424A');


insert into titulacion values ('130110','Matematicas');
insert into titulacion values ('150210','Quimicas');
insert into titulacion values ('160000','Empresariales');


insert into asignatura values ('000115','Seguridad Vial','4','1','30 ','P204',null,null);
insert into asignatura values ('130113','Programacion I', '9','1','60 ','P101','130110','1');
insert into asignatura values ('130122','Analisis II',    '9','2','60 ','P203','130110','2');
insert into asignatura values ('150212','Quimica Fisica','4','2','70','P304','150210','1');
insert into asignatura values ('160002','Contabilidad','6','1','70','P117','160000','1');


insert into alumno_asignatura values('A010101','150212','1');
insert into alumno_asignatura values('A020202','130113','1');
insert into alumno_asignatura values('A020202','150212','2');
insert into alumno_asignatura values('A030303','130113','3');
insert into alumno_asignatura values('A030303','150212','1');
insert into alumno_asignatura values('A030303','130122','2');
insert into alumno_asignatura values('A040404','130122','1');
insert into alumno_asignatura values('A121212','000115','1');
insert into alumno_asignatura values('A131313','160002','4');


--1.Mostrar los nombres y los créditos de cada una de las asignaturas.
SELECT ALL Nombre,Creditos FROM asignatura;

--2. Obtener los posibles distintos créditos de las asignaturas que hay en la base de datos.
SELECT DISTINCT Creditos FROM asignatura;

--3. Mostrar todos los datos de todas de las personas
SELECT * FROM persona;

--4. Mostrar el nombre y créditos de las asignaturas del primer cuatrimestre.
SELECT Nombre,Creditos FROM asignatura WHERE CUATRIMESTRE LIKE 1;

--5. Mostrar el nombre y el apellido de las personas nacidas antes del 1 de enero de 1975.
SELECT Nombre,Apellido FROM persona WHERE (TO_CHAR (fecha_nacimiento,'yyyy')<'1975');

--6. Mostrar el nombre y el coste básico de las asignaturas de más de 4,5 créditos.
SELECT Nombre,Costebasico FROM asignatura WHERE Creditos >4.5;

--7. Mostrar el nombre de las asignaturas cuyo coste básico está entre 25 y 35 euros.
SELECT Nombre FROM asignatura WHERE Costebasico BETWEEN 25 AND 35;

--8. Mostrar el identificador de los alumnos matriculados en la asignatura '150212' o en la '130113' o en ambas.
SELECT idalumno FROM alumno_asignatura WHERE Idasignatura IN ('150212','130113');

--9. Obtener el nombre de las asignaturas del 2º cuatrimestre que no sean de 6 créditos.
SELECT Nombre FROM asignatura WHERE Cuatrimestre= 2 AND Creditos != 6;

--10. Mostrar el nombre y el apellido de las personas cuyo apellido comience por 'G'.
SELECT Nombre, Apellido FROM Persona WHERE Apellido LIKE 'G%';

--11. Obtener el nombre de las asignaturas que no tienen dato para el IdTitulacion. 
SELECT Nombre FROM asignatura WHERE IdTitulacion IS NULL;

--12. Obtener el nombre de las asignaturas que tienen dato para el IdTitulacion.
SELECT Nombre FROM asignatura WHERE IdTitulacion IS NOT NULL;

--13. Mostrar el nombre de las asignaturas cuyo coste por cada crédito sea mayor de 8 euros. 
SELECT Nombre FROM asignatura WHERE (COSTEBASICO / CREDITOS) > 8;

--14. Mostrar el nombre y el número de horas de las asignaturas de la base de datos. (1cred.=10 horas).
SELECT NOMBRE, CREDITOS *10 AS NUM_HORAS FROM asignatura; --ASS ALIAS
SELECT NOMBRE,NVL(CREDITOS,0) *10 AS NUM_HORAS FROM asignatura; --NVL PARA PONER 0 EN EL VALOR NULL

--15. Mostrar todos los datos de las asignaturas del 2º cuatrimestre ordenados por el identificador de asignatura.
SELECT * FROM ASIGNATURA WHERE CUATRIMESTRE = 2 ORDER BY IDASIGNATURA,CREDITOS;

--16. Mostrar el nombre de todas las mujeres que viven en Madrid.
SELECT * FROM PERSONA WHERE CIUDAD LIKE 'Madrid' AND VARON= 0;

--17. Mostrar el nombre y los teléfonos de aquellas personas cuyo teléfono empieza por 91
SELECT Nombre, Telefono FROM PERSONA WHERE Telefono LIKE '91%';

--18. Mostrar el nombre de las asignaturas que contengan la sílaba pro
SELECT Nombre FROM ASIGNATURA WHERE Lower(Nombre) LIKE '%pro%';

--19. Mostrar el nombre de la asignatura de primero y que lo imparta el profesor que tiene código P101
SELECT Nombre FROM ASIGNATURA WHERE CURSO = 1  AND IDPROFESOR LIKE 'P101';

--20. Mostrar el código de alumno que se ha matriculado tres o más veces de una asignatura, mostrando también el código de la asignatura correspondiente.
SELECT  IDALUMNO, IDASIGNATURA FROM ALUMNO_ASIGNATURA WHERE NUMEROMATRICULA >2;I

--21. El coste de cada asignatura va subiendo a medida que se repite la asignatura. Para saber cuál sería el precio de las distintas asignaturas en las repeticiones (y así animar a nuestros alumnos a que estudien) se quiere mostrar un listado en donde esté el nombre de la asignatura, el precio básico, el precio de la primera repetición (un 10 por ciento más que el coste básico),  el precio de la segunda repetición (un 30 por ciento más que el coste básico) y el precio de la tercer repetición (un 60 por ciento más que el coste básico).
SELECT NOMBRE, NVL(COSTEBASICO,0),NVL(COSTEBASICO + COSTEBASICO*0.10,0) AS PRECIO_PRIMERAREPETICION,NVL(COSTEBASICO + COSTEBASICO*0.30,0) AS PRECIO_SEGUNDAREPETICION,NVL(COSTEBASICO + COSTEBASICO*0.60,0) AS PRECIO_TERCERAREPETICION FROM ASIGNATURA;

--22. Mostrar todos los datos de las personas que tenemos en la base de datos que han nacido antes de la década de los 70.
SELECT * FROM PERSONA WHERE (TO_CHAR (FECHA_NACIMIENTO,'yyyy')<'1970');
SELECT * FROM PERSONA WHERE EXTRACT (YEAR FROM FECHA_NACIMIENTO)<'1970'; --Otra forma

--23. Mostrar el identificador de las personas que trabajan como profesor, sin que salgan valores repetidos.
SELECT DISTINCT DNI FROM PROFESOR WHERE DNI IS NOT NULL;

--24. Mostrar el identificador de los alumnos que se encuentran matriculados en la asignatura con código 130122.
SELECT IDALUMNO FROM ALUMNO_ASIGNATURA WHERE IDASIGNATURA LIKE '130122';

--25. Mostrar los códigos de las asignaturas en las que se encuentra matriculado algún alumno, sin que salgan códigos repetidos.
SELECT DISTINCT IDASIGNATURA FROM ALUMNO_ASIGNATURA WHERE IDALUMNO IS NOT NULL ;

--26. Mostrar el nombre de las asignaturas que tienen más de 4 créditos, y además, o se imparten en el primer cuatrimestre o son del primer curso.
SELECT Nombre FROM ASIGNATURA WHERE CREDITOS >4 AND (CUATRIMESTRE= 1 OR CURSO=1);

--27. Mostrar los distintos códigos de las titulaciones en las que hay alguna asignatura en nuestra base de datos.
SELECT DISTINCT IDTITULACION FROM ASIGNATURA;

--28. Mostrar el dni de las personas cuyo apellido contiene la letra g en mayúsculas o minúsculas.
SELECT DNI FROM PERSONA WHERE APELLIDO LIKE '%g%' OR APELLIDO LIKE '%G%';
SELECT DNI FROM PERSONA WHERE UPPER(APELLIDO) LIKE '%G%'; --Forma más optima

--29. Mostrar las personas varones que tenemos en la base de datos que han nacido con posterioridad a 1970 y que vivan en una ciudad que empieza por M.
SELECT * FROM PERSONA WHERE VARON = 1 AND (TO_CHAR (FECHA_NACIMIENTO,'yyyy')>'1970') AND CIUDAD LIKE 'M%';
SELECT * FROM PERSONA WHERE EXTRACT (YEAR FROM FECHA_NACIMIENTO)>'1970'AND CIUDAD LIKE 'M%' AND VARON=1; --Otra forma


--BOLETÍN 2

--1.Para cada titulacion ordenar por coste mostrando primero las asignaturas mas caras y para las asignaturas del mismo coste mostrar por orden alfabetico 
--de nombre de asignatura. 
SELECT T.IDTITULACION,A.NOMBRE,A.COSTEBASICO
FROM TITULACION T, ASIGNATURA A
WHERE A.IDTITULACION=T.IDTITULACION 
ORDER BY A.COSTEBASICO DESC, A.NOMBRE ASC;


--2. Mostrar el nombre y los apellidos de los profesores. 
SELECT NOMBRE,APELLIDO 
FROM PROFESOR P, PERSONA A 
WHERE P.DNI = A.DNI;

--3. Mostrar el nombre de las asignaturas impartidas por profesores de Sevilla. 
SELECT a.NOMBRE 
FROM ASIGNATURA A, PERSONA P, PROFESOR PR
WHERE A.IDPROFESOR = PR.IDPROFESOR 
AND PR.DNI= P.DNI 
AND UPPER(P.CIUDAD) LIKE 'SEVILLA';


--4. Mostrar el nombre y los apellidos de los alumnos.
SELECT NOMBRE,APELLIDO 
FROM ALUMNO a2, PERSONA p 
WHERE P.DNI = a2.DNI;

--5. Mostrar el DNI, nombre y apellidos de los alumnos que viven en Sevilla. 
SELECT a.DNI, P.NOMBRE,P.APELLIDO 
FROM ALUMNO a, PERSONA P
WHERE a.DNI = P.DNI 
AND UPPER(P.CIUDAD) LIKE 'SEVILLA';

--6. Mostrar el DNI, nombre y apellidos de los alumnos matriculados en la asignatura "Seguridad Vial". 
SELECT A.DNI, P.NOMBRE,P.APELLIDO 
FROM ALUMNO A, ALUMNO_ASIGNATURA A1, PERSONA P, ASIGNATURA A2
WHERE A.DNI = P.DNI 
AND A.IDALUMNO = A1.IDALUMNO 
AND A1.IDASIGNATURA = A2.IDASIGNATURA 
AND UPPER(A2.NOMBRE) LIKE 'SEGURIDAD VIAL';

--7. Mostrar el Id de las titulaciones en las que están matriculado el alumno con DNI 20202020A. Un alumno estÃÂ¡ matriculado en una titulaciÃÂ³n si estÃÂ¡ matriculado en una asignatura de la titulaciÃÂ³n.
SELECT DISTINCT T.IDTITULACION
FROM TITULACION T, ASIGNATURA A2, ALUMNO_ASIGNATURA A1, ALUMNO A
WHERE T.IDTITULACION = A2.IDTITULACION 
AND A1.IDASIGNATURA = A2.IDASIGNATURA 
AND A1.IDALUMNO = A.IDALUMNO 
AND A.DNI LIKE '20202020A';

-- 8. Obtener el nombre de las asignaturas en las que estÃ¡ matriculada Rosa Garcia.
SELECT A2.NOMBRE 
FROM  ASIGNATURA A2, ALUMNO_ASIGNATURA A1, ALUMNO A, PERSONA P
WHERE P.DNI = A.DNI 
AND A.IDALUMNO = A1.IDALUMNO 
AND A1.IDASIGNATURA = A2.IDASIGNATURA
AND UPPER(P.NOMBRE) LIKE 'ROSA'
AND UPPER(P.APELLIDO) LIKE 'GARCIA';

-- 9. Obtener el DNI de los alumnos a los que le imparte clase el profesor Jorge Saenz. 
SELECT A.DNI 
FROM PERSONA P, PROFESOR PR, ASIGNATURA A, ALUMNO_ASIGNATURA A1, ALUMNO A, PERSONA p1
WHERE P.DNI = PR.DNI 
AND PR.IDPROFESOR = A.IDPROFESOR 
AND A.IDASIGNATURA = A1.IDASIGNATURA 
AND A1.IDALUMNO  = A.IDALUMNO 
AND UPPER (P.NOMBRE) LIKE 'JORGE'
AND UPPER (P.APELLIDO) LIKE 'SAENZ';


-- 10. Obtener el DNI, nombre y apellido de los alumnos a los que imparte clase el profesor Jorge SÃ¡enz. 
SELECT ALU.DNI, P.NOMBRE, P.APELLIDO 
FROM PERSONA PE, PROFESOR PRO, ASIGNATURA AS1, ALUMNO_ASIGNATURA AL2, ALUMNO ALU, PERSONA P
WHERE PE.DNI = PRO.DNI 
AND PRO.IDPROFESOR = AS1.IDPROFESOR 
AND AS1.IDASIGNATURA = AL2.IDASIGNATURA 
AND AL2.IDALUMNO  = ALU.IDALUMNO 
AND ALU.DNI = P.DNI 
AND PE.NOMBRE LIKE 'Jorge'
AND PE.APELLIDO LIKE 'Saenz';


-- 11. Mostrar el nombre de las titulaciones que tengan al menos una asignatura de 4 crÃ©ditos. 
SELECT T.NOMBRE 
FROM ASIGNATURA A, TITULACION T
WHERE T.IDTITULACION = A.IDTITULACION 
AND A.CREDITOS = 4;

-- 12. Mostrar el nombre y los creditos de las asignaturas del primer cuatrimestre junto con el nombre de la titulacion a la que pertenecen. 
SELECT A.NOMBRE, A.CREDITOS, T.NOMBRE 
FROM TITULACION T, ASIGNATURA A
WHERE T.IDTITULACION = A.IDTITULACION 
AND A.CUATRIMESTRE = 1;

-- 13. Mostrar el nombre y el coste basico de las asignaturas de mas de 4,5 creditos junto con el nombre de las personas matriculadas
SELECT A.NOMBRE, A.COSTEBASICO, P.NOMBRE 
FROM ASIGNATURA A, ALUMNO_ASIGNATURA A1, ALUMNO AL, PERSONA P
WHERE A.IDASIGNATURA = A1.IDASIGNATURA 
AND A1.IDALUMNO = AL.IDALUMNO 
AND AL.DNI = P.DNI 
AND A.CREDITOS > 4.5;

-- 14. Mostrar el nombre de los profesores que imparten asignaturas con coste entre 25 y 35 euros, ambos incluidos
SELECT P.NOMBRE
FROM PERSONA P, PROFESOR PR, ASIGNATURA A
WHERE P.DNI = PR.DNI 
AND PR.IDPROFESOR = A.IDPROFESOR 
AND A.COSTEBASICO BETWEEN 25 AND 35;

-- 15. Mostrar el nombre de los alumnos matriculados en la asignatura '150212' Ã³ en la '130113' Ã³ en ambas.
SELECT DISTINCT P.NOMBRE
FROM PERSONA P, ALUMNO AL, ALUMNO_ASIGNATURA A1
WHERE P.DNI = AL.DNI 
AND AL.IDALUMNO = A1.IDALUMNO 
AND A1.IDASIGNATURA IN ('150212','130113');

-- 16. Mostrar el nombre de las asignaturas del 2º cuatrimestre que no sean de 6 crÃ©ditos,junto con el nombre de la titulaciÃ³n a la que pertenece.
SELECT A.NOMBRE, T.NOMBRE
FROM ASIGNATURA A, TITULACION T
WHERE A.IDTITULACION = T.IDTITULACION  
AND A.CUATRIMESTRE = 2
AND A.CREDITOS <> 6;

-- 17. Mostrar el nombre y el numero de horas de todas las asignaturas. (1cred.=10 horas) junto con el dni de los alumnos que estÃ¡n matriculados.
SELECT A.NOMBRE, A.CREDITOS * 10 AS NUMHORAS, AL.DNI 
FROM ASIGNATURA A, ALUMNO AL, ALUMNO_ASIGNATURA A1
WHERE A.IDASIGNATURA = A1.IDASIGNATURA 
AND AL.IDALUMNO = A1.IDALUMNO;

-- 18. Mostrar el nombre de todas las mujeres que viven en Sevilla y que estan matriculados de alguna asignatura
SELECT P.NOMBRE 
FROM PERSONA P, ALUMNO AL, ALUMNO_ASIGNATURA A1
WHERE P.DNI = AL.DNI 
AND AL.IDALUMNO = A1.IDALUMNO 
AND P.CIUDAD LIKE 'Sevilla'
AND P.VARON = 0;

-- 19. Mostrar el nombre de la asignatura de primero y que lo imparta el profesor con identificador p101.
SELECT  A.NOMBRE 
FROM PROFESOR PR, ASIGNATURA A
WHERE PR.IDPROFESOR = A.IDPROFESOR 
AND A.CURSO = 1
AND PR.IDPROFESOR LIKE 'P101';


-- 20. Mostrar el nombre de los alumnos que se ha matriculado tres o mÃ¡s veces en alguna asignatura.
SELECT P.NOMBRE 
FROM PERSONA P, ALUMNO AL, ALUMNO_ASIGNATURA A1
WHERE P.DNI  = AL.DNI 
AND AL.IDALUMNO  = A1.IDALUMNO 
AND A1.NUMEROMATRICULA  >= 3;

--BOLETÍN 3

-- 1. Cuantos costes básicos hay.

SELECT COUNT (nvl(costeBasico,0))
FROM ASIGNATURA;

-- 2. Para cada titulación mostrar el número de asignaturas que hay junto con el nombre de la titulación.

SELECT t.NOMBRE, COUNT(a.NOMBRE) 
FROM TITULACION t, ASIGNATURA a
WHERE t.IDTITULACION = a.IDTITULACION 
GROUP BY t.NOMBRE;

-- 3. Para cada titulación mostrar el nombre de la titulación junto con el precio total de todas sus asignaturas.

SELECT t.NOMBRE,  SUM(a.COSTEBASICO) 
FROM TITULACION t, ASIGNATURA a 
WHERE t.IDTITULACION = a.IDTITULACION 
GROUP BY t.NOMBRE;

-- 4. Cual sería el coste global de cursar la titulación de Matemáticas si el coste de cada asignatura 
-- fuera incrementado en un 7%. 

SELECT t.NOMBRE, SUM(a.COSTEBASICO + (a.COSTEBASICO * 0.07)) 
FROM TITULACION t, ASIGNATURA a 
WHERE t.IDTITULACION = a.IDTITULACION  
AND UPPER(t.NOMBRE) LIKE 'MATEMATICAS'
GROUP BY t.NOMBRE;

-- 5. Cuantos alumnos hay matriculados en cada asignatura, junto al id de la asignatura. 

SELECT a.IDASIGNATURA, COUNT (aa.IDASIGNATURA)
FROM ALUMNO_ASIGNATURA aa, ASIGNATURA a 
WHERE aa.IDASIGNATURA = a.IDASIGNATURA 
GROUP BY a.IDASIGNATURA;

-- 6. Igual que el anterior pero mostrando el nombre de la asignatura.

SELECT a.NOMBRE, a.IDASIGNATURA, COUNT (aa.IDASIGNATURA)
FROM ALUMNO_ASIGNATURA aa, ASIGNATURA a 
WHERE aa.IDASIGNATURA = a.IDASIGNATURA 
GROUP BY a.NOMBRE, a.IDASIGNATURA;

-- 7. Mostrar para cada alumno, el nombre del alumno junto con lo que tendría que 
-- pagar por el total de todas las asignaturas en las que está matriculada. 
-- Recuerda que el precio de la matrícula tiene un incremento de un 10% por cada año en el que esté matriculado. 

SELECT p.NOMBRE, SUM(a2.COSTEBASICO),(a2.COSTENASICO*ASIG.NUMEROMATRICULA)*01 (1 + 0.1*(aa.NUMEROMATRICULA - 1))) 
FROM PERSONA p, ALUMNO a, ALUMNO_ASIGNATURA aa, ASIGNATURA a2 
WHERE p.DNI = a.DNI
AND a.IDALUMNO = aa.IDALUMNO
AND aa.IDASIGNATURA = a2.IDASIGNATURA
GROUP BY p.DNI, p.NOMBRE;

-- 8. Coste medio de las asignaturas de cada titulación, para aquellas titulaciones 
-- en el que el coste total de la 1ª matrícula sea mayor que 60 euros.
SELECT t.NOMBRE, AVG(a.COSTEBASICO) AS COSTE_MEDIO_ASIGNATURA 
FROM TITULACION t, ASIGNATURA a, ALUMNO_ASIGNATURA AL
WHERE t.IDTITULACION = a.IDTITULACION
AND a.IDTITULACION = t.IDTITULACION 
AND AL.NUMEROMATRICULA =1
GROUP BY t.NOMBRE 
HAVING SUM(a.COSTEBASICO) > 60;


-- 9. Nombre de las titulaciones que tengan más de tres alumnos.

SELECT t.IDTITULACION, COUNT(aa.IDALUMNO) AS NUM_ALUMNOS
FROM TITULACION t, ASIGNATURA a, ALUMNO_ASIGNATURA aa
WHERE t.IDTITULACION = a.IDTITULACION 
AND	a.IDASIGNATURA = aa.IDASIGNATURA
GROUP BY t.IDTITULACION;
HAVING COUNT (aa.IDALUMNO)>3;

--10. Nombre de cada ciudad junto con el número de personas que viven en ella.

SELECT p.CIUDAD, COUNT(p.DNI)
FROM PERSONA p
GROUP BY p.CIUDAD; 

-- 11. Nombre de cada profesor junto con el número de asignaturas que imparte.

SELECT p.NOMBRE, COUNT(a.IDASIGNATURA)
FROM PERSONA p, PROFESOR p2, ASIGNATURA a
WHERE p.DNI = p2.DNI
AND p2.IDPROFESOR = a.IDPROFESOR
GROUP BY p.DNI, p.NOMBRE;


-- 12. Nombre de cada profesor junto con el número de alumnos que tiene, 
-- para aquellos profesores que tengan dos o más de 2 alumnos.

SELECT p.NOMBRE, COUNT (aa.IDALUMNO)
FROM PERSONA p, PROFESOR p2, ASIGNATURA a, ALUMNO_ASIGNATURA aa 
WHERE p.DNI = p2.DNI 
AND a.IDPROFESOR = p2.IDPROFESOR 
AND a.IDASIGNATURA = aa.IDASIGNATURA 
GROUP BY p.NOMBRE
HAVING COUNT(aa.IDALUMNO) >= 2;

-- 13. Obtener el máximo de las sumas de los costesbásicos de cada cuatrimestre

SELECT max(sum(a.COSTEBASICO)) AS COSTE_MAXIMO_CUATRIMESTRE  
FROM ASIGNATURA a 
GROUP BY a.CUATRIMESTRE;

-- 14. Suma del coste de las asignaturas

SELECT SUM(a.COSTEBASICO) AS COSTE_ASIGNATURAS 
FROM ASIGNATURA a;


-- 15. ¿Cuántas asignaturas hay?

SELECT COUNT(a.IDASIGNATURA) AS NUM_ASIGNATURAS
FROM ASIGNATURA a;

-- 16. Coste de la asignatura más cara y de la más barata

SELECT MAX (a.COSTEBASICO) AS ASIGNATURA_CARA, MIN(a.COSTEBASICO) AS ASIGNATURA_BARATA  
FROM ASIGNATURA a; 

-- 17. ¿Cuántas posibilidades de créditos de asignatura hay?

SELECT  count(DISTINCT a.CREDITOS) 
FROM ASIGNATURA a;
 
-- 18. ¿Cuántos cursos hay?

SELECT COUNT (DISTINCT a.CURSO)
FROM ASIGNATURA a;

-- 19. ¿Cuántas ciudades hay?

SELECT COUNT(DISTINCT p.CIUDAD)
FROM PERSONA p; 

-- 20. Nombre y número de horas de todas las asignaturas.

SELECT ASI.NOMBRE, (ASI.CREDITOS * 10) AS NUMHORAS
FROM ASIGNATURA ASI;

-- 21. Mostrar las asignaturas que no pertenecen a ninguna titulación.

SELECT a.IDASIGNATURA, a.NOMBRE 
FROM ASIGNATURA a
WHERE a.IDTITULACION IS NULL;

-- 22. Listado del nombre completo de las personas, sus teléfonos y sus direcciones, 
-- llamando a la columna del nombre "NombreCompleto" y a la de direcciones "Direccion".

SELECT (p.NOMBRE || ' ' || p.APELLIDO) AS NombreCompleto, p.TELEFONO, (p.DIRECCIONNUM || ' '||p.DIRECCIONCALLE|| ' '||p.CIUDAD) AS Direccion
FROM PERSONA p;

-- 23. Cual es el día siguiente al día en que nacieron las personas de la B.D.

SELECT p.FECHA_NACIMIENTO + 1
FROM PERSONA p;

-- 24. Años de las personas de la Base de Datos, esta consulta tiene que valor para cualquier momento

SELECT TRUNC((SYSDATE - p.FECHA_NACIMIENTO) / 365) AS EDAD
FROM PERSONA p;

-- 25. Listado de personas mayores de 25 años ordenadas por apellidos y nombre, 
-- esta consulta tiene que valor para cualquier momento

SELECT p.*, TRUNC((SYSDATE - p.FECHA_NACIMIENTO) / 365) AS EDAD
FROM PERSONA p
WHERE TRUNC((SYSDATE - p.FECHA_NACIMIENTO) / 365) > 25
ORDER BY p.APELLIDO DESC, p.NOMBRE ASC;

-- 26. Nombres completos de los profesores que además son alumnos

SELECT p1.NOMBRE, p1.APELLIDO
FROM PERSONA p1, PROFESOR p, PERSONA p2, ALUMNO a
WHERE p1.DNI = p.DNI 
AND p2.DNI = a.DNI 
AND p.DNI = a.DNI;

-- 27. Suma de los créditos de las asignaturas de la titulación de Matemáticas

SELECT SUM(a.CREDITOS)
FROM TITULACION t, ASIGNATURA a
WHERE t.IDTITULACION = a.IDTITULACION
AND UPPER(t.NOMBRE) LIKE 'MATEMATICAS';

-- 28. Número de asignaturas de la titulación de Matemáticas

SELECT COUNT(a.IDASIGNATURA)
FROM TITULACION t, ASIGNATURA a
WHERE t.IDTITULACION = a.IDTITULACION
AND UPPER(t.NOMBRE) LIKE 'MATEMATICAS';

-- 29. ¿Cuánto paga cada alumno por su matrícula?

SELECT p.DNI, p.NOMBRE, p.APELLIDO, SUM(a2.COSTEBASICO * (1 + 0.1 * (aa.NUMEROMATRICULA - 1))) AS PAGO_TOTAL -- SUM(a2.CREDITOS * a2.COSTEBASICO * (1 + 0.1 * (aa.NUMEROMATRICULA - 1))) Si consideramos que el coste total de una asignatura es el costeBásico por el número de creditos
FROM PERSONA p, ALUMNO a, ALUMNO_ASIGNATURA aa, ASIGNATURA a2
WHERE p.DNI = a.DNI 
AND a.IDALUMNO = aa.IDALUMNO
AND a2.IDASIGNATURA = aa.IDASIGNATURA
GROUP BY p.DNI, p.NOMBRE, p.APELLIDO;

-- 30. ¿Cuántos alumnos hay matriculados en cada asignatura?

SELECT a.NOMBRE, COUNT(aa.IDALUMNO) AS ALUMNOS_MATRICULADOS
FROM ASIGNATURA a, ALUMNO_ASIGNATURA aa 
WHERE a.IDASIGNATURA = aa.IDASIGNATURA
GROUP BY a.IDASIGNATURA, a.NOMBRE;
