--=====================================================
-- 04_Vistas_KPIs_Inventario.sql
-- Descripción: Capa de inteligencia para reportes y Power BI.
--=====================================================

CREATE VIEW vw_InventarioDetallado AS
SELECT
    P.SKU_Producto AS SKU,
    P.Descripcion_Producto AS Producto,
    M.Nombre_Marca_Producto AS Marca,
    D.Nombre_Departamento AS Departamento,
    AO.Nombre_Almacen AS Bodega_Origen,
    AD.Nombre_Almacen AS Bodega_Destino,
    TD.Cantidad,
    TD.Costo_Unitario_Historico AS Costo_Unitario,
    TD.Subtotal,
    T.FUM AS Fecha_Movimiento,
    E.Nombre_Empleado + ' ' + E.Apellido_Paterno_Empleado AS Responsable,
    TM.Nombre_Tipo_Movimiento AS Operacion,
    ET.Descripcion_Estatus_Transito AS Estatus
FROM Transferencias T
INNER JOIN Transferencias_Detalle TD ON T.ID_Transferencia = TD.ID_Transferencia
INNER JOIN Productos P ON TD.ID_Producto = P.ID_Producto
INNER JOIN Marca_Producto M ON P.ID_Marca = M.ID_Marca_Producto
INNER JOIN Departamento D ON P.ID_Departamento = D.ID_Departamento
INNER JOIN Almacenes AO ON T.ID_Almacen_Origen = AO.ID_Almacen
INNER JOIN Almacenes AD ON T.ID_Almacen_Destino = AD.ID_Almacen
INNER JOIN Empleado E ON T.ID_Empleado = E.ID_Empleado
INNER JOIN Tipo_Movimiento TM ON T.ID_Tipo_Movimiento = TM.ID_Tipo_Movimiento
INNER JOIN Estatus_Transito ET ON T.ID_Estatus = ET.ID_Estatus_Transito;
GO
