# autoWorkshop
This repository was created for save the files that contain all about the autoWorkshop Data Base.

# Queries
*1.* Obtain the repair history of a specific vehicle

### Querie
~~~~mysql
SELECT
		fkVehicleId AS vehicleId,
		repairDateIn,
		repairDateOut,
		description
FROM
		repair
WHERE
		fkVehicleId = 10;	
~~~~

### Outcome
| vehicleId | repairDateIn | repairDateOut | description|
|:---------:|:------------:|:-------------:|------------------------------------------------------------------------------------------------------------------------:|
|        10 | 2020-08-10   | 2020-08-17    | Se reemplazó el sensor de oxígeno defectuoso para corregir un cdigo de error del sistema de control de emisiones.|
|        10 | 2022-02-10   | 2022-03-02    | Se le apagó en el camino. Se realizaron múltiples reparaciones en el sistema de encendido. |

*2.* Calculate the total cost of all repairs performed by a specific employee in a period of time.


### Querie
~~~~mysql
SELECT
		SUM(totalPrice) AS totalPrice
FROM
		(
			(SELECT
					e.employeeId,
					CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
					sum(onss.price) AS totalPrice
					
			FROM
					employee AS e,
					onSiteRepairService AS onsrp,
					onSiteService AS onss,
					repair AS r
			WHERE
				onsrp.fkEmployeeId = e.employeeId AND
				onsrp.fkOnSiteServiceId= onss.onSiteServiceId AND
				onsrp.fkRepairId = r.repairId AND 
				e.employeeId = 4 AND
				r.repairDateOut >= '2020-01-01' AND  r.repairDateOut <= '2024-06-05')
			
			UNION 
			
			(SELECT
					e.employeeId,
					CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
					sum(ouss.price) AS totalPrice
					
			FROM
					employee AS e,
					outSiteRepairService AS ousrp,
					outSiteService AS ouss,
					repair AS r
			WHERE
				ousrp.fkEmployeeId = e.employeeId AND
				ousrp.fkOutSiteServiceId= ouss.outSiteServiceId AND
				ousrp.fkRepairId = r.repairId AND 
				e.employeeId = 4 AND
				r.repairDateOut >= '2020-01-01' AND  r.repairDateOut <= '2024-06-05')) AS services_price;	
~~~~

### Outcome
| totalPrice |
|:----------:|
| 1730000.00 |

*3.* List all customers and the vehicles they own

### Querie
~~~~mysql
SELECT
		c.customerId,
		CONCAT(c.firstName, ' ', IFNULL(c.lastName, '')) AS customerName,
		v.vehicleId,
		v.numberPlate,
		b.name AS Brand,
		cm.model
	FROM
			customer AS c,
			vehicle AS v,
			carModel AS cm,
			brand AS b
	WHERE
		c.customerId = v.fkCustomerId AND 
		v.fkCarModelId = cm.carModelId AND 
		cm.fkBrandId = b.brandId;
~~~~

### Outcome
| customerId | customerName                     | vehicleId | numberPlate | Brand    | model   |
|:----------:|:--------------------------------:|:---------:|:-----------:|:--------:|:-------:|
|          1 | Juan Carlos Aguilar              |         1 | AUX258      | Toyota   | Corolla |
|          2 | GAVASSA SA LTDA                  |         2 | AXC325      | Toyota   | Camry   |
|          2 | GAVASSA SA LTDA                  |         3 | ADC458      | Toyota   | RAV4    |
|          2 | GAVASSA SA LTDA                  |         4 | XMN459      | Toyota   | Hilux   |
|          2 | GAVASSA SA LTDA                  |         5 | VCD186      | Chvrolet | Dimax   |
|          3 | Julio Csar Galvis               |         6 | XUV125      | Ford     | Escape  |
|          4 | GMEZ PAN SA                     |         7 | XMV753      | Ford     | Focus   |
|          4 | GMEZ PAN SA                     |         8 | XCD426      | Ford     | Fiesta  |
|          4 | GMEZ PAN SA                     |         9 | XGL251      | Chvrolet | Dimax   |
|          5 | Luis Alfonso Gmez Mancilla      |        10 | BTR942      | Renault  | Clio    |
|          6 | PENAGOS & HERMANOS               |        11 | XMN356      | Toyota   | Hilux   |
|          6 | PENAGOS & HERMANOS               |        12 | FGH719      | Chvrolet | Dimax   |
|          6 | PENAGOS & HERMANOS               |        13 | BGF369      | Volvo    | FH      |
|          6 | PENAGOS & HERMANOS               |        14 | VDC845      | Volvo    | VNL     |
|          7 | FARMATODO SA                     |        15 | ACF354      | Nissan   | Sentra  |
|          7 | FARMATODO SA                     |        16 | ATT546      | Renault  | Megane  |
|          8 | Aracely Lpez Guzmn             |        17 | XSD301      | Toyota   | Hilux   |
|          9 | Leidy Stefany Valencia Hernndez |        18 | XUV620      | Chvrolet | Aveo    |
|         10 | VIJUAGUAL CARNES SA              |        19 | AXD798      | Volvo    | VNL     |
|         10 | VIJUAGUAL CARNES SA              |        20 | XVN531      | Toyota   | Hilux   |
|         10 | VIJUAGUAL CARNES SA              |        21 | XUV412      | Volvo    | FM      |

