CREATE OR REPLACE PROCEDURE merge_fact_orders()
BEGIN
  MERGE star_schema.fact_orders AS fo
  USING (
          SELECT
            CONCAT(a.Order_ID, '-', a.Product_ID) AS Order_Product_ID,
            a.Order_ID,
            a.Order_Date,
            a.Ship_Date,
            a.Ship_Mode,
            SUM(a.Sales) AS Sales,
            SUM(a.Quantity) AS Quantity,
            SUM(a.Discount) AS Discount,
            SUM(a.Profit) AS Profit,
            a.Product_ID,
            a.Customer_ID,
            dm.Address_ID,
            CURRENT_TIMESTAMP() AS Created_Date,
            CURRENT_TIMESTAMP() AS Last_Updated_Date
          FROM  `orders.order_details` a
          JOIN `star_schema.dim_address` dm
            ON a.Country = dm.Country
            AND a.Postal_Code = dm.Postal_Code
            AND a.State = dm.State
            AND a.City = dm.City
          LEFT JOIN `star_schema.fact_orders` fo
              ON a.Order_ID = fo.Order_ID
              AND a.Product_ID = fo.Product_ID
          GROUP BY ALL
        ) AS new_orders
  ON fo.Order_ID = new_orders.Order_ID
  AND fo.Product_ID = new_orders.Product_ID
  WHEN MATCHED THEN
    UPDATE SET
      Order_Date = new_orders.Order_Date,
      Ship_Date = new_orders.Ship_Date,
      Ship_Mode = new_orders.Ship_Mode,
      Sales = new_orders.Sales,
      Quantity = new_orders.Quantity,
      Discount = new_orders.Discount,
      Profit = new_orders.Profit,
      Last_Updated_Date = new_orders.Last_Updated_Date
  WHEN NOT MATCHED THEN
    INSERT (Order_Product_ID, Order_ID, Order_Date, Ship_Date, Ship_Mode, Sales, Quantity, Discount, Profit, Product_ID, Customer_ID, Address_ID, Created_Date, Last_Updated_Date)
    VALUES (
      new_orders.Order_Product_ID,
      new_orders.Order_ID,
      new_orders.Order_Date,
      new_orders.Ship_Date,
      new_orders.Ship_Mode,
      new_orders.Sales,
      new_orders.Quantity,
      new_orders.Discount,
      new_orders.Profit,
      new_orders.Product_ID,
      new_orders.Customer_ID,
      new_orders.Address_ID,
      new_orders.Created_Date,
      new_orders.Last_Updated_Date
    );
END;
