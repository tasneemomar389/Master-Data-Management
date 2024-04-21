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
   Example commands for installation
   install gcloud
   pip3 install fsspec
   pip3 install gcsfs
   gcloud components install google cloud storage

4. **Run Data Loading Script:**
   - Execute the 'orderpipeline.py' script to load data from Google Storage into BigQuery tables. Make sure to configure the script with the correct bucket name, project, and table details.
   - This can be also via Google Function using the Same script https://us-east1-graphic-abbey-356908.cloudfunctions.net/load_orders
   Example command to run the script
   python3 orderpipeline.py

5. **Run Merge Scripts:**
   - Create Schema (Stored Procedure) under the BigQuery project where stored procedures will be stored Execute the merge scripts ('merge_dim_customer', 'merge_dim_product', 'merge_dim_address', 'merge_fact_orders') to perform data merging operations. These scripts handle tasks such as updating dimensions and inserting/updating facts in the data warehouse using Incremental load(Merge)

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
     https://lookerstudio.google.com/reporting/2b37a713-0d9d-4a4b-9f52-0090231aa1c6

10. **Testing and Monitoring:**
    - Perform thorough testing of the entire MDM process to ensure data accuracy and consistency.
    - Set up monitoring and alerting mechanisms to detect and address any issues that may arise during data processing.
    - I've added a Test script as Sample "Tests.sql"

## Additional Notes

- Ensure that all configurations, such as bucket name, project ID, and table details, are correctly set before running scripts or procedures.
- Regularly monitor the data quality and system performance to maintain an efficient and reliable MDM system.
