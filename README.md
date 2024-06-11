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
|        10 | 2020-08-10   | 2020-08-17    | Se reemplaz el sensor de oxgeno defectuoso para corregir un cdigo de error del sistema de control de emisiones.|
|        10 | 2022-02-10   | 2022-03-02    | Se le apag en el camino. Se realizaron mltiples reparaciones en el sistema de encendido, que incluyeron el reemplazo de bujas, cables de encendido, bobina de encendi
do y ajuste del tiempo de encendido. |

