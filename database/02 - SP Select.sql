use PhoneStore;
go;

-- Telefonos
create procedure sp_obtenerTelefonos
as
	select T.idTelefono, T.nombre, T.marca, T.procesador, T.os, T.camaraPrincipal, T.camaraFrontal, T.bateria,
			T.almacenamiento, T.ram, T.color, T.estado, DT.precioVenta, DT.precioCompra, DT.existencias, DT.existenciasMinimas
	from Producto.Telefono T
		inner join Producto.Detalle_Telefono DT
		on T.idTelefono = DT.idTelefono;
go;

create procedure sp_obtenerTelefonoPorId (
	@id int
)
as
	select T.idTelefono, T.nombre, T.marca, T.procesador, T.os, T.camaraPrincipal, T.camaraFrontal, T.bateria,
			T.almacenamiento, T.ram, T.color, T.estado, DT.precioVenta, DT.precioCompra, DT.existencias, DT.existenciasMinimas
	from Producto.Telefono T
		inner join Producto.Detalle_Telefono DT
		on T.idTelefono = DT.idTelefono
	where T.idTelefono = @id;
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
	select E.idEntrada, (P.nombres + ' ' + P.apellidos) as Proveedor,  (U.nombres + ' ' + U.apellidos) as Gestor, 
			(T.marca + ' ' + T.nombre) as Telefono, DE.cantidadEntrante, E.observacion, E.fechaEntrada
	from Entrada.Entrada E
		inner join Entrada.Detalle_Entrada DE
		on E.idEntrada = DE.idEntrada
		inner join Persona.Proveedor P
		on E.idProveedor = P.idProveedor
		inner join Persona.Usuario U
		on E.idUsuario = U.idUsuario
		inner join Producto.Telefono T
		on T.idTelefono = DE.idTelefono;
go;

create procedure sp_obtenerEntradaPorId (
	@idEntrada int
)
as
	select E.idEntrada, (P.nombres + ' ' + P.apellidos) as Proveedor,  (U.nombres + ' ' + U.apellidos) as Gestor, 
			(T.marca + ' ' + T.nombre) as Telefono, DE.cantidadEntrante, E.observacion, E.fechaEntrada
	from Entrada.Entrada E
		inner join Entrada.Detalle_Entrada DE
		on E.idEntrada = DE.idEntrada
		inner join Persona.Proveedor P
		on E.idProveedor = P.idProveedor
		inner join Persona.Usuario U
		on E.idUsuario = U.idUsuario
		inner join Producto.Telefono T
		on T.idTelefono = DE.idTelefono
	where DE.idEntrada = @idEntrada;
go;

-- Venta
create procedure sp_obtenerVentas 
as
	select V.idVenta, (T.marca + ' ' +T.nombre) Telefono, V.cliente, (U.nombres + ' ' + U.apellidos) Gestor, 
			DV.cantidadVendida, DT.precioVenta, V.subtotal, V.descuento, V.observacion, V.fechaVenta 
	from Salida.Venta V
		inner join Salida.Detalle_Venta DV
		on V.idVenta = DV.idVenta
		inner join Persona.Usuario U
		on V.idUsuario = U.idUsuario
		inner join Producto.Telefono T
		on T.idTelefono = DV.idTelefono
		inner join Producto.Detalle_Telefono DT
		on T.idTelefono = DT.idTelefono;
go;

create procedure sp_obtenerVentaPorId (
	@idVenta int
)
as
	select V.idVenta, (T.marca + ' ' +T.nombre) Telefono, V.cliente, (U.nombres + ' ' + U.apellidos) Gestor, 
			DV.cantidadVendida, DT.precioVenta, V.subtotal, V.descuento, V.observacion, V.fechaVenta 
	from Salida.Venta V
		inner join Salida.Detalle_Venta DV
		on V.idVenta = DV.idVenta
		inner join Persona.Usuario U
		on V.idUsuario = U.idUsuario
		inner join Producto.Telefono T
		on T.idTelefono = DV.idTelefono
		inner join Producto.Detalle_Telefono DT
		on T.idTelefono = DT.idTelefono
	where V.idVenta = @idVenta;
go;