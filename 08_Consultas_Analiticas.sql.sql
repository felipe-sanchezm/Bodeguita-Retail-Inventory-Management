--=====================================================
-- 08_Consultas_Analiticas.sql
-- Descripción: Scripts para análisis financiero y operativo del inventario.
--=====================================================

-- 1. VALORIZACIÓN DE EXISTENCIAS
-- Útil para cierres contables y entender el valor real en anaquel.
SELECT
	P.Descripcion_Producto,
	SUM(TD.Cantidad) AS Stock_Existencia,
	AVG(TD.Costo_Unitario_Historico) AS Costo_Promedio,
	SUM(TD.Cantidad * TD.Costo_Unitario_Historico) AS Valor_Total_Inventario
	FROM Productos P
INNER JOIN Transferencias_Detalle TD ON P.ID_Producto = TD.ID_Producto
GROUP BY P.Descripcion_Producto
HAVING SUM(TD.Cantidad) > 0;


-- 2. REPORTE DE MOVIMIENTOS
SELECT
	T.ID_Transferencia,
	T.FUM AS Fecha_Movimiento,
	AO.Nombre_Almacen AS Origen,
	AD.Nombre_Almacen AS Destino,
	P.Descripcion_Producto,
	TD.Cantidad,
	E.ID_Empleado AS Numero_Operador,
	E.Nombre_Empleado + ' ' + E.Apellido_Paterno_Empleado + ' ' + E.Apellido_Materno_Empleado AS Operador
FROM Transferencias T
INNER JOIN Almacenes AO ON T.ID_Almacen_Origen = AO.ID_Almacen
INNER JOIN Almacenes AD ON T.ID_Almacen_Destino = AD.ID_Almacen
INNER JOIN Transferencias_Detalle TD ON T.ID_Transferencia = TD.ID_Transferencia
INNER JOIN Productos P ON TD.ID_Producto = P.ID_Producto
INNER JOIN Empleado E ON T.ID_Empleado = E.ID_Empleado


-- 3. RIESGO FINANCIERO POR ESTATUS (VALOR EN TRÁNSITO)
-- Ayuda a identificar cuánto dinero está "detenido" o "en camino".
SELECT
	ET.Descripcion_Estatus_Transito,
	COUNT(T.ID_Transferencia) AS Numero_Transferencias,
	SUM(TD.Cantidad * TD.Costo_Unitario_Historico) AS Valor_En_Transito
FROM Transferencias T
JOIN Estatus_Transito ET ON T.ID_Estatus = ET.ID_Estatus_Transito
JOIN Transferencias_Detalle TD ON T.ID_Transferencia =  TD.ID_Transferencia
GROUP BY ET.Descripcion_Estatus_Transito