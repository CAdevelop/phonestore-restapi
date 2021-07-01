use PhoneStore;
go;

-- Telefonos
create procedure sp_nuevoTelefono (
	@nombre varchar(50),
	@marca varchar(30),
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
	@estado varchar(20),
	@idUsuario int,
	@proveedor varchar(60)
)
as
	set nocount on;

	begin transaction;
	
	declare @idTelefono int,
			@idProveedor int,
			@idEntrada int;

	set @idProveedor = (select idProveedor from Persona.Proveedor where CONCAT(RTRIM(nombres), ' ', apellidos) = @proveedor);
	set @idTelefono = (select idTelefono from Producto.Telefono where nombre = @nombre);

	-- Checks the provider exists and the phone doesn't exists yet
	if ((nullif(@idProveedor, '') is not null) and (nullif(@idTelefono, '') is null)) 
		begin
			insert into Producto.Telefono (
				idEstado, nombre, marca, procesador, os, camaraPrincipal,
				camaraFrontal, bateria, almacenamiento, ram, color, estado
			) values (
				0, @nombre, @marca, @procesador, @os, @camaraPrincipal,
				@camaraFrontal, @bateria, @almacenamiento, @ram, @color, @estado
			);

			set @idTelefono = @@IDENTITY;

			insert into Producto.Detalle_Telefono (
				idTelefono, precioVenta, precioCompra, existencias, 
				existenciasMinimas
			) values (
				@idTelefono, @precioVenta, @precioCompra, @existencias, 
				@existenciasMinimas
			);

			insert into Entrada.Entrada (
				fechaEntrada, idProveedor, observacion, idUsuario
			) values (
				getDate(), @idProveedor, 'Entrada inicial del producto, Agregado al Stock', @idUsuario
			);

			set @idEntrada = @@IDENTITY;

			insert into Entrada.Detalle_Entrada (
				idEntrada, idTelefono, cantidadEntrante
			) values (
				@idEntrada, @idTelefono, @existencias
			);

			commit transaction;
			print 'Telefono creado';
		end
	else 
		begin
			rollback transaction;
			print 'El telefono ya existe';
		end
go;

-- Proveedores
create procedure sp_nuevoProveedor (
	@nombres varchar(30),
	@apellidos varchar(30),
	@correo varchar(50) = 'No registrado',
	@telefono varchar(20) = 'No registrado'
)
as
	set nocount on;
	begin transaction;

	declare @idProveedor int;

	set @idProveedor = (select idProveedor from Persona.Proveedor where nombres = @nombres and apellidos = @apellidos);

	if (nullif(@idProveedor, '') is null)
		begin
			insert into Persona.Proveedor (
				idEstado, nombres, apellidos, correo, telefono
			) values (
				0, @nombres, @apellidos, @correo, @telefono
			);

			print 'Proveedor creado';
			commit transaction;
		end
	else 
		begin
			rollback transaction;
			print 'El proveedor ya existe';
		end
go;

-- Usuarios
create procedure sp_nuevoUsuario (
	@nombres varchar(30),
	@apellidos varchar(30),
	@correo varchar(50) = 'No registrado',
	@rol varchar(20)
)
as
	set nocount on;
	begin transaction;

	declare @idUsuario int;

	set @idUsuario = (select idUsuario from Persona.Usuario where nombres = @nombres and apellidos = @apellidos);

	if (nullif(@idUsuario, '') is null)
		begin
			insert into Persona.Usuario (
				idEstado, nombres, apellidos, correo, rol
			) values (
				0, @nombres, @apellidos, @correo, @rol
			);

			print 'Usuario creado';
			commit transaction;
		end
	else 
		begin
			rollback transaction;
			print 'El usuario ya existe';
		end
go;

-- Entrada
create procedure sp_nuevaEntrada (
	@proveedor varchar(60), 
	@idUsuario int,
	@nombreTelefono varchar(50),
	@cantidadEntrante smallint,
	@observacion varchar(200)
)
as
	set nocount on;
	begin transaction;
	
	declare @idTelefono int,
			@idProveedor int,
			@idEntrada int,
			@idUser int;

	set @idProveedor = (select idProveedor from Persona.Proveedor where CONCAT(RTRIM(nombres), ' ', apellidos) = @proveedor);
	set @idTelefono = (select idTelefono from Producto.Telefono where nombre = @nombreTelefono);
	set @idUser = (select idUsuario from Persona.Usuario where idUsuario = @idUsuario);

	if ((nullif(@idTelefono, '') is not null) and (nullif(@idProveedor, '') is not null) and (nullif(@idUser, '') is not null))
		begin
			insert into Entrada.Entrada (
				fechaEntrada, idProveedor, observacion, idUsuario
			) values (
				getDate(), @idProveedor, @observacion, @idUsuario
			);

			set @idEntrada = @@IDENTITY;

			insert into Entrada.Detalle_Entrada (
				idEntrada, idTelefono, cantidadEntrante
			) values (
				@idEntrada, @idTelefono, @cantidadEntrante
			);

			print 'Entrada completa';
			commit transaction;
		end
	else 
		begin
			print 'El telefono, el proveedor y/o el usuario no existe';
			rollback transaction;
		end
go;

-- Venta
create procedure sp_nuevaVenta (
	@idUsuario int,
	@descuento decimal(5,2),
	@cliente varchar(50),
	@nombreTelefono varchar(50),
	@cantidadVendida smallint,
	@observacion varchar(200)
)
as
	set nocount on;
	begin transaction;
	
	declare @idVenta int,
			@idTelefono int,
			@precioVenta money,
			@subtotal money,
			@existencias smallint,
			@stockMinimo smallint,
			@nuevaCantidad smallint;

	set @idTelefono = (select idTelefono from Producto.Telefono where nombre = @nombreTelefono);

	if ((nullif(@idTelefono, '') is not null) and (nullif(@idUsuario, '') is not null))
		begin
			set @existencias = (select existencias from Producto.Detalle_Telefono where idTelefono = @idTelefono);
			set @stockMinimo = (select existenciasMinimas from Producto.Detalle_Telefono where idTelefono = @idTelefono);
			set @nuevaCantidad = @existencias - @cantidadVendida;

			if ((@existencias >= @cantidadVendida) and (@nuevaCantidad >= @stockMinimo))
				begin
					set @precioVenta = (select precioVenta from Producto.Detalle_Telefono where idTelefono = @idTelefono);
					set @subtotal = @precioVenta * @cantidadVendida;

					insert into Salida.Venta (
						fechaVenta, observacion, idUsuario, descuento, cliente, subtotal
					) values (
						getDate(), @observacion, @idUsuario, @descuento, @cliente, @subtotal
					);

					set @idVenta = @@IDENTITY;

					insert into Salida.Detalle_Venta (
						idVenta, idTelefono, cantidadVendida
					) values (
						@idVenta, @idTelefono, @cantidadVendida
					);

					print 'Venta completa';
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
			print 'El telefono y/o el usuario no existe';
			rollback transaction;
		end
go;