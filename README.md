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
