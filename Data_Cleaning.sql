/*
Cleaning Data in SQL Queries

*/

select * from nashville_housing;
----------------------------------------------------------------------------------

-- Standardize Data Format
select sale_date::date 
from nashville_housing;

alter table nashville_housing
add sale_date_converted date;

update nashville_housing
set sale_date_converted = sale_date::date;

select sale_date_converted 
from nashville_housing;

-----------------------------------------------------------------------------------

--Populate Property Address data
select *
from nashville_housing
--where property_address is null
order by parcel_id;

--observe entries with same parcel_id have same property_address

select housing_1.unique_id, housing_1.parcel_id, housing_1.property_address, housing_2.unique_id, housing_2.parcel_id, housing_2.property_address, COALESCE(housing_1.property_address, housing_2.property_address)
from nashville_housing as housing_1
JOIN nashville_housing housing_2
    on housing_1.parcel_id = housing_2.parcel_id
	AND housing_1.unique_id <> housing_2.unique_id
WHERE housing_1.property_address is null;


update nashville_housing
set property_address = COALESCE(nashville_housing.property_address, housing_2.property_address)
from nashville_housing housing_2
WHERE nashville_housing.parcel_id = housing_2.parcel_id AND 
      nashville_housing.unique_id <> housing_2.unique_id AND 
	  nashville_housing.property_address is null;

-------------------------------------------------------------------------------------------------

-- Breaking out address into individual columns(address, city, state)
select property_address
from nashville_housing;

select 
split_part(property_address, ',', 1) as address,
split_part(property_address, ',', -1) as city
from nashville_housing;

alter table nashville_housing
    add property_split_address varchar,
	add property_split_city varchar;

update nashville_housing
set property_split_address = split_part(property_address, ',', 1),property_split_city = split_part(property_address, ',', -1);

select property_split_address, property_split_city
from nashville_housing;


select owner_address
from nashville_housing;

select
split_part(owner_address, ',', 1) as address,
split_part(owner_address, ',', 2) as city,
split_part(owner_address, ',', -1) as state
from nashville_housing;

alter table nashville_housing
    add owner_split_address varchar,
	add owner_split_city varchar,
	add owner_split_state varchar;

update nashville_housing
set owner_split_address = split_part(owner_address, ',', 1), owner_split_city = split_part(owner_address, ',', 2),
    owner_split_state = split_part(owner_address, ',', -1);

select owner_split_address, owner_split_city, owner_split_state
from nashville_housing;

-------------------------------------------------------------------------------------

--Change Y and N to Yes and No in "Sold as Vacant" field

select distinct(sold_as_vacant), count(sold_as_vacant)
from nashville_housing
group by sold_as_vacant
order by 2;

select sold_as_vacant
,CASE when sold_as_vacant = 'Y' THEN 'Yes'
       when sold_as_vacant = 'N' THEN 'No'
	   ELSE sold_as_vacant
	   END
from nashville_housing;

update nashville_housing
set sold_as_vacant = CASE when sold_as_vacant = 'Y' THEN 'Yes'
       when sold_as_vacant = 'N' THEN 'No'
	   ELSE sold_as_vacant
	   END

--------------------------------------------------------------------------------------------

--See Duplicates

WITH row_num_cte AS(
select *,
    row_number() OVER(
	PARTITION BY parcel_id,
	             property_address,
	             sale_price,
	             sale_date,
	             legal_reference
	             order by
	                unique_id
	                 ) row_num
from nashville_housing
--order by parcel_id;
)
select * 
from row_num_cte
where row_num > 1;

--Delete duplicates 

delete from nashville_housing
where unique_id in(
      select unique_id
      from(
	       select unique_id,
	              row_number() over (partition by parcel_id, property_address, sale_price, sale_date, legal_reference) row_num
	       from nashville_housing
	  ) s
      where row_num>1
);

----------------------------------------------------------------------------------------------------

--Delete unused columns

select *
from nashville_housing;

alter table nashville_housing
   drop column property_address,
   drop column owner_address,
   drop column tax_district,
   drop column sale_date