*4.* Obtain the quantity of parts in inventory for each part

### Querie
~~~~mysql
SELECT
	sp.supplierPieceId,
	p.name AS pieceName,
	b.name AS brand,
		SUM(ps.stock) AS totalStock
FROM 
	piece AS p,
	pieceStock AS ps,
	supplierpiece AS sp,
	brand AS b
WHERE 
	p.pieceId = sp.supplierPieceId AND 
	ps.fkSupplierPieceId = sp.supplierPieceId AND 
	sp.fkBrandId = b.brandId
GROUP BY
	sp.supplierPieceId;
~~~~

### Outcome
| supplierPieceId | pieceName                               | brand           | totalStock |
|:---------------:|:---------------------------------------:|:---------------:|:----------:|
|               1 | Filtro de aceite                        | Bosch           |         11 |
|               2 | Buja                                   | Denso           |         14 |
|               3 | Pastilla de freno                       | Brembo          |         50 |
|               4 | Amortiguador                            | Bosch           |         35 |
|               5 | Batera                                 | KYB             |         52 |
|               6 | Neumtico                               | Bosch           |         45 |
|               7 | Cable de encendido                      | Aisin           |         23 |
|               8 | Bomba de agua                           | Continental     |         52 |
|               9 | Filtro de aire                          | NGK             |         25 |
|              10 | Correas de distribucin                 | Continental     |         35 |
|              11 | Alternador                              | Bosch           |         51 |
|              12 | Radiador                                | Denso           |         25 |
|              13 | Disco de freno                          | Brembo          |         32 |
|              14 | Sensor de oxgeno                       | SKF             |         22 |
|              15 | Bomba de combustible                    | Milwaukee       |         10 |
|              16 | Inyector de combustible                 | Bosch           |         10 |
|              17 | Compresor de aire acondicionado         | KYB             |          9 |
|              18 | Embrague                                | Optima          |          8 |
|              19 | Cojinete de rueda                       | Spectra Premium |         35 |
|              20 | Tornillo de rueda                       | Continental     |        150 |
|              21 | Tornillo de culata (tornillo de cabeza) | Aisin           |        150 |
|              22 | Tornillo de crter de aceite            | K&N             |        135 |
|              23 | Tornillo de motor (tornillo de bloque)  | K&N             |        130 |

*5.* Obtain the scheduled appointments for a specific day

### Querie
~~~~mysql
SELECT 
	 	appointmentId,
		appointDate
FROM
		appointment
WHERE 
		appointDate = '2022-05-15';
~~~~


### Outcome
| appointmentId | appointDate         |
|:-------------:|:-------------------:|
|             4 | 2022-05-15 00:00:00 |

*6.* Generate an invoice for a specific customer on a given date

### Querie
~~~~mysql
SELECT
		customerId,
		customerName,
		invoiceDate,
		SUM(Price) AS totalPrice
FROM
		(	
		(SELECT 
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
				i.invoiceDate = '2021-04-04')
					
		UNION 
			
		(SELECT 
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
				i.invoiceDate = '2021-04-04')) AS servicePrice;
~~~~


### Outcome
| customerId | customerName     | invoiceDate         | totalPrice |
|:----------:|:----------------:|:-------------------:|:----------:|
|          2 | GAVASSA SA LTDA  | 2021-04-04 00:00:00 |  865000.00 |

*7.* List all purchase orders and their details

### Querie
~~~~mysql
SELECT 
		po.purchaseOrderId,
		e.employeeId,
		CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
		po.orderDate,
		p.name AS pieceName,
		b.name AS brand,
		s.name AS supplier,
		pop.quantity
			
FROM 
		purchaseOrder AS po,
		purchaseOrderPiece AS pop,
		supplierPiece AS sp,
		piece AS p,
		brand AS b,
		supplier AS s,
		employee AS e
WHERE
		po.purchaseOrderId = pop.fkPurchaseOrderId AND
		pop.fkSupplierPieceId = sp.supplierPieceId AND 
		sp.fkPieceId = p.pieceId AND 
		sp.fkBrandId = b.brandId AND 
		sp.fkSupplierId = s.supplierId AND 
		po.fkEmployeeId = e.employeeId;
~~~~


