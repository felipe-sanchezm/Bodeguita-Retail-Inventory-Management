CREATE VIEW vw_ExistenciasActuales AS
SELECT
	P.SKU_Producto AS SKU,
	P.Descripcion_Producto AS Producto,
	D.Nombre_Departamento AS Departamento,
	A.Nombre_Almacen AS Ubicacion,
	--Calculamos el Neto: (Lo que entró a este almacén) - (Lo que salió de este almacén)
	ISNULL(SumEntradas.Total, 0) - ISNULL(SumSalidas.Total, 0) AS Stock_Disponible
FROM Productos P
CROSS JOIN Almacenes A --Evaluamos cada producto en cada almacén
LEFT JOIN Departamento D ON P.ID_Departamento = D.ID_Departamento
--Subconsulta para sumar todo lo que ENTRÓ a este almacén específico
LEFT JOIN (
	SELECT ID_Producto, ID_Almacen_Destino, SUM(Cantidad) AS Total
	FROM Movimientos
	GROUP BY ID_Producto, ID_Almacen_Destino
) AS SumEntradas ON P.ID_Producto = SumEntradas.ID_Producto AND A.ID_Almacen = SumEntradas.ID_Almacen_Destino
--Subconsulta para sumar todo lo que SALIÓ de este almacén específico
LEFT JOIN (
	SELECT ID_Producto, ID_Almacen_Origen, SUM(Cantidad) AS Total
	FROM Movimientos
	GROUP BY ID_Producto, ID_Almacen_Origen
) AS SumSalidas ON P.ID_Producto = SumSalidas.ID_Producto AND A.ID_Almacen = SumSalidas.ID_Almacen_Origen
WHERE ISNULL(SumEntradas.Total, 0) - ISNULL(SumSalidas.Total, 0) > 0;

SELECT * FROM vw_ExistenciasActuales;
