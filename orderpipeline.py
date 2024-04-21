import pandas as pd 

from google.cloud import storage

from datetime  import datetime 

from google.cloud import bigquery  

import pyarrow 


client= storage.Client()

bucket_name="tasneem_orders"

orders_list= client.list_blobs(bucket_name)

blob_list =[] 

for blob in orders_list : 
    blob_list.append(blob.name)

datafram_list= []


for file in blob_list :
    df = pd.read_csv("gs://tasneem_orders/"+file,sep="|",encoding='latin1' )
    datafram_list.append(df)



for file_1 in datafram_list :
    df_1 = pd.concat(datafram_list,ignore_index=True)

columns= df_1.columns
df_1.columns= columns.str.replace(" ","_",regex=True)
df_1.columns= df_1.columns.str.replace("-","_",regex=True)
df_1["Row_ID"] = pd.to_numeric(df_1["Row_ID"])
df_1["Order_Date"] = pd.to_datetime(df_1["Order_Date"],format="%d-%m-%Y" , errors='coerce') 
df_1["Ship_Date"] = pd.to_datetime(df_1["Ship_Date"],format="%d-%m-%Y" , errors='coerce') 
df_1["Profit"] = pd.to_numeric(df_1["Profit"])
df_1["Row_ID"] = pd.to_numeric(df_1["Row_ID"])
df_1["Order_ID"] = df_1["Order_ID"].astype("string")
df_1["Customer_ID"] = df_1["Customer_ID"].astype("string")
df_1["Product_ID"] = df_1["Product_ID"].astype("string")
df_1["State"] = df_1["State"].astype("string")
df_1["City"] = df_1["City"].astype("string")
df_1["Country"] = df_1["Country"].astype("string")
df_1["Segment"] = df_1["Segment"].astype("string")
df_1["Customer_Name"] = df_1["Customer_Name"].astype("string")
df_1["Ship_Mode"] = df_1["Ship_Mode"].astype("string")
df_1["Product_Name"] = df_1["Product_Name"].astype("string")
df_1["Sub_Category"] = df_1["Sub_Category"].astype("string")
df_1["Category"] = df_1["Category"].astype("string")



client_bq = bigquery.Client(project="graphic-abbey-356908")

client_bq.load_table_from_dataframe(df_1,"orders.order_details")



# df_1.describe()
# df_1.dtypes
# df_1["Order_Date"].isnull().sum()





