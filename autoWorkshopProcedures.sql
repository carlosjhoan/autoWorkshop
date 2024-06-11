-- This script contains some store procedures neccesaries for the autoWorkshop Data Base

USE autoWorkshop;

/*
*1.* Crear un procedimiento almacenado para insertar una nueva reparación.
*/


delimiter $$
CREATE PROCEDURE repairProcedure(IN vehId INT, IN dateIn DATE, IN dateOut DATE, IN descr TEXT)
BEGIN
		DECLARE msj VARCHAR(100);
		INSERT INTO repair(fkVehicleId, repairDateIn, repairDateOut, description)
		VALUES (vehId, dateIn, dateOut, descr);
		if ROW_COUNT() > 0 then
			SET msj = 'Successfully Insertion';
		ELSE 
			SET msj = 'Failed Insertion';
		END if;
		
		SELECT msj; 
END $$
delimiter ;

SET @vehId = 9;
SET @dateIn = '2024-02-10';
SET @dateOut = '2024-03-20';
SET @descr = 'Se necesita cambiar neuméticos';

CALL repairProcedure(@vehId, @dateIn, @dateOut, @descr);

SELECT fkVehicleId, repairDateIn, repairDateOut, description FROM repair;

/*
*2.* Crear un procedimiento almacenado para actualizar el inventario de una pieza.
*/


delimiter $$
CREATE  PROCEDURE  addPieceQuantity(IN supplPiece INT, IN zoneIn INT, IN headq INT, IN  quantity INT)
BEGIN 
	DECLARE quant INT;
	DECLARE qPieces INT; 
	DECLARE msj VARCHAR(100);
	
	SELECT
		stock INTO quant
	FROM
		pieceStock
	WHERE
		fkSupplierPieceId = supplPiece AND
		fkZoneId = zoneIn AND
		fkHeadquarterId = headq;
		
	SET qPieces = quant + quantity;
	
	UPDATE pieceStock
	SET stock = qPieces
	WHERE 	fkSupplierPieceId = supplPiece AND
				fkZoneId = zoneIn AND
				fkHeadquarterId = headq;
	
	if ROW_COUNT() > 0 then
			SET msj = 'Successfully Updated';
	ELSE 
			SET msj = 'Failed Updated';
	END if;
		
	SELECT msj; 	

END  $$
delimiter ;

SET @supplPiece = 1;
SET @zoneIn = 8;
SET @headq = 1;
SET @quanqtity = 2;

SELECT
		fkSupplierPieceId,
		fkZoneId,
		fkHeadquarterId,
		stock
FROM
		pieceStock
WHERE 		
		fkSupplierPieceId = @supplPiece AND
		fkZoneId = @zoneIn AND 
		fkHeadquarterId = @headq;

CALL addPieceQuantity(@supplPiece, @zoneIn, @headq, @quanqtity);

SELECT
		fkSupplierPieceId,
		fkZoneId,
		fkHeadquarterId,
		stock
FROM
		pieceStock
WHERE 		
		fkSupplierPieceId = @supplPiece AND
		fkZoneId = @zoneIn AND 
		fkHeadquarterId = @headq;

		
/*
*3.* Crear un procedimiento almacenado para eliminar una cita
*/

delimiter $$
CREATE PROCEDURE appointmentDelented(IN appointId INT)
BEGIN
	DECLARE msj VARCHAR(100);
	
	DELETE FROM appointmentVehicle
	WHERE fkAppointmentId = appointId;
	
	DELETE FROM appointment
	WHERE appointmentId = appointId;
	
	if ROW_COUNT() > 0 then
			SET msj = 'Successfully Deleted';
	ELSE 
			SET msj = 'Failed Deleted';
	END if;
		
	SELECT msj; 
		
END $$
delimiter ;

SET @appointId = 6;

SELECT 
		appointmentId, description
FROM
	appointment
WHERE
	appointmentId = @appointId;
	
CALL appointmentDelented(@appointId);

SELECT 
		appointmentId, description
FROM
	appointment
WHERE
	appointmentId = @appointId;
	
/*
*4.* Crear un procedimiento almacenado para generar una factura
*/



