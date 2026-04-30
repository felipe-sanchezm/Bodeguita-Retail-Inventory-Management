--=====================================================
-- 05_Vista_Stock_Disponible.sql
-- Descripción: Consulta en tiempo real del inventario neto por ubicación.
--=====================================================

CREATE VIEW vw_ExistenciasActuales AS
SELECT
    P.SKU_Producto AS SKU,
    P.Descripcion_Producto AS Producto,
    D.Nombre_Departamento AS Departamento,
    A.Nombre_Almacen AS Ubicacion,
    E.Cantidad_Actual AS Stock_Disponible,
    E.Stock_Minimo,
    -- Agregamos un semáforo lógico para el reporte
    CASE 
        WHEN E.Cantidad_Actual <= E.Stock_Minimo THEN 'REABASTECER'
        WHEN E.Cantidad_Actual <= (E.Stock_Minimo * 1.5) THEN 'STOCK BAJO'
        ELSE 'OK'
    END AS Estatus_Surtido,
    E.Ultima_Actualizacion
FROM Existencias E
INNER JOIN Productos P ON E.ID_Producto = P.ID_Producto
INNER JOIN Almacenes A ON E.ID_Almacen = A.ID_Almacen
LEFT JOIN Departamento D ON P.ID_Departamento = D.ID_Departamento
WHERE E.Cantidad_Actual > 0; -- Solo mostramos lo que tiene stock
GO
