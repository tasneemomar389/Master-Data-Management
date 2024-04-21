CREATE OR REPLACE PROCEDURE stored_procedure.merge_dim_address()
BEGIN
  MERGE INTO `star_schema.dim_address` AS da
  USING ( SELECT DISTINCT a.Country, a.City, a.State, a.Postal_Code, a.Region, CURRENT_TIMESTAMP() AS Created_Date, CURRENT_TIMESTAMP() AS Last_Updated_Date
          FROM `orders.order_details` a
          LEFT JOIN `star_schema.dim_address` da
            ON a.Country = da.Country
            AND a.City = da.City
            AND a.State = da.State
            AND a.Postal_Code = da.Postal_Code
            AND a.Region = da.Region
           WHERE da.Address_ID IS NULL
        ) AS nd
  ON  1 = 0 -- Always false condition to ensure INSERT only
WHEN NOT MATCHED THEN
    INSERT ( Address_ID, Country, City, State, Postal_Code, Region,Created_Date, Last_Updated_Date
    )
    VALUES ((SELECT COALESCE(MAX(Address_ID), 0) + ROW_NUMBER() OVER () FROM `star_schema.dim_address`),
           nd.Country, nd.City, nd.State,nd.Postal_Code,nd.Region,nd.Created_Date,nd.Last_Updated_Date
    );
END;