### Outcome
| purchaseOrderId | employeeId | employeeName       | orderDate           | pieceName                               | brand           | supplier               | quantity |
|:---------------:|:----------:|:------------------:|:-------------------:|:---------------------------------------:|:---------------:|:----------------------:|:--------:|
|               2 |         11 | Paula Ramrez Ruiz | 2021-07-12 00:00:00 | Filtro de aceite                        | Bosch           | AutoPartsPlus          |       25 |
|               4 |         11 | Paula Ramrez Ruiz | 2022-07-23 00:00:00 | Filtro de aceite                        | Bosch           | AutoPartsPlus          |       40 |
|               6 |         11 | Paula Ramrez Ruiz | 2024-02-23 00:00:00 | Filtro de aceite                        | Bosch           | AutoPartsPlus          |       15 |
|               1 |         11 | Paula Ramrez Ruiz | 2020-06-15 00:00:00 | Buja                                   | Denso           | AutoPartsPlus          |        7 |
|               3 |         11 | Paula Ramrez Ruiz | 2022-03-15 00:00:00 | Buja                                   | Denso           | AutoPartsPlus          |       15 |
|               1 |         11 | Paula Ramrez Ruiz | 2020-06-15 00:00:00 | Pastilla de freno                       | Brembo          | AutoPartsPlus          |       10 |
|               5 |         11 | Paula Ramrez Ruiz | 2023-10-25 00:00:00 | Amortiguador                            | Bosch           | AutoPartsPlus          |       20 |
|               4 |         11 | Paula Ramrez Ruiz | 2022-07-23 00:00:00 | Batera                                 | KYB             | AutoPartsPlus          |       35 |
|               3 |         11 | Paula Ramrez Ruiz | 2022-03-15 00:00:00 | Cable de encendido                      | Aisin           | SpeedyCarParts         |       20 |
|               2 |         11 | Paula Ramrez Ruiz | 2021-07-12 00:00:00 | Filtro de aire                          | NGK             | SpeedyCarParts         |       32 |
|               6 |         11 | Paula Ramrez Ruiz | 2024-02-23 00:00:00 | Filtro de aire                          | NGK             | SpeedyCarParts         |       25 |
|               3 |         11 | Paula Ramrez Ruiz | 2022-03-15 00:00:00 | Correas de distribucin                 | Continental     | SpeedyCarParts         |       10 |
|               5 |         11 | Paula Ramrez Ruiz | 2023-10-25 00:00:00 | Alternador                              | Bosch           | TurboAutoSupplies      |       30 |
|               5 |         11 | Paula Ramrez Ruiz | 2023-10-25 00:00:00 | Disco de freno                          | Brembo          | TurboAutoSupplies      |       50 |
|               1 |         11 | Paula Ramrez Ruiz | 2020-06-15 00:00:00 | Embrague                                | Optima          | MotorWorksDistributors |       12 |
|               4 |         11 | Paula Ramrez Ruiz | 2022-07-23 00:00:00 | Cojinete de rueda                       | Spectra Premium | MotorWorksDistributors |       12 |
|               2 |         11 | Paula Ramrez Ruiz | 2021-07-12 00:00:00 | Tornillo de rueda                       | Continental     | MotorWorksDistributors |      150 |
|               2 |         11 | Paula Ramrez Ruiz | 2021-07-12 00:00:00 | Tornillo de culata (tornillo de cabeza) | Aisin           | MotorWorksDistributors |      125 |
|               6 |         11 | Paula Ramrez Ruiz | 2024-02-23 00:00:00 | Tornillo de culata (tornillo de cabeza) | Aisin           | MotorWorksDistributors |       85 |
|               6 |         11 | Paula Ramrez Ruiz | 2024-02-23 00:00:00 | Tornillo de crter de aceite            | K&N             | MotorWorksDistributors |      120 |
|               4 |         11 | Paula Ramrez Ruiz | 2022-07-23 00:00:00 | Tornillo de motor (tornillo de bloque)  | K&N             | MotorWorksDistributors |      100 |


*8.* Obtain the total cost of parts used in a specific repair

### Querie
~~~~mysql
SELECT 
		r.repairId,
		SUM(rp.quantity * sp.itemPrice) AS pieceTotalPrice
FROM 
		repair AS r,
		repairpiece AS rp,
		piecestock AS ps,
		supplierpiece AS sp
WHERE 
		r.repairId = rp.fkRepairId AND 
		rp.fkPieceStockId = ps.pieceStockId AND 
		ps.fkSupplierPieceId = sp.supplierPieceId AND 
		r.repairId = 14;
~~~~


### Outcome
| repairId | pieceTotalPrice |
|:--------:|:---------------:|
|       14 |       159000.00 |


