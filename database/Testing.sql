use PhoneStore;
go;

-- Testing de inserción

exec sp_nuevoProveedor 'Luis', 'Gonzalez', 'luisgonzales@gmail.com', '81457391'; 
exec sp_nuevoProveedor 'Eduardo Antonio', 'Varela Orozco', 'csmike81@gmail.com', '81457391'; 
exec sp_nuevoProveedor 'Maria', 'Artola', 'ejemplo@ejemplo.com', '78454126'; 
exec sp_nuevoProveedor 'Gisselle Nayeli', 'Romero Castillo', 'correo@correo.com', '46548979'; 
exec sp_nuevoProveedor 'Allison Nicole', 'Cerda Hernandez', 'ali@maria.com', '31354987'; 

exec sp_nuevoUsuario 'Eduardo Antonio', 'Varela Orozco', 'eduardovarela139@gmail.com', 'Administrador';
exec sp_nuevoUsuario 'Antonella', 'Gozo', 'eduardovarela139@gmail.com', 'Administrador';
exec sp_nuevoUsuario 'Halsey', 'Nochon', '', 'Administrador';
exec sp_nuevoUsuario 'Ricardo', 'Mayorga', '', 'Administrador';
exec sp_nuevoUsuario 'Juan', 'Caldera', '', 'Administrador';

exec sp_nuevoTelefono 'Galaxy S7', 'Samsung', 'Exynos', 'Android', '12MP', '5MP', '3000mAh', '32GB', '4GB', 'Negro', '300', '250', '7', '2', 'Usado', 1, 'Luis Gonzalez';
exec sp_nuevoTelefono 'Galaxy S8', 'Samsung', 'Exynos', 'Android', '20MP', '8MP', '7000mAh', '64GB', '2GB', 'Rojo', '500', '450', '15', '3', 'Nuevo', 1, 'Eduardo Antonio Varela Orozco';
exec sp_nuevoTelefono 'Galaxy S9', 'Samsung', 'Exynos', 'Android', '12MP', '7MP', '4000mAh', '32GB', '2GB', 'Negro', '1000', '900', '20', '5', 'Usado', 3, 'Luis Gonzalez';
exec sp_nuevoTelefono 'IPhone 12', 'Apple', 'Intel', 'iOS', '13MP', '5MP', '5200mAh', '64GB', '6GB', 'Celeste', '300', '150', '35', '15', 'Nuevo', 1, 'Maria Artola';
exec sp_nuevoTelefono 'ZenPhone 4', 'ASUS', 'MediaTek', 'Android', '12MP', '5MP', '4500mAh', '128GB', '4GB', 'Rosado', '600', '400', '90', '20', 'Usado', 5, 'Luis Gonzalez';

exec sp_nuevaEntrada 'Eduardo Antonio Varela Orozco', 2 , 'Galaxy S7', 40, '';
exec sp_nuevaEntrada 'Luis Gonzalez', 5 , 'Galaxy S7', 30, '';
exec sp_nuevaEntrada 'Eduardo Antonio Varela Orozco', 4 , 'Galaxy S8', 20, '';
exec sp_nuevaEntrada 'Eduardo Antonio Varela Orozco', 1 , 'Galaxy S9', 10, 'Productos usados';
exec sp_nuevaEntrada 'Luis Gonzalez', 3 , 'IPhone 12', 350, '';
exec sp_nuevaEntrada 'Allison Nicole Cerda Hernandez', 2 , 'IPhone 12', 20, '';
exec sp_nuevaEntrada 'Gisselle Nayeli Romero Castillo', 5 , 'ZenPhone 4', 50, '';

exec sp_nuevaVenta 1, 10, 'Emilio Valentino', 'Galaxy S7', 1,  'Ninguna';
exec sp_nuevaVenta 4, 15.3, 'Emilio Florentino', 'Galaxy S8', 5,  'Ninguna';
exec sp_nuevaVenta 2, 16.2, 'Elcho Tomayor', 'Galaxy S9', 3,  'Alguna observacion';
exec sp_nuevaVenta 1, 25.32, 'Elma Mador', 'IPhone 12', 7,  'Observacion';
exec sp_nuevaVenta 3, 5.5, 'Dora Exploradora', 'ZenPhone 4', 6,  'Ninguna';

-- Testing de selección

exec sp_obtenerTelefonos;
exec sp_obtenerTelefonoPorId 2;
exec sp_obtenerProveedores;
exec sp_obtenerProveedorPorId 3;
exec sp_obtenerUsuarios;
exec sp_obtenerUsuarioPorId 3;
exec sp_obtenerEntradas;
exec sp_obtenerEntradaPorId 10;
exec sp_obtenerVentas;
exec sp_obtenerVentaPorId 5;