delimiter $$
CREATE PROCEDURE  invoiceGenerated(IN invId INT)
BEGIN 
	DECLARE msj VARCHAR(100);
	
	if invId = ANY(SELECT invoiceId FROM invoice) then
		set msj = 'It´s OK!';
		SELECT
			invoiceId,
			customerId,
			customerName,
			invoiceDate,
			SUM(Price) AS totalPrice
	FROM
			(	
			(SELECT 
					i.invoiceId,
					c.customerId,
					CONCAT(c.firstName, ' ',IFNULL(c.lastName, '')) AS customerName,
					i.invoiceDate,
					sum(onss.price) AS Price
			FROM 
					invoice AS i,
					repairinvoice AS ri,
					customer AS c,
					vehicle AS v,
					repair AS r,
					onSiteRepairService AS onsrs,
					onSiteService AS onss
			WHERE 
					i.fkCustomerId = c.customerId AND 
					c.customerId = v.fkCustomerId AND 
					v.vehicleId = r.fkVehicleId AND 
					ri.fkInvoiceId = i.invoiceId AND 
					ri.fkRepairId = r.repairId AND 
					onsrs.fkRepairId = r.repairId AND 
					onsrs.fkOnSiteServiceId = onss.onSiteServiceId AND
					i.invoiceId = invId 
			GROUP BY 
					i.invoiceId)
					
			UNION 
			
			(SELECT 
					i.invoiceId,
					c.customerId,
					CONCAT(c.firstName, ' ', IFNULL(c.lastName, '')) AS customerName,
					i.invoiceDate,
					sum(ouss.price) AS Price
			FROM 
					invoice AS i,
					repairinvoice AS ri,
					customer AS c,
					vehicle AS v,
					repair AS r,
					outSiteRepairService AS ousrs,
					outSiteService AS ouss
			WHERE 
					i.fkCustomerId = c.customerId AND 
					c.customerId = v.fkCustomerId AND 
					v.vehicleId = r.fkVehicleId AND 
					ri.fkInvoiceId = i.invoiceId AND 
					ri.fkRepairId = r.repairId AND 
					ousrs.fkRepairId = r.repairId AND 
					ousrs.fkOutSiteServiceId = ouss.outSiteServiceId AND
					i.invoiceId = invId
			GROUP BY 
					i.invoiceId)) AS servicePrice
	GROUP BY 
			invoiceId;
		
	else
		set msj = 'This invoice doen´t exist';
	END if;
	
	SELECT msj;
END  $$
delimiter ;

SET @invId = 30;
CALL invoiceGenerated(@invId);

/*
*5.* Crear un procedimiento almacenado para obtener el historial de reparaciones
de un vehículo
*/


delimiter $$
CREATE PROCEDURE histRepairs(IN vehId INT) 
BEGIN 
	DECLARE msj VARCHAR(100);
	
	if vehId = ANY(SELECT vehicleId FROM vehicle) then
		set msj = 'It´s OK!';
		
		SELECT
			fkVehicleId AS vehicleId,
			repairDateIn,
			repairDateOut,
			description
		FROM
			repair
		WHERE
			fkVehicleId = vehId;
	else
		set msj = 'This vehicle doen´t exist';
	END if;
	
	SELECT msj;
	
END  $$
delimiter ;


SET @vehId = 30;

CALL histRepairs(@vehId);

/*
*6.* Crear un procedimiento almacenado para calcular el costo total de
reparaciones de un cliente en un período
*/

delimiter $$
CREATE PROCEDURE totalCostRepair(IN custId INT, IN dateFrom DATE, IN dateTo DATE) 
BEGIN 
	DECLARE msj VARCHAR(100);
	
	if custId = ANY(SELECT customerId FROM customer) then
		set msj = 'It´s OK!';
		
		SELECT
			customerId,
			customerName,
			Format(SUM(Price), 2) AS totalPrice
	FROM
			(	
			(SELECT 
					c.customerId,
					CONCAT(c.firstName, ' ', IFNULL(c.lastName, '')) AS customerName,
					sum(onss.price) AS Price
			FROM 
					customer AS c,
					vehicle AS v,
					repair AS r,
					onSiteRepairService AS onsrs,
					onSiteService AS onss
			WHERE 
					c.customerId = v.fkCustomerId AND 
					v.vehicleId = r.fkVehicleId AND  
					onsrs.fkRepairId = r.repairId AND 
					onsrs.fkOnSiteServiceId = onss.onSiteServiceId AND
					r.repairDateOut >= dateFrom AND r.repairDateOut <= dateTo AND 
					c.customerId = custId
			GROUP BY
					c.customerId)
					
			UNION 
			
			(SELECT 
					c.customerId,
					CONCAT(c.firstName, ' ', IFNULL(c.lastName, '')) AS customerName,
					sum(ouss.price) AS Price
			FROM 
					customer AS c,
					vehicle AS v,
					repair AS r,
					outSiteRepairService AS ousrs,
					outSiteService AS ouss
			WHERE 
					c.customerId = v.fkCustomerId AND 
					v.vehicleId = r.fkVehicleId AND 
					ousrs.fkRepairId = r.repairId AND 
					ousrs.fkOutSiteServiceId = ouss.outSiteServiceId AND
					r.repairDateOut >= dateFrom AND r.repairDateOut <= dateTo AND
					c.customerId = custId
			GROUP BY
					c.customerId)) AS servicePrice
	GROUP BY 
			customerId;
	
	else
		set msj = 'This customer doen´t exist';
	
	END if;
	
	SELECT msj;

