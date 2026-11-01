
/*
===============================================================================
Bronze Layer: Data Loading Script
===============================================================================

Purpose:
    This script loads raw data from CRM and ERP CSV files into the
    corresponding Bronze Layer tables in the DataWarehouse database.

Operations:
    1. Truncate existing records from Bronze tables.
    2. Load raw data from source CSV files using BULK INSERT.
    3. Skip the header row in each CSV file.
    4. Use comma (,) as the field delimiter.
    5. Validate the loaded data using record counts.

Source Systems:
    CRM (Customer Relationship Management)
        - cust_info.csv
        - prd_info.csv
        - sales_details.csv

    ERP (Enterprise Resource Planning)
        - cust_az12.csv
        - LOC_A101.csv
        - PX_CAT_G1V2.csv

Important Notes:
    - Bronze Layer stores raw source data.
    - No data cleaning or transformations are performed.
    - Existing records are deleted before loading new data.
    - BULK INSERT is used for efficient data loading.

===============================================================================
*/


-- ============================================================================
-- CRM SOURCE DATA
-- ============================================================================


-- ----------------------------------------------------------------------------
-- Load CRM Customer Information
-- Source: cust_info.csv
-- Target: bronze.crm_cust_info
-- ----------------------------------------------------------------------------

-- Remove existing records before loading fresh data
TRUNCATE TABLE bronze.crm_cust_info;

-- Import customer information from the CRM source file
BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\prave\OneDrive\Desktop\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
    FIRSTROW = 2,           -- Skip the header row
    FIELDTERMINATOR = ',',  -- Separate columns using commas
    TABLOCK                 -- Apply table-level bulk import lock
);

-- Validate the number of records loaded
SELECT COUNT(*) AS total_customer_records
FROM bronze.crm_cust_info;
GO


-- ----------------------------------------------------------------------------
-- Load CRM Product Information
-- Source: prd_info.csv
-- Target: bronze.crm_prd_info
-- ----------------------------------------------------------------------------

-- Remove existing records before loading fresh data
TRUNCATE TABLE bronze.crm_prd_info;

-- Import product information from the CRM source file
BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\prave\OneDrive\Desktop\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH (
    FIRSTROW = 2,           -- Skip the header row
    FIELDTERMINATOR = ',',  -- Separate columns using commas
    TABLOCK                 -- Apply table-level bulk import lock
);

-- Validate the number of records loaded
SELECT COUNT(*) AS total_product_records
FROM bronze.crm_prd_info;
GO


-- ----------------------------------------------------------------------------
-- Load CRM Sales Details
-- Source: sales_details.csv
-- Target: bronze.crm_sales_details
-- ----------------------------------------------------------------------------

-- Remove existing records before loading fresh data
TRUNCATE TABLE bronze.crm_sales_details;

-- Import sales transaction details from the CRM source file
BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\prave\OneDrive\Desktop\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH (
    FIRSTROW = 2,           -- Skip the header row
    FIELDTERMINATOR = ',',  -- Separate columns using commas
    TABLOCK                 -- Apply table-level bulk import lock
);

-- Validate the number of records loaded
SELECT COUNT(*) AS total_sales_records
FROM bronze.crm_sales_details;
GO


-- ============================================================================
-- ERP SOURCE DATA
-- ============================================================================


-- ----------------------------------------------------------------------------
-- Load ERP Customer Information
-- Source: cust_az12.csv
-- Target: bronze.erp_cust_az12
-- ----------------------------------------------------------------------------

-- Remove existing records before loading fresh data
TRUNCATE TABLE bronze.erp_cust_az12;

-- Import additional customer information from the ERP source file
BULK INSERT bronze.erp_cust_az12
FROM 'C:\Users\prave\OneDrive\Desktop\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
WITH (
    FIRSTROW = 2,           -- Skip the header row
    FIELDTERMINATOR = ',',  -- Separate columns using commas
    TABLOCK                 -- Apply table-level bulk import lock
);

-- Validate the number of records loaded
SELECT COUNT(*) AS total_erp_customer_records
FROM bronze.erp_cust_az12;
GO


-- ----------------------------------------------------------------------------
-- Load ERP Customer Location Information
-- Source: LOC_A101.csv
-- Target: bronze.erp_loc_a101
-- ----------------------------------------------------------------------------

-- Remove existing records before loading fresh data
TRUNCATE TABLE bronze.erp_loc_a101;

-- Import customer location information from the ERP source file
BULK INSERT bronze.erp_loc_a101
FROM 'C:\Users\prave\OneDrive\Desktop\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
WITH (
    FIRSTROW = 2,           -- Skip the header row
    FIELDTERMINATOR = ',',  -- Separate columns using commas
    TABLOCK                 -- Apply table-level bulk import lock
);

-- Validate the number of records loaded
SELECT COUNT(*) AS total_erp_location_records
FROM bronze.erp_loc_a101;
GO


-- ----------------------------------------------------------------------------
-- Load ERP Product Category Information
-- Source: PX_CAT_G1V2.csv
-- Target: bronze.erp_px_cat_g1v2
-- ----------------------------------------------------------------------------

-- Remove existing records before loading fresh data
TRUNCATE TABLE bronze.erp_px_cat_g1v2;

-- Import product category information from the ERP source file
BULK INSERT bronze.erp_px_cat_g1v2
FROM 'C:\Users\prave\OneDrive\Desktop\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH (
    FIRSTROW = 2,           -- Skip the header row
    FIELDTERMINATOR = ',',  -- Separate columns using commas
    TABLOCK                 -- Apply table-level bulk import lock
);

-- Validate the number of records loaded
SELECT COUNT(*) AS total_erp_category_records
FROM bronze.erp_px_cat_g1v2;
GO


/*
===============================================================================
END OF BRONZE LAYER DATA LOADING SCRIPT
===============================================================================
*/

