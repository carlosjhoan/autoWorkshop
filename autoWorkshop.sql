-- DataBase automoWorkshop

drop database if exists autoWorkshop;

create database if not exists autoWorkshop;

use autoWorkshop;

-- Creation of country table
create table if not exists country(
	countryId int auto_increment,
	name varchar(100) not null,
	constraint pk_country_id primary key(countryId)
);

-- Creation of  region table
create table if not exists region(
	regionId int auto_increment,
	name varchar(100) not null,
	fkCountryId int not null,
	constraint pk_region_id primary key(regionId),
	constraint fk_region_country_id foreign key(fkCountryId) references country(countryId)
);

-- Creation of city table
CREATE TABLE city(
	cityId int auto_increment,
	name varchar(100) not null,
	postalCode varchar(100) not null,
	fkRegionId INT NOT NULL,
	constraint pk_city_id primary key(cityId),
	constraint fk_city_region_id foreign key(fkRegionId) references region(regionId)
);

-- Creation of customer table
create table if not exists customer(
	customerId int auto_increment,
	firstName varchar(50) not null,
	lastName varchar(50),
	email varchar(100) unique,
	constraint pk_customer_id primary key(customerId)
);

-- Creation of documentType table
create table if not exists documentType(
	typeId int auto_increment,
	type varchar(50) not null,
	constraint pk_type_id primary key(typeId)
);

-- Creation of customerDocument table
create table if not exists customerDocument(
	customerDocumentId int auto_increment,
	documentNum varchar(50) unique,
	fkTypeId int not null,
	fkCustomerId int not null,
	constraint pk_customer_document_id primary key(customerDocumentId),
	constraint fk_customer_document_id foreign key(fkCustomerId) references customer(customerId),
	constraint fk_customer_document_type_id foreign key(fkTypeId) references documentType(typeId)	
);

-- Creaction of phoneType table
create table if not exists phoneType(
	phoneTypeId int auto_increment,
	type varchar(50) not null,
	constraint pk_phone_type_id primary key(phoneTypeId)
); 

-- Creation of customerPhone table
create table if not exists customerPhone(
	customerPhoneId int auto_increment,
	phoneNum varchar(20),
	fkPhoneTypeId int,
	fkCustomerId int not null,
	constraint pk_customer_phone_id primary key(customerPhoneId),
	constraint fk_customer_phone_id foreign key(fkCustomerId) references customer(customerId),
	constraint fk_phone_type_id foreign key(fkPhoneTypeId) references phoneType(phoneTypeId)
);

/*
-- Creation of addressType table
create table if not exists addressType(
	addressTypeId int auto_increment,
	type varchar(50) not null,
	constraint pk_address_type_id primary key(addressTypeId)
);
*/

/*
-- Creation of customerAddress table
create table if not exists customerAddress(
	customerAddressId int auto_increment,
	address varchar(100),
	fkAddressTypeId varchar(50),
	fkCustomerId int not null,
	constraint fk_customer_address_id foreign key(fkCustomerId) references customer(customerId),
	constraint fk_address_type_id foreign key(fkAddressTypeId) references addressType(fkAddressTypeId)
);
*/

-- Creation of brand table
create table if not exists brand(
	brandId int auto_increment,
	name varchar(20) not null,
	constraint pk_phone_type_id primary key(brandId)	
);

-- Creation of carModel table
create table if not exists carModel(
	carModelId int auto_increment,
	fkBrandId int not null,
	model varchar(50) not null,
	constraint pk_brand_id primary key(carModelId, fkBrandId),
	constraint fk_brand_car_model_id foreign key(fkBrandId) references brand(brandId)
);

-- Creation of vehicle table
create table if not exists vehicle(
	vehicleId int auto_increment,
	numberPlate varchar(15) not null,
	fkCarModelId int not null,
	fabYear year,
	fkCustomerId int not null,
	constraint pk_vehicle_id primary key(vehicleId),
	constraint fk_vehicle_car_model_id foreign key(fkCarModelId) references carModel(carModelId),
	constraint fk_vehicle_customer_id foreign key(fkCustomerId) references customer(customerId)	
);

-- Creation of zone table
create table if not exists zone(
	zoneId int auto_increment,
	name varchar(70) not null,
	description text,
	constraint pk_zone_id primary key(zoneId)
);

-- Creation of onSiteService table
create table if not exists onSiteService(
	onSiteServiceId int auto_increment,
	name varchar(70) not null,
	description text not null,
	fkZoneId int not null,
	price decimal(15,2) not null,
	constraint pk_onSiteService_id primary key(onSiteServiceId),
	constraint fk_onSiteService_zone_id foreign key(fkZoneId) references zone(zoneId)
);

-- Creation of outSiteService table
create table if not exists outSiteService(
	outSiteServiceId int auto_increment,
	name varchar(70) not null,
	description text not null,
	price decimal(15,2) not null,
	constraint pk_outSiteService_id primary key(outSiteServiceId)
);