END $$
delimiter;

SET @custId = 5;
SET @dateFrom = '2020-06-30';
SET @dateTo = '2024-06-10';

CALL totalCostRepair(@custId, @dateFrom, @dateTo); 

/*
*8.*  Crear un procedimiento almacenado para insertar una nueva orden de compra 
*/



delimiter $$
CREATE PROCEDURE insertPurchaseOrder(in emplId INT, IN descr text) 
BEGIN 
	DECLARE msj VARCHAR(100);
	
	INSERT INTO purchaseOrder(fkEmployeeId, orderDate, description)
	VALUES (emplId, CURRENT_TIMESTAMP(), descr);
	
	if ROW_COUNT() > 0 then
		SET msj = 'Successfully Insertion';
		
	ELSE 
		SET msj = 'Failed Insertion';
	END if;
		
	SELECT msj; 
	
END $$
delimiter;

SET @emplId = 11;
SET @descr = 'Se acaban los tornillos para ajustar el motor. Se agitan filtros de aceiete y aire';

CALL insertPurchaseOrder(@emplId , @descr);

SELECT
	purchaseOrderId,
	fkEmployeeId,
	orderDate,
	description
FROM 
	purchaseOrder
WHERE
	purchaseOrderId = LAST_INSERT_ID();	
	
/*
*9.* Crear un procedimiento almacenado para actualizar los datos de un cliente
*/

delimiter $$
CREATE PROCEDURE updateCustomerInfo(in custId INT, IN fName VARCHAR(50), IN lName VARCHAR(50), IN custEmail VARCHAR(100)) 
BEGIN 
	DECLARE msj VARCHAR(100);
	DECLARE msjUpdate VARCHAR(100);
	DECLARE nameF VARCHAR(50);
	DECLARE nameL VARCHAR(50);
	DECLARE emailC VARCHAR(100);
	
	SELECT
		firstName, 
		lastName, 
		email INTO nameF, nameL, emailC
	FROM
		customer
	WHERE 
		customerId = custId;
	
	if custId = ANY(SELECT customerId FROM customer) then
		set msj = 'It´s OK!';
		
		if fName = '' OR fName = ' ' then
			SET fName = nameF;
		ELSE 
			SET fName = fName;
		END if;
		
		if lName = '' OR lName = ' ' then
			SET lName = nameL;
		ELSE 
			SET lName = lName;
		END if;
		
		if custEmail = '' OR custEmail = ' ' then
			SET custEmail = emailC;
		ELSE 
			SET custEmail = custEmail;
		END if;
		
		UPDATE customer
		SET firstName = fName, lastName = lName, email = custEmail
		WHERE
			customerId = custId;
			
		if ROW_COUNT() > 0 then
			SET msjUpdate = 'Successfully Updating';
		
		ELSE 
			SET msjUpdate = 'Failed Updating';
		END if;
			
		SELECT msjUpdate; 
		
	
	ELSE 
		set msj = 'This customer doesn´t exist.';
	
	END if;
END $$
delimiter ;

SET @custId = 1;
SET @fName = '';
SET @lName = ' ';
SET @custEmail = 'newEmail2024@example.com';

CALL updateCustomerInfo(@custId, @fName, @lName, @custEmail); 

SELECT
	*
FROM 
	customer
WHERE
	customerId = @custId;

/*
*10.* Crear un procedimiento almacenado para obtener los servicios más solicitados
en un período 
*/


delimiter $$
CREATE PROCEDURE mostSolicitatedServices(IN dateFrom DATE, IN dateTo DATE) 
BEGIN 
	SELECT
			Service,
			quantService
	FROM 
			(
				(SELECT
					onss.name AS Service,
					COUNT(onss.onSiteServiceId) AS quantService
				FROM 
					repair AS r,
					onSiteService AS onss,
					onSiteRepairService AS onsrs
				WHERE 
						r.repairId = onsrs.fkRepairId AND 
						onsrs.fkOnSiteServiceId = onss.onSiteServiceId AND 
						r.repairDateOut >= dateFrom AND r.repairDateOut <= dateTo
				GROUP by
						Service)
						
				UNION
				
				(SELECT
					ouss.name AS Service,
					COUNT(ouss.outSiteServiceId) AS quantService
				FROM 
					repair AS r,
					outSiteService AS ouss,
					outSiteRepairService AS ousrs
				WHERE 
						r.repairId = ousrs.fkRepairId AND 
						ousrs.fkOutSiteServiceId = ouss.outSiteServiceId AND 
						r.repairDateOut >= dateFrom AND r.repairDateOut <= dateTo
				GROUP by
						Service)) AS services
	ORDER BY quantService DESC;
END $$
delimiter;

SET @dateFrom = '2020-01-01';
SET @dateTo = '2024-06-10';

CALL mostSolicitatedServices(@dateFrom, @dateTo);