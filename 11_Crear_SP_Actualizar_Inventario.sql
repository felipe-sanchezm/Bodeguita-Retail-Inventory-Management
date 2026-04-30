CREATE PROCEDURE sp_Actualizar_Inventario_Total
AS
BEGIN
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
	MERGE Existencias AS Destino
	USING Saldos_Calculados AS Fuente
	ON (Destino.ID_Almacen = Fuente.ID_Almacen AND Destino.ID_Producto = Fuente.ID_Producto)
	WHEN MATCHED THEN
	--Sumamos el movimiento al saldo actual
		UPDATE SET Destino.Cantidad_Actual = Destino.Cantidad_Actual + Fuente.Saldo_Final
	WHEN NOT MATCHED THEN
	--Si el registro es nuevo, simplemente insertamos el saldo
		INSERT (ID_Almacen, ID_Producto, Cantidad_Actual)
		VALUES(Fuente.ID_Almacen, Fuente.ID_Producto, Fuente.Saldo_Final);
END;

SELECT * FROM Existencias
