
drop database Projecto_1;
create database Projecto_1;
use Projecto_1;
SET FOREIGN_KEY_CHECKS=0;

create table `Productos` (
	`id`		varchar(255) ,
    `Marca` 			varchar(100),
    `Producto`			varchar(250),
	`Unidad`			varchar(250),
    `n1`				varchar(30),
    `n2`				varchar(30),
    `y3`				varchar(30)
 
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_spanish_ci;
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Productos.csv'  
into table `Productos` 
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;


create table `Sucursal` (
	`IdSucursal`			Varchar(250) ,
    `comercioId` 			varchar(50),
    `banderaId`				varchar(50),
	`banderaDescripcion`    varchar(255),
    `comercioRazonSocial`	varchar(255),
    `provincia`				varchar(30),
    `localidad`				varchar(100),
    `direccion`				varchar(250),
    `lat`					varchar(30),
    `lng`					varchar(30),
    `sucursalNombre`		varchar(100),
    `sucursalTipo`		    varchar(100)
 
	
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_spanish_ci;
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\sucursal.csv'  
into table `Sucursal` 
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;


create table `precios_semanas_20200419_20200426` (
	`precio`					Varchar(250)null,
    `sucursal_id` 			     varchar(250)null,
    `producto_id`				varchar(250)null
		
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_spanish_ci;
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\precios_semanas_20200419_20200426.csv'  
into table `precios_semanas_20200419_20200426` 
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;


create table `precios_semana_20200519` (
	`precio`					Varchar(250) ,
    `sucursal_id` 		    	varchar(250),
    `producto_id`				varchar(50)
		
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_spanish_ci;
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\precios_semana_20200518.csv'  
into table `precios_semana_20200519` 
FIELDS TERMINATED BY '|' ENCLOSED BY ' ' ESCAPED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;


create table `precios_semana_20200503` (
	`precio`					Varchar(250),
    `sucursal_id` 		    	varchar(255),
    `producto_id`				varchar(250)
		
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_spanish_ci;
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\precios_semana_20200503.csv'  
into table `precios_semana_20200503` 
FIELDS TERMINATED BY ','  ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;


create table `precios_semana_20200413` (
	`precio`				   varchar(250)null ,
    `producto_id` 				varchar(250) ,
    `sucursal_id`				varchar(250)  
		
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_spanish_ci;
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\precios_semana_20200413.csv'  
into table `precios_semana_20200413` 
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\"'  
LINES TERMINATED BY '\n'  IGNORE 1 lines   ; 

#ETl
#Elimina columnas de tabla producos
ALTER TABLE Productos DROP COLUMN n1;
ALTER TABLE Productos DROP COLUMN n2;
ALTER TABLE Productos DROP COLUMN y3;
#productosponemos sin dato a valores nulos 
ALTER TABLE `Productos` CHANGE `id` `IdProducto` varchar(250) ;
UPDATE `Productos` SET IdProducto = 'Sin Dato' WHERE TRIM(IdProducto) = "n" OR ISNULL(IdProducto);
UPDATE `Productos` SET Marca = 'Sin Dato' WHERE TRIM(Marca) = "n" OR ISNULL(Marca);
UPDATE `Productos` SET Producto = 'Sin Dato' WHERE TRIM(Producto) = "n" OR ISNULL(Producto);
UPDATE `Productos` SET Unidad = 'Sin Dato' WHERE TRIM(Unidad) = "n" OR ISNULL(Unidad);
UPDATE `Productos` SET IdProducto = REPLACE(IdProducto,'-','');




#ETL de tabla Sucursal 
ALTER TABLE `sucursal` CHANGE `comercioId` `IdComercio` varchar(50) ;
ALTER TABLE `sucursal` CHANGE `banderaId` `IdBandera` varchar(255) ;
ALTER TABLE `sucursal` CHANGE `banderaDescripcion` `Bandera_Descipcion` varchar(255) ;
ALTER TABLE `sucursal` CHANGE `comercioRazonSocial` `Razon_Social_Comercio` varchar(250) ;
ALTER TABLE `sucursal` CHANGE `provincia` `Provincia` varchar(30) ;
ALTER TABLE `sucursal` CHANGE `localidad` `Localidad` varchar(100) ;
ALTER TABLE `sucursal` CHANGE `direccion` `Direccion_Sucursal` varchar(250) ;
ALTER TABLE `sucursal` CHANGE `lat` `Latitud` varchar(30) ;
ALTER TABLE `sucursal` CHANGE `lng` `Longitud` varchar(30) ;
ALTER TABLE `sucursal` CHANGE `sucursalNombre` `Nombre_Sucursal` varchar(100) ;
ALTER TABLE `sucursal` CHANGE `sucursalTipo` `Tipo_Sucursal` varchar(100);
ALTER TABLE sucursal DROP COLUMN Latitud ;
ALTER TABLE sucursal DROP COLUMN Longitud ;



#Etl de precios_semanas_20200419_20200426
ALTER TABLE `precios_semanas_20200419_20200426` CHANGE `precio` `Precio` varchar(250) ;
ALTER TABLE `precios_semanas_20200419_20200426` CHANGE `sucursal_id` `IdSucursal` varchar(255) ;
ALTER TABLE `precios_semanas_20200419_20200426` CHANGE `producto_id` `IdProducto` varchar(250) ;
UPDATE `precios_semanas_20200419_20200426` SET Precio = 'Sin Dato' WHERE TRIM(precio) = " " OR ISNULL(precio);
UPDATE `precios_semanas_20200419_20200426` SET IdSucursal = 'Sin Dato' WHERE TRIM(IdSucursal) = " " OR ISNULL(IdSucursal);
UPDATE `precios_semanas_20200419_20200426` SET IdProducto = 'Sin Dato' WHERE TRIM(IdProducto) = " " OR ISNULL(IdProducto);
ALTER TABLE `precios_semanas_20200419_20200426`
MODIFY Precio varchar(250)
AFTER IdProducto;
UPDATE `precios_semanas_20200419_20200426` SET IdProducto = REPLACE(IdProducto,'-','');
ALTER TABLE precios_semanas_20200419_20200426
ADD Fecha VARCHAR(20) NULL ;
UPDATE `precios_semanas_20200419_20200426` SET Fecha = '2020/05/19-26' WHERE TRIM(Fecha) = " " OR ISNULL(Fecha);


#Etl de precios_semana_20200519
ALTER TABLE `precios_semana_20200519` CHANGE `precio` `Precio` varchar(250) ;
ALTER TABLE `precios_semana_20200519` CHANGE `sucursal_id` `IdSucursal` varchar(255) ;
ALTER TABLE `precios_semana_20200519` CHANGE `producto_id` `IdProducto` varchar(250) ;
UPDATE `precios_semana_20200519` SET Precio = 'Sin Dato' WHERE TRIM(precio) = " " OR ISNULL(precio);
UPDATE `precios_semana_20200519` SET IdSucursal = 'Sin Dato' WHERE TRIM(IdSucursal) = " " OR ISNULL(IdSucursal);
UPDATE `precios_semana_20200519` SET IdProducto = 'Sin Dato' WHERE TRIM(IdProducto) = " " OR ISNULL(IdProducto);
ALTER TABLE `precios_semana_20200519`
MODIFY Precio varchar(250)
AFTER IdProducto;
UPDATE `precios_semana_20200519` SET IdProducto = REPLACE(IdProducto,'-','');
ALTER TABLE precios_semana_20200519
ADD Fecha VARCHAR(20) NULL ;
UPDATE `precios_semana_20200519` SET Fecha = '2020/05/18' WHERE TRIM(Fecha) = " " OR ISNULL(Fecha);
UPDATE `precios_semana_20200519` SET IdSucursal = REPLACE(IdSucursal,'"','');



#Etl de precios_semana_20200413
ALTER TABLE `precios_semana_20200413` CHANGE `precio` `Precio` varchar(250) ;
ALTER TABLE `precios_semana_20200413` CHANGE `sucursal_id` `IdSucursal` varchar(250) ;
ALTER TABLE `precios_semana_20200413` CHANGE `producto_id` `IdProducto` varchar(250) ;
UPDATE `precios_semana_20200413` SET Precio = 'Sin Dato' WHERE TRIM(precio) = " " OR ISNULL(precio);
UPDATE `precios_semana_20200413` SET IdSucursal = 'Sin Dato' WHERE TRIM(IdSucursal) = " " OR ISNULL(IdSucursal);
UPDATE `precios_semana_20200413` SET IdProducto = 'Sin Dato' WHERE TRIM(IdProducto) = " " OR ISNULL(IdProducto);
ALTER TABLE `precios_semana_20200413`
MODIFY Precio varchar(250)
AFTER IdSucursal;
ALTER TABLE `precios_semana_20200413`
MODIFY IdProducto varchar(250)
AFTER IdSucursal;
UPDATE `precios_semana_20200413` SET IdProducto = REPLACE(IdProducto,'-','');
ALTER TABLE precios_semana_20200413
ADD Fecha VARCHAR(20) NULL ;
UPDATE `precios_semana_20200413` SET Fecha = '2020/04/13' WHERE TRIM(Fecha) = " " OR ISNULL(Fecha);



#Etl de precios_semana_20200503

ALTER TABLE `precios_semana_20200503` CHANGE `precio` `Precio` varchar(255) ;
ALTER TABLE `precios_semana_20200503` CHANGE `sucursal_id` `IdSucursal` varchar(255) ;
ALTER TABLE `precios_semana_20200503` CHANGE `producto_id` `IdProducto` varchar(250) ;
ALTER TABLE `precios_semana_20200503` CHANGE `IdProducto` `IdSucursal1` varchar(50) ;
ALTER TABLE `precios_semana_20200503` CHANGE `IdSucursal` `IdProducto` varchar(50) ;
ALTER TABLE `precios_semana_20200503` CHANGE `IdSucursal1` `IdSucursal` varchar(50) ;
UPDATE `precios_semana_20200503` SET Precio = 'Sin Dato' WHERE TRIM(precio) = " " OR ISNULL(precio);
UPDATE `precios_semana_20200503` SET IdSucursal = 'Sin Dato' WHERE TRIM(IdSucursal) = " " OR ISNULL(IdSucursal);
UPDATE `precios_semana_20200503` SET IdProducto = 'Sin Dato' WHERE TRIM(IdProducto) = " " OR ISNULL(IdProducto);
ALTER TABLE `precios_semana_20200503`
MODIFY IdProducto varchar(250)
AFTER IdSucursal;
ALTER  TABLE `precios_semana_20200503`
MODIFY Precio varchar(250)
AFTER IdProducto;
UPDATE `precios_semana_20200503` SET IdProducto = REPLACE(IdProducto,'-','');
ALTER TABLE precios_semana_20200503
ADD Fecha VARCHAR(20) NULL ;
UPDATE `precios_semana_20200503` SET Fecha = '2020/05/03' WHERE TRIM(Fecha) = " " OR ISNULL(Fecha);


#Creamo relaciones con las tablas producto y sucursales y unificamos las tablas  
  alter table sucursal
  add primary key (IdSucursal);
  alter table productos
  add primary key (IdProducto);



create table Precio_Fecha_Semana (
  `IdSucursal` 		    	 varchar(255),
	`IdProducto`				varchar(250),
    `Precio`					varchar(255),
    `Fecha`						varchar(250),
    FOREIGN KEY (IdProducto) REFERENCES productos(IdProducto),
	FOREIGN KEY (IdSucursal) REFERENCES sucursal(IdSucursal)
)engine=InnoDB default charset=utf8mb4 collate=utf8mb4_spanish_ci;
ALTER TABLE `precios_semana_20200503` CHANGE `sucursal_id` `IdSucursal` varchar(255) ;

INSERT INTO Precio_Fecha_Semana 
SELECT * FROM precios_semanas_20200419_20200426;
INSERT INTO Precio_Fecha_Semana 
SELECT * FROM precios_semana_20200503;
INSERT INTO Precio_Fecha_Semana 
SELECT * FROM precios_semana_20200413;
INSERT INTO Precio_Fecha_Semana
select * from precios_semana_20200519;

#eliminamos las tablas 

##sacamos El promedio de preio
select avg(Precio)
from Precio_Fecha_Semana 
where IdSucursal like '9-1-688%'

