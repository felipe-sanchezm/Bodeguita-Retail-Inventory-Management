--=====================================================
-- 10_Vista_Auditoria_Saldos.sql
-- Descripción: Vista de reconciliación para detectar discrepancias 
--              entre el stock físico (Existencias) y el histórico de movimientos.
--=====================================================
--Parte 1: Las salidas (Lo que nos resta)
SELECT
	ID_Almacen_Origen AS ID_Almacen,
	ID_Producto,
	(Cantidad * -1) AS Movimiento
FROM Transferencias T
JOIN Transferencias_Detalle TD ON T.ID_Transferencia = TD.ID_Transferencia

UNION ALL

--Parte 2: Las entradas (Lo que nos suma)
SELECT
	ID_Almacen_Destino AS ID_Almacen,
	ID_Producto,
	Cantidad AS Movimiento
FROM Transferencias T
JOIN Transferencias_Detalle TD ON T.ID_Transferencia = TD.ID_Transferencia


-- Tabla Virtual creada como una subconsulta
SELECT
	ID_Almacen,
	ID_Producto,
	SUM(Movimiento) AS Saldo_Final
FROM (
	SELECT
		ID_Almacen_Origen AS ID_Almacen,
		ID_Producto,
		(Cantidad * -1) AS Movimiento
	FROM Transferencias T
	JOIN Transferencias_Detalle TD ON T.ID_Transferencia = TD.ID_Transferencia
UNION ALL
	SELECT
		ID_Almacen_Destino AS ID_Almacen,
		ID_Producto,
		Cantidad AS Movimiento
	FROM Transferencias T
	JOIN Transferencias_Detalle TD ON T.ID_Transferencia = TD.ID_Transferencia
) AS Tabla_Virtual
GROUP BY ID_Almacen, ID_Producto;

--Tabla virtual creada como una Common Table Expression (CTEs)
WITH Saldos_Calculados AS (
SELECT
	ID_Almacen,
	ID_Producto,
	SUM(Movimiento) AS Saldo_Final
FROM (
		SELECT 
			ID_Almacen_Origen AS ID_Almacen,
			ID_Producto,
			(Cantidad * -1) AS Movimiento
		FROM Transferencias T
		JOIN Transferencias_Detalle TD ON T.ID_Transferencia = TD.ID_Transferencia
		UNION ALL
		SELECT
			ID_Almacen_Destino AS ID_Almacen,
			ID_Producto,
			Cantidad AS Movimiento
		FROM Transferencias T
		JOIN Transferencias_Detalle TD ON T.ID_Transferencia = TD.ID_Transferencia
	) AS Movimientos
	GROUP BY ID_Almacen, ID_Producto
)


--CREAR VISTA para reutilizar la consulta
CREATE OR ALTER VIEW Vista_Inventarios_Estatus AS
--Tabla virtual creada como una Common Table Expression (CTEs)
WITH Saldos_Calculados AS (
SELECT
	ID_Almacen,
	ID_Producto,
	SUM(Movimiento) AS Saldo_Final
FROM (
		SELECT 
			ID_Almacen_Origen AS ID_Almacen,
			ID_Producto,
			(Cantidad * -1) AS Movimiento
		FROM Transferencias T
		JOIN Transferencias_Detalle TD ON T.ID_Transferencia = TD.ID_Transferencia
		UNION ALL
		SELECT
			ID_Almacen_Destino AS ID_Almacen,
			ID_Producto,
			Cantidad AS Movimiento
		FROM Transferencias T
		JOIN Transferencias_Detalle TD ON T.ID_Transferencia = TD.ID_Transferencia
	) AS Movimientos
	GROUP BY ID_Almacen, ID_Producto
)

SELECT
	E.ID_Almacen,
	E.ID_Producto,
	E.Cantidad_Actual AS Inventario_Registrado,
	ISNULL (SC.Saldo_Final, 0) AS Inventario_Calculado,
	(E.Cantidad_Actual + ISNULL(SC.Saldo_Final, 0)) AS Diferencia
FROM Existencias E
LEFT JOIN Saldos_Calculados SC ON E.ID_Almacen = SC.ID_Almacen AND E.ID_Producto = SC.ID_Producto

SELECT * FROM Vista_Inventarios_Estatus;
