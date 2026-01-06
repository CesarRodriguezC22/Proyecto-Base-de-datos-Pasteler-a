/*
PROYECTO FINAL BASE DE DATOS
EQUIPO:
- Reyes Pérez Jared Everardo.
- Santos Jiménez Grecia Amairani.
- De Groot Morales Estefania.
- César Enrique Rodríguez Cantoral.
Descripción: BASE DE DATOS DE LA PASTELERIA "Los Michistemas".
Fecha: 2-12-2024
*/
CREATE DATABASE PasteleriaLosMichistemas;
GO
USE PasteleriaLosMichistemas;
GO
--SE HAN EJECUTADO ABSOLUTAMENTE TODAS LAS LINEAS 2-12-24
/* CREACIÓN DE ESQUEMAS */
CREATE SCHEMA Administracion;
GO
CREATE SCHEMA Pasteles;
GO
/* CREACIÓN DE TABLAS */
-- Crear tabla "Clientes" --
CREATE TABLE Administracion.Clientes(
IdCliente int PRIMARY KEY IDENTITY not null,
NombreCliente Varchar(25) Not Null,
PrimerApellidoCliente Varchar(25) Not Null,
SegundoApellidoCliente Varchar(25) Null,
Telefono Varchar(12) Not Null,
Calle Varchar(50) Not Null,
Numero Varchar(5) Not Null,
Colonia Varchar(30) Not Null,
CorreoElectronico Varchar(30) Not Null
)
-- Crear tabla "Cargos" --
CREATE TABLE Administracion.Cargos(
IdCargo int PRIMARY KEY IDENTITY not null,
NombreCargo Varchar(50) Not Null
)
-- Crear tabla "Empleados" --
CREATE TABLE Administracion.Empleados(
IdEmpleado int PRIMARY KEY IDENTITY not null,
NombreEmp Varchar(50) Not Null,
PrimerApellidoEmp Varchar(50) Not Null,
SegundoApellidoEmp Varchar(50) Null,
Calle Varchar(50) Not Null,
Numero Varchar(5) Not Null,
Colonia Varchar(30) Not Null,
Telefono Varchar(12) Not Null,
FechaContratacion Date DEFAULT GETDATE(),
FechaNacimiento Date Not Null,
Sueldo Money Not Null,
Puesto int Not Null Foreign Key REFERENCES Administracion.Cargos(IdCargo)
)
-- Crear tabla "Proveedores"
CREATE TABLE Administracion.Proveedores(
IdProveedor int PRIMARY KEY IDENTITY not null,
NombreEmpresa Varchar(50) Not Null,
NombreContacto Varchar(50) Not Null,
PrimerApellidoContacto Varchar(50) Null,
SegundoApellidoContacto Varchar(50) Null,
Calle Varchar(50) Not Null,
Numero Varchar(5) Not Null,
Colonia Varchar(30) Not Null,
TelefonoProv Varchar(12) Not Null,
)
-- Crear tabla " Pasteles.Ingredientes"
CREATE TABLE Pasteles.Ingredientes(
IdIngrediente int IDENTITY Primary Key not null,
NombreProd varchar(50) Not Null,
UnidadMedida varchar(10) Not Null,
PrecioUnitario money Not Null
)
-- Crear tabla " Pasteles.Inventario"
CREATE TABLE Pasteles.Inventario(
IdIngrediente int Not Null Foreign Key REFERENCES Pasteles.Ingredientes(IdIngrediente)
unique,
CantidadStock float not null
)
-- Crear tabla para los panes posibles de cada pastel --
CREATE TABLE Pasteles.Panes(
IdPan int IDENTITY Primary Key not null,
Nombre varchar(30) Not Null,
Descripcion varchar(75) Null,
)
CREATE TABLE Pasteles.IngredientesDePan(
IdPan int Foreign Key REFERENCES Pasteles.Panes(IdPan),
IdIngrediente int Foreign Key REFERENCES Pasteles.Ingredientes(IdIngrediente)
)
-- Crear tabla para las coberturas posibles de cada pastel --
CREATE TABLE Pasteles.Coberturas(
IdCobertura int PRIMARY KEY IDENTITY,
Nombre varchar(30) Not Null,
Descripcion varchar(75) null
)
CREATE TABLE Pasteles.IngredientesDeCobertura(
IdCobertura int Foreign Key REFERENCES Pasteles.Coberturas(IdCobertura),
IdIngrediente int Foreign Key REFERENCES Pasteles.Ingredientes(IdIngrediente)
)
-- Crear tabla para los rellenos posibles de cada pastel --
CREATE TABLE Pasteles.Rellenos(
IdRelleno int IDENTITY Primary Key not null,
Nombre varchar(30) Not Null,
Descripcion varchar(75) Null,
)
CREATE TABLE Pasteles.IngredientesDeRelleno(
IdRelleno int Foreign Key REFERENCES Pasteles.Rellenos(IdRelleno),
IdIngrediente int Foreign Key REFERENCES Pasteles.Ingredientes(IdIngrediente)
)
-- Crear tabla para las decoraciones posibles de cada pastel --
CREATE TABLE Pasteles.Decoraciones(
IdDecoracion int IDENTITY Primary Key not null,
Nombre varchar(30) Not Null,
Descripcion varchar(75) Null,
)
CREATE TABLE Pasteles.IngredientesDeDecoraciones(
IdDecoracion int Foreign Key REFERENCES Pasteles.Decoraciones(IdDecoracion),
IdIngrediente int Foreign Key REFERENCES Pasteles.Ingredientes(IdIngrediente)
)
-- Crear tabla para los distintos tipos de pasteles en venta --
CREATE TABLE Pasteles.TiposPastel(
IdTipoPastel int PRIMARY KEY IDENTITY,
Nombre varchar(30) Not Null,
IdCobertura INT Not null FOREIGN KEY REFERENCES Pasteles.Coberturas(IdCobertura),
IdPan INT Not null FOREIGN KEY REFERENCES Pasteles.Panes(IdPan)
)
-- Crear tablas para los tamaños de los pasteles
CREATE TABLE Pasteles.TamañosPastel(
IdTamaño int PRIMARY KEY IDENTITY,
Nombre varchar(30) Not Null,
Porciones float Not Null CHECK(Porciones > 0)
)
CREATE TABLE Pasteles.Pasteles(
IdPastel int PRIMARY KEY IDENTITY,
IdTipoPastel int Foreign Key REFERENCES Pasteles.TiposPastel(IdTipoPastel) Not Null,
IdTamaño int Foreign Key REFERENCES Pasteles.TamañosPastel(IdTamaño) Not Null,
Precio Money Not Null
)
-- Crear tablas para tomar en cuenta múltiples rellenos y decoraciones
CREATE TABLE Pasteles.RellenosIncluidos(
IdTipoPastel int Foreign Key REFERENCES Pasteles.TiposPastel(IdTipoPastel),
IdRelleno int Foreign Key REFERENCES Pasteles.Rellenos(IdRelleno)
)
CREATE TABLE Pasteles.DecoracionesIncluidas(
IdTipoPastel int Foreign Key REFERENCES Pasteles.TiposPastel(IdTipoPastel),
IdDecoracion int Foreign Key REFERENCES Pasteles.Decoraciones(IdDecoracion)
)
-- Crear tabla "Administracion.Pedidos" --
CREATE TABLE Administracion.Pedidos(
IdPedido int IDENTITY PRIMARY KEY,
FechaPedido Date DEFAULT GETDATE(),
FechaEntregaPedido Date,
EstadoDelPedido Varchar(25) Not Null CHECK(EstadoDelPedido
IN('Entregado','Pendiente','Cancelado')),
IdCliente int Not Null FOREIGN KEY REFERENCES Administracion.Clientes(IdCliente),
IdEmpleado int Not Null FOREIGN KEY REFERENCES
Administracion.Empleados(IdEmpleado)
)
-- Crear tabla para los detalles de los pedidos --
CREATE TABLE Administracion.PedidoDetalles(
IdPedido int Not Null Foreign Key REFERENCES Administracion.Pedidos(IdPedido),
IdPastel int Not Null Foreign Key REFERENCES Pasteles.Pasteles(IdPastel),
NumPisos INT Not null CHECK(NumPisos BETWEEN 1 AND 3),
ObservacionesPastel VARCHAR(75)
)
-- Crear tabla "Administracion.Ventas" --
CREATE TABLE Administracion.Ventas(
IdPago int IDENTITY Not Null PRIMARY KEY,
IdPedido int Not Null Foreign Key REFERENCES Administracion.Pedidos(IdPedido),
MetodoPago Varchar(15) Null,
Monto Money Not Null CHECK(Monto > 0),
FechaVenta Date Default GETDATE()
)
/* INSERCIÓN DE DATOS */
--Clientes
INSERT INTO Administracion.Clientes (NombreCliente, PrimerApellidoCliente,
SegundoApellidoCliente, Telefono, Calle, Numero, Colonia, CorreoElectronico)
VALUES('Alberto', 'Pérez', 'López', '5566778899', 'Av. Siempre Viva', '123', 'Centro',
'juan.perez@gmail.com'),
('Jhoselin', 'Gómez', 'Nolasco', '5588997766', 'Calle Olmo', '45', 'Las Flores',
'maria.gomez@yahoo.com'),
('Ángel', 'Kauil', NULL, '5599887766', 'Calle Pino', '89', 'La Esperanza',
'carlos.santos@hotmail.com');
INSERT INTO Administracion.Clientes (NombreCliente, PrimerApellidoCliente,
SegundoApellidoCliente, Telefono, Calle, Numero, Colonia, CorreoElectronico)
VALUES('Sandra', 'Morales', 'García', '1122334455', 'Calle Tela', '87', 'Fidel Velásquez',
'sandramorales@gmail.com'),
('Noe', 'Maglah', NULL, '1122334455', 'Calle Kirichná', '30', 'Payo Obispo',
'noe.maglah@outlook.com'),
('Jacobo', 'Vázquez','López', '1122334455', 'Av. Maxuxac', '15', 'Bugambilias',
'yeicob01@gmail.com');
--Cargos
INSERT INTO Administracion.Cargos (NombreCargo)
VALUES('Cajero'),
('Repostero'),
('Gerente'),
('Repartidor')
--Empleados
INSERT INTO Administracion.Empleados (NombreEmp, PrimerApellidoEmp, SegundoApellidoEmp,
Calle, Numero, Colonia, Telefono, FechaNacimiento, Sueldo, Puesto)
VALUES('Dana', 'Martínez', NULL, 'Av. Primavera', '34', 'Centro', '5544332211', '1990-05-15',
12000.00, 2),
('David', 'Duarte', 'Rojas', 'Calle del Sol', '56', 'La Luz', '5599887765', '1985-11-20',
18000.00, 3),
('Jacobo', 'Vázquez', 'Morales', 'Calle Lirio', '12', 'Flor Blanca', '5577889900', '1995-
03-10', 9000.00, 1);
INSERT INTO Administracion.Empleados (NombreEmp, PrimerApellidoEmp, SegundoApellidoEmp,
Calle, Numero, Colonia, Telefono, FechaNacimiento, Sueldo, Puesto)
VALUES('Estefania', 'Morales', NULL, 'Av. Tulipán', '21', 'Erick Paolo', '0022446688', '1990-10-1',
15000.00, 2),
('Alejandro', 'Medina', NULL, 'Calle Tucán', '92', 'El Sol', '0022446688', '1975-03-19',
14000.00, 4),
('Cesar', 'Rodríguez', 'Cantoral', 'Noche Estrellada', '34', 'Italia', '5577709200',
'1995-07-24', 7000.00, 1);
--Respaldo
INSERT INTO Administracion.Empleados (NombreEmp, PrimerApellidoEmp, SegundoApellidoEmp,
Calle, Numero, Colonia, Telefono, FechaNacimiento, Sueldo, Puesto)
VALUES('Fernando', 'Rosado', NULL, 'Av. Primavera', '34', 'Centro', '5544332211', '1990-05-15',
12000.00, 2)
INSERT INTO Administracion.Proveedores (NombreEmpresa, NombreContacto,
PrimerApellidoContacto, SegundoApellidoContacto, Calle, Numero, Colonia, TelefonoProv)
VALUES('Bimbo', 'Fernando', 'Rosado', NULL, 'Av. Sur', '01', 'Forjadores', '5544332211')
--Proveedores
INSERT INTO Administracion.Proveedores (NombreEmpresa, NombreContacto,
PrimerApellidoContacto, SegundoApellidoContacto, Calle, Numero, Colonia, TelefonoProv)
VALUES('Pastelera SA', 'Roberto', 'López', 'Martínez', 'Av. Norte', '21', 'Industrial', '5544332211'),
('Distribuciones Dulces', 'Carla', 'González', NULL, 'Calle Central', '98', 'Centro',
'5599776655'),
('Sabores del Sur', 'Mario', 'Fernández', 'Torres', 'Av. Sur', '76', 'La Estrella',
'5588997766');
INSERT INTO Administracion.Proveedores (NombreEmpresa, NombreContacto,
PrimerApellidoContacto, SegundoApellidoContacto, Calle, Numero, Colonia, TelefonoProv)
VALUES('Bimbo', 'Rául', 'Sanchez', NULL, 'Av. Sur', '01', 'Forjadores', '5544332211'),
('Cosechas Naturales', 'Maria', 'Hernández', 'Sandoval', 'Venustiano Carranza', '35',
'Magisterial', '5599776655'),
('Panadería Angeles', 'Arath', 'Arjona', 'Torres', 'Reforma', '62', 'Lagunitas',
'5588997766');
-- Pasteles.Ingredientes
INSERT INTO Pasteles.Ingredientes (NombreProd, UnidadMedida, PrecioUnitario)
VALUES('Harina', 'kg', 30.00),
('Azúcar', 'kg', 25.00),
('Huevo', 'docena', 50.00),
('Leche', 'litro', 18.00),
('Mantequilla', 'gr', 20.00),
('Sal', 'kg', 25.00),
('Polvo para hornear', 'kg', 30.00),
('Azúcar Morena', 'kg', 25.00);
INSERT INTO Pasteles.Ingredientes (NombreProd, UnidadMedida, PrecioUnitario)
VALUES ('Nueces', 'kg', 15.00),
 ('Café', 'kg', 20.00)
-- Pasteles.Coberturas
INSERT INTO Pasteles.Coberturas (Nombre, Descripcion)
VALUES('Chocolate', 'Cobertura de chocolate oscuro'),
('Fondant', 'Cobertura lisa y brillante'),
('Crema', 'Cobertura de crema batida');
INSERT INTO Pasteles.Coberturas (Nombre, Descripcion)
VALUES('Vainilla', 'Cobertura de vainilla'),
('Betún de Mantequilla', 'Cremosa y ligera'),
('Mermelada', NULL);
INSERT INTO Pasteles.IngredientesDeCobertura
VALUES(1, 2),
(2, 2),
(3, 2),
(3, 4)
INSERT INTO Pasteles.IngredientesDeCobertura
VALUES(4, 10),
(5, 5),
(6, 9),
(5, 10)
--Pan
INSERT INTO Pasteles.Panes (Nombre, Descripcion)
VALUES('Bizcocho', 'Pan esponjoso para pasteles'),
('Chiffon', 'Pan ligero y aireado'),
('Brownie', 'Pan denso de chocolate');
INSERT INTO Pasteles.IngredientesDePan
VALUES(1, 1),
(1, 2),
(1, 3),
(1, 4),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(3, 1),
(3, 2),
(3, 3),
(3, 4)
--Pasteles.Rellenos
INSERT INTO Pasteles.Rellenos (Nombre, Descripcion)
VALUES('Crema pastelera', 'Relleno dulce de crema y vainilla'),
('Mermelada', 'Relleno de mermelada de fresa'),
('Chocolate', 'Relleno de ganache de chocolate');
INSERT INTO Pasteles.Rellenos (Nombre, Descripcion)
VALUES('Dulce de leche', 'Relleno de cajeta, dulce y cremoso'),
('Crema chantilly', 'Relleno ligero y aireado'),
('Mousse de Café', 'Relleno con un mousse suave de café');
INSERT INTO Pasteles.IngredientesDeRelleno
VALUES(1, 2),
(1, 4),
(2, 2),
(3, 4)
INSERT INTO Pasteles.IngredientesDeRelleno
VALUES(4, 2),
(5, 2),
(6, 9),
(5, 10)
--Pasteles.Decoraciones
INSERT INTO Pasteles.Decoraciones (Nombre, Descripcion)
VALUES('Flores de fondant', 'Decoración de flores comestibles'),
('Chispas de chocolate', 'Decoración de chocolate en trozos pequeños'),
('Perlas comestibles', 'Perlas brillantes de azúcar');
INSERT INTO Pasteles.IngredientesDeDecoraciones
VALUES(1, 2),
(2, 2),
(2, 4),
(3, 2)
--Pasteles
INSERT INTO Pasteles.TiposPastel(Nombre, IdCobertura, IdPan)
VALUES ('Pastel de Chocolate', 1, 3),
('Pastel de Vainilla', 2, 1),
('Pastel Tres Leches', 3, 1);
-- Pasteles.Rellenos de cada tipo de pastel
INSERT INTO Pasteles.RellenosIncluidos
VALUES(1, 3),
(1, 6),
(2, 5),
(3, 5)
INSERT INTO Pasteles.DecoracionesIncluidas
VALUES(1, 1),
(2, 3)
INSERT INTO Pasteles.TamañosPastel (Nombre, porciones)
VALUES('Mediano', 10),
('Grande', 16),
('Pequeño', 6)
-- Agregar distintos pasteles en base a los tipos predefinidos
INSERT INTO Pasteles.Pasteles(IdTipoPastel, IdTamaño, Precio)
VALUES(1, 2, 800),
(1, 3, 300),
(2, 1, 450),
(3, 1, 500)
--Administracion.Pedidos
INSERT INTO Administracion.Pedidos (FechaEntregaPedido, EstadoDelPedido, IdCliente,
IdEmpleado)
VALUES('2024-12-05', 'Pendiente', 1, 2),
('2024-12-06', 'Entregado', 2, 3),
('2024-12-07', 'Cancelado', 3, 1);
--Administracion.PedidoDetalles
INSERT INTO Administracion.PedidoDetalles (IdPedido, IdPastel, NumPisos)
VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(3, 3, 1);
--Administracion.Ventas
INSERT INTO Administracion.Ventas (IdPedido, MetodoPago, Monto)
VALUES
(2, 'Efectivo', 450.00),
(1, 'Tarjeta', 850.00),
(3, 'Efectivo', 100.00);
GO
/* VISTAS */
/*
1-Vista_PedidosPorCliente:
 Muestra el numero de pedidos realizados por cada cliente.
*/
CREATE VIEW Vista_PedidosPorCliente
AS
SELECT Administracion.Clientes.IdCliente, Administracion.Clientes.NombreCliente,
Administracion.Clientes.PrimerApellidoCliente,
 COUNT(Administracion.Pedidos.IdPedido) AS TotalPedidos
FROM
 Administracion.Clientes
INNER JOIN
 Administracion.Pedidos
ON
 Administracion.Clientes.IdCliente = Administracion.Pedidos.IdCliente
GROUP BY
 Administracion.Clientes.IdCliente,
 Administracion.Clientes.NombreCliente,
 Administracion.Clientes.PrimerApellidoCliente
GO
--Ejecución
select * from Vista_PedidosPorCliente
/*
2-Vista_DetallesDePedidos:
Muestra todos los detalles de los pedidos
*/
GO
CREATE VIEW Vista_DetallesDePedidos AS
SELECT
 Administracion.Pedidos.IdPedido,
 Administracion.Pedidos.FechaPedido,
 Administracion.Pedidos.FechaEntregaPedido,
 Administracion.Pedidos.EstadoDelPedido,
 SUM(Pasteles.Precio) AS MontoTotal
FROM Administracion.Pedidos INNER JOIN Administracion.PedidoDetalles ON
Administracion.Pedidos.IdPedido = Administracion.PedidoDetalles.IdPedido
INNER JOIN Pasteles.Pasteles ON Pasteles.Pasteles.IdPastel =
Administracion.PedidoDetalles.IdPastel
GROUP BY Administracion.Pedidos.IdPedido, Administracion.Pedidos.FechaPedido,
Administracion.Pedidos.FechaEntregaPedido, Administracion.Pedidos.EstadoDelPedido
GO
SELECT * FROM Vista_DetallesDePedidos
/*
3-Vista_ProductosPorCliente:
 Muestra los pasteles más solicitados por cada cliente, ayudando a personalizar ofertas o
promociones.
*/
GO
CREATE VIEW Vista_ProductosPorCliente AS
SELECT Administracion.Clientes.IdCliente, Administracion.Clientes.NombreCliente,
Administracion.Clientes.PrimerApellidoCliente,
 Pasteles.TiposPastel.Nombre AS PastelFavorito,
 COUNT(Administracion.PedidoDetalles.IdPastel) AS VecesPedido
FROM Administracion.PedidoDetalles
INNER JOIN Administracion.Pedidos ON Administracion.PedidoDetalles.IdPedido =
Administracion.Pedidos.IdPedido
INNER JOIN Administracion.Clientes ON Administracion.Pedidos.IdCliente =
Administracion.Clientes.IdCliente
INNER JOIN Pasteles.TiposPastel ON Administracion.PedidoDetalles.IdPastel =
Pasteles.TiposPastel.IdTipoPastel
GROUP BY Administracion.Clientes.IdCliente, Administracion.Clientes.NombreCliente,
Administracion.Clientes.PrimerApellidoCliente, Pasteles.TiposPastel.Nombre
Go
SELECT * FROM Vista_ProductosPorCliente
/*
4-Vista_SueldoPorPuesto:
 Calcula el sueldo total y el promedio de los empleados agrupados por su puesto
*/
CREATE VIEW Vista_SueldoPorPuesto AS
SELECT
 Administracion.Cargos.IdCargo,Cargos.NombreCargo,
 SUM(Empleados.Sueldo) AS SueldoTotal,
 AVG(Empleados.Sueldo) AS SueldoPromedio
FROM Administracion.Empleados
INNER JOIN Administracion.Cargos ON Administracion.Empleados.Puesto =
Administracion.Cargos.IdCargo
GROUP BY Administracion.Cargos.IdCargo, Administracion.Cargos.NombreCargo;
Go
SELECT * FROM Vista_SueldoPorPuesto
/*
5-Vista_CostoDecoraciones:
Determina el costo promedio y el costo máximo de las decoraciones disponibles.
*/
CREATE VIEW Vista_CostoDecoraciones AS
SELECT Pasteles.Decoraciones.IdDecoracion, Pasteles.Decoraciones.Nombre AS
NombreDecoracion,
 AVG( Pasteles.Ingredientes.PrecioUnitario) AS CostoPromedioDecoracion,
 MAX( Pasteles.Ingredientes.PrecioUnitario) AS CostoMaximoDecoracion
FROM Pasteles.Decoraciones
INNER JOIN Pasteles.Ingredientes ON Pasteles.Decoraciones.IdDecoracion =
Pasteles.Ingredientes.IdIngrediente
GROUP BY Pasteles.Decoraciones.IdDecoracion, Pasteles.Decoraciones.Nombre
SELECT * FROM Vista_CostoDecoraciones
/* TRIGGERS */
-- 1RO. Cuando se realiza una modificación en el precio del pastel de la tabla pasteles, se actualiza
el monto a pagar de la tabla Ventas
--PRIMER TRIGGER
CREATE TRIGGER tr_ActualizarPrecioPastelPorIngrediente
ON Pasteles.Ingredientes
AFTER UPDATE
AS
BEGIN
 SET NOCOUNT ON;

 -- Solo proceder si se actualizó el PrecioUnitario
 IF UPDATE(PrecioUnitario)
 BEGIN
 DECLARE @DiferenciaPorcentaje DECIMAL(5,2) = 0.05; -- 5%

 -- Actualizar precio de pasteles que usan los ingredientes modificados
 UPDATE Pasteles.Pasteles
 SET Precio = ROUND(Precio * (1 +
 CASE
 WHEN (inserted.PrecioUnitario - deleted.PrecioUnitario) > 0 THEN @DiferenciaPorcentaje
 ELSE -@DiferenciaPorcentaje
 END), 2)
 FROM Pasteles.Pasteles
 INNER JOIN Pasteles.TiposPastel ON Pasteles.Pasteles.IdTipoPastel =
Pasteles.TiposPastel.IdTipoPastel
 INNER JOIN (
 --Panes que usan el ingrediente
 SELECT DISTINCT Pasteles.TiposPastel.IdTipoPastel
 FROM Pasteles.IngredientesDePan
 JOIN Pasteles.Panes ON Pasteles.IngredientesDePan.IdPan = Pasteles.Panes.IdPan
 JOIN Pasteles.TiposPastel ON Pasteles.TiposPastel.IdPan = Pasteles.Panes.IdPan
 JOIN inserted ON Pasteles.IngredientesDePan.IdIngrediente = inserted.IdIngrediente

 UNION

 --Coberturas que usan el ingrediente
 SELECT DISTINCT Pasteles.TiposPastel.IdTipoPastel
 FROM Pasteles.IngredientesDeCobertura
 JOIN Pasteles.Coberturas ON Pasteles.IngredientesDeCobertura.IdCobertura =
Pasteles.Coberturas.IdCobertura
 JOIN Pasteles.TiposPastel ON Pasteles.TiposPastel.IdCobertura =
Pasteles.Coberturas.IdCobertura
 JOIN inserted ON Pasteles.IngredientesDeCobertura.IdIngrediente = inserted.IdIngrediente

 UNION

 --Rellenos que usan el ingrediente
 SELECT DISTINCT Pasteles.RellenosIncluidos.IdTipoPastel
 FROM Pasteles.IngredientesDeRelleno
 JOIN Pasteles.Rellenos ON Pasteles.IngredientesDeRelleno.IdRelleno =
Pasteles.Rellenos.IdRelleno
 JOIN Pasteles.RellenosIncluidos ON Pasteles.RellenosIncluidos.IdRelleno =
Pasteles.Rellenos.IdRelleno
 JOIN inserted ON Pasteles.IngredientesDeRelleno.IdIngrediente = inserted.IdIngrediente

 UNION

 --Decoraciones que usan el ingrediente
 SELECT DISTINCT Pasteles.DecoracionesIncluidas.IdTipoPastel
 FROM Pasteles.IngredientesDeDecoraciones
 JOIN Pasteles.Decoraciones ON Pasteles.IngredientesDeDecoraciones.IdDecoracion =
Pasteles.Decoraciones.IdDecoracion
 JOIN Pasteles.DecoracionesIncluidas ON Pasteles.DecoracionesIncluidas.IdDecoracion =
Pasteles.Decoraciones.IdDecoracion
 JOIN inserted ON Pasteles.IngredientesDeDecoraciones.IdIngrediente =
inserted.IdIngrediente
 ) AS PastelesAfectados ON Pasteles.TiposPastel.IdTipoPastel = PastelesAfectados.IdTipoPastel
 JOIN inserted ON 1=1
 JOIN deleted ON inserted.IdIngrediente = deleted.IdIngrediente;

 -- Mostrar mensaje de confirmación
 DECLARE @IngredientesAfectados INT = (SELECT COUNT(*) FROM inserted);
 DECLARE @PastelesActualizados INT = @@ROWCOUNT;

 PRINT CONCAT('Se actualizó el precio de ', @IngredientesAfectados,
 ' ingrediente(s), lo que afectó ', @PastelesActualizados,
 ' pastel(es). Los precios se ajustaron un 5% según el cambio.');
 END
END
/*PRUEBAS DEL TRIGGER*/
--Insertar tipos de pastel básicos porque estaba vacío :c
INSERT INTO Pasteles.TiposPastel (Nombre, IdCobertura, IdPan)
VALUES
('Pastel de Chocolate', 1, 3),
('Pastel de Vainilla', 2, 1),
('Pastel Tres Leches', 3, 1);
SELECT * FROM Pasteles.TamañosPastel
INSERT INTO Pasteles.TamañosPastel (Nombre, Porciones)
VALUES
('Pequeño', 6),
('Mediano', 10),
('Grande', 16);
--Insertar pasteles asegurando que los IDs de tipo y tamaño existen
INSERT INTO Pasteles.Pasteles (IdTipoPastel, IdTamaño, Precio)
VALUES
(1, 1, 300.00), -- Pastel de Chocolate pequeño
(1, 2, 500.00), -- Pastel de Chocolate mediano
(2, 2, 450.00), -- Pastel de Vainilla mediano
(3, 3, 800.00); -- Pastel Tres Leches grande
-- Verificar qué panes usan harina (IdIngrediente = 1)
SELECT p.IdPan, p.Nombre
FROM Pasteles.Panes p
JOIN Pasteles.IngredientesDePan ip ON p.IdPan = ip.IdPan
WHERE ip.IdIngrediente = 1;
-- Verificar qué pasteles usan esos panes
SELECT tp.IdTipoPastel, tp.Nombre, p.IdPastel, p.Precio
FROM Pasteles.TiposPastel tp
JOIN Pasteles.Pasteles p ON tp.IdTipoPastel = p.IdTipoPastel
WHERE tp.IdPan IN (
 SELECT IdPan
 FROM Pasteles.IngredientesDePan
 WHERE IdIngrediente = 1
);
-- Verificar ingredientes en panes CON DATOS
SELECT * FROM Pasteles.IngredientesDePan;
-- Verificar ingredientes en coberturas CON DATOS
SELECT * FROM Pasteles.IngredientesDeCobertura;
-- Verificar ingredientes en rellenos VACIA
SELECT * FROM Pasteles.IngredientesDeRelleno;
-- Verificar ingredientes en decoraciones VACIA
SELECT * FROM Pasteles.IngredientesDeDecoraciones;
-- Para Pastel de Chocolate (IdTipoPastel = 1)
-- Relacionar ingredientes del pan (Brownie)
INSERT INTO Pasteles.IngredientesDePan (IdPan, IdIngrediente)
VALUES
(3, 1), -- Brownie con Harina
(3, 2), -- Brownie con Azúcar
(3, 3), -- Brownie con Huevo
(3, 4); -- Brownie con Leche
-- Relacionar ingredientes de la cobertura (Chocolate)
INSERT INTO Pasteles.IngredientesDeCobertura (IdCobertura, IdIngrediente)
VALUES
(1, 2), -- Chocolate con Azúcar
(1, 5); -- Chocolate con Mantequilla
-- Para Pastel de Vainilla (IdTipoPastel = 2)
-- Relacionar ingredientes del pan (Bizcocho)
INSERT INTO Pasteles.IngredientesDePan (IdPan, IdIngrediente)
VALUES
(1, 1), -- Bizcocho con Harina
(1, 2), -- Bizcocho con Azúcar
(1, 3), -- Bizcocho con Huevo
(1, 4); -- Bizcocho con Leche
-- Relacionar ingredientes de la cobertura (Fondant)
INSERT INTO Pasteles.IngredientesDeCobertura (IdCobertura, IdIngrediente)
VALUES
(2, 2), -- Fondant con Azúcar
(2, 4); -- Fondant con Leche
-- 1. Ver precios actuales de pasteles
SELECT p.IdPastel, tp.Nombre AS TipoPastel, p.Precio
FROM Pasteles.Pasteles p
JOIN Pasteles.TiposPastel tp ON p.IdTipoPastel = tp.IdTipoPastel;
-- 2. Actualizar precio de un ingrediente (Harina - IdIngrediente 1)
UPDATE Pasteles.Ingredientes
SET PrecioUnitario = PrecioUnitario * 1.10 -- Aumento del 10%
WHERE IdIngrediente = 1;
-- 3. Verificar mensajes del trigger (deberías ver los cambios)
-- 4. Comprobar nuevos precios
SELECT p.IdPastel, tp.Nombre AS TipoPastel, p.Precio
FROM Pasteles.Pasteles p
JOIN Pasteles.TiposPastel tp ON p.IdTipoPastel = tp.IdTipoPastel;
--2DO. Cuando algún objeto en un la tabla de Inventarios se reduce debajo de cierto número, se
manda una alerta por cada objeto con pocas existencias
CREATE TRIGGER tr_AlertaIngredientePorAgotarse
ON Pasteles.Inventario
AFTER UPDATE, INSERT
AS
BEGIN
 SET NOCOUNT ON;

 -- Umbrales mínimos de stock
 DECLARE @UmbralMinimoKilogramo FLOAT = 3;
DECLARE @UmbralMinimoGramo FLOAT = 500;
DECLARE @UmbralMinimoLitro FLOAT = 5;
DECLARE @UmbralMinimoDocena FLOAT = 6;

 -- Tabla temporal para almacenar los ingredientes con stock bajo
 DECLARE @IngredientesBajoStock TABLE (
 NombreIngrediente VARCHAR(50),
 CantidadStock INT
 );

 -- Insertar ingredientes con stock bajo en la tabla temporal
 INSERT INTO @IngredientesBajoStock
 SELECT
 i.NombreProd,
 inv.CantidadStock
 FROM inserted inv
 JOIN Pasteles.Ingredientes i ON inv.IdIngrediente = i.IdIngrediente
 WHERE inv.CantidadStock <=
Case i.UnidadMedida
WHEN 'kilogramo' THEN @UmbralMinimoKilogramo
WHEN 'gramo' THEN @UmbralMinimoGramo
WHEN 'docena' THEN @UmbralMinimoLitro
WHEN 'litro' THEN @UmbralMinimoDocena
ELSE 0
END
;

 -- Mostrar alerta para cada ingrediente con stock bajo
 IF EXISTS (SELECT 1 FROM @IngredientesBajoStock)
 BEGIN
 DECLARE @NombreIngrediente VARCHAR(50);
 DECLARE @CantidadStock INT;

 DECLARE ingredientes_cursor CURSOR FOR
 SELECT NombreIngrediente, CantidadStock FROM @IngredientesBajoStock;

 OPEN ingredientes_cursor;
 FETCH NEXT FROM ingredientes_cursor INTO @NombreIngrediente, @CantidadStock;

 WHILE @@FETCH_STATUS = 0
 BEGIN
 PRINT CONCAT('¡ALERTA! Stock bajo: "', @NombreIngrediente,
 '". Quedan solo ', @CantidadStock,
 ' unidades. Por favor contacta al proveedor para reabastecer.');

 FETCH NEXT FROM ingredientes_cursor INTO @NombreIngrediente, @CantidadStock;
 END

 CLOSE ingredientes_cursor;
 DEALLOCATE ingredientes_cursor;
 END
END
UPDATE Pasteles.Inventario
SET CantidadStock = 1
WHERE IdIngrediente = 4
/* PROCEDIMIENTOS ALMACENADOS */
/*
Crear un procedimiento que reciba el id del pastel y devuelva el nombre de los rellenos
que contiene
*/
CREATE PROCEDURE pr_ListaIngredientesPastel @tipoPastel VARCHAR(20)
AS
BEGIN
-- Consulta de los rellenos del pastel
-- Condicional para comprobar que exista el tipo de pastel, si es verdadera se realiza la
consulta
IF EXISTS(SELECT Pasteles.TiposPastel.Nombre FROM Pasteles.TiposPastel
WHERE Pasteles.TiposPastel.Nombre = @tipoPastel)
BEGIN
SELECT Pasteles.TiposPastel.Nombre AS 'Tipo de Pastel', Pasteles.Rellenos.Nombre AS
'Nombre del Relleno',
 Pasteles.Panes.Nombre AS 'Tipo de Pan'
FROM Pasteles.Panes INNER JOIN Pasteles.TiposPastel
ON Pasteles.Panes.IdPan = Pasteles.TiposPastel.IdPan
INNER JOIN Pasteles.RellenosIncluidos
ON Pasteles.TiposPastel.IdTipoPastel = Pasteles.RellenosIncluidos.IdTipoPastel
INNER JOIN Pasteles.Rellenos
ON Pasteles.Rellenos.IdRelleno = Pasteles.RellenosIncluidos.IdRelleno
WHERE Pasteles.TiposPastel.Nombre = @tipoPastel
END
-- Si el nombre no existe en la base de datos, se informará al usuario
ELSE
BEGIN
PRINT 'Ese tipo de pastel no existe'
END
END
GO
EXEC pr_ListaIngredientesPastel @tipoPastel = 'Pastel de Vainilla'
EXEC pr_ListaIngredientesPastel @tipoPastel = 'Pastel de Vainilla'
SELECT Pasteles.TiposPastel.Nombre FROM Pasteles.TiposPastel
-- Actualización de las fechas de entrega de la tabla
UPDATE Administracion.Pedidos SET FechaEntregaPedido = '12/31/2026'
WHERE Administracion.Pedidos.IdPedido = 3
-- Crear un procedimiento que reciba el id del empleado, la fecha que se hizo el pedido y su fecha
de entrega
-- y cuente la cantidad de pedidos que ha hecho y que muestre su información (Nombre, Apellido
y Puesto)
CREATE PROCEDURE pr_CantidadPedidosXEmpleado @idEmpleado INT, @fechaInicio DATE,
@fechaFinal DATE
AS
BEGIN
-- Validamos que la fecha inicial sea menor a la fecha inicial
IF @fechaInicio > @fechaFinal
 BEGIN
 PRINT 'Error: La fecha de inicio no puede ser mayor que la fecha final'
 RETURN
 END
-- Consulta corregida, se usa una condicional para comprobar que existan pedidos hechos
en el lapso de tiempo
-- que busca el usuario
IF EXISTS(SELECT Administracion.Pedidos.IdPedido FROM Administracion.Pedidos
WHERE Administracion.Pedidos.IdEmpleado = @idEmpleado
 AND FechaPedido BETWEEN @fechaInicio AND @fechaFinal)
BEGIN
SELECT COUNT (Administracion.Pedidos.IdPedido) AS 'Cantidad de Pedidos',
Administracion.Empleados.NombreEmp AS 'Nombre Empleado',
Administracion.Empleados.PrimerApellidoEmp AS 'Apellido Paterno',
Administracion.Pedidos.FechaPedido AS 'Fecha de pedido',
Administracion.Pedidos.FechaEntregaPedido AS 'Fecha de Entrega',
Administracion.Cargos.NombreCargo AS 'Puesto'
FROM Administracion.Empleados INNER JOIN Administracion.Pedidos
ON Administracion.Empleados.IdEmpleado = Administracion.Pedidos.IdEmpleado
INNER JOIN Administracion.Cargos
ON Administracion.Cargos.IdCargo = Administracion.Empleados.Puesto
WHERE Administracion.Pedidos.IdEmpleado = @idEmpleado
 AND FechaPedido BETWEEN @fechaInicio AND @fechaFinal
GROUP BY Administracion.Empleados.NombreEmp,
Administracion.Empleados.PrimerApellidoEmp,
Administracion.Pedidos.FechaPedido,
Administracion.Pedidos.FechaEntregaPedido, Administracion.Cargos.NombreCargo
END
-- En caso de que el empleado no haya realizado pedidos, se enviará un mensaje al usuario
ELSE
BEGIN
PRINT 'El empleado no realizó pedidos en el período de tiempo solicitado'
END
END
EXEC pr_CantidadPedidosXEmpleado @idEmpleado = 1, @fechaInicio = '05/22/2025', @fechaFinal
= '12/20/2025'
GO
-- Crear un procedimiento que consulte el historial de pedidos del cliente con un rango de fechas
CREATE PROCEDURE pr_ConsultarPedidosCliente @idCliente INT, @fechaInicio DATE, @fechaFinal
DATE
AS
BEGIN
-- Validamos que la fecha inicial sea menor a la fecha inicial
IF @fechaInicio > @fechaFinal
 BEGIN
 PRINT 'Error: La fecha de inicio no puede ser mayor que la fecha final'
 RETURN
 END
-- Si el cliente ha hecho un pedido dentro del tiempo establecido, se ejecutará la consulta
IF EXISTS (SELECT Administracion.Pedidos.IdCliente FROM Administracion.Pedidos
WHERE Administracion.Pedidos.IdCliente = @idCliente
AND FechaPedido BETWEEN @fechaInicio AND @fechaFinal)
BEGIN
 SELECT Administracion.Pedidos.IdPedido,
 Administracion.Pedidos.FechaPedido, Administracion.Pedidos.FechaEntregaPedido,
 Administracion.Pedidos.EstadoDelPedido, SUM(Pasteles.Precio) AS 'Total Pedido'
 FROM Administracion.Pedidos INNER JOIN Administracion.PedidoDetalles
 ON Administracion.Pedidos.IdPedido = Administracion.PedidoDetalles.IdPedido
INNER JOIN Pasteles.Pasteles
ON Pasteles.Pasteles.IdPastel = Administracion.PedidoDetalles.IdPastel
 WHERE Administracion.Pedidos.IdCliente = @idCliente
 AND FechaPedido BETWEEN @fechaInicio AND @fechaFinal
 GROUP BY Administracion.Pedidos.IdPedido, Administracion.Pedidos.FechaPedido,
Administracion.Pedidos.FechaEntregaPedido, Administracion.Pedidos.EstadoDelPedido
 ORDER BY Administracion.Pedidos.FechaPedido DESC;
END
-- En caso de que el cliente no haya realizado pedidos, se enviará un mensaje al usuario
ELSE
BEGIN
 PRINT 'El cliente no tiene un historial en ese período de tiempo'
END
END
EXEC pr_ConsultarPedidosCliente @idCliente = 1, @fechaInicio = '05/23/2025', @fechaFinal =
'12/20/2025'
GO
/* LOGINS */
CREATE LOGIN GerenteUno
WITH PASSWORD = 'Gerente_01'
CREATE LOGIN CajeroUno
WITH PASSWORD = 'Cajero_01'
/* USUARIOS */
CREATE USER DavidDuarte FOR LOGIN GerenteUno
CREATE USER JacoboVazquez FOR LOGIN CajeroUno
-- Permisos Gerente
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA :: Administracion
TO DavidDuarte
GO
-- Permisos
GRANT SELECT, INSERT, UPDATE ON SCHEMA :: Pasteles
TO JacoboVazquez
GO
GRANT SELECT ON Administracion.Pedidos
TO JacoboVazquez
GO
GRANT SELECT ON Administracion.PedidoDetalles
TO JacoboVazquez
GO