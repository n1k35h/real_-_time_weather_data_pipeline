# Real - Time Weather Data Pipeline
Building a Real-Time Weather Data Pipeline using MongoDB, Airbyte, and DuckDB for SkyLogix Transportation

This script, ingest_weather_api.py, is a Python-based utility for ingesting hourly weather forecast data from the weatherbit.io API and storing it in a MongoDB database. The script is designed to be easily configurable and handles data fetching, normalization, and bulk upsert operations to ensure data freshness and deduplication. Airbyte is required to fetch the data from MongoDB database (MongoDB Atlas Cloud) then transfer the data to the destination, MotherDuck, where the data will be analysed and provide visualisation.

## Features

- **Configurable Locations:** Fetches 24-hour hourly weather forecasts for a predefined list of cities in Africa: Lagos, Accra, and Johannesburg.
- **API Integration:** Uses the requests library to connect to the Weatherbit.io API.
- **Data Normalization:** Processes raw API responses into a structured format, creating a deterministic _id for each record based on the city and timestamp to prevent duplicates.
- **MongoDB Upsert:** Performs a bulk upsert operation, which efficiently inserts new records or updates existing ones, minimizing database write operations.
- **Environment Variables:** Securely manages sensitive credentials (API keys, database passwords) using a .env file.
- **Idempotency:** The script is designed to be idempotent; running it multiple times will not create duplicate records due to the use of a unique index on the _id field.

## Requirements

- Python 3.7+
- Weatherbit.io API Key
- MongoDB Cluster: Access to a MongoDB database is required. The script is configured to connect to a MongoDB Atlas cluster.
- Airbyte: Access from Airbyte to get a connection to MongoDB Atlas Cloud, so the data moves to the selected destination data warehousing
- MotherDuck: is the destination for the MongoDB data for analysis and visualisation
- Python packages:
  - requests
  - pymongo
  - python-dotenv

Install dependencies with:

```sh
pip install pandas requests pymongo python-dotenv
```

## Setup

1. Clone the repository (if applicable) or save the script to your local machine.

2. Create a .env file in the same directory as the script. This file will store your credentials.
    ```sh
    API_KEY="API_KEY"
    password="password"
    ```

3. Replace the placeholder values with your actual Weatherbit API key and MongoDB Atlas password.
   
4. **Verify MongoDB Connection String:** The MONGO_URI is currently hardcoded in the script to connect to a specific MongoDB Atlas cluster (`scoobycluster1`). If you are using a different cluster, you'll need to update this line in the `ingest_weather_api.py` file:

    ```sh
    MONGO_URI = f"mongodb+srv://skylogix1:{DB_PASS}@scoobycluster1.8ynjmbv.mongodb.net/?retryWrites=true&w=majority&appName=scoobyCluster1"
    ```

5. Signed up to Airbyte to move data from `MongoDB Atlas cluster database` to the selected destination (`MotherDuck`)

6. Signed up to MotherDuck to gain access token code, which is required to be inputted in the destination section for the data to be allow to move to MotherDuck

7. MotherDuck to write SQL queries to analyse and visualise the data

## Usage
To run the script, execute the following command in your terminal:
    
```sh
python ingest_weather_api.py
```

The script will:

Connect to the specified MongoDB database and ensure the necessary indexes are in place on the `weather` collection.

Iterate through the list of cities (Lagos, Accra, Johannesburg).

For each city, it will construct a URL and fetch the hourly forecast data for the next 24 hours from the Weatherbit API.

The fetched records will be normalized into a consistent schema.

Finally, it will perform a bulk upsert of the normalized documents into the `skylogix_prod.weather` collection.

## Author:
Developed by Nikesh Mistry, If you like this project, please give this project a ⭐, thanks 😄 