-- Creation of jobs table
create table if not exists job(
	jobId int auto_increment,
	jobName varchar(50) not null,
	constraint pk_job_id primary key(jobId)
); 

-- Creation of headquarter table
create table if not exists headquarter(
	headquarterId int auto_increment,
	name varchar(70) not null,
	address varchar(70) not null,
	fkCityId int not null,
	constraint pk_headquarter_id primary key(headquarterId),
	constraint fk_headquarter_city_id foreign key(fkCityId) references city(CityId)
);

-- Creation of employee table
create table if not exists employee(
	employeeId int auto_increment,
	firstName varchar(70) not null,
	lastName varchar(70) not null,
	fkJobId int,
	fkHeadquarterId int not null,
	email varchar(100) unique,
	constraint pk_employee_id primary key(employeeId),
	constraint fk_employee_job_id foreign key(fkJobId) references job(jobId),
	constraint fk_employee_headquarter_id foreign key(fkHeadquarterId) references headquarter(headquarterId)
);



-- Creation of employeeDocument table
create table if not exists employeeDocument(
	employeeDocumentId int auto_increment,
	documentNum varchar(50) unique,
	fkTypeId int not null,
	fkEmployeeId int not null,
	constraint pk_employee_document_id primary key(employeeDocumentId),
	constraint fk_employee_document_id foreign key(fkEmployeeId) references employee(employeeId),
	constraint fk_employee_document_type_id foreign key(fkTypeId) references documentType(typeId)	
);

-- Creation of repair table
create table if not exists repair(
	repairId int auto_increment,
	fkVehicleId int not null,
	repairDateIn date not null,
	repairDateOut date,
	description text,
	constraint pk_repair_id primary key(repairId),
	constraint fk_repair_vehicle_id foreign key(fkVehicleId) references vehicle(vehicleId)
);

-- Creation of outSiteRepairService table
create table if not exists outSiteRepairService(
	fkRepairId int not null,
	fkOutSiteServiceId int not null,
	fkEmployeeId int not null,
	address varchar(100) not null,
	fkCityId int not null,
	constraint pk_outSiteRepairService_id primary key(fkRepairId, fkOutSiteServiceId),
	constraint fk_outSiteService_repair_id foreign key(fkRepairId) references repair(repairId),
	constraint fk_outSiteRepair_service_id foreign key(fkOutSiteServiceId) references outSiteService(outSiteServiceId),
	constraint fk_outSiteServiceRepair_employee_id foreign key(fkEmployeeId) references employee(employeeId),
	constraint fk_outSiteServiceRepair_city_id foreign key(fkCityId) references city(cityId)
);

-- Creation of onSiteRepairService table
create table if not exists onSiteRepairService(
	fkRepairId int not null,
	fkOnSiteServiceId int not null,
	fkEmployeeId int not null,
	constraint pk_onSiteRepairService_id primary key(fkRepairId, fkOnSiteServiceId),
	constraint fk_onSiteService_repair_id foreign key(fkRepairId) references repair(repairId),
	constraint fk_onSiteRepair_service_id foreign key(fkOnSiteServiceId) references onSiteService(onSiteServiceId),
	constraint fk_onSiteServiceRepair_employee_id foreign key(fkEmployeeId) references employee(employeeId)
);


-- Creation of supplier table
create table if not exists supplier(
	supplierId int auto_increment,
	name varchar(50) not null,
	email varchar(50) unique,
	fkCityId int,
	constraint pk_supplier_id primary key(supplierId),
	constraint fk_supplier_city_id foreign key(fkCityId) references city(cityId)
);

-- Creation of supplierPhone table
create table if not exists supplierPhone(
	supplierPhoneId int auto_increment,
	phoneNum varchar(20),
	fkPhoneTypeId int,
	fkSupplierId int not null,
	constraint pk_supplier_phone_id primary key(supplierPhoneId),
	constraint fk_supplier_phone_id foreign key(fkSupplierId) references supplier(supplierId),
	constraint fk_supplier_phone_type_id foreign key(fkPhoneTypeId) references phoneType(phoneTypeId)
);



-- Creation of supplierContact table
create table if not exists supplierContact(
	supplierContactId int auto_increment,
	firstName varchar(50) not null,
	lastName varchar(50),
	email varchar(100) unique,
	fkSupplierId int not null,
	constraint pk_supplierContact_id primary key(supplierContactId),
	constraint fk_phone_contact_id foreign key(fkSupplierId) references supplier(supplierId)
);

-- Creation of supplierContactPhone table
create table if not exists supplierContactPhone(
	supplierContactPhoneId int auto_increment,
	phoneNum varchar(20),
	fkPhoneTypeId int,
	fkSupplierContactId int not null,
	constraint pk_supplierContact_phone_id primary key(supplierContactPhoneId),
	constraint fk_supplierContact_phone_id foreign key(fkSupplierContactId) references supplierContact(supplierContactId),
	constraint fk_supplierContact_phone_type_id foreign key(fkPhoneTypeId) references phoneType(phoneTypeId)
);

