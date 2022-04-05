--1.Número de clientes que tienen alguna factura con IVA 16%.
SELECT COUNT(CODCLI) 
FROM FACTURAS 
WHERE IVA = 16;

--2.Número de clientes que no tienen ninguna factura con un 16% de IVA.
SELECT COUNT(CODCLI)
FROM FACTURAS 
WHERE IVA != 16;

--3.Número de clientes que en todas sus facturas tienen un 16% de IVA 
--(los clientes deben tener al menos una factura).
SELECT COUNT(CODFAC) 
FROM FACTURAS 
WHERE NVL(IVA,0)IN (SELECT IVA FROM FACTURAS WHERE IVA=16);

--4.Fecha de la factura con mayor importe (sin tener en cuenta descuentos ni impuestos).
SELECT DISTINCT FECHA
FROM FACTURAS F, LINEAS_FAC LF
WHERE F.CODFAC = LF.CODFAC 
AND LF.PRECIO IN (SELECT MAX(PRECIO)FROM LINEAS_FAC);

--5.Número de pueblos en los que no tenemos clientes.
SELECT COUNT(PU.CODPUE)
FROM PUEBLOS PU, CLIENTES CL
WHERE PU.CODPUE= CL.CODPUE(+)
AND CL.CODPUE IS NULL;

--6.Número de artículos cuyo stock supera las 20 unidades, con precio superior a 15 euros y de
-- los que no hay ninguna factura en el último trimestre del año pasado.
SELECT COUNT(A.CODART)
FROM ARTICULOS A,FACTURAS F, LINEAS_FAC LF
WHERE A.STOCK >20 AND A.PRECIO >15
AND A.CODART =LF.CODART 
AND LF.CODFAC = F.CODFAC 
AND EXTRACT(YEAR FROM FECHA)!=EXTRACT(YEAR FROM SYSDATE)-1
AND EXTRACT(MONTH FROM FECHA)NOT IN (10,11,12);


--7.Obtener el número de clientes que en todas las facturas del año pasado han pagado IVA
-- (no se ha pagado IVA si es cero o nulo).
SELECT COUNT(CODCLI)
FROM CLIENTES C
WHERE C.CODCLI IN
				(SELECT DISTINCT F.CODCLI
				FROM FACTURAS F
				WHERE F.IVA!=0
				AND F.IVA IS NOT NULL 
				AND EXTRACT(YEAR FROM F.FECHA)= EXTRACT(YEAR FROM SYSDATE)-1;

--8.Clientes (código y nombre) que fueron preferentes durante el mes de noviembre del año 
--pasado y que en diciembre de ese mismo año no tienen ninguna factura. 
--Son clientes preferentes de un mes aquellos que han solicitado más de 60,50 euros en 
--facturas durante ese mes, sin tener en cuenta descuentos ni impuestos.
SELECT CLI.CODCLI, CLI.NOMBRE 
FROM CLIENTES CLI (SELECT F.CODCLI, F.FECHA 
					FROM LINEAS_FAC LF, FACTURAS F
					WHERE LF.CODFAC=F.CODFAC
					AND EXTRACT(YEAR FROM F.FECHA)=EXTRACT(YEAR FROM SYSDATE)-1
					AND EXTRACT(MONTH FROM F.FECHA)=11
					GROUP BY F.CODCLI 
					HAVING SUM(LF.PRECIO)>60.50 CLIENTE_PREFERENTE
				WHERE C.CODCLI= CLIENTE_PREFERENTE.CODCLI
				AND EXTRACT(YEAR FROM CLIENTE_PREFERENTE.FECHA)=EXTRACT(YEAR FROM SYSDATE)-1
				AND EXTRACT(MONTH FROM CLIENTE_PREFERENTE.FECHA)=12;

--9.Código, descripción y precio de los diez artículos más caros.
SELECT AR.CODART, AR.DESCRIP, AR.PRECIO 
FROM ARTICULOS AR
WHERE AR.PRECIO = (SELECT MAX(PRECIO) FROM ARTICULOS);


--10.Nombre de la provincia con mayor número de clientes.
SELECT *
FROM (SELECT COUNT(CL.CODCLI),PR.NOMBRE
FROM PROVINCIAS PR, PUEBLOS PUE, CLIENTES CL
WHERE PR.CODPRO = PUE.CODPRO 
AND PUE.CODPUE = CL.CODPUE
GROUP BY PR.NOMBRE 
ORDER BY COUNT(CL.CODCLI)DESC)
WHERE ROWN -1;


--11.Código y descripción de los artículos cuyo precio es mayor de 90,15 euros y se han vendido 
--menos de 10 unidades (o ninguna) durante el año pasado.
SELECT A.CODART, A.DESCRIP 
FROM ARTICULOS A, LINEAS_FAC LF, FACTURAS F
WHERE A.CODART =LF.CODART 
AND LF.CODFAC = F.CODFAC 
AND A.PRECIO >90.15
AND EXTRACT(YEAR FROM F.FECHA)= EXTRACT(YEAR FROM SYSDATE)-1
GROUP BY A.CODART, A.DESCRIP 
HAVING COUNT(LF.CODART)<=10;

--12.Código y descripción de los artículos cuyo precio es más de tres mil veces mayor que el 
--precio mínimo de cualquier artículo.
SELECT AR.CODART, AR.DESCRIP 
FROM ARTICULOS AR 
WHERE AR.PRECIO> (SELECT MIN(PRECIO)*3000 FROM ARTICULOS );

--13.Nombre del cliente con mayor facturación.
SELECT CL.NOMBRE
FROM CLIENTES CL,LINEAS_FAC LF,FACTURAS F
WHERE CL.CODCLI = FA.CODCLI 
AND F.CODFAC = LF.CODFAC 
GROUP BY CL.NOMBRE 
HAVING SUM(LF.PRECIO)=(SELECT MAX(SUM)


--14.Código y descripción de aquellos artículos con un precio superior a la media y que hayan sido
-- comprados por más de 5 clientes.
SELECT * FROM LINEAS_FAC lf ;
SELECT * FROM  ARTICULOS a ;
SELECT * FROM  FACTURAS f ;
SELECT AR.CODART, AR.DESCRIP 
FROM ARTICULOS AR, LINEAS_FAC LF
WHERE AR.PRECIO >(SELECT AVG(AR.PRECIO) FROM ARTICULOS)
AND LF.CODART >5;
GROUP BY AR.CODART;
