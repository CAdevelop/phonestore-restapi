use master;
go;

create database PhoneStore on primary (
	name = 'PhoneStore_dat',
	filename = 'D:\Programacion\SQL\SQL Server\PhoneStore\PhoneStore.mdf',
	size = 10mb,
	maxsize = 20mb,
	filegrowth = 5mb
) log on (
	name = 'PhoneStore_log',
	filename = 'D:\Programacion\SQL\SQL Server\PhoneStore\PhoneStore.ldf',
	size = 5mb,
	maxsize = 10mb,
	filegrowth = 5mb
);

use PhoneStore;
go;

create schema Entrada;
create schema Salida;
create schema Producto;
create schema Persona;

create table Producto.Telefono (
	idTelefono int constraint pk_Telefono_idTelefono primary key identity(1,1),
	nombre varchar(50) not null,
	marca varchar(30) not null,
	procesador varchar(30) not null,
	os varchar(20) not null,
	camaraPrincipal varchar(50) not null,
	camaraFrontal varchar(50) not null,
	bateria varchar(20) not null,
	almacenamiento varchar(20) not null,
	ram varchar(20) not null,
	color varchar(20) not null,
	estado varchar(20) not null
);

create table Producto.Detalle_Telefono (
	idTelefono int constraint fk_Detalle_Telefono_idTelefono foreign key
	references Producto.Telefono (idTelefono),
	precioVenta money not null, 
	precioCompra money not null, 
	existencias smallint not null,
	existenciasMinimas smallint not null,
);

create table Persona.Usuario (
	idUsuario int constraint pk_Usuario_idUsuario primary key identity(1,1),
	nombres varchar(30) not null,
	apellidos varchar(30) not null,
	correo varchar(50) not null,
	rol varchar(20) not null
);

create table Persona.Proveedor (
	idProveedor int constraint pk_Proveedor_idProveedor primary key identity(1,1),
	nombres varchar(30) not null,
	apellidos varchar(30) not null,
	correo varchar(50) not null,
	telefono varchar(20) not null
);

create table Entrada.Entrada (
	idEntrada int constraint pk_Entrada_idEntrada primary key identity(1,1),
	fechaEntrada smalldatetime default getDate(),
	idProveedor int constraint fk_Entrada_idProveedor foreign key
	references Persona.Proveedor (idProveedor),
	observacion varchar(200) not null,
	idUsuario int constraint fk_Entrada_idUsuario foreign key
	references Persona.Usuario (idUsuario)
);

create table Entrada.Detalle_Entrada (
	idEntrada int constraint fk_Detalle_Entrada_idEntrada foreign key 
	references Entrada.Entrada (idEntrada),
	idTelefono int constraint fk_Detalle_Entrada_idTelefono foreign key
	references Producto.Telefono (idTelefono),
	cantidadEntrante smallint not null
);

create table Salida.Venta (
	idVenta int constraint pk_Venta_idVenta primary key identity(1,1),
	fechaVenta smalldatetime default getDate(),
	observacion varchar(200) not null,
	idUsuario int constraint fk_Venta_idUsuario foreign key
	references Persona.Usuario (idUsuario),
	descuento decimal(5,2) not null,
	cliente varchar(50) not null,
	subTotal money not null
);

create table Salida.Detalle_Venta (
	idVenta int constraint fk_Detalle_Venta_idVenta foreign key 
	references Salida.Venta (idVenta),
	idTelefono int constraint fk_Detalle_Venta_idTelefono foreign key
	references Producto.Telefono (idTelefono),
	cantidadVendida smallint not null
);