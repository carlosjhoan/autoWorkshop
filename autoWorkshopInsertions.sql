USE autoworkshop;

-- Insertintos into country table
INSERT INTO country(name)
VALUES	('Colombia'),
			('Ecuador'),
			('Argentina');
	
-- Insertintos into region table	
INSERT INTO region(name, fkCountryId)
VALUES	('Santander', 1),
			('Antioquia', 1),
			('Guayas', 2),
			('Azuay', 2),
			('Santa Fé', 3),
			('Buenos Aires', 3);

-- Insertintos into city table	
INSERT INTO city(name, postalCode, fkRegionId)
VALUES	('Bucaramanga', '680001', 1),
			('Medellín', '050001', 2),
			('Guayaquil', '090101', 3),
			('Cuenca', '010101', 4),
			('Rosario', '2000', 5),
			('Buenos Aires', '1228', 6);

-- insertions into customer table
INSERT INTO customer(firstName, lastName, email)
VALUES	('Juan Carlos', 'Aguilar', 'juanchopolo66@gmail.com'),
			('GAVASSA SA LTDA', NULL, 'gavassaSA@gmail.com'),
			('Julio César', 'Galvis', 'jjuliogalvis65@gmail.com'),
			('GÓMEZ PAN SA', NULL, 'pangomezpan@gmail.com'),
			('Luis Alfonso', 'Gómez Mancilla', 'lualgoman@gmail.com'),
			('PENAGOS & HERMANOS', NULL, 'penagosyhnos@gmail.com'),
			('FARMATODO SA', NULL, 'farmatodocompany@gmail.com'),
			('Aracely', 'López Guzmán', 'aralogu@gmail.com'),
			('Leidy Stefany', 'Valencia Hernández', 'lulustefval@gmail.com'),
			('VIJUAGUAL CARNES SA', NULL, 'carnescompanyvijagua@gmail.com');
	
	-- Insertions into brand table
	INSERT INTO brand(name)
	VALUES	('Toyota'),
				('Ford'),
				('Chvrolet'),
				('Honda'),
				('Volkswagen'),
				('Volvo'),
				('Nissan'),
				('Renault'),
				('Craftsman'),
				('Snap-On'),
				('Matco Tools'),
				('Kobalt'),
				('Stanley'),
				('DEWALT'),
				('Bosch'),
				('Milwaukee');
	
	INSERT INTO brand(name)
	VALUES	('Mann-Filter'),
				('NGK'),
				('Brembo'),
				('KYB'),
				('Optima'),
				('Michelin'),
				('Goodyear'),
				('Denso'),
				('Aisin'),
				('K&N'),
				('Continental'),
				('Spectra Premium'),
				('Sachs'),
				('SKF');
				
	
	-- Insertions into carModel table
	INSERT INTO carModel(fkBrandId, model)
	VALUES 	(1, 'Corolla'),
				(1, 'Camry'),
				(1, 'RAV4'),
				(1, 'Hilux'),
				(2, 'Escape'),
				(2, 'Focus'),
				(2, 'Fiesta'),
				(3, 'Dimax'),
				(3, 'Optra'),
				(3, 'Aveo'),
				(4, 'Pilot'),
				(4, 'Civic'),
				(4, 'Accord'),
				(5, 'Golf'),
				(5, 'Jetta'),
				(6, 'FH'),
				(6, 'FM'),
				(6, 'VNL'),
				(7, 'Sentra'),
				(8, 'Clio'),
				(8, 'Megane'),
				(8, 'Koleos');
	
	
	-- Insertions into vehicle table
	INSERT INTO vehicle(numberPlate, fkCarModelId, fabYear, fkCustomerId)
	VALUES	('AUX258', 1, '2008', 1),
				('AXC325', 2, '2012', 2),
				('ADC458', 3, '2016', 2),
				('XMN459', 4, '2018', 2),
				('VCD186', 8, '2017', 2),
				('XUV125', 5, '2017', 3),
				('XMV753', 6, '2011', 4),
				('XCD426', 7, '2015', 4),
				('XGL251', 8, '2020', 4),
				('BTR942', 20, '2013', 5),
				('XMN356', 4, '2019', 6),
				('FGH719', 8, '2017', 6),
				('BGF369', 16, '2018', 6),
				('VDC845', 18, '2022', 6),
				('ACF354', 19, '2008', 7),
				('ATT546', 21, '2016', 7),
				('XSD301', 4, '2019', 8),
				('XUV620', 10, '2022', 9),
				('AXD798', 18, '2021', 10),
				('XVN531', 4, '2023', 10),
				('XUV412', 17, '2020', 10);
	
	-- Insertions into headquarter table	
	INSERT INTO headquarter(name, address, fkCityId)
	VALUES ('Taller Bucaramanga', 'Calle 56 #26-48, La Concordia', 1),
			 ('Taller Medellín', 'Carrera 43A #1-50, Barrio El Poblado', 2),
			 ('Taller Guayaquil', 'Avenida 9 de Octubre #100 y P. Icaza, Barrio Centro', 3),
			 ('Taller Cuenca', 'Calle Larga 8-63 y Luis Cordero, Barrio El Centro', 4),
			 ('Taller Rosario', 'Calle Córdoba 1555, Barrio Centro', 5),
			 ('Taller Buenos Aires', 'Avenida Corrientes 348, Barrio San Nicolás', 6);
	
	-- Insertions into zone table
	INSERT INTO zone(name, description)
	VALUES	('Área de Recepción y Atención al Cliente', 'Donde se reciben a los clientes, se registran sus solicitudes y se les proporciona información sobre los servicios disponibles.'),
				('Área de Diagnóstico', 'Donde se realizan pruebas y diagnósticos para identificar problemas mecánicos y eléctricos en los vehículos.'),
				('Área de Reparación General', 'Donde se llevan a cabo las reparaciones y mantenimiento general de los vehículos, como cambio de aceite, filtros, pastillas de freno, etc.'),
				('Área de Mecánica', 'Donde se realizan reparaciones y mantenimiento específicos del motor, transmisión, suspensión, dirección, y otros sistemas mecánicos del vehículo.'),
				('Área de Electricidad y Electrónica', 'Donde se realizan diagnósticos y reparaciones en sistemas eléctricos y electrónicos del vehículo, como el sistema de encendido, luces, sistema de gestión del motor, entre otros.'),
				('Área de Carrocería y Pintura', 'Donde se llevan a cabo reparaciones de chapa y pintura, incluyendo enderezado de carrocería, reparación de golpes, y pintura de vehículos.'),
				('Área de Llantas y Alineación', 'Donde se realizan servicios relacionados con las llantas, como cambio, balanceo, alineación y reparaciones.'),
				('Área de Almacenamiento y Suministros', 'Donde se almacenan las piezas de repuesto, herramientas y suministros necesarios para el trabajo en el taller.');
				
	
	-- Insertions into onSiteService table
	INSERT INTO onSiteService(name, description, fkZoneId, price)
	VALUES	('Cambio de aceite y filtro', 'Cambio del lubricante del motor y del filtro de aceite.', 3, 65000.0),
				('Reparación de frenos', 'Incluyendo cambio de pastillas, discos y revisión del sistema de frenado.', 3, 100000.0),
				('Alineación y balanceo', 'Ajuste de la alineación de las ruedas y equilibrado de las llantas para un desgaste uniforme y una conducción suave.', 7, 350000.0),
				('Revisión y mantenimiento periódico', 'Inspección general del vehículo y reemplazo de piezas según el programa de mantenimiento recomendado por el fabricante.', 2, 400000.0),
				('Diagnóstico de fallas', 'Identificación y reparación de problemas mecánicos y eléctricos a través de pruebas y análisis.', 2, 400000.0),
				('Reparación de sistemas de suspensión y dirección', 'Incluyendo cambio de amortiguadores, muelles, barras estabilizadoras y revisión de la dirección.', 4, 350000.0),
				('Reparación de sistemas de transmisión', 'Incluyendo cambios de aceite, ajustes, reparaciones de fugas y reconstrucción de transmisiones automáticas o manuales.', 4, 420000.0),
				('Reparación de sistemas de enfriamiento', 'Incluyendo cambio de líquido refrigerante, reparación de fugas, cambio de radiadores y termostatos.', 4, 470000.0),
				('Diagnóstico y reparación de sistemas eléctricos y electrónicos', 'Incluyendo problemas de encendido, luces, sistemas de seguridad, y sistemas de entretenimiento', 5, 350000.0),
				('Reparación de sistemas de escape', 'Incluyendo cambio de catalizadores, silenciadores, y revisión del sistema de escape para prevenir fugas y reducir emisiones.', 4, 220000.0),
				('Reparación de sistema de climatización', '', 4, 410000.0),
				('Servicios de carrocería y pintura', 'Incluyendo reparación de golpes, enderezado de chasis, pintura y retoque estético', 6, 310000.0);
				
	
	-- Insertions into outSiteService table
	INSERT INTO outSiteService(name, description, price)
	VALUES	('Reparación de pinchazos', 'Si el vehículo tiene un neumático pinchado, el taller puede ofrecer reparación in situ o cambio de neumático.', 80000.0),
				('Servicio de arranque', 'Si el vehículo no arranca debido a problemas con la batería, el taller puede ofrecer servicios de arranque con cables o carga de batería.', 110000.0),
				('Diagnóstico de problemas mecánicos', 'Si el vehículo presenta problemas mecánicos, como fallas en el motor o en otros sistemas, el taller puede realizar un diagnóstico rápido para identificar la causa del problema', 420000.0),
				('Reparaciones menores', 'Si el problema puede ser resuelto en el lugar, el taller puede realizar reparaciones menores, como reemplazo de fusibles, ajustes de cables, etc.', 150000.0),
				('Servicio de remolque', 'Si el vehículo no puede ser reparado en el lugar, el taller puede ofrecer servicios de remolque para transportarlo a su taller o a otro destino seguro.', 150000.0);
	
	-- insertions into job table
	INSERT INTO job(jobName)
	VALUES	('Técnico en Mecánica automotriz'),
				('Técnico en electrónica automotriz'),
				('Pintor automotriz'),
				('Auxiliar de taller'),
				('Gerente de taller'),
				('Recepcionista o asistente de servicio'),
				('Especialista en diagnóstico'),
				('Administrador de inventario'),
				('Especialista en aire acondicionado automotriz'),
				('Especialista en sistemas de frenos'),
				('Especialista en sistemas de dirección y suspensión'),
				('Especialista en sistemas de transmisión'),
				('Especialista en sistemas de escape'),
				('Técnico en sistemas de seguridad'),
				('Especialista en sistemas de inyección');

