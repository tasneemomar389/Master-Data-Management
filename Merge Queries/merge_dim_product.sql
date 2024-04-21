CREATE OR REPLACE PROCEDURE stored_procedure.merge_dim_product()
BEGIN MERGE `star_schema.dim_product` AS dp
  USING ( WITH cte_product AS
                              ( SELECT DISTINCT Product_ID, Product_Name, Category, Sub_Category
                                FROM `orders.order_details`
                               )
                              SELECT Product_ID, Category, Sub_Category, STRING_AGG(Product_Name, '/') AS Product_Names,
                                CURRENT_TIMESTAMP() AS Created_Date,
                                CURRENT_TIMESTAMP() AS Last_Updated_Date
                               FROM cte_product
                              GROUP BY ALL
  ) AS od
  ON dp.Product_ID = od.Product_ID

  WHEN MATCHED THEN
    UPDATE SET
      Product_Names = od.Product_Names,
      Category      = od.Category,
      Sub_Category  = od.Sub_Category,
      Last_Updated_Date = od.Last_Updated_Date
  WHEN NOT MATCHED THEN
    INSERT (Product_ID, Category, Sub_Category, Product_Names, Created_Date, Last_Updated_Date)
    VALUES (
      od.Product_ID,
      od.Category,
      od.Sub_Category,
      od.Product_Names,
      od.Created_Date,
      od.Last_Updated_Date
    );
END;
