--=======================
--INSERCIÓN DE CATALOGOS
--=======================
-- 1. ROLES DE USUARIO
INSERT INTO Rol_Usuario(Descripcion_Rol_Usuario) VALUES 
('Gerencia'), ('Jefe de Recibo'), ('Jefe de Inventarios'), 
('Surtidor Ropa'), ('Surtidor Variedades'), ('Surtidor Perfumería'), ('Recibo de Camión');

-- 2. ESTATUS Y TIPOS
INSERT INTO Estatus_Empleado (Descripcion_Estatus_Empleado) VALUES ('Activo'), ('Baja'), ('Temporal');
INSERT INTO Tipo_Movimiento (Nombre_Tipo_Movimiento) VALUES ('Entrada'), ('Salida'), ('Traspaso'), ('Ajuste'), ('En tránsito');

-- 3. PUESTOS
INSERT INTO Puesto_Empleado (Nombre_Puesto_Empleado, Salario_Base_Puesto_Empleado) VALUES 
('Gerente', 18000.00), ('Jefe de Departamento', 12000.00), 
('Auxiliar A', 9000.00), ('Auxiliar General', 7500.00),
('Jefe de Inventarios', 13000.00), ('Auxiliar A de Inventarios', 9500.00);

-- 4. ALMACENES
INSERT INTO Almacenes (Codigo_Almacen, Nombre_Almacen) VALUES 
('A001', 'Piso de Ventas'), 
('A003', 'Bodega Externa 1'), 
('A004', 'Bodega Externa 2'), 
('B001', 'Devoluciones'), 
('B002', 'Mermas');

INSERT INTO Almacenes (Codigo_Almacen, Nombre_Almacen) 
VALUES ('PROV', 'Proveedor Externo / CEDIS');

-- 5. DEPARTAMENTOS UNIFICADOS
INSERT INTO Departamento (Nombre_Departamento) VALUES 
('Corsetería y Lencería'), ('Niñas Interior'), ('Niñas'), ('Teens 14-18'), ('Dama Juvenil'), 
('Curvy Joven'), ('Dama'), ('Talla Extra Dama'), ('Talla Extra Caballeros'), ('Talla Extra Joven'), 
('Caballero Juvenil'), ('Niños'), ('Chavos 13-18'), ('Deportivo'), ('Caballeros Interior'), 
('Niños Interior'), ('Escolar'), ('Bebés Interior'), ('Bebés Meses'), ('Bebés Años'),
('Cuidado Personal'), ('Tintes y Shampoos'), ('Belleza'), ('Eléctrico Cuidado Personal'), ('Checkout'),
('Enseres Menores'), ('Blancos'), ('Hogar'), ('Regalos'), ('Mascotas'), ('Electrónica'), 
('Accesorios'), ('Zapatería'), ('Cuidado del Bebé'), ('Bebés Blancos'), ('Accesorios Deportivo'), 
('Juguetería Niños'), ('Juguetería Niñas'), ('Juguetería Bebés'), ('Coleccionables'), 
('Papelería'), ('Dulcería'), ('Dulcería Granel'), ('Dulcería Checkout'), ('Playa'), ('Navideño');


--========================
--INSERTAR FUERZA LABORAL
--========================
-- INSERTAR LOS 15 EMPLEADOS
INSERT INTO Empleado (Nombre_Empleado, Apellido_Paterno_Empleado, ID_Puesto, ID_Estatus, Fecha_Ingreso_Empleado) VALUES 
('Ricardo', 'Mendoza', 1, 1, '2023-01-15'), -- Gerente
('Laura', 'Castillo', 2, 1, '2023-03-10'),  -- Jefe de Depto
('Sofía', 'García', 5, 1, '2023-05-20'),   -- Jefe de Inventarios
('Andrés', 'Reyes', 3, 1, '2024-01-05'),   -- Auxiliar A
('César', 'Ruiz', 6, 1, '2024-02-12'),    -- Auxiliar A de Inventarios
('Mateo', 'López', 4, 1, '2024-06-01'),    -- Auxiliar General
('Elena', 'Vargas', 4, 1, '2024-06-05'),   
('Luis', 'Torres', 4, 1, '2024-06-10'),    
('Diana', 'Sánchez', 4, 1, '2024-07-01'),  
('Oscar', 'Martínez', 4, 3, '2024-11-15'), -- Temporal
('Karla', 'Peña', 4, 3, '2024-11-20'),    -- Temporal
('Hugo', 'Salazar', 4, 1, '2025-01-10'),   
('Rosa', 'Méndez', 4, 1, '2025-01-15'),    
('Javier', 'Luna', 4, 2, '2024-08-01'),    -- Baja
('Gabriela', 'Solís', 4, 1, '2025-02-01'); 

