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

-- 6. Estatus de Transito
INSERT INTO Estatus_Transito (Descripcion_Estatus_Transito) VALUES
('Pendiente Validar'),
('En Camino'),
('Recibido en Tienda'),
('Cancelado'),
('Demorado');


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
INSERT INTO Productos (SKU_Producto, Material_Producto, Descripcion_Producto, Costo_Unitario, ID_Marca, ID_Proveedor, ID_Departamento)
VALUES 
-- DEPT 1: CORSETERÍA Y LENCERÍA
('7501000000000001', 10000001, 'Bustier Encaje Negro V1', 550.00, 1, 3, 1),
('7501000000000002', 10000002, 'Bata de Seda Rosa', 890.00, 1, 3, 1),
('7501000000000003', 10000003, 'Pack 3 Panties Algodon', 249.00, 1, 3, 1),
('7501000000000004', 10000004, 'Bra Strapless Basico', 420.00, 1, 3, 1),
('7501000000000005', 10000005, 'Corset Reductor Pro', 680.00, 1, 3, 1),
('7501000000000006', 10000006, 'Pijama Satinada 2 pz', 720.00, 1, 3, 1),
('7501000000000007', 10000007, 'Faja Alta Compresion', 950.00, 1, 3, 1),
('7501000000000008', 10000008, 'Baby Doll Encaje Rojo', 480.00, 1, 3, 1),
('7501000000000009', 10000009, 'Body de Malla Negro', 310.00, 1, 3, 1),
('7501000000000010', 10000010, 'Liguero con Medias Red', 199.00, 1, 3, 1),

-- DEPT 7: DAMA
('7507000000000001', 70000001, 'Vestido Noche Corte Sirena', 1850.00, 2, 3, 7),
('7507000000000002', 70000002, 'Blazer Ejecutivo Marino', 1200.00, 2, 3, 7),
('7507000000000003', 70000003, 'Jeans Levanta Pompa Mezclilla', 650.00, 2, 3, 7),
('7507000000000004', 70000004, 'Blusa Gasa Floral', 380.00, 2, 3, 7),
('7507000000000005', 70000005, 'Falda Midi Plisada', 520.00, 2, 3, 7),
('7507000000000006', 70000006, 'Sueter Punto Oversize', 450.00, 2, 3, 7),
('7507000000000007', 70000007, 'Abrigo de Panio Invierno', 2300.00, 2, 3, 7),
('7507000000000008', 70000008, 'Top Satinado Tirantes', 290.00, 2, 3, 7),
('7507000000000009', 70000009, 'Pantalon Vestir Recto', 780.00, 2, 3, 7),
('7507000000000010', 70000010, 'Chaleco Acolchado Dama', 1100.00, 2, 3, 7),

-- DEPT 15: CABALLEROS INTERIOR
('7515000000000001', 15000001, 'Boxer Ajustado Algodon', 180.00, 3, 3, 15),
('7515000000000002', 15000002, 'Pack 3 Camisetas Cuello V', 450.00, 3, 3, 15),
('7515000000000003', 15000003, 'Bermuda para Dormir Gris', 320.00, 3, 3, 15),
('7515000000000004', 15000004, 'Bata de Banio Microfibra', 650.00, 3, 3, 15),
('7515000000000005', 15000005, 'Calcetin Ejecutivo Negro', 85.00, 3, 3, 15),
('7515000000000006', 15000006, 'Boxer Brief Deportivo', 220.00, 3, 3, 15),
('7515000000000007', 15000007, 'Tirantes Ajustables Elasticos', 290.00, 3, 3, 15),
('7515000000000008', 15000008, 'Pijama Franela Cuadros', 580.00, 3, 3, 15),
('7515000000000009', 15000009, 'Calzoncillo Clasico Blanco', 120.00, 3, 3, 15),
('7515000000000010', 15000010, 'Calceta Termica Invierno', 150.00, 3, 3, 15),

