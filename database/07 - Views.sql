use PhoneStore;
go;

create view Producto.Marcas 
as 
	select distinct marca from Producto.Telefono;
go;