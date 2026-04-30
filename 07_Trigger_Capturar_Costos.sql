--=====================================================
-- 07_Trigger_Historico_Costos.sql
-- Descripción: Automatización para capturar el costo vigente al momento 
--              del movimiento y actualizar auditoría en la tabla maestra.
--=====================================================

/*
La funcion de este Trigger es copiar el costo del producto de la tabla Productos y copiarlo en la tabla Transferencias_Detalle
*/

CREATE TRIGGER TR_Capturar_Costo_Y_Monto
ON Transferencias_Detalle
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    -- 1. CAPTURA DE COSTO HISTÓRICO
    -- Evita que cambios futuros en el catálogo de Productos alteren el valor 
    -- registrado de transferencias pasadas.
    -- Actualizamos el Costo_Unitario_Historico en el Detalle
    -- Lo tomamos directamente de la tabla Productos usando el ID_Producto
    UPDATE TD
    SET TD.Costo_Unitario_Historico = P.Costo_Unitario
    FROM Transferencias_Detalle TD
    INNER JOIN inserted I ON TD.ID_Transferencias_Detalle = I.ID_Transferencias_Detalle
    INNER JOIN Productos P ON I.ID_Producto = P.ID_Producto;

    -- 2. (Opcional pero recomendado) Actualizamos la Fecha de Modificación en el Maestro
    -- Así sabemos cuándo fue la última vez que se le agregó algo a ese Folio
    UPDATE T
    SET T.FUM = GETDATE()
    FROM Transferencias T
    INNER JOIN inserted I ON T.ID_Transferencia = I.ID_Transferencia;
END;