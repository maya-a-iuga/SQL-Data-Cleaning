CREATE TABLE IF NOT EXISTS nashville_housing
(
    unique_id numeric,
	parcel_id varchar,
	land_use varchar,
	property_address varchar,
	sale_date timestamp,
	sale_price varchar,
	legal_reference varchar,
	sold_as_vacant varchar,
	owner_name varchar,
	owner_address varchar,
	acreage numeric,
	tax_district varchar,
	land_value numeric,
	building_value numeric,
	total_value numeric,
	year_built numeric,
	bedrooms numeric,
	full_bath numeric,
	half_bath numeric
);

SELECT * FROM nashville_housing;

UPDATE nashville_housing SET property_address = NULL where property_address = cast(-7 as varchar);
UPDATE nashville_housing SET owner_name = NULL where owner_name = cast(-7 as varchar);
UPDATE nashville_housing SET owner_address = NULL where owner_address = cast(-7 as varchar);
UPDATE nashville_housing SET acreage = NULL where acreage = -7;
UPDATE nashville_housing SET tax_district = NULL where tax_district = cast(-7 as varchar);
UPDATE nashville_housing SET land_value = NULL where land_value = -7;
UPDATE nashville_housing SET building_value = NULL where building_value = -7;
UPDATE nashville_housing SET total_value = NULL where total_value = -7;
UPDATE nashville_housing SET year_built = NULL where year_built = -7;
UPDATE nashville_housing SET bedrooms = NULL where bedrooms = -7;
UPDATE nashville_housing SET full_bath = NULL where full_bath = -7;
UPDATE nashville_housing SET half_bath = NULL where half_bath = -7;