-- Insertions into employee table			
INSERT INTO employee(firstName, lastName, fkJobId, fkHeadquarterId, email)
VALUES	('María', 'López Martínez', 3, 1, 'maria.lopezmartinez@gmail.com'),
			('Juan', 'Martínez García', 6, 1, ' juan.martinezgarcia@gmail.com'),
			('Laura', 'Rodríguez Hernández', 1, 1, 'laura.rodriguezhernandez@gmail.com'),
			('carlos', ' García Pérez', 2, 1, 'carlos.garciaperez@gmail.com'),
			('Ana', 'Herrera Rodríguez', 4, 1, 'ana.herrerarodriguez@gmail.com'),
			('Luis', 'Fernández Pérez', 4, 1, ' luis.fernandezperez@gmail.com'),
			('Sofía', 'Pérez Martínez', 5, 1, 'sofia.perezmartinez@gmail.com'),
			('Alejandro', 'Díaz González', 6, 1, 'alejandro.diazgonzalez@gmail.com'),
			('Andrea', 'Torres Gómez', 7, 1, 'andrea.torresgomez@gmail.com'),
			('David', 'Sánchez Vargas', 4, 1, 'david.sanchezvargas@gmail.com'),
			('Paula', 'Ramírez Ruiz', 8, 1, 'paula.ramirezruiz@gmail.com'),
			('Javier', 'Gómez García', 9, 1, ' javier.gomezgarcia@gmail.com'),
			('Natalia', 'Vargas López', 10, 1, 'natalia.vargaslopez@gmail.com'),
			('Diego', 'Castro Sánchez', 4, 1, 'diego.castrosanchez@gmail.com'),
			('Carolina', 'Medina Torres', 1, 1, 'carolina.medinatorres@gmail.com'),
			('Manuel', 'Nuñez Rodríguez', 11, 1, 'manuel.nunezrodriguez@gmail.com'),
			('Gabriela', 'Castro Pérez', 12, 1, 'gabriela.castroperez@gmail.com'),
			('Daniel', 'Alvarez Hernández', 13, 1, 'daniel.alvarezhernandez@gmail.com'),
			('Valentina', 'Ruiz García', 14, 1, 'valentina.ruizgarcia@gmail.com'),
			('Miguel', 'López Martínez', 15, 1, 'miguel.lopezmartinez@gmail.com'),
			('Lorenzo', 'López González', 3, 1, 'lorenzo.lopez.gonzalez@gmail.com');
			
