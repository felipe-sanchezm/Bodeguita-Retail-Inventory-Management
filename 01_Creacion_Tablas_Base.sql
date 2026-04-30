--================
--TABLAS MAESTRAS
--================
CREATE TABLE Almacenes (
    ID_Almacen INT Primary Key Identity(1,1),
    Codigo_Almacen VARCHAR(6),
    Nombre_Almacen VARCHAR(100),
    Estatus_Almacen Bit DEFAULT 1
);

CREATE TABLE Contacto (
    ID_Contacto INT PRIMARY KEY IDENTITY(1,1),
    Nombre_Contacto VARCHAR (255) NOT NULL,
    Correo_Contacto VARCHAR (100),
    Telefono1_Contacto VARCHAR (16),
    Telefono2_Contacto Varchar (16),
    Estatus_Contacto Bit DEFAULT 1
);

CREATE TABLE Proveedor (
    ID_Proveedor INT PRIMARY KEY IDENTITY(1,1),
    Razon_Social_Proveedor VARCHAR(100) NOT NULL,
    RFC_Proveedor VARCHAR (20) NOT NULL,
    Estatus_Proveedor Bit DEFAULT 1
);

CREATE TABLE Estatus_Empleado (
    ID_Estatus_Empleado INT PRIMARY KEY IDENTITY(1,1),
    Descripcion_Estatus_Empleado VARCHAR (50) NOT NULL
);

CREATE TABLE Puesto_Empleado (
    ID_Puesto_Empleado INT PRIMARY KEY IDENTITY(1,1),
    Nombre_Puesto_Empleado VARCHAR(100) NOT NULL,
    Salario_Base_Puesto_Empleado DECIMAL(10,2),
    Estatus_Puesto_Empleado Bit DEFAULT 1
);

CREATE TABLE Empleado (
    ID_Empleado INT PRIMARY KEY IDENTITY(1,1),
    Nombre_Empleado VARCHAR (100)NOT NULL,
    Apellido_Paterno_Empleado VARCHAR(100) NOT NULL,
    Apellido_Materno_Empleado VARCHAR(100),
    ID_Puesto INT,
    Fecha_Nacimiento_Empleado DATE,
    Fecha_Ingreso_Empleado DATE,
    ID_Estatus INT
);

CREATE TABLE Rol_Usuario (
    ID_Rol_Usuario INT PRIMARY KEY IDENTITY(1,1),
    Descripcion_Rol_Usuario VARCHAR (100) NOT NULL,
    Estatus_Rol_Usuario Bit DEFAULT 1
);

CREATE TABLE Departamento (
    ID_Departamento INT PRIMARY KEY IDENTITY(1,1),
    Nombre_Departamento VARCHAR(50) NOT NULL,
    Estatus_Departamento Bit DEFAULT 1
);

CREATE TABLE Tipo_Movimiento (
    ID_Tipo_Movimiento INT PRIMARY KEY IDENTITY(1,1),
    Nombre_Tipo_Movimiento VARCHAR (50) NOT NULL
);

CREATE TABLE Usuario (
    ID_Usuario INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR (100) NOT NULL UNIQUE,
    Password_user VARCHAR (100) NOT NULL,
    ID_Rol INT,
    Estatus_Usuario Bit DEFAULT 1
);

CREATE TABLE Marca_Producto (
    ID_Marca_Producto INT PRIMARY KEY IDENTITY(1,1),
    Nombre_Marca_Producto VARCHAR (255) NOT NULL,
    Estatus_Marca_Producto Bit DEFAULT 1
);

CREATE TABLE Estatus_Transito (
	ID_Estatus_Transito INT PRIMARY KEY IDENTITY(1,1),
	Descripcion_Estatus_Transito VARCHAR(20) NOT NULL
);

--=====================================
--TABLAS CON RELACIONES A OTRAS TABLAS
--=====================================

CREATE TABLE Ubicaciones_Depto (
    ID_Departamento INT,
    ID_Almacen INT
);

CREATE TABLE Contacto_Proveedor (
    ID_Proveedor INT,
    ID_Contacto INT,
    Estatus_Contacto_Proveedor Bit DEFAULT 1
);

