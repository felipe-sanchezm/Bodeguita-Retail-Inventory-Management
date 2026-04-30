--=====================================================
-- 09_Vista_Auditoria_Saldos.sql
-- Descripción: Vista de reconciliación para detectar discrepancias 
--              entre el stock físico (Existencias) y el histórico de movimientos.
--=====================================================

CREATE OR ALTER VIEW vw_Auditoria_Inventario AS
WITH Saldos_Calculados AS (
    SELECT
        ID_Almacen,
        ID_Producto,
        SUM(CASE 
            WHEN TM.Tipo_Operacion = 'Entrada' THEN TD.Cantidad 
            WHEN TM.Tipo_Operacion = 'Salida' THEN (TD.Cantidad * -1)
            ELSE 0 
        END) AS Saldo_Historico
    FROM Transferencias T
    INNER JOIN Transferencias_Detalle TD ON T.ID_Transferencia = TD.ID_Transferencia
    INNER JOIN Tipo_Movimiento TM ON T.ID_Tipo_Movimiento = TM.ID_Tipo_Movimiento
    -- Nota: Aquí unificamos la lógica. Si es entrada, suma al Almacén Destino. 
    -- Si es salida, resta al Almacén Origen.
    CROSS APPLY (
        SELECT T.ID_Almacen_Destino AS ID_Almacen WHERE TM.Tipo_Operacion = 'Entrada'
        UNION ALL
        SELECT T.ID_Almacen_Origen AS ID_Almacen WHERE TM.Tipo_Operacion = 'Salida'
    ) AS Almacen_Relacionado
    GROUP BY ID_Almacen, ID_Producto
)
SELECT
    A.Nombre_Almacen,
    P.Descripcion_Producto,
    E.Cantidad_Actual AS Stock_Fisico_Tabla,
    ISNULL(SC.Saldo_Historico, 0) AS Stock_Calculado_Historico,
    (E.Cantidad_Actual - ISNULL(SC.Saldo_Historico, 0)) AS Discrepancia
FROM Existencias E
INNER JOIN Productos P ON E.ID_Producto = P.ID_Producto
INNER JOIN Almacenes A ON E.ID_Almacen = A.ID_Almacen
LEFT JOIN Saldos_Calculados SC ON E.ID_Almacen = SC.ID_Almacen AND E.ID_Producto = SC.ID_Producto;
-- Consulta para el auditor:
-- SELECT * FROM vw_Auditoria_Inventario WHERE Discrepancia <> 0;