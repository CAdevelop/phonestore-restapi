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

-- Entrada
create procedure sp_borrarEntrada (
	@idEntrada int
)
as
	delete Entrada.Detalle_Entrada where idEntrada = @idEntrada;
	delete Entrada.Entrada where idEntrada = @idEntrada;
go;

-- Salida
create procedure sp_borrarVenta (
	@idVenta int
)
as
	delete Salida.Detalle_Venta where idVenta = @idVenta;
	delete Salida.Venta where idVenta = @idVenta;
go;