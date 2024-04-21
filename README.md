# Master-Data-Management
This project aims to establish a Master Data Management (MDM) system using Google Cloud Platform (GCP) services. The project involves setting up data sources, loading data into Google BigQuery, creating schemas, running stored procedures, and generating reports for business analysis.
Got it! Here's a revised version of your README file structured in the same way you've created it:

Steps

1. **Create Google Storage Bucket:**
   - The source system for this project is Google Storage. Make sure to create a bucket to store the data files.

2. **Navigate to BigQuery and Run DDLs Script:**
   - Access Google BigQuery and execute the Data Definition Language (DDL) script provided in the project. This script sets up the necessary tables and schemas for data storage and processing.

3. **Install Required Tools:**
   - Install necessary tools like `gcloud` for managing GCP resources and Python packages (`fsspec`, `gcsfs`) for interacting with Google Storage.
   # Example commands for installation
   install gcloud
   pip3 install fsspec
   pip3 install gcsfs
   gcloud components install google cloud storage

4. **Run Data Loading Script:**
   - Execute the 'orderpipeline.py' script to load data from Google Storage into BigQuery tables. Make sure to configure the script with the correct bucket name, project, and table details.
   # Example command to run the script
   python3 orderpipeline.py

5. **Create Schema (Stored Procedure):**
   - Create a schema named 'stored_procedure' under the BigQuery project where stored procedures will be stored. This schema will hold the scripts for merging data and maintaining data consistency.

6. **Run Merge Scripts:**
   - Execute the merge scripts ('merge_dim_customer', 'merge_dim_product', 'merge_dim_address', 'merge_fact_orders') to perform data merging operations. These scripts handle tasks such as updating dimensions and inserting/updating facts in the data warehouse using Incremental load(Merge)

7. **Call Stored Procedures:**
   - Call the stored procedures from the 'stored_procedure' schema to trigger the merge operations. Use SQL `CALL` statements to execute the procedures and update the data in the data warehouse.
   ```sql
   # Example SQL statements to call stored procedures
   CALL stored_procedure.merge_dim_customer();
   CALL stored_procedure.merge_dim_address();
   CALL stored_procedure.merge_dim_product();
   CALL stored_procedure.merge_dim_customer();
   ```

8. **Data Verification:**
   - Verify that the data has been loaded into the StarSchema fact and dimension tables correctly by running sample queries or performing data validation checks.

9. **Generate Reports:**
   - Utilize Google Data Studio or other reporting tools to connect to the BigQuery tables and generate reports for business analysis and decision-making.

10. **Testing and Monitoring:**
    - Perform thorough testing of the entire MDM process to ensure data accuracy and consistency.
    - Set up monitoring and alerting mechanisms to detect and address any issues that may arise during data processing.

## Additional Notes

- Ensure that all configurations, such as bucket name, project ID, and table details, are correctly set before running scripts or procedures.
- Regularly monitor the data quality and system performance to maintain an efficient and reliable MDM system.










1. The source system for this project is Google Stroge , so please make sure to create a bucket and load the files there.
2. The destionaion is Google BiqQuery , Navigate to BigQuery and Run DDL.sql Script.
3. On your machine open IDE i used ( Visual Studio Code) for this project .
4. Make sure to make Installs for
   install gcloud
   pip3 install fsspec
   pip3 install gcsfs
   gcloud components install google cloud storage
   gcloud component list
   ./google-cloud-sdk/install.sh
5. Run orderpipeline.py script ( make sure to change the values of the ( bucket_name , project and the load_table_from_dataframe) in this project I've used
   project="graphic-abbey-356908
   load_table_from_dataframe = "orders.order_details"
   bucket_name="tasneem_orders"
6. Runing the above will generte records under bigquery orders.order_details
7. Create a dataset (create schema stored_procedure under the same biquery project)
8. Run the attached script under Merge Queries folder ( merge_dim_customer , merge_dim_product, merge_dim_address , merge_fact_orders)
9. Call the 3 Script that we have created
   CALL stored_procedure.merge_dim_customer();
   CALL stored_procedure.merge_dim_address();
   CALL stored_procedure.merge_dim_product();
   CALL stored_procedure.merge_dim_customer();
10. Data has been loaded into StarSchema fact and Dims.
11. I've added a script that contains some testing queries 
12. you can connect the BiQuery tables via Google Data Studio in order to Genetre reports for bussnines
    
   