-- Insertions into repair table
INSERT INTO repair(fkVehicleId, repairDateIn, repairDateOut, description)
VALUES	(1, '2020-01-30', '2020-02-16', 'Se realizó un cambio de aceite y filtro como parte del mantenimiento programado del vehículo.'),
			(2, '2021-03-20', '2021-04-04', 	'Se realizó un servicio completo de mantenimiento, que incluyó cambio de aceite, filtros, revisión de frenos y ajuste de la alineación.'),
			(3, '2021-03-20', '2021-04-04', 'Se solucionaron múltiples problemas eléctricos, que incluyeron el reemplazo de fusibles quemados, reparación de un cortocircuito y ajuste de conexiones sueltas.'),
			(4, '2022-04-08', '2022-04-12', 'Se reparó una fuga en el sistema de escape mediante la soldadura de una fisura en el tubo de escape.'),
			(5, '2022-04-08', '2022-04-20', 'Se realizó una revisión exhaustiva del sistema de suspensión y dirección, con reemplazo de amortiguadores, barras estabilizadoras y reparación de rótulas desgastadas.'),
			(6, '2022-05-10', '2022-06-15', 'Se realizaron múltiples reparaciones en el sistema de frenos, que incluyeron el reemplazo de pastillas, discos, cilindros de freno y reparación de un problema de vacío en el sistema.'),
			(7, '2023-04-03', '2023-06-17', 'Se realizó una revisión exhaustiva del sistema de transmisión, con reemplazo del fluido de transmisión, filtro y ajuste de los engranajes para mejorar la suavidad de cambio.'),
			(8, '2023-04-03', '2023-06-17', 'Se reparó una fuga en el sistema de dirección hidráulica mediante la sustitución de una manguera deteriorada.'),
			(9, '2023-04-03', '2023-06-17', 'Se solucionó un problema de sobrecalentamiento del motor mediante el reemplazo de la bomba de agua, la reparación de una fuga en el sistema de refrigeración y la limpieza del radiador.'),
			(10, '2020-08-10', '2020-08-17', 'Se reemplazó el sensor de oxígeno defectuoso para corregir un código de error del sistema de control de emisiones.'),
			(10, '2022-02-10', '2022-03-02', 'Se le apagó en el camino. Se realizaron múltiples reparaciones en el sistema de encendido, que incluyeron el reemplazo de bujías, cables de encendido, bobina de encendido y ajuste del tiempo de encendido.'),	
			(11, '2023-09-20', '2023-10-15', 'Se solucionó un problema de vibración en la dirección mediante el reemplazo de los neumáticos desgastados, balanceo de ruedas y alineación de la dirección.'),
			(12, '2023-09-20', '2023-10-15', 'Se solucionó un problema de vibración en la dirección mediante el reemplazo de los neumáticos desgastados, balanceo de ruedas y alineación de la dirección'),
			(13, '2024-01-20', '2024-03-15', 'Se llevó a cabo una reparación integral del sistema de combustible, que incluyó el reemplazo de la bomba de combustible, el filtro de combustible y la limpieza de los inyectores.'),
			(14, '2024-01-20', '2024-03-15', 'Se realizó una revisión completa del sistema de iluminación, con reemplazo de bombillas, reparación de conexiones sueltas y ajuste de los faros para mejorar la visibilidad nocturna.'),
			(15, '2024-05-20', '2024-05-25', 'Se pinchó en la carretera y el vehículo además se le apagó'),
			(16, '2024-05-26', '2024-06-03', 'Se realizó un servicio completo de mantenimiento, que incluyó cambio de aceite, filtros, revisión de frenos y ajuste de la alineación.'),
			(17, '2022-04-05', '2024-04-07', 'Se realizó un servicio completo de mantenimiento, que incluyó cambio de aceite, filtros, revisión de frenos y ajuste de la alineación.'),
			(18, '2020-03-06', '2020-03-14', 'Despinchada y arranque en la calle.'),	
			(18, '2021-10-28', '2021-11-10', 'Se llevó a cabo una reparación integral del sistema de frenado antibloqueo (ABS), que incluyó el reemplazo del módulo de control, sensores de velocidad y reparación de conexiones.'),	
			(19, '2023-10-01', '2023-10-20', 'Se solucionó un problema de arranque intermitente mediante el reemplazo del motor de arranque, la limpieza de los cables de la batería y la recarga del sistema eléctrico.'),
			(20, '2023-10-01', '2023-10-20', 'Reparación de la carrocería. Se llevó a cabo una reparación integral del sistema de combustible, que incluyó el reemplazo de la bomba de combustible, el filtro de combustible y la limpieza de los inyectores'),
			(21, '2023-10-01', '2023-10-20', 'Se realizó una revisión exhaustiva del sistema de suspensión y dirección, con reemplazo de amortiguadores, barras estabilizadoras y reparación de rótulas desgastadas.');
	
	
	-- insertions into invoice table
	INSERT INTO invoice(fkCustomerId, invoiceDate, fkHeadquarterId)
	VALUES	(1, '2020-02-16', 1),
				(2, '2021-04-04', 1),
				(2, '2022-04-20', 1),
				(3, '2022-06-15', 1),
				(4, '2023-06-17', 1),
				(5, '2020-08-17', 1),
				(5, '2022-03-02', 1),
				(6, '2023-10-15', 1),
				(6, '2024-03-15', 1),
				(7, '2024-05-25', 1),
				(7, '2024-06-03', 1),
				(8, '2024-04-07', 1),
				(9, '2020-03-14', 1),
				(9, '2021-11-10', 1),
				(10, '2023-10-20', 1); 
				

	-- Insertions into repairInvoice table
	INSERT INTO repairInvoice(fkInvoiceId, fkRepairId)
	VALUES	(1, 1),
				(2, 2),
				(2, 3),
				(3, 4),
				(3, 5),
				(4, 6),
				(5, 7),
				(5, 8),
				(5, 9),
				(6, 10),
				(7, 11),
				(8, 12),
				(8, 13),
				(9, 14),
				(9, 15),
				(10, 16),
				(11, 17),
				(12, 18),
				(13, 19),
				(14, 20),
				(15, 21),
				(15, 22),
				(15, 23);
	