*9.* Obtain the inventory of parts that need to be restocked (quantity below a threshold

### Querie
~~~~mysql
SELECT 
		sp.supplierPieceId,
		p.name AS pieceName,
		b.name AS brand,
		ps.stock AS currentStock,
		ps.maxStock,
		z.name AS zone,
		h.name AS headquarter 

FROM 
		piece AS p,
		pieceStock AS ps,
		supplierpiece AS sp,
		brand AS b,
		zone AS z,
		headquarter AS h
WHERE 
		ps.fkSupplierPieceId = sp.supplierPieceId AND 
		sp.fkPieceId = p.pieceId AND 
		sp.fkBrandId = b.brandId AND 
		ps.fkZoneId = z.zoneId AND 
		ps.fkHeadquarterId = h.headquarterId AND 
		((ps.maxStock - ps.stock)  / ps.maxStock) * 100 >= 20;
~~~~


### Outcome
| supplierPieceId | pieceName               | brand       | currentStock | maxStock | zone                                 | headquarter        |
|:---------------:|:-----------------------:|:-----------:|:------------:|:--------:|:------------------------------------:|:------------------:|
|               5 | Batería                 | KYB         |           52 |       68 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|               7 | Cable de encendido      | Aisin       |           23 |       32 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|               8 | Bomba de agua           | Continental |           52 |       65 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|              12 | Radiador                | Denso       |           25 |       42 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|              13 | Disco de freno          | Brembo      |           32 |       40 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|              14 | Sensor de oxígeno       | SKF         |           22 |       35 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|              16 | Inyector de combustible | Bosch       |           10 |       15 | Área de Almacenamiento y Suministros | Taller Bucaramanga |

*10.* Obtain the list of most requested services in a specific period

### Querie
~~~~mysql
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
					r.repairDateOut >= '2020-01-01' AND r.repairDateOut <= '2024-06-10'
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
					r.repairDateOut >= '2020-01-01' AND r.repairDateOut <= '2024-06-10'
			GROUP by
					Service)) AS services
ORDER BY quantService DESC;
~~~~


### Outcome
| Service                                                        | quantService |
|:--------------------------------------------------------------:|:------------:|
| Cambio de aceite y filtro                                      |            6 |
| Reparacin de frenos                                           |            5 |
| Reparacin de sistemas de suspensin y direccin               |            5 |
| Diagnstico y reparacin de sistemas elctricos y electrnicos |            5 |
| Servicio de arranque                                           |            3 |
| Alineacin y balanceo                                          |            3 |
| Reparacin de sistemas de escape                               |            2 |
| Revisin y mantenimiento peridico                             |            2 |
| Reparacin de sistemas de transmisin                          |            2 |
| Reparacin de pinchazos                                        |            2 |
| Servicios de carrocera y pintura                              |            1 |
| Reparacin de sistemas de enfriamiento                         |            1 |

*11.* Obtain the total cost of repairs for each customer in a specific period.

### Querie
~~~~mysql
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
				r.repairDateOut >= '2020-01-01' AND r.repairDateOut <= '2024-06-10'
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
				r.repairDateOut >= '2024-01-01' AND r.repairDateOut <= '2024-06-10'
		GROUP BY
				c.customerId)) AS servicePrice
GROUP BY 
		customerId;
~~~~


### Outcome
| customerId | customerName                     | totalPrice   |
|:----------:|:--------------------------------:|:------------:|
|          1 | Juan Carlos Aguilar              | 65,000.00    |
|          2 | GAVASSA SA LTDA                  | 1,835,000.00 |
|          3 | Julio César Galvis               | 100,000.00   |
|          4 | GÓMEZ PAN SA                     | 1,305,000.00 |
|          5 | Luis Alfonso Gmez Mancilla      | 570,000.00   |
|          6 | PENAGOS & HERMANOS               | 1,535,000.00 |
|          7 | FARMATODO SA                     | 705,000.00   |
|          8 | Aracely López Guzmán             | 515,000.00   |
|          9 | Leidy Stefany Valencia Hernández | 100,000.00   |
|         10 | VIJUAGUAL CARNES SA              | 1,760,000.00 |

*12.* List the employees with the highest number of repairs performed in a specific period

### Querie
~~~~mysql
SELECT
	employeeId,
	employeeName,
	SUM(quantityServices) AS servicesQuantity
FROM
	(
		(SELECT
				e.employeeId,
				CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
				COUNT(e.employeeId) AS quantityServices
				
		FROM
				employee AS e,
				onSiteRepairService AS onsrp,
				onSiteService AS onss,
				repair AS r
		WHERE
				onsrp.fkEmployeeId = e.employeeId AND
				onsrp.fkOnSiteServiceId= onss.onSiteServiceId AND
				onsrp.fkRepairId = r.repairId AND 
				r.repairDateOut >= '2020-01-01' AND  r.repairDateOut <= '2024-06-10'
		GROUP BY 
				e.employeeId)
		
		UNION 
		
		(SELECT
				e.employeeId,
				CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
				COUNT(e.employeeId) AS quantityServices
		FROM
				employee AS e,
				outSiteRepairService AS ousrp,
				outSiteService AS ouss,
				repair AS r
		WHERE
				ousrp.fkEmployeeId = e.employeeId AND
				ousrp.fkOutSiteServiceId= ouss.outSiteServiceId AND
				ousrp.fkRepairId = r.repairId AND
				r.repairDateOut >= '2020-01-01' AND  r.repairDateOut <= '2024-06-10'
		GROUP BY 
				e.employeeId)) AS employee_services
