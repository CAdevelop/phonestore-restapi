use PhoneStore;
go;

-- Marcas
create procedure sp_obtenerMarcas 
as
	select * from Producto.Marca;
go;

create procedure sp_obtenerMarcasPorId (
	@id smallint
)
as
	select * from Producto.Marca where idMarca = @id;
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