-- Insertions into onSiteRepairService table
INSERT INTO onSiteRepairService(fkRepairId, fkOnSiteServiceId, spentTime, fkEmployeeId)
VALUES 	(1, 1, '04:20:00', 5),
			(2, 1, '02:10:00', 5),
			(2, 2, '03:00:00', 13),
			(2, 3, '04:00:00', 17),
			(3, 9, '06:00:00', 4),
			(4, 10, '04:15:00', 18),
			(5, 4, '05:20:00', 9),
			(5, 6, '03:00:00', 16),
			(6, 2, '04:15:00', 13),
			(7, 7, '05:10:0', 17),
			(7, 1, '02:00:00', 6),
			(8, 6, '03:20:00', 16),
			(9, 8, '04:25:00', 12),
			(10, 10, '03:35:00', 18),
			(11, 9, '04:20:00', 4),
			(12, 6, '03:20:00', 16),
			(13, 6, '02:50:00', 16),
			(14, 7, '03:15:00', 17),
			(14, 1, '02:23:00', 6),
			(15, 9, '05:30:00', 4),
			(17, 1, '02:10:00', 5),
			(17, 2, '03:00:00', 13),
			(17, 3, '04:00:00', 17),
			(18, 1, '02:10:00', 6),
			(18, 2, '03:00:00', 13),
			(18, 3, '04:00:00', 17),
			(20, 2, '06:35:00', 13),
			(21, 9, '04:30:00', 4),
			(22, 12, '08:00:00', 3),
			(22, 9, '03:40:00', 20),
			(23, 4, '05:20:00', 9),
			(23, 6, '03:00:00', 16);
			