CREATE TABLE Productos (
    ID_Producto INT PRIMARY KEY IDENTITY(1,1),
    SKU_Producto VARCHAR(20) NOT NULL,
    Material_Producto INT,
    Descripcion_Producto VARCHAR(MAX) NOT NULL,
    Costo_Unitario DECIMAL (18,2) NOT NULL DEFAULT 0,
    ID_Marca INT,
    ID_Proveedor INT,
    ID_Departamento INT
);

CREATE TABLE Existencias (
    ID_Existencia INT PRIMARY KEY IDENTITY(1,1),
    ID_Producto INT NOT NULL,
    ID_Almacen INT NOT NULL,
    Cantidad_Actual INT DEFAULT 0,
    Stock_Minimo INT DEFAULT 0,
    Stock_Maximo INT DEFAULT 0,
    Ultima_Actualizacion DATETIME DEFAULT GETDATE(),
);

CREATE TABLE Transferencias (
	ID_Transferencia INT PRIMARY KEY IDENTITY(1,1),
	ID_Almacen_Origen INT NOT NULL,
	ID_Almacen_Destino INT NOT NULL,
	ID_Estatus INT NOT NULL,
    ID_Usuario INT NOT NULL,
    ID_Empleado INT NOT NULL,
    ID_Tipo_Movimiento INT NOT NULL,
	FUM DATETIME DEFAULT GETDATE()
);

CREATE TABLE Transferencias_Detalle (
	ID_Transferencias_Detalle INT PRIMARY KEY IDENTITY(1,1),
	ID_Transferencia INT NOT NULL,
	ID_Producto INT NOT NULL,
	Cantidad INT NOT NULL,
	Costo_Unitario_Historico DECIMAL(18,2) NULL CHECK (Costo_Unitario_Historico >= 0),
	FUM DATETIME DEFAULT GETDATE(),
	Subtotal AS (Cantidad * Costo_Unitario_Historico)
);


--================
--LLAVES FORANEAS
--================
/*
    *******************
    UBICACIONES_DEPTO
    *******************
*/
--Relaciones de la tabla Ubicaciones_Depto
ALTER TABLE Ubicaciones_Depto
ADD CONSTRAINT FK_Ubicaciones_Departamento
FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID_Departamento);

ALTER TABLE Ubicaciones_Depto
ADD CONSTRAINT FK_Ubicaciones_Almacen
FOREIGN KEY (ID_Almacen) REFERENCES Almacenes(ID_Almacen);

/*
    *******************
    CONTACTO_PROVEEDOR
    *******************
*/
--Relaciones de la tabla Contacto_Proveedor
ALTER TABLE Contacto_Proveedor
ADD CONSTRAINT FK_ContactoProveedor_Proveedor
FOREIGN KEY(ID_Proveedor) REFERENCES Proveedor(ID_Proveedor);

ALTER TABLE Contacto_Proveedor
ADD CONSTRAINT FK_ContactoProveedor_Contacto
FOREIGN KEY(ID_Contacto) REFERENCES Contacto(ID_Contacto);

/*
    *******************
        PRODUCTOS
    *******************
*/
--Relaciones de la tabla Productos
ALTER TABLE Productos
ADD CONSTRAINT FK_Productos_MarcaProducto
FOREIGN KEY(ID_Marca) REFERENCES Marca_Producto(ID_Marca_Producto);

ALTER TABLE Productos
ADD CONSTRAINT FK_Productos_Proveedor
FOREIGN KEY(ID_Proveedor) REFERENCES Proveedor(ID_Proveedor);

ALTER TABLE Productos
ADD CONSTRAINT FK_Productos_Departamento
FOREIGN KEY(ID_Departamento) REFERENCES Departamento(ID_Departamento)

/*
    *******************
        EMPLEADO
    *******************
*/
-- Relaciones de la tabla Empleado
ALTER TABLE Empleado
ADD CONSTRAINT FK_Empleado_Puesto FOREIGN KEY (ID_Puesto) 
REFERENCES Puesto_Empleado(ID_Puesto_Empleado);

