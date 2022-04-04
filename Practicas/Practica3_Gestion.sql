
--1.Descuento medio aplicado en las facturas.
SELECT AVG(DTO)FROM FACTURAS;

--2.Descuento medio aplicado en las facturas sin considerar los valores nulos.
SELECT AVG(DTO) FROM FACTUTAS WHERE DTO IS NOT NULL;

--3. Descuento medio aplicado en las facturas considerando los valores nulos como cero.
SELECT TRUNC(AVG(NVL(DTO,0))) FROM FACTURAS;

--4. Número de facturas.
SELECT COUNT(CODFAC) FROM FACTURAS;

--5. Número de pueblos de la Comunidad de Valencia.
SELECT COUNT(CODPUE)
FROM PUEBLOS
WHERE CODPRO IN(3,12,46);

--6. Importe total de los artículos que tenemos en el almacén. Este importe se 
--calcula sumando el producto de las unidades en stock por el precio de cada unidad
SELECT SUM(PRECIO* STOCK) FROM ARTICULOS;

--7. Número de pueblos en los que residen clientes cuyo código postal empieza por ‘12’.
SELECT COUNT(DISTINCT CODPUE) FROM CLIENTES 
WHERE CODPOSTAL LIKE '12%';

--8. Valores máximo y mínimo del stock de los artículos cuyo precio oscila entre 9 y 12 € y diferencia entre ambos valores
SELECT MAX(STOCK), MIN(STOCK),MAX(STOCK)-MIN(STOCK)AS DIFERENCIA 
FROM ARTICULOS 
WHERE PRECIO BETWEEN 9 AND 12;

--9. Precio medio de los artículos cuyo stock supera las 10 unidades.
SELECT AVG(NVL(PRECIO,0)) FROM ARTICULOS 
WHERE STOCK >10;

--10. Fecha de la primera y la última factura del cliente con código 210.
SELECT MIN(FECHA),MAX(FECHA)FROM FACTURAS
WHERE CODCLI=210;

--11. Número de artículos cuyo stock es nulo.
SELECT COUNT(CODART) FROM ARTICULOS
WHERE STOCK IS NULL;

--12. Número de líneas cuyo descuento es nulo (con un decimal)
SELECT TRUNC(COUNT(linea),1)FROM LINEAS_FAC lf
WHERE DTO IS NULL;

--13. Obtener cuántas facturas tiene cada cliente.
SELECT COUNT(CODFAC),CODCLI FROM FACTURAS
GROUP BY CODCLI;

--14. Obtener cuántas facturas tiene cada cliente, pero sólo si tiene dos o más facturas.
SELECT COUNT(CODFAC),F.CODCLI
FROM FACTURAS F, CLIENTES C
WHERE F.CODCLI = C.CODCLI
GROUP BY F.CODCLI
HAVING COUNT(CODFAC)>=2;

--15. Importe de la facturación (suma del producto de la cantidad por el precio de las líneas de factura) de los artículos
SELECT SUM(CANT*PRECIO)FROM LINEAS_FAC lf;

--16. Importe de la facturación (suma del producto de la cantidad por el precio de las líneas de factura) de aquellos artículos cuyo código contiene la letra “A” (bien mayúscula o minúscula).
SELECT SUM(lf.CANT*lf.PRECIO)FROM LINEAS_FAC lf, ARTICULOS a
WHERE lf.CODART= a.CODARTf AND UPPER(a.CODART)LIKE'%A%';

--17. Número de facturas para cada fecha, junto con la fecha
SELECT COUNT(CODFAC),FECHA 
FROM FACTURAS 
GROUP BY FECHA;

--18. Obtener el número de clientes del pueblo junto con el nombre del pueblo mostrando primero los pueblos que más clientes tengan.
SELECT COUNT(C.CODCLI),P.NOMBRE
FROM CLIENTES C, PUEBLOS P
WHERE C.CODPUE = P.CODPUE
GROUP BY P.NOMBRE 
ORDER BY COUNT(C.CODCLI)DESC;

--19.Obtener el número de clientes del pueblo junto con el nombre del pueblo mostrando primero los pueblos que más clientes tengan, siempre y cuando tengan más de dos clientes.
SELECT COUNT(C.CODCLI),P.NOMBRE
FROM CLIENTES C, PUEBLOS P
WHERE C.CODPUE= P.CODPUE
GROUP BY P.NOMBRE 
HAVING COUNT(C.CODCLI)>2
ORDER BY COUNT(C.CODCLI)DESC;

--20. Cantidades totales vendidas para cada artículo cuyo código empieza por “P", mostrando también la descripción de dicho artículo.9.- Precio máximo y precio mínimo de venta (en líneas de facturas) para cada artículo cuyo código empieza por “c”.
SELECT SUM(LF.CANT),A.DESCRIP 
FROM ARTICULOS A, LINEAS_FAC LF
WHERE A.CODART LIKE 'P%'
GROUP BY A.DESCRIP;

--21. Igual que el anterior pero mostrando también la diferencia entre el precio máximo y mínimo.
SELECT MAX(PRECIO),MIN(PRECIO)
FROM LINEAS_FAC 
WHERE CODART LIKE 'C%';




