-- Insertions into outSiteRepairService table			
INSERT INTO outSiteRepairService(fkRepairId, fkOutSiteServiceId, spentTime, fkEmployeeId, address, fkCityId)
VALUES 	(11, 2, '02:00:00', 4, 'Cra 33 #56-28, Cabecera', 1),	
			(16, 1, '01:10:00', 6, 'Cll 9 #25-82, Cristo Rey', 1),
			(16, 2, '02:20:00', 4, 'Cll 9 #25-82, Cristo Rey', 1),
			(19, 1, '1:30:00', 5, 'Cra 9 # 10-25, Gaitán', 1),
			(19, 2, '1:20:00', 4, 'Cra 9 # 10-25, Gaitán', 1);
			

-- Insertions into appointment table
INSERT INTO appointment(fkCustomerId, appointDate, fkHeadquarterId, description)
VALUES	(1, '2020-01-01', 1, 'Ciente solicita cambiar aceite'),
			(2, '2021-02-10', 1, 'Vehículos con problemas para ser revisados'),
			(2, '2022-02-15', 1, 'Vehículos para ser revisados con urgencia'),
			(3, '2022-05-15', 1, 'Cliente solicita revisión'),
			(4, '2023-04-20', 1, 'Cliente solicita revisión'),
			(5, '2020-07-25', 1, 'Cliente solicita revisión'),
			(5, '2022-01-17', 1, 'Cliente solicita revisión'),
			(6, '2023-08-07', 1, 'Vehículos Para revisión periódica'),   
			(6, '2024-01-10', 1, 'Vehículos Para revisión periódica'),
			(7, '2024-04-12', 1, 'Vehículo con problemas para arrancar'),
			(7, '2024-04-08', 1, 'Cliente solicita revisión'),
			(8, '2024-02-21', 1, 'Vehículo no arranca'),
			(9, '2020-01-08', 1, 'Problema en sistema de transmisión'),
			(9, '2021-10-26', 1, 'Cliente solicita revisión inmediata'),
			(10, '2023-10-01', 1, 'Revisión peridódicoa de flota de vehículos');
			
