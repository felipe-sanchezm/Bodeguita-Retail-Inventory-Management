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
    Nombre_Contacto VARCHAR (MAX) NOT NULL,
    Correo_Contacto VARCHAR (MAX),
    Telefono1_Contacto VARCHAR (16),
    Telefono2_Contacto Varchar (16),
    Estatus_Contacto Bit DEFAULT 1
);

CREATE TABLE Proveedor (
    ID_Proveedor INT PRIMARY KEY IDENTITY(1,1),
    Razon_Social_Proveedor VARCHAR(MAX) NOT NULL,
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
    Salario_Base_Puesto_Empleado DECIMAL,
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
    Password_user VARCHAR (100) NOT NULL UNIQUE,
    ID_Rol INT,
    Estatus_Usuario Bit DEFAULT 1
);

CREATE TABLE Marca_Producto (
    ID_Marca_Producto INT PRIMARY KEY IDENTITY(1,1),
    Nombre_Marca_Producto VARCHAR (MAX) NOT NULL,
    Estatus_Marca_Producto Bit DEFAULT 1
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

CREATE TABLE Movimientos (
    ID_Movimiento INT PRIMARY KEY IDENTITY(1,1),
    ID_Producto INT,
    Cantidad INT NOT NULL,
    ID_Almacen_Origen INT NOT NULL,
    ID_Almacen_Destino INT NOT NULL,
    ID_Usuario INT NOT NULL,
    ID_Empleado INT NOT NULL,
    FUM DATE DEFAULT GETDATE(),
    ID_Tipo_Movimiento INT NOT NULL,
    Comentario VARCHAR (MAX) DEFAULT NULL
);

CREATE TABLE Productos (
    ID_Producto INT PRIMARY KEY IDENTITY(1,1),
    SKU_Producto VARCHAR(20) NOT NULL,
    Material_Producto INT,
    Descripcion_Producto VARCHAR(MAX) NOT NULL,
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
    -- Esta regla evita que tengas dos renglones del mismo producto en el mismo almacén
    CONSTRAINT UQ_Producto_Almacen UNIQUE (ID_Producto, ID_Almacen)
);

--================
--LLAVES FORANEAS
--================
--Relaciones de la tabla Ubicaciones_Depto
ALTER TABLE Ubicaciones_Depto
ADD CONSTRAINT FK_Ubicaciones_Departamento
FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID_Departamento);

ALTER TABLE Ubicaciones_Depto
ADD CONSTRAINT FK_Ubicaciones_Almacen
FOREIGN KEY (ID_Almacen) REFERENCES Almacenes(ID_Almacen);

--Relaciones de la tabla Contacto_Proveedor
ALTER TABLE Contacto_Proveedor
ADD CONSTRAINT FK_ContactoProveedor_Proveedor
FOREIGN KEY(ID_Proveedor) REFERENCES Proveedor(ID_Proveedor);

ALTER TABLE Contacto_Proveedor
ADD CONSTRAINT FK_ContactoProveedor_Contacto
FOREIGN KEY(ID_Contacto) REFERENCES Contacto(ID_Contacto);

--Relaciones de la tabla Movimientos
ALTER TABLE Movimientos
ADD CONSTRAINT FK_Movimientos_Producto
FOREIGN KEY(ID_Producto) REFERENCES Productos(ID_Producto);

ALTER TABLE Movimientos
ADD CONSTRAINT FK_Movimientos_AlmacenOrigen
FOREIGN KEY(ID_Almacen_Origen) REFERENCES Almacenes(ID_Almacen);

ALTER TABLE Movimientos
ADD CONSTRAINT FK_Movimientos_AlmacenDestino
FOREIGN KEY(ID_Almacen_Destino) REFERENCES Almacenes(ID_Almacen);

ALTER TABLE Movimientos
ADD CONSTRAINT FK_Movimientos_Usuarios
FOREIGN KEY(ID_Usuario) REFERENCES Usuario(ID_Usuario);

ALTER TABLE Movimientos
ADD CONSTRAINT FK_Movimientos_Empleado
FOREIGN KEY(ID_Empleado) REFERENCES EMpleado(ID_Empleado);

ALTER TABLE Movimientos
ADD CONSTRAINT FK_Movimientos_TipoMovimiento
FOREIGN KEY(ID_Tipo_Movimiento) REFERENCES Tipo_Movimiento(ID_Tipo_Movimiento);

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

-- Relaciones de la tabla Empleado
ALTER TABLE Empleado
ADD CONSTRAINT FK_Empleado_Puesto FOREIGN KEY (ID_Puesto) 
REFERENCES Puesto_Empleado(ID_Puesto_Empleado);

ALTER TABLE Empleado
ADD CONSTRAINT FK_Empleado_Estatus FOREIGN KEY (ID_Estatus) 
REFERENCES Estatus_Empleado(ID_Estatus_Empleado);

-- Relación de la tabla Usuario
ALTER TABLE Usuario
ADD CONSTRAINT FK_Usuario_Rol FOREIGN KEY (ID_Rol) 
REFERENCES Rol_Usuario(ID_Rol_Usuario);

-- Relaciones de la tabla Existencias
ALTER TABLE Existencias
ADD CONSTRAINT FK_Existencias_Producto 
FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto);

ALTER TABLE Existencias
ADD CONSTRAINT FK_Existencias_Almacen 
FOREIGN KEY (ID_Almacen) REFERENCES Almacenes(ID_Almacen);
