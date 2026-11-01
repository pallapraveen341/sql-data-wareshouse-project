```sql
/*
===============================================================================
Stored Procedure: bronze.load_bronze
===============================================================================
Purpose:
    This stored procedure loads raw data from CRM and ERP source CSV files
    into their corresponding tables in the Bronze Layer.

    It automates the Bronze Layer data loading process using BULK INSERT.

Process:
    1. Truncate existing data from Bronze tables.
    2. Load fresh data from CRM and ERP CSV files.
    3. Track the execution time of each table load.
    4. Track the overall Bronze Layer execution time.
    5. Handle errors using TRY...CATCH.
    6. Display error details if the loading process fails.

Source Systems:
    CRM (Customer Relationship Management):
        - cust_info.csv
        - prd_info.csv
        - sales_details.csv

    ERP (Enterprise Resource Planning):
        - cust_az12.csv
        - LOC_A101.csv
        - PX_CAT_G1V2.csv

Logging:
    - Overall procedure start time
    - Overall procedure end time
    - Individual table loading duration
    - Total execution duration
    - Error message and error details

Important Notes:
    - The Bronze Layer stores raw source data.
    - No data cleaning or transformations are performed.
    - Existing table data is truncated before loading.
    - BULK INSERT is used for efficient data ingestion.

===============================================================================
*/


-- Create or modify the Bronze Layer loading stored procedure

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN

    -- Declare variables to capture individual table execution times
    DECLARE @start_time DATETIME, @end_time DATETIME;

    -- Declare variables to capture overall procedure execution times
    DECLARE @total_start_time DATETIME, @total_end_time DATETIME;


    BEGIN TRY

        PRINT '==========================================';
        PRINT '       LOADING BRONZE LAYER';
        PRINT '==========================================';


        -- Capture the overall Bronze Layer loading start time
        SET @total_start_time = GETDATE();

        PRINT 'Bronze Layer Start Time: '
              + CAST(@total_start_time AS NVARCHAR(30));


        -- ============================================================
        -- CRM SOURCE SYSTEM
        -- ============================================================


        --------------------------------------------
        -- 1. CRM: CUSTOMER INFORMATION
        --------------------------------------------

        -- Capture the start time of customer data loading
        SET @start_time = GETDATE();

        -- Remove existing customer records before loading fresh data
        TRUNCATE TABLE bronze.crm_cust_info;

        -- Load customer information from the CRM CSV file
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\prave\OneDrive\Desktop\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,           -- Skip the CSV header row
            FIELDTERMINATOR = ',',  -- Separate columns using commas
            TABLOCK                 -- Apply a table-level lock during bulk loading
        );

        -- Capture the end time and calculate the customer loading duration
        SET @end_time = GETDATE();

        PRINT 'CRM Customer Info Load Duration: '
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
              + ' seconds';


        --------------------------------------------
        -- 2. CRM: PRODUCT INFORMATION
        --------------------------------------------

        -- Capture the start time of product data loading
        SET @start_time = GETDATE();

        -- Remove existing product records before loading fresh data
        TRUNCATE TABLE bronze.crm_prd_info;

        -- Load product information from the CRM CSV file
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\prave\OneDrive\Desktop\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,           -- Skip the CSV header row
            FIELDTERMINATOR = ',',  -- Separate columns using commas
            TABLOCK                 -- Apply a table-level lock during bulk loading
        );

        -- Capture the end time and calculate the product loading duration
        SET @end_time = GETDATE();

        PRINT 'CRM Product Info Load Duration: '
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
              + ' seconds';


        --------------------------------------------
        -- 3. CRM: SALES DETAILS
        --------------------------------------------

        -- Capture the start time of sales data loading
        SET @start_time = GETDATE();

        -- Remove existing sales records before loading fresh data
        TRUNCATE TABLE bronze.crm_sales_details;

        -- Load sales transaction details from the CRM CSV file
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\prave\OneDrive\Desktop\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,           -- Skip the CSV header row
            FIELDTERMINATOR = ',',  -- Separate columns using commas
            TABLOCK                 -- Apply a table-level lock during bulk loading
        );

        -- Capture the end time and calculate the sales loading duration
        SET @end_time = GETDATE();

        PRINT 'CRM Sales Details Load Duration: '
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
              + ' seconds';


        -- ============================================================
        -- ERP SOURCE SYSTEM
        -- ============================================================


        --------------------------------------------
        -- 4. ERP: CUSTOMER INFORMATION
        --------------------------------------------

        -- Capture the start time of ERP customer data loading
        SET @start_time = GETDATE();

        -- Remove existing ERP customer records before loading fresh data
        TRUNCATE TABLE bronze.erp_cust_az12;

        -- Load additional customer information from the ERP CSV file
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\prave\OneDrive\Desktop\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
        WITH (
            FIRSTROW = 2,           -- Skip the CSV header row
            FIELDTERMINATOR = ',',  -- Separate columns using commas
            TABLOCK                 -- Apply a table-level lock during bulk loading
        );

        -- Capture the end time and calculate the ERP customer loading duration
        SET @end_time = GETDATE();

        PRINT 'ERP Customer Info Load Duration: '
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
              + ' seconds';


        --------------------------------------------
        -- 5. ERP: LOCATION INFORMATION
        --------------------------------------------

        -- Capture the start time of location data loading
        SET @start_time = GETDATE();

        -- Remove existing location records before loading fresh data
        TRUNCATE TABLE bronze.erp_loc_a101;

        -- Load customer location information from the ERP CSV file
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\prave\OneDrive\Desktop\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,           -- Skip the CSV header row
            FIELDTERMINATOR = ',',  -- Separate columns using commas
            TABLOCK                 -- Apply a table-level lock during bulk loading
        );

        -- Capture the end time and calculate the location loading duration
        SET @end_time = GETDATE();

        PRINT 'ERP Location Info Load Duration: '
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
              + ' seconds';


        --------------------------------------------
        -- 6. ERP: PRODUCT CATEGORY INFORMATION
        --------------------------------------------

        -- Capture the start time of product category data loading
        SET @start_time = GETDATE();

        -- Remove existing category records before loading fresh data
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        -- Load product category information from the ERP CSV file
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\prave\OneDrive\Desktop\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,           -- Skip the CSV header row
            FIELDTERMINATOR = ',',  -- Separate columns using commas
            TABLOCK                 -- Apply a table-level lock during bulk loading
        );

        -- Capture the end time and calculate the category loading duration
        SET @end_time = GETDATE();

        PRINT 'ERP Product Category Load Duration: '
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
              + ' seconds';


        -- ============================================================
        -- OVERALL BRONZE LAYER EXECUTION SUMMARY
        -- ============================================================

        -- Capture the overall Bronze Layer loading end time
        SET @total_end_time = GETDATE();

        PRINT '==========================================';
        PRINT '       BRONZE LAYER LOAD COMPLETED';
        PRINT '==========================================';

        -- Display the overall procedure start time
        PRINT 'Bronze Layer Start Time: '
              + CAST(@total_start_time AS NVARCHAR(30));

        -- Display the overall procedure end time
        PRINT 'Bronze Layer End Time: '
              + CAST(@total_end_time AS NVARCHAR(30));

        -- Calculate and display the total execution duration in seconds
        PRINT 'Total Execution Duration: '
              + CAST(DATEDIFF(SECOND, @total_start_time, @total_end_time) AS NVARCHAR(20))
              + ' seconds';

        PRINT '==========================================';


    END TRY

    BEGIN CATCH

        -- ============================================================
        -- ERROR HANDLING
        -- ============================================================

        -- Display an error message if any operation fails
        PRINT '==========================================';
        PRINT 'ERROR OCCURRED DURING BRONZE LAYER LOADING';

        -- Display the SQL Server error message
        PRINT 'Error Message: ' + ERROR_MESSAGE();

        -- Display the SQL Server error number
        PRINT 'Error Number: '
              + CAST(ERROR_NUMBER() AS NVARCHAR(20));

        -- Display the SQL Server error state
        PRINT 'Error State: '
              + CAST(ERROR_STATE() AS NVARCHAR(20));

        PRINT '==========================================';

        -- Re-throw the original error to the calling process
        THROW;

    END CATCH

END;
GO


-- Execute the Bronze Layer loading stored procedure
EXEC bronze.load_bronze;
GO
```
