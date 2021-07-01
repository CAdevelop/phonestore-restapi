use PhoneStore;
go;

-- Telefonos
create procedure sp_actualizarTelefono (
	@idTelefono int,
	@procesador varchar(30),
	@os varchar(20),
	@camaraPrincipal varchar(50),
	@camaraFrontal varchar(50),
	@bateria varchar(20),
	@almacenamiento varchar(20),
	@ram varchar(20),
	@color varchar(20),
	@estado varchar(20)
)
as
	set nocount on;

	begin transaction;

	if exists (select idTelefono from Producto.Telefono where idTelefono = @idTelefono)
		begin
			update Producto.Telefono set 
				procesador = @procesador, os = @os,
				camaraPrincipal = @camaraPrincipal, camaraFrontal = @camaraFrontal, bateria = @bateria, almacenamiento = @almacenamiento,
				ram = @ram, color = @color, estado = @estado
			where idTelefono = @idTelefono and activo = 0;

			print 'Telefono actualizado';
			commit transaction;
		end
	else 
		begin
			print 'No se puede actualizar un telefono que no existe';
			rollback transaction;
		end
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
	set nocount on;

	begin transaction;

	if exists (select idProveedor from Persona.Proveedor where idProveedor = @idProveedor)
		begin
			update Persona.Proveedor set 
				nombres = @nombres, apellidos = @apellidos, correo = @correo, telefono = @telefono
			where idProveedor = @idProveedor and activo = 0;

			print 'Proveedor actualizado';
			commit transaction;
		end
	else 
		begin
			print 'No se puede actualizar un proveedor que no existe';
			rollback transaction;
		end
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
	set nocount on;

	begin transaction;

	if exists (select idUsuario from Persona.Usuario where idUsuario = @idUsuario)
		begin
			update Persona.Usuario set 
				nombres = @nombres, apellidos = @apellidos, correo = @correo, rol = @rol
			where idUsuario = @idUsuario and activo = 0

			print 'Usuario actualizado';
			commit transaction;
		end
	else 
		begin
			print 'No se puede actualizar un usuario que no existe';
			rollback transaction;
		end
go;

-- Entrada
create procedure sp_actualizarEntrada (
	@idEntrada int,
	@idProveedor int,
	@idUsuario int,
	@idTelefono int,
	@observacion varchar(200),
	@cantidadEntrante smallint
)
as
	set nocount on;

	begin transaction;

	declare @auxIdEntrada int,
			@auxIdProveedor int,
			@auxIdUsuario int,
			@auxIdTelefono int,
			@cantidadAnteriorTelefonos smallint;

	set @auxIdEntrada = (select idEntrada from Entrada.Entrada where idEntrada = @idEntrada);
	set @auxIdProveedor = (select idProveedor from Persona.Proveedor where idProveedor = @idProveedor and activo = 0);
	set @auxIdUsuario = (select idUsuario from Persona.Usuario where idUsuario = @idUsuario and activo = 0);
	set @auxIdTelefono = (select idTelefono from Producto.Telefono where idTelefono = @idTelefono and activo = 0);

	if ((nullif(@auxIdEntrada, '') is not null) and 
		(nullif(@auxIdProveedor, '') is not null) and 
		(nullif(@auxIdUsuario, '') is not null) and 
		(nullif(@auxIdTelefono, '') is not null))
		begin
			set @cantidadAnteriorTelefonos = (select existencias from Producto.Detalle_Telefono where idTelefono = @idTelefono) - 
												(select cantidadEntrante from Entrada.Detalle_Entrada where idEntrada = @idEntrada);
			
			update Entrada.Entrada set 
				idProveedor = @idProveedor, idUsuario = @idUsuario, observacion = @observacion
			where idEntrada = @idEntrada;

			update Entrada.Detalle_Entrada set
				idTelefono = @idTelefono, cantidadEntrante = @cantidadEntrante
			where idEntrada = @idEntrada;
			
			update Producto.Detalle_Telefono set
				existencias = (@cantidadAnteriorTelefonos + @cantidadEntrante)
			where idTelefono = @idTelefono;

			print 'Entrada actualizada';
			commit transaction;
		end
	else 
		begin
			print 'La entrada, proveedor, usuario y/o telefono no existe(n)';
			rollback transaction;
		end
go;

-- Venta
create procedure sp_actualizarVenta (
	@idVenta int,
	@idUsuario int,	
	@idTelefono int,
	@cliente varchar(50),
	@observacion varchar(200),
	@cantidadVendida smallint,
	@descuento decimal(5,2)
)
as
	set nocount on;
	begin transaction;

	declare @auxIdSalida int,
			@auxIdUsuario int,
			@auxIdTelefono int,
			@auxIdVenta int,
			@existencias smallint,
			@nuevaCantidad smallint,
			@stockMinimo smallint,
			@precioVenta money,
			@subtotal money,
			@cantidadAnteriorTelefonos smallint;

	set @auxIdVenta = (select idVenta from Salida.Venta where idVenta = @idVenta);
	set @auxIdUsuario = (select idUsuario from Persona.Usuario where idUsuario = @idUsuario and activo = 0);
	set @auxIdTelefono = (select idTelefono from Producto.Telefono where idTelefono = @idTelefono and activo = 0);

	if ((nullif(@auxIdVenta, '') is not null) and
		(nullif(@auxIdUsuario, '') is not null) and 
		(nullif(@auxIdTelefono, '') is not null))
		begin
			set @existencias = (select existencias from Producto.Detalle_Telefono where idTelefono = @idTelefono);
			set @stockMinimo = (select existenciasMinimas from Producto.Detalle_Telefono where idTelefono = @idTelefono);
			set @nuevaCantidad = @existencias - @cantidadVendida;
			
			if ((@existencias >= @cantidadVendida) and (@nuevaCantidad >= @stockMinimo))
				begin
					set @cantidadAnteriorTelefonos = (select existencias from Producto.Detalle_Telefono where idTelefono = @idTelefono) +
														(select cantidadVendida from Salida.Detalle_Venta where idVenta = @idVenta);

					set @precioVenta = (select precioVenta from Producto.Detalle_Telefono where idTelefono = @idTelefono);
					set @subtotal = @precioVenta * @cantidadVendida;

					update Salida.Venta set
						observacion = @observacion, idUsuario = @idUsuario, descuento = @descuento,
						cliente = @cliente, subtotal = @subtotal
					where idVenta = @idVenta;

					update Salida.Detalle_Venta set
						idTelefono = @idTelefono, cantidadVendida = @cantidadVendida
					where idVenta = @idVenta;

					update Producto.Detalle_Telefono set
						existencias = (@cantidadAnteriorTelefonos - @cantidadVendida)
					where idTelefono = @idTelefono;

					print 'Entrada actualizada';
					commit transaction;
				end
			else 
				begin
					print 'No hay suficiente stock para poder vender la cantidad deseada o no cumple con el stock de seguridad';
					rollback transaction;
				end
		end
	else 
		begin
			print 'La entrada, usuario y/o telefono no existe(n)';
			rollback transaction;
		end
go;