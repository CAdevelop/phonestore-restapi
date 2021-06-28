use PhoneStore;
go;

-- Telefonos
create procedure sp_actualizarTelefono (
	@idTelefono int,
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
	@estado varchar(20)
)
as
	update Producto.Telefono set 
		nombre = @nombre, idMarca = @idMarca, procesador = @procesador, os = @os,
		camaraPrincipal = @camaraPrincipal, camaraFrontal = @camaraFrontal, bateria = @bateria, almacenamiento = @almacenamiento,
		ram = @ram, color = @color, precioVenta = @precioVenta, precioCompra = @precioCompra, existencias = @existencias,
		existenciasMinimas = @existenciasMinimas, estado = @estado
	where idTelefono = @idTelefono;
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
	update Persona.Proveedor set 
		nombres = @nombres, apellidos = @apellidos, correo = @correo, telefono = @telefono
	where idProveedor = @idProveedor;
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
	update Persona.Proveedor set 
		nombres = @nombres, apellidos = @apellidos, correo = @correo, rol = @rol
	where idUsuario = @idUsuario;
go;

-- Entrada
create procedure sp_actualizarEntrada (
	@idEntrada int,
	@idProveedor int,
	@idUsuario int,
	@observacion varchar(200),
	@idTelefono int,
	@cantidadEntrante smallint
)
as
	update Entrada.Entrada set 
		idProveedor = @idProveedor, idUsuario = @idUsuario, observacion = @observacion
	where idEntrada = @idEntrada;

	update Entrada.Detalle_Entrada set
		idTelefono = @idTelefono, cantidadEntrante = @cantidadEntrante
	where idEntrada = @idEntrada
go;

-- Venta
create procedure sp_actualizarVenta (
	@idVenta int,
	@idUsuario int,
	@cliente varchar(50),
	@observacion varchar(200),
	@idTelefono int,
	@cantidadVendida smallint,
	@descuento decimal,
	@subtotal money
)
as
	update Salida.Venta set
		observacion = @observacion, idUsuario = @idUsuario, descuento = @descuento,
		cliente = @cliente, subtotal = @subtotal
	where idVenta = @idVenta;

	update Salida.Detalle_Venta set
		idTelefono = @idTelefono, cantidadVendida = @cantidadVendida
	where idVenta = @idVenta;
go;