-- Creation of piece table
create table if not exists piece(
	pieceId int auto_increment,
	name varchar(80) not null,
	description text,
	constraint pk_piece_id primary key(pieceId)
);


-- Creation of supplierPiece table
create table if not exists supplierPiece(
	supplierPieceId int auto_increment,
	fkPieceId int not null,
	fkBrandId int,
	fkSupplierId INT not null,
	itemPrice decimal(15, 2) not null,
	constraint pk_supplierPiece_id primary key(supplierPieceId),
	constraint fk_supplier_piece_id foreign key(fkPieceId) references piece(pieceId),
	constraint fk_supplierPiece_brand_id foreign key(fkBrandId) references brand(brandId),
	constraint fk_supplierPiece_supplier_id foreign key(fkSupplierId) references supplier(supplierId)
);


-- Creation of pieceStock table
create table if not exists pieceStock(
	pieceStockId int auto_increment,
	fkSupplierPieceId int not null,
	fkZoneId int not null,
	fkHeadquarterId int not null,
	stock int not null,
	constraint pk_pieceStock_id primary key(pieceStockId),
	constraint fk_pieceStock_supplierPiece_id foreign key(fkSupplierPieceId) references supplierPiece(supplierPieceId),
	constraint fk_pieceStock_zone_id foreign key(fkZoneId) references zone(zoneId),
	constraint fk_pieceStock_headquarter_id foreign key(fkHeadquarterId) references headquarter(headquarterId)
); 

-- Creation of repairPiece table
create table if not exists repairPiece(
	fkRepairId int not null,
	fkPieceStockId int not null,
	quantity int not null,
	constraint pk_repairPiece_id primary key(fkRepairId, fkPieceStockId),
	constraint fk_repairPiece_repair_id foreign key(fkRepairId) references repair(repairId),
	constraint fk_repair_pieceStock_id foreign key(fkPieceStockId) references supplierPiece(supplierPieceId)
); 


-- Creation of appointment table
create table if not exists appointment(
	appointmentId int auto_increment,
	fkCustomerId int not null,
	appointDate datetime not null,
	fkHeadquarterId int not null,
	description text,
	constraint pk_appointment_id primary key(appointmentId),
	constraint fk_appointment_customer_id foreign key(fkCustomerId) references customer(customerId),
	constraint fk_appointment_headquarter_id foreign key(fkHeadquarterId) references headquarter(headquarterId)
);


-- Creation of appointmentVehicle table
create table if not exists appointmentVehicle(
	fkAppointmentId int not null,
	fkVehicleId int not null,
	constraint pk_appointmentVehicle_id primary key(fkAppointmentId, fkVehicleId),
	constraint fk_appointmentVehicle_appointment_id foreign key(fkAppointmentId) references appointment(appointmentId),
	constraint fk_appointmentVehicle_vehicle_id foreign key(fkVehicleId) references vehicle(vehicleId)
);

-- Creation of invoice table
create table if not exists invoice(
	invoiceId int auto_increment,
	fkCustomerId int not null,
	invoiceDate datetime not null,
	fkHeadquarterId int not null,
	constraint pk_invoice_id primary key(invoiceId),
	constraint fk_invoice_customer_id foreign key(fkCustomerId) references customer(customerId),
	constraint fk_invoice_headquarter_id foreign key(fkHeadquarterId) references headquarter(headquarterId)
);

-- Creation of repairInvoice table
create table if not exists repairInvoice(
	fkInvoiceId int not null,
	fkRepairId int not null,
	constraint pk_repairInvoice_id primary key(fkInvoiceId, fkRepairId),
	constraint fk_repairInvoice_invoice_id foreign key(fkInvoiceId) references invoice(invoiceId),
	constraint fk_repairInvoice_repair_id foreign key(fkRepairId) references repair(repairId)
);

-- Creation of purchaseOrder table
create table if not exists purchaseOrder(
	purchaseOrderId int auto_increment,
	fkEmployeeId int not null,
	orderDate datetime not null default(CURRENT_TIMESTAMP()),
	description text,
	constraint pk_purchaseOrder_id primary key(purchaseOrderId),
	constraint fk_purchaseOrderId_employee_id foreign key(fkEmployeeId) references employee(employeeId)
);

-- Creation of purchaseOrderPiece table
create table if not exists purchaseOrderPiece(
	fkPurchaseOrderId int not null,
	fkSupplierPieceId int not null,
	quantity int not null,
	constraint pk_purchaseOrderPiece_id primary key(fkPurchaseOrderId, fkSupplierPieceId),
	constraint fk_purchaseOrderPiece_order_id foreign key(fkPurchaseOrderId) references purchaseOrder(purchaseOrderId),
	constraint fk_purchaseOrderPiece_supplierPiece_id foreign key(fkSupplierPieceId) references supplierPiece(supplierPieceId)
);





















