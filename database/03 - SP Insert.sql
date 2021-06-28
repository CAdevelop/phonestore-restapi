use PhoneStore;
go;

-- Marcas
create procedure sp_nuevaMarca (
	@nombre varchar(30)
)
as
	insert into Producto.Marca values (@nombre);
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
	@estado tinyint
)
as
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
	insert into Persona.Usuario values (
		@nombres, @apellidos, @correo, @rol
	);
go;