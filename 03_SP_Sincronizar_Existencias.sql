--=====================================================
-- 03_SP_Sincronizar_Existencias.sql
-- Descripción: Procedimiento maestro para recalcular el stock real
--              basado en el historial completo de transferencias.
--=====================================================

CREATE OR ALTER PROCEDURE sp_Sincronizar_Inventario_Global
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Calculamos saldos usando la nueva columna Tipo_Operacion
        WITH Saldos_Nuevos AS (
            SELECT 
                Almacen_ID,
                ID_Producto,
                SUM(Monto_Final) AS Saldo_Final
            FROM (
                -- Lógica para Entradas
                SELECT 
                    T.ID_Almacen_Destino AS Almacen_ID,
                    TD.ID_Producto,
                    TD.Cantidad AS Monto_Final
                FROM Transferencias T
                JOIN Transferencias_Detalle TD ON T.ID_Transferencia = TD.ID_Transferencia
                JOIN Tipo_Movimiento TM ON T.ID_Tipo_Movimiento = TM.ID_Tipo_Movimiento
                WHERE TM.Tipo_Operacion = 'Entrada'

                UNION ALL

                -- Lógica para Salidas
                SELECT 
                    T.ID_Almacen_Origen AS Almacen_ID,
                    TD.ID_Producto,
                    (TD.Cantidad * -1) AS Monto_Final
                FROM Transferencias T
                JOIN Transferencias_Detalle TD ON T.ID_Transferencia = TD.ID_Transferencia
                JOIN Tipo_Movimiento TM ON T.ID_Tipo_Movimiento = TM.ID_Tipo_Movimiento
                WHERE TM.Tipo_Operacion = 'Salida'
            ) AS Consolidado
            GROUP BY Almacen_ID, ID_Producto
        )

        -- Sincronización con MERGE
        MERGE Existencias AS Destino
        USING Saldos_Nuevos AS Fuente
        ON (Destino.ID_Almacen = Fuente.Almacen_ID AND Destino.ID_Producto = Fuente.ID_Producto)
        
        WHEN MATCHED THEN
            UPDATE SET 
                Destino.Cantidad_Actual = Fuente.Saldo_Final,
                Destino.Ultima_Actualizacion = GETDATE()
        
        WHEN NOT MATCHED THEN
            INSERT (ID_Almacen, ID_Producto, Cantidad_Actual, Ultima_Actualizacion)
            VALUES (Fuente.Almacen_ID, Fuente.ID_Producto, Fuente.Saldo_Final, GETDATE());

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;