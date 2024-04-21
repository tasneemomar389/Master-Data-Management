
CREATE OR REPLACE PROCEDURE stored_procedure.merge_dim_customer()
BEGIN
  MERGE `star_schema.dim_customer` AS dc
  USING ( SELECT DISTINCT Customer_ID,Customer_Name, Segment, CURRENT_TIMESTAMP() AS Created_Date, CURRENT_TIMESTAMP() AS Last_Updated_Date
          FROM `orders.order_details`
          ) AS od
  ON dc.Customer_ID = od.Customer_ID

  WHEN MATCHED THEN
    UPDATE SET
      Customer_Name = od.Customer_Name,
      Segment = od.Segment,
      Last_Updated_Date = od.Last_Updated_Date

  WHEN NOT MATCHED THEN
    INSERT (Customer_ID, Customer_Name, Segment, Created_Date, Last_Updated_Date)
    VALUES ( od.Customer_ID, od.Customer_Name, od.Segment, od.Created_Date, od.Last_Updated_Date);
END;