-- Insertions into appointmentVehicle table
INSERT INTO appointmentVehicle(fkAppointmentId, fkVehicleId)
VALUES	(1, 1),
			(2, 2),
			(2, 3),
			(3, 4),
			(3, 5),
			(4, 6),
			(5, 7),
			(5, 8),
			(5, 9),
			(6, 10),
			(7, 10),
			(8, 11),
			(8, 12),
			(9, 13),
			(9, 14),
			(10, 15),
			(11, 16),
			(12, 18),
			(13, 18),
			(14, 17),
			(15, 19),
			(15, 20),
			(15, 21);	

-- Insertions into piece table
INSERT INTO piece(name, description) 
VALUES	('Filtro de aceite', 'Su función principal es eliminar contaminantes y partículas de suciedad del aceite del motor, asegurando así una correcta lubricación y prolongando la vida útil del motor'),
			('Bujía', 'Componente esencial en los motores de gasolina y algunos motores de gas, responsable de encender la mezcla de aire y combustible que se introduce en los cilindros del motor.'),
			('Pastilla de freno', 'Componentes cruciales del sistema de frenos de disco. Están diseñadas para presionar contra el disco de freno cuando se acciona el pedal del freno, creando la fricción necesaria para disminuir la velocidad del vehículo o detenerlo completamente'),
			('Amortiguador', 'Los amortiguadores están diseñados para controlar el movimiento de la suspensión y las ruedas del vehículo, absorbiendo los impactos y vibraciones provenientes de la superficie del camino'),
			('Batería', 'Suministra la energía eléctrica necesaria para arrancar el motor y alimentar los sistemas eléctricos del vehículo cuando el motor no está en funcionamiento.'),
			('Neumático', 'Proporcionan tracción y soporte al vehículo, permitiendo un contacto adecuado con la superficie del camino para garantizar una conducción segura y eficiente.'),
			('Cable de encendido', 'Tansmitin la corriente eléctrica desde la bobina de encendido hasta las bujías para iniciar la combustión de la mezcla de aire y combustible en los cilindros del motor.'),
			('Bomba de agua', 'Circulan el refrigerante a través del motor y el radiador para mantener una temperatura de funcionamiento óptima y evitar el sobrecalentamiento.'),
			('Filtro de aire', 'Protegen el motor al filtrar el aire que entra al sistema de admisión, eliminando partículas de suciedad, polvo y otros contaminantes para asegurar una combustión limpia y eficiente.'),
			('Correas de distribución', 'Sincronizan el movimiento de las válvulas y los pistones en el motor, asegurando que abran y cierren en el momento adecuado durante el ciclo de combustión.'),
			('Alternador', 'Transmiten la energía mecánica desde el motor hacia el alternador, permitiendo así la generación de electricidad para cargar la batería y suministrar energía a los sistemas eléctricos del vehículo.'),
			('Radiador', 'Disipan el calor generado por el motor, enfriando el líquido refrigerante que circula a través del sistema de enfriamiento del motor. '),
			('Disco de freno', 'Proporcionan una superficie de fricción para las pastillas de freno, permitiendo que el sistema de frenado disminuya la velocidad del vehículo o lo detenga por completo al convertir la energía cinética en calor. '),
			('Sensor de oxígeno', 'Monitorean el nivel de oxígeno en los gases de escape del motor y enviar esta información al sistema de gestión del motor para ajustar la mezcla de aire y combustible, garantizando así una combustión más eficiente y reduciendo las emisiones contaminantes. '),
			('Bomba de combustible', 'Suministran combustible desde el tanque de combustible hasta el motor del vehículo, manteniendo así un flujo constante de combustible para la inyección o la carburación, lo que permite al motor funcionar correctamente.'),
			('Inyector de combustible', 'Atomizan y rociar el combustible directamente en la cámara de combustión del motor en el momento adecuado y en la cantidad precisa, garantizando así una combustión eficiente y controlada. '),
			('Compresor de aire acondicionado', 'Regulan y controlan el flujo de refrigerante hacia el evaporador, manteniendo así una presión constante y permitiendo un funcionamiento eficiente del sistema de aire acondicionado.'),
			('Embrague', 'Conectan y desconectan el motor con la transmisión del vehículo, permitiendo así que el conductor controle la transferencia de potencia desde el motor hacia las ruedas.'),
			('Cojinete de rueda', 'Permiten que la rueda gire libremente al mismo tiempo que soporta el peso del vehículo.'),
			('Tornillo de rueda', 'Fijan la rueda al cubo de la rueda y al rotor o tambor de freno del vehículo. '),
			('Tornillo de culata (tornillo de cabeza)', 'Mantienen la culata del motor firmemente unida al bloque del motor, asegurando así un sellado adecuado de la cámara de combustión y permitiendo el correcto funcionamiento del motor.'),
			('Tornillo de cárter de aceite', 'Sellan herméticamente el cárter de aceite del motor, asegurando que el aceite permanezca contenido en su lugar y evitando fugas.'),
			('Tornillo de motor (tornillo de bloque)', 'Mantienen unidas las partes del motor, asegurando la integridad estructural del conjunto y permitiendo su correcto funcionamiento.');
			