GROUP BY
		employeeId
ORDER by
		servicesQuantity DESC;
~~~~


### Outcome
| employeeId | employeeName              | servicesQuantity |
|:----------:|:-------------------------:|:----------------:|
|          4 | carlos  Garca Prez      |                7 |
|         16 | Manuel Nuez Rodrguez    |                5 |
|         13 | Natalia Vargas Lpez      |                5 |
|         17 | Gabriela Castro Prez     |                5 |
|          6 | Luis Fernndez Prez      |                4 |
|          5 | Ana Herrera Rodrguez     |                4 |
|          9 | Andrea Torres Gmez       |                2 |
|         18 | Daniel Alvarez Hernndez  |                2 |
|         20 | Miguel Lpez Martnez     |                1 |
|          3 | Laura Rodrguez Hernndez |                1 |
|         12 | Javier Gmez Garca       |                1 |


*13.* Obtain the most used parts in repairs during a specific period

### Querie
~~~~mysql
SELECT 
		sp.supplierPieceId,
		p.name AS pieceName,
		b.name AS brand,
		SUM(rp.quantity) AS piecesQuantity
FROM 
		repair AS r,
		repairPiece AS rp,
		supplierPiece AS sp,
		pieceStock AS ps,
		piece AS p,
		brand AS b
WHERE
		r.repairId = rp.fkRepairId AND
		rp.fkPieceStockId = ps.pieceStockId AND
		ps.fkSupplierPieceId = sp.supplierPieceId AND 
		sp.fkPieceId = p.pieceId AND 
		sp.fkBrandId = b.brandId AND 
		r.repairDateOut >= '2020-01-01' AND  r.repairDateOut <= '2024-06-10'
GROUP BY 
		sp.supplierPieceId
ORDER BY 
		piecesQuantity DESC
LIMIT 3;
~~~~


### Outcome
| supplierPieceId | pieceName                    | brand | piecesQuantity |
|:---------------:|:----------------------------:|:-----:|:--------------:|
|               6 | Neumtico                    | Bosch |              4 |
|              22 | Tornillo de crter de aceite | K&N   |              4 |
|               1 | Filtro de aceite             | Bosch |              2 |

*14.* Calculate the average cost of repairs per vehicle

### Querie
~~~~mysql
SELECT
		AVG(repairPrice) AS averagePrice
FROM 
		(
			SELECT
					repairId,
					SUM(totalPrice) AS repairPrice
			FROM
					(
						(SELECT
								r.repairId,
								sum(onss.price) AS totalPrice
						FROM
								vehicle AS v,
								onSiteRepairService AS onsrp,
								onSiteService AS onss,
								repair AS r
						WHERE
								v.vehicleId = r.fkVehicleId AND
								onsrp.fkOnSiteServiceId= onss.onSiteServiceId AND
								onsrp.fkRepairId = r.repairId 
						GROUP BY 
								r.repairId)
						
						UNION 
						
						(SELECT
								r.repairId,
								sum(ouss.price) AS totalPrice
								
						FROM
								vehicle AS v,
								outSiteRepairService AS ousrp,
								outSiteService AS ouss,
								repair AS r
						WHERE
								v.vehicleId = r.fkVehicleId AND
								ousrp.fkOutSiteServiceId= ouss.outSiteServiceId AND
								ousrp.fkRepairId = r.repairId
						GROUP BY 
								r.repairId)) AS services_price
			GROUP BY 
				repairId) AS repair_service;
~~~~


### Outcome
| averagePrice  |
|:-------------:|
| 382173.913043 |

*15.* Obtain the inventory of parts by supplier

### Querie
~~~~mysql
SELECT 
		s.supplierId,
		s.name AS supplierName,
		SUM(ps.stock) AS supplierPiecesStock

FROM 
		pieceStock AS ps,
		supplierpiece AS sp,
		supplier AS s
WHERE 
		ps.fkSupplierPieceId = sp.supplierPieceId AND
		s.supplierId = sp.fkSupplierId
GROUP BY 
		s.supplierId; 
~~~~


### Outcome
| supplierId | supplierName           | supplierPiecesStock |
|:----------:|:----------------------:|:-------------------:|
|          1 | AutoPartsPlus          |                 162 |
|          2 | SpeedyCarParts         |                 180 |
|          3 | TurboAutoSupplies      |                 150 |
|          4 | MotorWorksDistributors |                 617 |


