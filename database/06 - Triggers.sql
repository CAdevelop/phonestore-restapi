use PhoneStore;
go;

create trigger TIactualizarStockEntrada on Entrada.Detalle_Entrada
after insert
as
	declare @existencias smallint,
			@idTelefono int,
			@cantidadEntrante smallint;

	set @cantidadEntrante = (select cantidadEntrante from inserted);
	set @idTelefono = (select idTelefono from inserted);
	set @existencias = (select existencias from Producto.Detalle_Telefono where idTelefono = @idTelefono) + @cantidadEntrante;

	update Producto.Detalle_Telefono set existencias = @existencias where idTelefono = @idTelefono;
go;

create trigger TIactualizarStockVenta on Salida.Detalle_Venta
after insert
as
	declare @existencias smallint,
			@idTelefono int,
			@cantidadVendida smallint;

	set @cantidadVendida = (select cantidadVendida from inserted);
	set @idTelefono = (select idTelefono from inserted);
	set @existencias = (select existencias from Producto.Detalle_Telefono where idTelefono = @idTelefono) - @cantidadVendida;

	update Producto.Detalle_Telefono set existencias = @existencias where idTelefono = @idTelefono;
go;