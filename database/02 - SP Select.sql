use PhoneStore;
go;

-- Telefonos
create procedure sp_obtenerTelefonos
as
	select T.idTelefono, T.nombre, T.marca, T.procesador, T.os, T.camaraPrincipal, T.camaraFrontal, T.bateria,
			T.almacenamiento, T.ram, T.color, T.estado, DT.precioVenta, DT.precioCompra, DT.existencias, DT.existenciasMinimas
	from Producto.Telefono T
		inner join Producto.Detalle_Telefono DT
		on T.idTelefono = DT.idTelefono
	where T.activo = 0;
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
	where T.activo = 0 and T.idTelefono = @id;
go;

-- Proveedores
create procedure sp_obtenerProveedores
as
	select idProveedor, nombres, apellidos, correo, telefono 
	from Persona.Proveedor where activo = 0;
go;

create procedure sp_obtenerProveedorPorId (
	@id int
)
as
	select idProveedor, nombres, apellidos, correo, telefono 
	from Persona.Proveedor where idProveedor = @id and activo = 0;
go;

-- Usuarios
create procedure sp_obtenerUsuarios
as
	select idUsuario, nombres, apellidos, correo, rol 
	from Persona.Usuario where activo = 0;
go;

create procedure sp_obtenerUsuarioPorId (
	@id int
)
as
	select idUsuario, nombres, apellidos, correo, rol
	from Persona.Usuario where activo = 0 and idUsuario = @id;
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
		on T.idTelefono = DE.idTelefono
	where T.activo = 0 and P.activo = 0 and U.activo = 0;
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
	where (T.activo = 0 and P.activo = 0 and U.activo = 0) and DE.idEntrada = @idEntrada;
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
		on T.idTelefono = DT.idTelefono
	where T.activo = 0 and U.activo = 0;
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
	where (T.activo = 0 and U.activo = 0) and V.idVenta = @idVenta;
go;

/*------------------ SOLICITADOS -------------------- */
-- Login
create procedure sp_ingreso (
	@correo varchar(50),
	@contra varchar(30)
)
as
	if exists (select idUsuario from Persona.Usuario where correo = @correo and contraseña = @contra)
		select 1 as Respuesta
	else 
		select -1 as Respuesta;
go;

-- Entradas
create procedure sp_verEntradas 
as
	select * from Entrada.Entrada;
go;

create procedure sp_verEntradaPorId (
	@id int
)
as
	select * from Entrada.Entrada where idEntrada = @id;
go;

-- Detalles entrada
create procedure sp_verDetallesEntrada 
as
	select * from Entrada.Detalle_Entrada;
go;

create procedure sp_verDetalleEntradaPorId (
	@id int
)
as
	select * from Entrada.Detalle_Entrada where idEntrada = @id;
go;
-- Ventas
create procedure sp_verVentas 
as
	select * from Salida.Venta;
go;

create procedure sp_verVentaPorId (
	@id int
)
as
	select * from Salida.Venta where idVenta = @id;
go;

-- Detalle Ventas
create procedure sp_verDetalleVentas 
as
	select * from Salida.Detalle_Venta;
go;

create procedure sp_verDetalleVentaPorId (
	@id int
)
as
	select * from Salida.Detalle_Venta where idVenta = @id;
go;

create procedure sp_verTelefonoYDetalle
as
	select * from Producto.TelefonoYDetalle;
go;

create procedure sp_topTelefonos
as
	select top 6 T.idTelefono, T.nombre, T.marca, sum(DV.cantidadVendida) [Cantidad Vendida] from Producto.Telefono T
		inner join Salida.Detalle_Venta DV
		on T.idTelefono = DV.idTelefono
	group by T.idTelefono, T.nombre, T.marca order by [Cantidad Vendida] desc
go;

create procedure sp_ventas7Dias
as
	select T.nombre, T.marca, Convert(money, Round(sum(V.subTotal * (V.descuento / 100)), 2), 103) Recaudacion, V.fechaVenta from Producto.Telefono T
		inner join Salida.Detalle_Venta DV
		on T.idTelefono = DV.idTelefono
		inner join Salida.Venta V
		on V.idVenta = DV.idVenta
	where V.fechaVenta >= dateadd(day, -7, V.fechaVenta)
	group by T.nombre, T.marca, V.fechaVenta order by Recaudacion desc;
go;