*16.* List the customers who haven't had repairs in the last year

### Querie
~~~~mysql
SELECT 
		c.customerId,
		CONCAT(c.firstName, ' ', IFNULL(c.lastName, '')) AS customerName
FROM 
		repair AS r,
		vehicle AS v,
		customer AS c
WHERE 
		v.vehicleId = r.repairId AND 
		c.customerId = v.fkCustomerId AND 
		r.repairDateOut < ADDDATE(CURRENT_DATE(), INTERVAL -1 YEAR)
GROUP BY
	c.customerId;
~~~~


### Outcome
| customerId | customerName                |
|:----------:|:---------------------------:|
|          1 | Juan Carlos Aguilar         |
|          2 | GAVASSA SA LTDA             |
|          3 | Julio Csar Galvis          |
|          5 | Luis Alfonso Gmez Mancilla |
|          6 | PENAGOS & HERMANOS          |
|         10 | VIJUAGUAL CARNES SA         |


*17.* Obtain the total earnings of the workshop in a specific period.

### Querie
~~~~mysql
SELECT
		SUM(earningRepair) AS totalEarnings
FROM
		(	
		(SELECT 
				r.repairId,
				SUM(onss.price) AS Price,
				SUM(rp.quantity * sp.itemPrice) AS pieceCost,
				(SUM(onss.price) - SUM(rp.quantity * sp.itemPrice)) AS earningRepair
		FROM 
				repair AS r,
				onSiteRepairService AS onsrs,
				onSiteService AS onss,
				repairPiece AS rp,
				pieceStock AS ps,
				supplierPiece AS sp
		WHERE 
				onsrs.fkRepairId = r.repairId AND 
				onsrs.fkOnSiteServiceId = onss.onSiteServiceId AND 
				rp.fkRepairId = r.repairId AND 
				rp.fkPieceStockId = ps.pieceStockId AND
				ps.fkSupplierPieceId = sp.supplierPieceId AND 
				r.repairDateOut >= '2020-01-01' AND  r.repairDateOut <= '2024-06-10'
		GROUP BY 
				r.repairId)
				
		UNION 
		
		(SELECT 
				r.repairId,
				SUM(ouss.price) AS Price,
				SUM(rp.quantity * sp.itemPrice) AS pieceCost,
				(SUM(ouss.price) - SUM(rp.quantity * sp.itemPrice)) AS earningRepair
		FROM
				repair AS r,
				outSiteRepairService AS ousrs,
				outSiteService AS ouss,
				repairPiece AS rp,
				pieceStock AS ps,
				supplierPiece AS sp
		WHERE
				ousrs.fkRepairId = r.repairId AND 
				ousrs.fkOutSiteServiceId = ouss.outSiteServiceId AND 
				rp.fkRepairId = r.repairId AND 
				rp.fkPieceStockId = ps.pieceStockId AND
				ps.fkSupplierPieceId = sp.supplierPieceId AND 
				r.repairDateOut >= '2020-01-01' AND  r.repairDateOut <= '2024-06-10'
		GROUP BY 
				r.repairId)) AS servicePrice;
~~~~


### Outcome
| totalEarnings |
|:-------------:|
|    1720000.00 |


*18.* List the employees and the total hours worked on repairs in a specific period (assuming the duration of each repair is recorded).

### Querie
~~~~mysql
SELECT
		employeeId,
		employeeName,
		SEC_TO_TIME(sum( TIME_TO_SEC(spentTime))) AS employeeSpentTime 
	FROM
		(
			(SELECT
					e.employeeId,
					CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
					SEC_TO_TIME(sum( TIME_TO_SEC(onsrp.spentTime))) AS spentTime
			FROM
					employee AS e,
					onSiteRepairService AS onsrp,
					onSiteService AS onss,
					repair AS r
			WHERE
					onsrp.fkEmployeeId = e.employeeId AND
					onsrp.fkOnSiteServiceId= onss.onSiteServiceId AND
					onsrp.fkRepairId = r.repairId AND 
					r.repairDateOut >= '2020-01-01' AND  r.repairDateOut <= '2024-06-10'
			GROUP BY
					e.employeeId)
			
			UNION 
			
			(SELECT
					e.employeeId,
					CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
					SEC_TO_TIME(sum( TIME_TO_SEC(ousrp.spentTime))) AS spentTime
					
			FROM
					employee AS e,
					outSiteRepairService AS ousrp,
					outSiteService AS ouss,
					repair AS r
			WHERE
					ousrp.fkEmployeeId = e.employeeId AND
					ousrp.fkOutSiteServiceId= ouss.outSiteServiceId AND
					ousrp.fkRepairId = r.repairId AND
					r.repairDateOut >= '2020-01-01' AND  r.repairDateOut <= '2024-06-10'
			GROUP BY
					e.employeeId)) AS employee_service_time
	GROUP BY
			employeeId;
