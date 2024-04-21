
CREATE  SCHEMA orders;

CREATE  TABLE orders.order_details
(   Row_ID INT64 OPTIONS(description="Row number in files")  ,
    Order_ID STRING OPTIONS(description="Unique Order Id")  ,
    Order_Date DATE OPTIONS(description="Order creation date by customer")  ,
    Ship_Date DATE OPTIONS(description="Order shipment date")  ,
    Ship_Mode STRING OPTIONS(description="Order priority type (Same day, First Class, …) ")  ,
    Customer_ID STRING OPTIONS(description="Unique Customer Id")  ,
    Customer_Name STRING OPTIONS(description="Customer Name")  ,
    Segment STRING OPTIONS(description="Consumer Segment (Consumer, Corporate, …)")  ,
    Country STRING OPTIONS(description="Country of delivery")  ,
    City STRING OPTIONS(description="City of delivery")  ,
    State STRING OPTIONS(description="State of delivery")  ,
    Postal_Code INT64 OPTIONS(description="Postal Code of delivery") ,
    Region STRING OPTIONS(description="Region of delivery")  ,
    Product_ID STRING OPTIONS(description="Unique Id of ordered product") ,
    Category STRING OPTIONS(description="Product category") ,
    Sub_Category STRING OPTIONS(description="Product sub-category") ,
    Product_Name STRING OPTIONS(description="Product name") ,
    Sales FLOAT64 OPTIONS(description="Sales amount in USD") ,
    Quantity INT64 OPTIONS(description="Qty of product in order") ,
    Discount FLOAT64 OPTIONS(description="Order Discount") ,
    Profit FLOAT64 OPTIONS(description="Profit from delivery of the product")
  ) OPTIONS(description="Details of orders placed") ;


  CREATE  SCHEMA star_schema;


  CREATE  OR REPLACE TABLE star_schema.fact_orders (
    Order_Product_ID STRING  NOT NULL ,
    Order_ID STRING NOT NULL ,
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode STRING,
    Sales FLOAT64,
    Quantity INT64,
    Discount FLOAT64,
    Profit FLOAT64,
    Address_ID INT,
    Customer_ID STRING,
    Product_ID STRING NOT NULL,
    Created_Date TIMESTAMP,
    Last_Updated_Date TIMESTAMP
  ) OPTIONS(description="Fact table containing details of orders placed") ;


  CREATE OR REPLACE TABLE star_schema.dim_customer (
    Customer_ID STRING NOT NULL,
    Customer_Name STRING,
    Segment STRING,
    Created_Date TIMESTAMP,
    Last_Updated_Date TIMESTAMP
  ) OPTIONS(description="Dimension table containing details of customers") ;

  CREATE  OR REPLACE TABLE star_schema.dim_product (
    Product_ID STRING NOT NULL,
    Category STRING,
    Sub_Category STRING,
    Product_Names STRING,
    Created_Date TIMESTAMP,
    Last_Updated_Date TIMESTAMP
  ) OPTIONS(description="Dimension table containing details of products") ;


  CREATE OR REPLACE TABLE star_schema.dim_address (
    Address_ID INT NOT NULL,
    Country STRING,
    City STRING,
    State STRING,
    Postal_Code INT,
    Region STRING,
    Created_Date TIMESTAMP,
    Last_Updated_Date TIMESTAMP
  ) OPTIONS(description="Dimension table containing details of shipping address") ;