-- DEPT 26: ENSERES MENORES
('7526000000000001', 26000001, 'Freidora de Aire 4.5L', 1650.00, 4, 1, 26),
('7526000000000002', 26000002, 'Cafetera Goteo 12 Tazas', 590.00, 4, 1, 26),
('7526000000000003', 26000003, 'Tostadora Acero Inox', 420.00, 4, 1, 26),
('7526000000000004', 26000004, 'Batidora Mano 5 Vel', 350.00, 4, 1, 26),
('7526000000000005', 26000005, 'Exprimidor Citricos Elec', 280.00, 4, 1, 26),
('7526000000000006', 26000006, 'Olla Electrica Lenta', 1100.00, 4, 1, 26),
('7526000000000007', 26000007, 'Waflera Antiadherente', 499.00, 4, 1, 26),
('7526000000000008', 26000008, 'Parrilla Elec 2 Quemadores', 850.00, 4, 1, 26),
('7526000000000009', 26000009, 'Hervidor Agua Elec 1.7L', 390.00, 4, 1, 26),
('7526000000000010', 26000010, 'Sandwichera Prensa Grill', 410.00, 4, 1, 26),

-- DEPT 28: HOGAR
('7528000000000001', 28000001, 'Juego Sartenes Antiadherente', 1200.00, 5, 1, 28),
('7528000000000002', 28000002, 'Set Cuchillos Profesionales', 850.00, 5, 1, 28),
('7528000000000003', 28000003, 'Cesta Ropa Sucia Tejida', 350.00, 5, 1, 28),
('7528000000000004', 28000004, 'Espejo Pared Marco Madera', 1450.00, 5, 1, 28),
('7528000000000005', 28000005, 'Lampara Escritorio LED', 420.00, 5, 1, 28),
('7528000000000006', 28000006, 'Cuadro Decorativo Moderno', 600.00, 5, 1, 28),
('7528000000000007', 28000007, 'Alfombra Sala 1.5x2mts', 2100.00, 5, 1, 28),
('7528000000000008', 28000008, 'Reloj Pared Silencioso', 380.00, 5, 1, 28),
('7528000000000009', 28000009, 'Organizador Zapatos 10 Niv', 550.00, 5, 1, 28),
('7528000000000010', 28000010, 'Cortina Blackout Gris', 720.00, 5, 1, 28),

-- DEPT 31: ELECTRÓNICA
('7531000000000001', 31000001, 'Smart TV 55 Pulgadas 4K', 8900.00, 6, 1, 31),
('7531000000000002', 31000002, 'Laptop 15.6 Pulgadas 8GB', 12500.00, 6, 1, 31),
('7531000000000003', 31000003, 'Smartphone 128GB Unlocked', 4500.00, 6, 1, 31),
('7531000000000004', 31000004, 'Consola Videojuegos 512GB', 7200.00, 6, 1, 31),
('7531000000000005', 31000005, 'Bocina Alexa Echo Dot', 1100.00, 6, 1, 31),
('7531000000000006', 31000006, 'Tablet 10 Pulgadas Estudiante', 3200.00, 6, 1, 31),
('7531000000000007', 31000007, 'Camara Seguridad WiFi', 850.00, 6, 1, 31),
('7531000000000008', 31000008, 'Mouse Inalambrico Basico', 250.00, 6, 1, 31),
('7531000000000009', 31000009, 'Teclado Mecanico RGB', 1400.00, 6, 1, 31),
('7531000000000010', 31000010, 'Cable HDMI 4K 2mts', 180.00, 6, 1, 31),

-- DEPT 33: ZAPATERÍA
('7533000000000001', 33000001, 'Tenis Correr Hombre', 1600.00, 7, 1, 33),
('7533000000000002', 33000002, 'Bota Industrial Casquillo', 1250.00, 7, 1, 33),
('7533000000000003', 33000003, 'Zapato Vestir Piel', 1400.00, 7, 1, 33),
('7533000000000004', 33000004, 'Sandalias Playa Casual', 320.00, 7, 1, 33),
('7533000000000005', 33000005, 'Zapatilla Tacon Dama', 890.00, 7, 1, 33),
('7533000000000006', 33000006, 'Mocasin Gamuza Joven', 750.00, 7, 1, 33),
('7533000000000007', 33000007, 'Tenis Lona Clasicos', 550.00, 7, 1, 33),
('7533000000000008', 33000008, 'Bota Lluvia Infantil', 420.00, 7, 1, 33),
('7533000000000009', 33000009, 'Pantuflas Descanso Felpa', 190.00, 7, 1, 33),
('7533000000000010', 33000010, 'Botin Casual Gamuza', 1150.00, 7, 1, 33),