~~~~


### Outcome
| employeeId | employeeName              | employeeSpentTime |
|:----------:|:-------------------------:|:-----------------:|
|          3 | Laura Rodrguez Hernndez | 08:00:00          |
|          4 | carlos  Garca Prez      | 26:00:00          |
|          5 | Ana Herrera Rodrguez     | 10:10:00          |
|          6 | Luis Fernndez Prez      | 07:43:00          |
|          9 | Andrea Torres Gmez       | 10:40:00          |
|         12 | Javier Gmez Garca       | 04:25:00          |
|         13 | Natalia Vargas Lpez      | 19:50:00          |
|         16 | Manuel Nuez Rodrguez    | 15:30:00          |
|         17 | Gabriela Castro Prez     | 20:25:00          |
|         18 | Daniel Alvarez Hernndez  | 07:50:00          |
|         20 | Miguel Lpez Martnez     | 03:40:00          |

*19.* Obtain the list of services provided by each employee in a specific period

### Querie
~~~~mysql
(SELECT
		e.employeeId,
		CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
		onss.name AS Service
				
FROM
		employee AS e,
		onSiteRepairService AS onsrp,
		onSiteService AS onss,
		repair AS r
WHERE
		onsrp.fkEmployeeId = e.employeeId AND
		onsrp.fkOnSiteServiceId= onss.onSiteServiceId AND
		onsrp.fkRepairId = r.repairId AND 
		r.repairDateOut >= '2020-01-01' AND  r.repairDateOut <= '2024-06-10')
		
UNION 
		
(SELECT
		e.employeeId,
		CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
		ouss.name AS Service
				
FROM
		employee AS e,
		outSiteRepairService AS ousrp,
		outSiteService AS ouss,
		repair AS r
WHERE
		ousrp.fkEmployeeId = e.employeeId AND
		ousrp.fkOutSiteServiceId= ouss.outSiteServiceId AND
		ousrp.fkRepairId = r.repairId AND
		r.repairDateOut >= '2020-01-01' AND  r.repairDateOut <= '2024-06-10');
~~~~


### Outcome
| employeeId | employeeName              | Service                                                        |
|:----------:|-------------------------:|:--------------------------------------------------------------:|
|          5 | Ana Herrera Rodríguez     | Cambio de aceite y filtro                                      |
|          6 | Luis Fernández Prez      | Cambio de aceite y filtro                                      |
|         13 | Natalia Vargas López      | Reparación de frenos                                           |
|         17 | Gabriela Castro Prez     | Alineación y balanceo                                          |
|          9 | Andrea Torres Gmez       | Revisión y mantenimiento periódico                             |
|         16 | Manuel Nuez Rodríguez    | Reparación de sistemas de suspensión y dirección               |
|         17 | Gabriela Castro Pírez     | Reparación de sistemas de transmisión                          |
|         12 | Javier Gmez Garca       | Reparación de sistemas de enfriamiento                         |
|          4 | carlos  Garca Prez      | Diagnóstico y reparación de sistemas eléctricos y electrónicos |
|         20 | Miguel López Martínez     | Diagnóstico y reparación de sistemas eléctricos y electrónicos |
|         18 | Daniel Alvarez Hernández  | Reparación de sistemas de escape                               |
|          3 | Laura Rodrguez Hernndez | Servicios de carrocería y pintura                              |
|          4 | Carlos  García Pérez      | Servicio de arranque                                           |
|          5 | Ana Herrera Rodríguez     | Reparación de pinchazos                                        |
|          6 | Luis Fernández Pérez      | Reparación de pinchazos                                        |


# Subquieries  

*1.* Obtain the customer who has spent the most on repairs during the last year.

### Querie
~~~~mysql
SELECT
		customerId,
		customerName,
		SUM(Price) AS totalPrice
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
				r.repairDateOut >= ADDDATE(CURRENT_DATE(), INTERVAL -1 YEAR)
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
				r.repairDateOut >= ADDDATE(CURRENT_DATE(), INTERVAL -1 YEAR)
		GROUP BY 
			c.customerId)) AS servicePrice
GROUP BY 
		customerId
ORDER BY 
		totalPrice DESC
LIMIT 1;
~~~~


### Outcome
| customerId | customerName         | totalPrice |
|:----------:|:--------------------:|:----------:|
|         10 | VIJUAGUAL CARNES SA  | 1760000.00 |


*2.* Obtain the most used part in repairs during the last month.

### Querie
~~~~mysql
SELECT 
		sp.supplierPieceId,
		p.name AS pieceName,
		b.name AS brand,
		SUM(rp.quantity) AS pieceQuantity
