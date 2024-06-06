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

-- Creation of service table
create table if not exists service(
	serviceId int auto_increment,
	name varchar(70) not null,
	description text not null,
	price decimal(15,2) not null,
	constraint pk_service_id primary key(serviceId)
);

-- Creation of jobs table
create table if not exists job(
	jobId int auto_increment,
	jobName varchar(50) not null,
	constraint pk_job_id primary key(jobId)
); 

-- Creation of employee table
create table if not exists employee(
	employeeId int auto_increment,
	firstName varchar(70) not null,
	lastName varchar(70) not null,
	fkJobId int,
	email varchar(100) unique,
	constraint pk_employee_id primary key(employeeId),
	constraint fk_employee_job_id foreign key(fkJobId) references job(jobId)
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

-- Creation of headquarter table
create table if not exists headquarter(
	headquarterId int auto_increment,
	name varchar(70) not null,
	address varchar(70) not null,
	fkCityId int not null,
	constraint pk_headquarter_id primary key(headquarterId),
	constraint fk_headquarter_city_id foreign key(fkCityId) references city(CityId)
);



























