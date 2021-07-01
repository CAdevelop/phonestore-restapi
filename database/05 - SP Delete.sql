use PhoneStore;
go;

-- Telefonos
create procedure sp_borrarTelefono (
	@idTelefono int
)
as
	update Producto.Telefono set activo = 1 where idTelefono = @idTelefono;
go;

-- Proveedores
create procedure sp_borrarProveedor (
	@idProveedor int
)
as
	update Persona.Proveedor set activo = 1 where idProveedor = @idProveedor;
go;

-- Usuarios
create procedure sp_borrarUsuario (
	@idUsuario int
)
as
	update Persona.Usuario set activo = 1 where idUsuario = @idUsuario;
go;