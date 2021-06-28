use PhoneStore;
go;

-- Telefonos
create procedure sp_borrarTelefono (
	@idTelefono int
)
as
	delete Producto.Telefono where idTelefono = @idTelefono;
go;

-- Proveedores
create procedure sp_borrarProveedor (
	@idProveedor int
)
as
	delete Persona.Proveedor where idProveedor = @idProveedor;
go;

-- Usuarios
create procedure sp_borrarUsuario (
	@idUsuario int
)
as
	delete Persona.Usuario where idUsuario = @idUsuario;
go;