-- DEPT 37: JUGUETERÍA NIÑOS
('7537000000000001', 37000001, 'Set Construccion Bloques', 1200.00, 8, 2, 37),
('7537000000000002', 37000002, 'Pista Carreras Triple Loop', 1850.00, 8, 2, 37),
('7537000000000003', 37000003, 'Figura Accion Superheroe', 350.00, 8, 2, 37),
('7537000000000004', 37000004, 'Lanza Dardos Espuma', 620.00, 8, 2, 37),
('7537000000000005', 37000005, 'Coche Control Remoto Offroad', 950.00, 8, 2, 37),
('7537000000000006', 37000006, 'Dinosaurio T-Rex Sonidos', 480.00, 8, 2, 37),
('7537000000000007', 37000007, 'Telescopio Astronomo Junior', 1100.00, 8, 2, 37),
('7537000000000008', 37000008, 'Set Quimica Experimentos', 750.00, 8, 2, 37),
('7537000000000009', 37000009, 'Pelota Futbol Profesional', 450.00, 8, 2, 37),
('7537000000000010', 37000010, 'Robot Inteligente Programable', 2100.00, 8, 2, 37),

-- DEPT 41: PAPELERÍA
('7541000000000001', 41000001, 'Caja Hojas Blanca 5000pz', 1100.00, 9, 4, 41),
('7541000000000002', 41000002, 'Set Marcadores Arte 24pz', 480.00, 9, 4, 41),
('7541000000000003', 41000003, 'Libreta Profesional Pasta Dura', 180.00, 9, 4, 41),
('7541000000000004', 41000004, 'Calculadora Cientifica Pro', 650.00, 9, 4, 41),
('7541000000000005', 41000005, 'Mochila Escolar Ergonomica', 950.00, 9, 4, 41),
('7541000000000006', 41000006, 'Set Geometria Metal', 120.00, 9, 4, 41),
('7541000000000007', 41000007, 'Agenda Ejecutiva 2026', 350.00, 9, 4, 41),
('7541000000000008', 41000008, 'Engrapadora Uso Pesado', 420.00, 9, 4, 41),
('7541000000000009', 41000009, 'Pack Boligrafos Tinta Gel', 250.00, 9, 4, 41),
('7541000000000010', 41000010, 'Organizador Escritorio Malla', 290.00, 9, 4, 41),

-- DEPT 42: DULCERÍA
('7542000000000001', 42000001, 'Caja Chocolate Surtido 1kg', 650.00, 10, 4, 42),
('7542000000000002', 42000002, 'Bolsa Gomitas Frutales 500g', 120.00, 10, 4, 42),
('7542000000000003', 42000003, 'Pack 24 Paletas Caramelo', 180.00, 10, 4, 42),
('7542000000000004', 42000004, 'Estuche Dulce Regional 2kg', 890.00, 10, 4, 42),
('7542000000000005', 42000005, 'Malvaviscos Cubiertos Choco', 240.00, 10, 4, 42),
('7542000000000006', 42000006, 'Caja Mazapan Grande 30pz', 210.00, 10, 4, 42),
('7542000000000007', 42000007, 'Canasta Navidenia Dulces', 1450.00, 10, 4, 42),
('7542000000000008', 42000008, 'Dulce Tamarindo Picante 1kg', 320.00, 10, 4, 42),
('7542000000000009', 42000009, 'Set Regalo Chocolates Finos', 1100.00, 10, 4, 42),
('7542000000000010', 42000010, 'Bolsa Dulce Checkout Mix', 55.00, 10, 4, 42);
*/