-- Insertions into supplier table
INSERT INTO supplier(name, email, fkCityId)
VALUES	('AutoPartsPlus' , 'info@autopartsplus.com', 1),
			( 'SpeedyCarParts', 'sales@speedycarparts.com', 2),
			( 'TurboAutoSupplies', 'sales@turboautosupplies.com', 3),			
			( 'MotorWorksDistributors', 'info@motorworksdistributors.com', 5);
			

-- Insertions into supplierPiece table
INSERT INTO supplierPiece(fkPieceId, fkBrandId, fkSupplierId, itemPrice)
VALUES	(1, 15, 1, 40000.0),
			(2, 24, 1, 50000.0),
			(3, 19, 1, 75000.0),
			( 4, 15, 1, 120000.0),
			( 5, 20, 1, 250000.0),
			( 6, 15, 2, 80000.0),
			( 7, 25, 2, 25000.0),
			( 8, 27, 2, 125000.0),
			( 9, 18, 2, 45000.0),
			( 10, 27, 2, 85000.0),
			( 11, 15, 3, 250000.0),
			( 12, 24, 3, 175000.0),
			( 13, 19, 3, 90000.0),
			( 14, 30, 3, 122000.0),
			( 15, 16, 3, 115000.0),
			( 16, 15, 3, 124000.0),
			( 17, 20, 4, 78000.0),
			( 18, 21, 4, 127000.0),
			( 19, 28, 4, 85000.0),
			( 20, 27, 4, 12000.0),
			( 21, 25, 4, 9000.0),
			( 22, 26, 4, 11000.0),
			( 23, 26, 4, 11500.0);
			
