use PhoneStore;
go;

-- Telefonos
create procedure sp_nuevoTelefono (
	@nombre varchar(50),
	@marca varchar(30),
	@procesador varchar(30),
	@os varchar(20),
	@camaraPrincipal varchar(50),
	@camaraFrontal varchar(50),
	@bateria varchar(20),
	@almacenamiento varchar(20),
	@ram varchar(20),
	@color varchar(20),
	@precioVenta money,
	@precioCompra money,
	@existencias smallint,
	@existenciasMinimas smallint,
	@estado varchar(20)
)
as
	set nocount on;

	insert into Producto.Telefono (
		nombre, marca, procesador, os, camaraPrincipal,
		camaraFrontal, bateria, almacenamiento, ram, color,
		precioVenta, precioCompra, existencias, existenciasMinimas, estado
	) values (
		@nombre, @marca, @procesador, @os, @camaraPrincipal,
		@camaraFrontal, @bateria, @almacenamiento, @ram, @color, 
		@precioVenta, @precioCompra, @existencias, @existenciasMinimas, @estado
	);
go;

-- Proveedores
create procedure sp_nuevoProveedor (
	@nombres varchar(30),
	@apellidos varchar(30),
	@correo varchar(50) = 'No registrado',
	@telefono varchar(20) = 'No registrado'
)
as
	set nocount on;

	insert into Persona.Proveedor values (
		@nombres, @apellidos, @correo, @telefono
	);
go;

-- Usuarios
create procedure sp_nuevoUsuario (
	@nombres varchar(30),
	@apellidos varchar(30),
	@correo varchar(50) = 'No registrado',
	@rol varchar(20)
)
as
	set nocount on;

	insert into Persona.Usuario values (
		@nombres, @apellidos, @correo, @rol
	);
go;

-- Entrada
create procedure sp_nuevaEntrada (
	@idProveedor int, 
	@idUsuario int,
	@idTelefono int,
	@cantidadEntrante smallint,
	@observacion varchar(200)
)
as
	set nocount on;
	
	declare @idEntrada int;

	insert into Entrada.Entrada (
		fechaEntrada, idProveedor, observacion, idUsuario
	) values (
		getDate(), @idProveedor, @observacion, @idUsuario
	);

	set @idEntrada = @@IDENTITY;

	insert into Entrada.Detalle_Entrada (
		idEntrada, idTelefono, cantidadEntrante
	) values (
		@idEntrada, @idTelefono, @cantidadEntrante
	);
go;

-- Venta
create procedure sp_nuevaVenta (
	@idUsuario int,
	@descuento decimal,
	@cliente varchar(50),
	@subtotal money,
	@idTelefono int,
	@cantidadVendida smallint,
	@observacion varchar(200)
)
as
	set nocount on;
	
	declare @idVenta int;

	insert into Salida.Venta (
		fechaVenta, observacion, idUsuario, descuento, cliente, subtotal
	) values (
		getDate(), @observacion, @idUsuario, @descuento, @cliente, @subtotal
	);

	set @idVenta = @@IDENTITY;

	insert into Salida.Detalle_Venta (
		idVenta, idTelefono, cantidadVendida
	) values (
		@idVenta, @idTelefono, @cantidadVendida
	);
go;