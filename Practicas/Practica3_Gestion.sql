
--1.Descuento medio aplicado en las facturas.
SELECT AVG(DTO)FROM FACTURAS;

--2.Descuento medio aplicado en las facturas sin considerar los valores nulos.
SELECT AVG(DTO) FROM FACTUTAS WHERE DTO IS NOT NULL;

--3. Descuento medio aplicado en las facturas considerando los valores nulos como cero.
SELECT TRUNC(AVG(NVL(DTO,0))) FROM FACTURAS;

--4. N�mero de facturas.
SELECT COUNT(CODFAC) FROM FACTURAS;

--5. N�mero de pueblos de la Comunidad de Valencia.
SELECT COUNT(CODPUE)
FROM PUEBLOS
WHERE CODPRO IN(3,12,46);

--6. Importe total de los art�culos que tenemos en el almac�n. Este importe se 
--calcula sumando el producto de las unidades en stock por el precio de cada unidad
SELECT SUM(PRECIO* STOCK) FROM ARTICULOS;

--7. N�mero de pueblos en los que residen clientes cuyo c�digo postal empieza por �12�.
SELECT COUNT(DISTINCT CODPUE) FROM CLIENTES 
WHERE CODPOSTAL LIKE '12%';

--8. Valores m�ximo y m�nimo del stock de los art�culos cuyo precio oscila entre 9 y 12 � y diferencia entre ambos valores
SELECT MAX(STOCK), MIN(STOCK),MAX(STOCK)-MIN(STOCK)AS DIFERENCIA 
FROM ARTICULOS 
WHERE PRECIO BETWEEN 9 AND 12;

--9. Precio medio de los art�culos cuyo stock supera las 10 unidades.
SELECT AVG(NVL(PRECIO,0)) FROM ARTICULOS 
WHERE STOCK >10;

--10. Fecha de la primera y la �ltima factura del cliente con c�digo 210.
SELECT MIN(FECHA),MAX(FECHA)FROM FACTURAS
WHERE CODCLI=210;

--11. N�mero de art�culos cuyo stock es nulo.
SELECT COUNT(CODART) FROM ARTICULOS
WHERE STOCK IS NULL;

--12. N�mero de l�neas cuyo descuento es nulo (con un decimal)
SELECT TRUNC(COUNT(linea),1)FROM LINEAS_FAC lf
WHERE DTO IS NULL;

--13. Obtener cu�ntas facturas tiene cada cliente.
SELECT COUNT(CODFAC),CODCLI FROM FACTURAS
GROUP BY CODCLI;

--14. Obtener cu�ntas facturas tiene cada cliente, pero s�lo si tiene dos o m�s facturas.
SELECT COUNT(CODFAC),F.CODCLI
FROM FACTURAS F, CLIENTES C
WHERE F.CODCLI = C.CODCLI
GROUP BY F.CODCLI
HAVING COUNT(CODFAC)>=2;

--15. Importe de la facturaci�n (suma del producto de la cantidad por el precio de las l�neas de factura) de los art�culos
SELECT SUM(CANT*PRECIO)FROM LINEAS_FAC lf;

--16. Importe de la facturaci�n (suma del producto de la cantidad por el precio de las l�neas de factura) de aquellos art�culos cuyo c�digo contiene la letra �A� (bien may�scula o min�scula).
SELECT SUM(lf.CANT*lf.PRECIO)FROM LINEAS_FAC lf, ARTICULOS a
WHERE lf.CODART= a.CODARTf AND UPPER(a.CODART)LIKE'%A%';

--17. N�mero de facturas para cada fecha, junto con la fecha
SELECT COUNT(CODFAC),FECHA 
FROM FACTURAS 
GROUP BY FECHA;

--18. Obtener el n�mero de clientes del pueblo junto con el nombre del pueblo mostrando primero los pueblos que m�s clientes tengan.
SELECT COUNT(C.CODCLI),P.NOMBRE
FROM CLIENTES C, PUEBLOS P
WHERE C.CODPUE = P.CODPUE
GROUP BY P.NOMBRE 
ORDER BY COUNT(C.CODCLI)DESC;

--19.Obtener el n�mero de clientes del pueblo junto con el nombre del pueblo mostrando primero los pueblos que m�s clientes tengan, siempre y cuando tengan m�s de dos clientes.
SELECT COUNT(C.CODCLI),P.NOMBRE
FROM CLIENTES C, PUEBLOS P
WHERE C.CODPUE= P.CODPUE
GROUP BY P.NOMBRE 
HAVING COUNT(C.CODCLI)>2
ORDER BY COUNT(C.CODCLI)DESC;

--20. Cantidades totales vendidas para cada art�culo cuyo c�digo empieza por �P", mostrando tambi�n la descripci�n de dicho art�culo.9.- Precio m�ximo y precio m�nimo de venta (en l�neas de facturas) para cada art�culo cuyo c�digo empieza por �c�.
SELECT SUM(LF.CANT),A.DESCRIP 
FROM ARTICULOS A, LINEAS_FAC LF
WHERE A.CODART LIKE 'P%'
GROUP BY A.DESCRIP;

--21. Igual que el anterior pero mostrando tambi�n la diferencia entre el precio m�ximo y m�nimo.
SELECT MAX(PRECIO),MIN(PRECIO)
FROM LINEAS_FAC 
WHERE CODART LIKE 'C%';




