ALTER TABLE Empleado
ADD CONSTRAINT FK_Empleado_Estatus FOREIGN KEY (ID_Estatus) 
REFERENCES Estatus_Empleado(ID_Estatus_Empleado);

/*
    *****************
        USUARIO
    *****************
*/
-- Relación de la tabla Usuario
ALTER TABLE Usuario
ADD CONSTRAINT FK_Usuario_Rol FOREIGN KEY (ID_Rol) 
REFERENCES Rol_Usuario(ID_Rol_Usuario);

/*
    *******************
        EXISTENCIAS
    *******************
*/
-- Relaciones de la tabla Existencias
ALTER TABLE Existencias
ADD CONSTRAINT FK_Existencias_Producto 
FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto);

ALTER TABLE Existencias
ADD CONSTRAINT FK_Existencias_Almacen 
FOREIGN KEY (ID_Almacen) REFERENCES Almacenes(ID_Almacen);

/*
    *********************
        TRANSFERENCIAS
    *********************
*/
--Relacion entre Transferencias y Almacenes para el Origen
ALTER TABLE Transferencias
ADD CONSTRAINT FK_Transferencias_AlmacenOrigen
FOREIGN KEY (ID_Almacen_Origen) REFERENCES Almacenes (ID_Almacen);

--Relacion entre Transferencias y Almacenes para el Destino
ALTER TABLE Transferencias
ADD CONSTRAINT FK_Transferencias_AlmacenDestino
FOREIGN KEY (ID_Almacen_Destino) REFERENCES Almacenes (ID_ALmacen);

--Relacion entre Transferencias y Estatus_Transito
ALTER TABLE Transferencias
ADD CONSTRAINT FK_Transferencias_EstatusTransito
FOREIGN KEY (ID_Estatus) REFERENCES Estatus_Transito (ID_Estatus_Transito);

--Relacion entre Transferencias y Tipo_Movimiento
ALTER TABLE Transferencias
ADD CONSTRAINT FK_Transferencias_TipoMovimiento
FOREIGN KEY (ID_Tipo_Movimiento) REFERENCES Tipo_Movimiento(ID_Tipo_Movimiento);

--Relacion entre Transferencias y Usuario
ALTER TABLE Transferencias
ADD CONSTRAINT FK_Transferencias_Usuario
FOREIGN KEY (ID_Usuario) REFERENCES Usuario (ID_Usuario);

--Relacion entre Transferencias y Empleado
ALTER TABLE Transferencias
ADD CONSTRAINT FK_Transferencias_Empleado
FOREIGN KEY (ID_Empleado) REFERENCES Empleado (ID_Empleado);

/*
    ***********************
    TRANSFERENCIAS_DETALLE
    ***********************
*/
--Relacion entre Transferencias_Detalle y Transferencias
ALTER TABLE Transferencias_Detalle
ADD CONSTRAINT FK_TransferenciasDetalle_Transferencia
FOREIGN KEY (ID_Transferencia) REFERENCES Transferencias (ID_Transferencia);

--Relacion entre Transferencias_Detalle y Productos
ALTER TABLE Transferencias_Detalle
ADD CONSTRAINT FK_TransferenciasDetalle_Productos
FOREIGN KEY (ID_Producto) REFERENCES Productos (ID_Producto);


--==================
--REGLAS ESPECIALES
--==================

--Restricción para que no se envíen a si mismo
ALTER TABLE Transferencias
ADD CONSTRAINT CK_Origen_Destino_Diferente CHECK (ID_Almacen_Origen <> ID_Almacen_Destino);

--Restricción que impide que se registren valores negativos en el costo_unitario_historico
ALTER TABLE Transferencias_Detalle
ADD CONSTRAINT CK_Costo_Unitario_Historico_Positivo 
CHECK (Costo_Unitario_Historico >= 0);

--Candado para evitar que un mismo producto exista en diferentes almacenes
ALTER TABLE Existencias
ADD CONSTRAINT UQ_Existencias_Producto_Almacen 
UNIQUE (ID_Producto, ID_Almacen);

--Restriccion que asegura que no se repita el SKU de un producto en otros
ALTER TABLE Productos ADD CONSTRAINT UQ_Productos_SKU UNIQUE (SKU_Producto);