FROM 
		repair AS r,
		repairPiece AS rp,
		pieceStock AS ps,
		supplierPiece AS sp,
		piece AS p,
		brand AS b
WHERE
		r.repairId = rp.fkRepairId AND 
		rp.fkPieceStockId = ps.pieceStockId AND 
		ps.fkSupplierPieceId = sp.supplierPieceId and
		sp.fkPieceId = p.pieceId AND 
		sp.fkBrandId  = b.brandId AND
		r.repairDateOut >= ADDDATE(CURRENT_DATE(), INTERVAL -1 MONTH)
GROUP BY 
		supplierPieceId
ORDER BY
		Quantity DESC
LIMIT 1;
~~~~


### Outcome
| supplierPieceId | pieceName | brand | pieceQuantity |
|:---------------:|:---------:|:-----:|:-------------:|
|               6 | Neumtico | Bosch |             1 |

*3.* Obtain the suppliers that provide the most expensive parts.

### Querie
~~~~mysql
SELECT 
		supplierId,
		supplierNAme
FROM
		(
			SELECT 
					s.supplierId,
					s.name AS supplierName,
					AVG(sp.itemPrice) AS averItemPrice
			FROM 
					supplier AS s,
					supplierPiece AS sp
			WHERE
					s.supplierId = sp.fkSupplierId
			GROUP BY
					s.supplierId
			ORDER BY 
				averItemPrice DESC 
			LIMIT 3) AS avg_item_price;
~~~~


### Outcome
| supplierId | supplierNAme      |
|:----------:|:-----------------:|
|          3 | TurboAutoSupplies |
|          1 | AutoPartsPlus     |
|          2 | SpeedyCarParts    |

*4.* List the repairs that did not use specific parts during the last year.

### Querie
~~~~mysql
SELECT 
		r.repairId,
		r.fkVehicleId
FROM
		repair AS r
LEFT JOIN 
		repairPiece AS rp
ON 		
		r.repairId = rp.fkRepairId
WHERE
	rp.fkPieceStockId IS NULL AND 
	r.repairDateOut >= ADDDATE(CURRENT_DATE(), INTERVAL -1 YEAR);
~~~~


### Outcome
| repairId | fkVehicleId |
|:--------:|:-----------:|
|        7 |           7 |
|        8 |           8 |
|        9 |           9 |
|       12 |          11 |
|       15 |          14 |
|       18 |          17 |
|       21 |          19 |
|       22 |          20 |
|       23 |          21 |

*5.* Obtain the parts that are in inventory below 10% of the initial stock.

### Querie
~~~~mysql
SELECT 
		sp.supplierPieceId,
		p.name AS pieceName,
		b.name AS brand,
		ps.stock AS currentStock,
		ps.maxStock,
		z.name AS zone,
		h.name AS headquarter 

FROM 
		piece AS p,
		pieceStock AS ps,
		supplierpiece AS sp,
		brand AS b,
		zone AS z,
		headquarter AS h
WHERE 
		ps.fkSupplierPieceId = sp.supplierPieceId AND 
		sp.fkPieceId = p.pieceId AND 
		sp.fkBrandId = b.brandId AND 
		ps.fkZoneId = z.zoneId AND 
		ps.fkHeadquarterId = h.headquarterId AND 
		((ps.maxStock - ps.stock)  / ps.maxStock) * 100 >= 10;
~~~~


### Outcome
| supplierPieceId | pieceName               | brand       | currentStock | maxStock | zone                                 | headquarter        |
|:---------------:|:-----------------------:|:-----------:|:------------:|:--------:|:------------------------------------:|:------------------:|
|               1 | Filtro de aceite        | Bosch       |           11 |       13 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|               2 | Bujía                   | Denso       |           14 |       16 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|               4 | Amortiguador            | Bosch       |           35 |       42 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|               5 | Batería                 | KYB         |           52 |       68 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|               6 | Neumático               | Bosch       |           45 |       51 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|               7 | Cable de encendido      | Aisin       |           23 |       32 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|               8 | Bomba de agua           | Continental |           52 |       65 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|              10 | Correas de distribución | Continental |           35 |       42 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|              11 | Alternador              | Bosch       |           51 |       60 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|              12 | Radiador                | Denso       |           25 |       42 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|              13 | Disco de freno          | Brembo      |           32 |       40 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|              14 | Sensor de oxígeno       | SKF         |           22 |       35 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|              15 | Bomba de combustible    | Milwaukee   |           10 |       12 | rea de Almacenamiento y Suministros | Taller Bucaramanga |
|              16 | Inyector de combustible | Bosch       |           10 |       15 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|              18 | Embrague                | Optima      |            8 |        9 | Área de Almacenamiento y Suministros | Taller Bucaramanga |
|              20 | Tornillo de rueda       | Continental |          150 |      170 | Área de Almacenamiento y Suministros | Taller Bucaramanga |

