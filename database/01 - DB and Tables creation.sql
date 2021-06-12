use master;
go;

create database PhoneStore on primary (
	name = 'PhoneStore_dat',
	filename = 'D:\Programacion\SQL\SQL Server\PhoneStore\PhoneStore.mdf',
	size = 10mb,
	maxsize = 20mb,
	filegrowth = 5mb
) log on (
	name = 'PhoneStore_lof',
	filename = 'D:\Programacion\SQL\SQL Server\PhoneStore\PhoneStore.ldf',
	size = 5mb,
	maxsize = 10mb,
	filegrowth = 5mb
);

use PhoneStore;
go;

create table Telefono (
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
	precioVenta money not null, 
	precioCompra money not null, 
	existencias smallint not null,
	existenciasMinimas smallint not null,
	estado tinyint not null
);

create table Usuario (
	idUsuario int constraint pk_Usuario_idUsuario primary key identity(1,1),
	nombre varchar(60) not null,
	correo varchar(50) not null,
	rol varchar(30) not null
);

create table Proveedor (
	idProveedor int constraint pk_Proveedor_idProveedor primary key identity(1,1),
	nombres varchar(30) not null,
	apellidos varchar(30) not null,
	correo varchar(50) not null,
	telefono varchar(20) not null
);

create table Entrada (
	idEntrada int constraint pk_Entrada_idEntrada primary key identity(1,1),
	fechaEntrada smalldatetime default getDate(),
	idProveedor int constraint fk_Entrada_idProveedor foreign key
	references Proveedor (idProveedor),
	observacion varchar(200) not null,
	idUsuario int constraint fk_Entrada_idUsuario foreign key
	references Usuario (idUsuario)
);

create table Detalle_Entrada (
	idEntrada int constraint fk_Detalle_Entrada_idEntrada foreign key 
	references Entrada (idEntrada),
	idTelefono int constraint fk_Detalle_Entrada_idTelefono foreign key
	references Telefono (idTelefono),
	cantidadEntrante smallint not null
);

create table Venta (
	idVenta int constraint pk_Venta_idVenta primary key identity(1,1),
	fechaVenta smalldatetime default getDate(),
	observacion varchar(200) not null,
	idUsuario int constraint fk_Venta_idUsuario foreign key
	references Usuario (idUsuario),
	descuento decimal not null,
	cliente varchar(50) not null,
	subTotal money not null,
	total money not null
);

create table Detalle_Venta (
	idVenta int constraint fk_Detalle_Venta_idVenta foreign key 
	references Venta (idVenta),
	idTelefono int constraint fk_Detalle_Venta_idTelefono foreign key
	references Telefono (idTelefono),
	cantidadVendida smallint not null,
	gananciaVenta money not null
);