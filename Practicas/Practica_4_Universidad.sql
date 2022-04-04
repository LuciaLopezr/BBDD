--1. Mostrar el identificador de los alumnos matriculados en cualquier asignatura excepto la '150212' y la '130113'.
SELECT A.IDALUMNO, AA.IDASIGNATURA
FROM ALUMNO A, ALUMNO_ASIGNATURA AA 
WHERE A.IDALUMNO = AA.IDALUMNO 
AND AA.IDASIGNATURA NOT LIKE '150212'
AND AA.IDASIGNATURA NOT LIKE '130113';

--2. Mostrar el nombre de las asignaturas que tienen más créditos que "Seguridad Vial". 
SELECT NOMBRE AS NOMBRE_ASIGNATURA 
FROM ASIGNATURA 
WHERE CREDITOS > (SELECT CREDITOS FROM ASIGNATURA
WHERE NOMBRE LIKE 'Seguridad Vial');

--3. Obtener el Id de los alumnos matriculados en las asignaturas "150212" y "130113" a la vez. 
SELECT AA.IDALUMNO, AA.IDASIGNATURA 
FROM ALUMNO_ASIGNATURA AA 
WHERE AA.IDASIGNATURA LIKE '150212'
AND AA.IDASIGNATURA LIKE '130113';

--4. Mostrar el Id de los alumnos matriculados en las asignatura "150212" ó "130113", en una o en otra pero no en ambas a la vez. 
SELECT AA.IDALUMNO, AA.IDASIGNATURA 
FROM ALUMNO_ASIGNATURA AA 
WHERE AA.IDASIGNATURA LIKE '150212'
OR AA.IDASIGNATURA LIKE '130113';

--5. Mostrar el nombre de las asignaturas de la titulación "130110" cuyos costes básicos sobrepasen el coste básico promedio por asignatura en esa titulación.
SELECT ASI.NOMBRE 
FROM ASIGNATURA ASI
WHERE ASI.IDTITULACION LIKE '130110';

--6. Mostrar el identificador de los alumnos matriculados en cualquier asignatura excepto la "150212" y la "130113”
SELECT IDALUMNO 
FROM ALUMNO 
WHERE IDALUMNO NOT IN (SELECT IDALUMNO FROM ALUMNO_ASIGNATURA WHERE IdAsignatura = '150212') 
AND IDALUMNO NOT IN (SELECT IDALUMNO FROM ALUMNO_ASIGNATURA WHERE IdAsignatura = '130113');

--7. Mostrar el Id de los alumnos matriculados en la asignatura "150212" pero no en la "130113". 
SELECT IDALUMNO 
FROM ALUMNO 
WHERE IDALUMNO IN (SELECT IDALUMNO FROM ALUMNO_ASIGNATURA WHERE IdAsignatura = '150212') 
AND IDALUMNO NOT IN (SELECT IDALUMNO FROM ALUMNO_ASIGNATURA WHERE IdAsignatura = '130113');

--8. Mostrar el nombre de las asignaturas que tienen más créditos que "Seguridad Vial". 
SELECT NOMBRE AS NOMBRE_ASIGNATURA 
FROM ASIGNATURA 
WHERE CREDITOS > (SELECT CREDITOS FROM ASIGNATURA
WHERE NOMBRE LIKE 'Seguridad Vial');

--9. Mostrar las personas que no son ni profesores ni alumnos.
SELECT *
FROM PERSONA 
WHERE DNI NOT IN (SELECT DNI FROM ALUMNO)
AND DNI NOT IN (SELECT DNI FROM PROFESOR);

--10. Mostrar el nombre de las asignaturas que tengan más créditos. 
SELECT NOMBRE
FROM ASIGNATURA 
WHERE CREDITOS = (SELECT MAX(CREDITOS)FROM ASIGNATURA );

--11. Lista de asignaturas en las que no se ha matriculado nadie. 
SELECT DISTINCT NOMBRE 
FROM ASIGNATURA, ALUMNO_ASIGNATURA 
WHERE NOMBRE IN (SELECT NUMEROMATRICULA FROM ALUMNO_ASIGNATURA WHERE NUMEROMATRICULA IS NULL );

--12. Ciudades en las que vive algún profesor y también algún alumno. 
SELECT DISTINCT CIUDAD 
FROM PERSONA ;
