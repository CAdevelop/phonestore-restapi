use PhoneStore;
go;

-- Marcas
create procedure sp_actualizarMarca (
	@id smallint,
	@nombre varchar(30)
)
as
	update Producto.Marca set nombre = @nombre where idMarca = @id;
go;

-- Telefonos
create procedure sp_actualizarTelefono (
	@idTelefono int,
	@nombre varchar(50),
	@idMarca smallint,
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
	update Producto.Telefono set 
		nombre = @nombre, idMarca = @idMarca, procesador = @procesador, os = @os,
		camaraPrincipal = @camaraPrincipal, camaraFrontal = @camaraFrontal, bateria = @bateria, almacenamiento = @almacenamiento,
		ram = @ram, color = @color, precioVenta = @precioVenta, precioCompra = @precioCompra, existencias = @existencias,
		existenciasMinimas = @existenciasMinimas, estado = @estado
	where idTelefono = @idTelefono;
go;

-- Proveedores
create procedure sp_actualizarProveedor (
	@idProveedor int,
	@nombres varchar(30),
	@apellidos varchar(30),
	@correo varchar(50) = 'No registrado',
	@telefono varchar(20) = 'No registrado'
)
as
	update Persona.Proveedor set 
		nombres = @nombres, apellidos = @apellidos, correo = @correo, telefono = @telefono
	where idProveedor = @idProveedor;
go;

-- Usuarios
create procedure sp_actualizarUsuario (
	@idUsuario int,
	@nombres varchar(30),
	@apellidos varchar(30),
	@correo varchar(50),
	@rol varchar(20)
)
as
	update Persona.Proveedor set 
		nombres = @nombres, apellidos = @apellidos, correo = @correo, rol = @rol
	where idUsuario = @idUsuario;
go;