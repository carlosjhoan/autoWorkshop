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