-- INSERTAR LOS 7 USUARIOS
-- Nota: Asegúrate de que los IDs coincidan con los que SQL generó (1 al 15)
INSERT INTO Usuario (Username, Password_user, ID_Rol) VALUES 
('gerencia_admin', 'Admin2026!', 1),   -- Gerente -> Gerencia
('jefe_bodega', 'Recibo#123', 2),     -- Jefe Depto -> Jefe de Recibo
('jefe_inv', 'InvMaster$1', 3),       -- Jefe Inv -> Jefe de Inventarios
('surt_ropa', 'Ropa2026', 4),         -- Auxiliar -> Surtidor Ropa
('surt_variedades', 'Var2026', 5),    -- Auxiliar -> Surtidor Variedades
('surt_perfumeria', 'Perf2026', 6),   -- Auxiliar -> Surtidor Perfumería
('recibo_camion', 'Camion#01', 7);    -- Auxiliar A Inv -> Recibo de Camión

--===========
--INVENTARIO
--===========
-- 1. MARCAS Y PROVEEDORES RÁPIDOS
INSERT INTO Marca_Producto(Nombre_Marca_Producto) VALUES 
('Hasbro'), ('Mattel'), ('Lego'), ('Disney'), ('Scribe'), ('Bic'), 
('Zote'), ('T-Fal'), ('Mabe'), ('Puma'), ('Adidas'), ('Levis'), 
('Crayola'), ('Saba'), ('Colgate'), ('Nestlé');

INSERT INTO Proveedor (Razon_Social_Proveedor, RFC_Proveedor) VALUES 
('Distribuidora Nacional Retail', 'DNR900101ABC'),
('Juguetes y Diversión S.A.', 'JDS850520XYZ'),
('Textiles de México', 'TXM700815HGT'),
('Abarrotes y Dulces del Centro', 'ADC951210LKP');

