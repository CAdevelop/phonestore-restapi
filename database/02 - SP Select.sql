use PhoneStore;
go;

-- Telefonos
create procedure sp_obtenerTelefonos
as
	select * from Producto.Telefono;
go;

create procedure sp_obtenerTelefonoPorId (
	@id int
)
as
	select * from Producto.Telefono where idTelefono = @id;
go;

-- Proveedores
create procedure sp_obtenerProveedores
as
	select * from Persona.Proveedor;
go;

create procedure sp_obtenerProveedorPorId (
	@id int
)
as
	select * from Persona.Proveedor where idProveedor = @id;
go;

-- Usuarios
create procedure sp_obtenerUsuarios
as
	select * from Persona.Usuario;
go;

create procedure sp_obtenerUsuarioPorId (
	@id int
)
as
	select * from Persona.Usuario where idUsuario = @id;
go;

-- Entrada
create procedure sp_obtenerEntradas
as
	select E.idEntrada, E.idProveedor, E.idUsuario, DE.idTelefono, DE.cantidadEntrante, E.observacion, E.fechaEntrada 
		from Entrada.Entrada E
		inner join Entrada.Detalle_Entrada DE
		on E.idEntrada = DE.idEntrada;
go;

create procedure sp_obtenerEntradasPorId (
	@idEntrada int
)
as
	select E.idEntrada, E.idProveedor, E.idUsuario, DE.idTelefono, DE.cantidadEntrante, E.observacion, E.fechaEntrada 
		from Entrada.Entrada E
		inner join Entrada.Detalle_Entrada DE
		on E.idEntrada = DE.idEntrada
	where E.idEntrada = @idEntrada;
go;

-- Venta
create procedure sp_obtenerVentas 
as
	select V.idVenta, DV.idTelefono, V.cliente, DV.cantidadVendida, V.descuento, V.subtotal, V.observacion, V.fechaVenta from Salida.Venta V
		inner join Salida.Detalle_Venta DV
		on V.idVenta = DV.idVenta;
go;

create procedure sp_obtenerVentasPorId (
	@idVenta int
)
as
	select V.idVenta, DV.idTelefono, V.cliente, DV.cantidadVendida, V.descuento, V.subtotal, V.observacion, V.fechaVenta from Salida.Venta V
		inner join Salida.Detalle_Venta DV
		on V.idVenta = DV.idVenta
	where V.idVenta = @idVenta;
go;