use PhoneStore;
go;

create view Producto.Marcas 
as 
	select distinct marca from Producto.Telefono where activo = 0;
go;

create view Producto.TelefonoYDetalle 
as
	select T.idTelefono, T.nombre, T.marca, T.procesador, T.os, T.camaraPrincipal, T.camaraFrontal,
			T.bateria, T.almacenamiento, T.ram, T.color, T.estado, DT.precioVenta, DT.precioCompra,
			DT.existencias, DT.existenciasMinimas
	from Producto.Telefono T
		inner join Producto.Detalle_Telefono DT
		on T.idTelefono = DT.idTelefono
	where T.activo = 0;
go;