-- Insertions into pieceStock table
INSERT INTO pieceStock(fkSupplierPieceId, fkZoneId, fkHeadquarterId, stock, maxStock)
VALUES	(1, 8, 1, 11, 13), 
			( 2, 8, 1, 14, 16),
			( 3, 8, 1, 50, 55),
			( 4, 8, 1, 35, 42),
			( 5, 8, 1, 52, 68),
			( 6, 8, 1, 45, 51),
			( 7, 8, 1, 23, 32),
			( 8, 8, 1, 52, 65),
			( 9, 8, 1, 25, 27),
			( 10, 8, 1, 35, 42),
			( 11, 8, 1, 51, 60),
			( 12, 8, 1 , 25, 42),
			( 13, 8, 1 , 32, 40),
			( 14, 8, 1 , 22, 35),
			( 15, 8, 1, 10, 12),
			( 16, 8, 1, 10, 15),
			( 17, 8, 1, 9, 9),
			( 18, 8, 1, 8, 9),
			( 19, 8, 1, 35, 38),
			( 20, 8, 1, 150, 170),
			( 21, 8, 1, 150, 155),
			( 22, 8, 1, 135, 145),
			( 23, 8, 1, 130, 135);

	
-- Insertions into purchaseorder table
INSERT INTO purchaseOrder(fkEmployeeId, orderDate, description)
VALUES	(11, '2020-06-15', 'Nuevas pastillas de frenos, bujias y embragues'),
			(11, '2021-07-12', 'Nuevos tornillos y filtros'),
			(11, '2022-03-15', 'Correas, Embragues, Bujías, cables de encendido'),
			(11, '2022-07-23', 'Cojinetes, filtros, baterías, tronillos'),
			(11, '2023-10-25', 'Discos, amortiguadores, alternadores'),
			(11, '2024-02-23', 'Tornillos, Filtros');

-- Insertions into purchaseOrderPiece table
INSERT INTO purchaseOrderPiece(fkPurchaseOrderId, fkSupplierPieceId, quantity)
VALUES	(1, 3, 10),
			(1, 2, 7),
			(1, 18, 12),
			(2, 20, 150),
			(2, 21, 125),
			(2, 1, 25),
			(2, 9, 32),
			(3, 10, 10),
			(3, 2, 15),
			(3, 7, 20),
			(4, 19, 12),
			(4, 1, 40),
			(4, 5, 35),
			(4, 23, 100),
			(5, 13, 50),
			(5, 4, 20),
			(5, 11, 30),
			(6, 22, 120),
			(6, 21, 85),
			(6, 1, 15),
			(6, 9, 25);
			
-- Insertions into repairPiece table
INSERT INTO repairPiece(fkRepairId, fkPieceStockId, quantity)
VALUES	(1, 1, 1),
			(3, 7, 2),
			(10, 14, 1),
			(14, 	15, 1),
			(14, 22, 4),
			(17, 	1, 1),
			(19, 	6, 1),
			(16, 6, 1),
			(13, 6, 2);			
			
			
			
			
			
			
			
			
			
			