-- 2. PRODUCTOS 
-- INSERTAR 50 PRODUCTOS CON LÓGICA DE Departamento
INSERT INTO Productos (SKU_Producto, Material_Producto, Descripcion_Producto, ID_Marca, ID_Proveedor, ID_Departamento)
VALUES 
-- BLOQUE ROPA (ID_Departamento vinculados a nombres de Ropa)
('7501000000000001', '5001', 'Bra Copa B con varilla y encaje floral - Corsetería', 1, 3, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Corsetería y Lencería')),
('7501000000000002', '5001', 'Pack 3 Pantaletas Niña algodón - Niñas Interior', 4, 3, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Niñas Interior')),
('7501000000000003', '5020', 'Jeans Dama Juvenil Corte Skinny Azul - Dama Juvenil', 12, 3, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Dama Juvenil')),
('7501000000000004', '5020', 'Pantalón Caballero Mezclilla Recto - Caballero Juvenil', 12, 3, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Caballero Juvenil')),
('7501000000000005', '5001', 'Mameluco Bebé Algodón Estampado - Bebés Meses', 4, 3, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Bebés Meses')),
('7501000000000006', '5044', 'Sudadera Deportiva con Gorro - Deportivo', 11, 3, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Deportivo')),
('7501000000000007', '5001', 'Camiseta Interior Niño Blanca - Niños Interior', 4, 3, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Niños Interior')),
('7501000000000008', '5020', 'Short Juvenil Mezclilla - Teens 14-18', 12, 3, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Teens 14-18')),
('7501000000000009', '5088', 'Vestido Dama Estampado Flores - Dama', 12, 3, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Dama')),
('7501000000000010', '5001', 'Calceta Escolar Blanca Par - Escolar', 6, 3, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Escolar')),

-- BLOQUE JUGUETERÍA Y TEMPORADA (Bodega Externa 2 - A004)
('8401000000000011', '100255', 'Figura de Acción Marvel Legends - Juguetería Niños', 1, 2, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Juguetería Niños')),
('8401000000000012', '100255', 'Muñeca Barbie Fashionista - Juguetería Niñas', 2, 2, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Juguetería Niñas')),
('8401000000000013', '100990', 'Set Lego Star Wars 500pzas - Juguetería Niños', 3, 2, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Juguetería Niños')),
('8401000000000014', '100440', 'Peluche Suave Personaje Disney - Juguetería Bebés', 4, 2, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Juguetería Bebés')),
('8401000000000015', '200110', 'Alberca Inflable Familiar - Playa', 4, 2, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Playa')),
('8401000000000016', '300550', 'Árbol Navidad Artificial 1.90m - Navideño', 4, 2, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Navideño')),
('8401000000000017', '100255', 'Carro Control Remoto Todoterreno - Juguetería Niños', 1, 2, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Juguetería Niños')),
('8401000000000018', '100255', 'Cocina de Juguete con Accesorios - Juguetería Niñas', 2, 2, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Juguetería Niñas')),
('8401000000000019', '100990', 'Rompecabezas 1000 piezas Paisaje - Coleccionables', 4, 2, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Coleccionables')),
('8401000000000020', '200110', 'Salvavidas Circular Infantil - Playa', 4, 2, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Playa')),

-- BLOQUE VARIEDADES / HOGAR / PAPELERÍA (Bodega Externa 1 - A003)
('9101000000000021', '8005544', 'Sartén Antiadherente 24cm - Hogar', 8, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Hogar')),
('9101000000000022', '8007722', 'Plancha de Vapor Cerámica - Enseres Menores', 9, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Enseres Menores')),
('9101000000000023', '40011', 'Cuaderno Profesional Raya 100H - Papelería', 5, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Papelería')),
('9101000000000024', '40022', 'Caja de Colores 24 piezas - Papelería', 13, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Papelería')),
('9101000000000025', '90033', 'Toalla Baño Algodón Premium - Blancos', 12, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Blancos')),
('9101000000000026', '80011', 'Licuadora 10 Velocidades - Enseres Menores', 9, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Enseres Menores')),
('9101000000000027', '70055', 'Set de Platos Cerámica 4pzas - Hogar', 8, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Hogar')),
('9101000000000028', '60011', 'Cama para Mascota Mediana - Mascotas', 4, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Mascotas')),
('9101000000000029', '40011', 'Calculadora Científica - Papelería', 16, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Papelería')),
('9101000000000030', '90055', 'Edredón Matrimonial Estampado - Blancos', 12, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Blancos')),

-- BLOQUE PERFUMERÍA / CUIDADO PERSONAL (Bodega Externa 1)
('6301000000000031', '12345', 'Shampoo Control Caspa 1L - Tintes y Shampoos', 16, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Tintes y Shampoos')),
('6301000000000032', '12345', 'Jabón Líquido Corporal 500ml - Cuidado Personal', 7, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Cuidado Personal')),
('6301000000000033', '55667', 'Crema Dental Triple Acción - Belleza', 15, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Belleza')),
('6301000000000034', '88990', 'Secadora de Cabello Profesional - Eléctrico Cuidado Personal', 9, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Eléctrico Cuidado Personal')),
('6301000000000035', '11223', 'Desodorante Roll-on Dama - Cuidado Personal', 15, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Cuidado Personal')),
('6301000000000036', '12345', 'Tinte para Cabello Tono 5.0 - Tintes y Shampoos', 16, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Tintes y Shampoos')),
('6301000000000037', '55667', 'Labial Larga Duración Rojo - Belleza', 15, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Belleza')),
('6301000000000038', '11223', 'Paquete Rastrillos 4pzas - Checkout', 15, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Checkout')),
('6301000000000039', '11223', 'Gel Antibacterial 250ml - Checkout', 7, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Checkout')),
('6301000000000040', '12345', 'Acondicionador Brillo Intenso - Tintes y Shampoos', 16, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Tintes y Shampoos')),

-- BLOQUE DULCERÍA / BEBÉS (Bodega Externa 1 / Externa 2)
('4201000000000041', '101010', 'Bolsa Dulce Surtido 1kg - Dulcería', 16, 4, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Dulcería')),
('4201000000000042', '101010', 'Gomitas Mango Enchilado - Dulcería Granel', 16, 4, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Dulcería Granel')),
('4201000000000043', '101010', 'Paletas Tutsi Pop Bolsa - Dulcería Checkout', 16, 4, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Dulcería Checkout')),
('4201000000000044', '202020', 'Pañales Etapa 3 40pzas - Cuidado del bebé', 4, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Cuidado del bebé')),
('4201000000000045', '202020', 'Toallitas Húmedas Pack 3 - Cuidado del bebé', 4, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Cuidado del bebé')),
('4201000000000046', '202020', 'Biberón Anti-cólicos - Cuidado del bebé', 4, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Cuidado del bebé')),
('4201000000000047', '101010', 'Malvaviscos Cubiertos Chocolate - Dulcería', 16, 4, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Dulcería')),
('4201000000000048', '101010', 'Chocolate Carlos V Caja - Dulcería Checkout', 16, 4, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Dulcería Checkout')),
('4201000000000049', '5001', 'Manta Recibidora Bebé - Bebés Blancos', 4, 3, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Bebés Blancos')),
('4201000000000050', '202020', 'Mordedera de Goma Fría - Cuidado del bebé', 4, 1, (SELECT TOP 1 ID_Departamento FROM Departamento WHERE Nombre_Departamento='Cuidado del bebé'));

-- 1. ENTRADA MASIVA INICIAL (Carga de Proveedor a Bodega)
INSERT INTO Movimientos (ID_Producto, Cantidad, ID_Almacen_Origen, ID_Almacen_Destino, ID_Usuario, ID_Empleado, FUM, ID_Tipo_Movimiento)
SELECT 
    p.ID_Producto, 
    500, 
    (SELECT ID_Almacen FROM Almacenes WHERE Codigo_Almacen = 'PROV'), -- ORIGEN: Proveedor (Ya no es NULL)
    CASE 
        WHEN d.Nombre_Departamento IN ('Juguetería Niños', 'Juguetería Niñas', 'Juguetería Bebés', 'Papelería', 'Playa', 'Navideño') 
        THEN (SELECT ID_Almacen FROM Almacenes WHERE Codigo_Almacen = 'A004')
        ELSE (SELECT ID_Almacen FROM Almacenes WHERE Codigo_Almacen = 'A003')
    END, 
    7, 5, '2025-03-21 08:00:00', 1
FROM Productos p
JOIN Departamento d ON p.ID_Departamento = d.ID_Departamento;

-- 2. BUCLE DE TRASPASOS (Surtido diario durante 1 año)
-- Este se mantiene igual porque el origen ya era una bodega real.
DECLARE @Contador INT = 0;
WHILE @Contador < 300 
BEGIN
    INSERT INTO Movimientos (ID_Producto, Cantidad, ID_Almacen_Origen, ID_Almacen_Destino, ID_Usuario, ID_Empleado, FUM, ID_Tipo_Movimiento)
    SELECT TOP 1
        p.ID_Producto,
        FLOOR(RAND()*(30-5+1))+5, 
        CASE 
            WHEN d.Nombre_Departamento IN ('Juguetería Niños', 'Juguetería Niñas', 'Juguetería Bebés', 'Papelería', 'Playa', 'Navideño') 
            THEN (SELECT ID_Almacen FROM Almacenes WHERE Codigo_Almacen = 'A004')
            ELSE (SELECT ID_Almacen FROM Almacenes WHERE Codigo_Almacen = 'A003')
        END, 
        (SELECT ID_Almacen FROM Almacenes WHERE Codigo_Almacen = 'A001'), 
        CASE WHEN d.Nombre_Departamento LIKE '%Ropa%' THEN 4 WHEN d.Nombre_Departamento LIKE '%Perfumería%' THEN 6 ELSE 5 END, 
        CASE WHEN d.Nombre_Departamento LIKE '%Ropa%' THEN 4 WHEN d.Nombre_Departamento LIKE '%Perfumería%' THEN 7 ELSE 6 END, 
        DATEADD(SECOND, FLOOR(RAND()*31536000), '2025-03-22'), 
        3 
    FROM Productos p
    JOIN Departamento d ON p.ID_Departamento = d.ID_Departamento
    ORDER BY NEWID();

    SET @Contador = @Contador + 1;
END;