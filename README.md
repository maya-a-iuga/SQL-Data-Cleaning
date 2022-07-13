# SQL-Data-Cleaning
In this project I performed data cleaning on a Nashville housing dataset using PostgreSQL.

## Transformations
The following transformations were applied to the raw dataset:
   + the dates columns were standardized to exclude time information
   + the null entries of the property_address columns were populated with correct entries based on the parcel_id column (entries with same parcel_id should have same property_address entry)
   + the property_address column was break into two individual columns: property_split_adress & property_split_city to separate address and city information
   + the owner_address column was break into three individual columns: owner_split_adress, owner_split_city & owner_split_state to separate address, city and state information 
   + entries in sold_as_vacant column were standardized, such that Y and N entries are now Yes & No
   + duplicate entries were removed from whole dataset
   + unused columns were deleted 
