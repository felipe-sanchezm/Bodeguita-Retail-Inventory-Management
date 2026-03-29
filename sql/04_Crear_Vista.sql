CREATE VIEW vw_InventarioDetallado AS
SELECT
	P.SKU_Producto AS SKU,
	P.Descripcion_Producto AS Producto,
	P.Material_Producto AS Codigo_Material,
	M.Nombre_Marca_Producto AS Marca,
	D.Nombre_Departamento AS Departamento,
	AO.Nombre_Almacen AS Origen,
	AD.Nombre_Almacen AS Destino,
	MV.Cantidad,
	MV.FUM AS Fecha_Movimiento,
	E.Nombre_Empleado + ' ' + E.Apellido_Paterno_Empleado AS Responsable,
	TM.ID_Tipo_Movimiento AS Tipo_Operacion
FROM Movimientos MV
INNER JOIN Productos P ON MV.ID_Producto = P.ID_Producto
INNER JOIN Marca_Producto M ON P.ID_Marca = M.ID_Marca_Producto
INNER JOIN Departamento D ON P.ID_Departamento = D.ID_Departamento
INNER JOIN Almacenes AO ON MV.ID_Almacen_Origen = AO.ID_Almacen
INNER JOIN Almacenes AD ON MV.ID_Almacen_Destino = AD.ID_Almacen
INNER JOIN Empleado E ON MV.ID_Empleado = E.ID_Empleado
INNER JOIN Tipo_Movimiento TM ON MV.ID_Tipo_Movimiento = TM.ID_Tipo_Movimiento;

SELECT * FROM vw_InventarioDetallado ORDER BY Departamento;