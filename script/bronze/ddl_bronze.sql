/*
===============================================================================
DDL Script: Create Bronze Layer Tables
===============================================================================

Purpose:
    This script creates tables in the Bronze schema of the DataWarehouse.

    The Bronze Layer stores raw data extracted from source CSV files
    without applying any transformations or business logic.

Source Systems:
    1. CRM (Customer Relationship Management)
    2. ERP (Enterprise Resource Planning)

Tables Created:
    CRM Tables:
        - bronze.crm_cust_info
        - bronze.crm_prd_info
        - bronze.crm_sales_details

    ERP Tables:
        - bronze.erp_cust_az12
        - bronze.erp_loc_a101
        - bronze.erp_px_cat_g1v2

Important Notes:
    - Data is stored in its original source format.
    - No data cleaning or transformation is performed here.
    - Data types are defined based on the source data structure.

===============================================================================
*/


-- ============================================================================
-- CRM SOURCE TABLES
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Table: bronze.crm_cust_info
-- Purpose: Stores customer information from the CRM source system.
-- ----------------------------------------------------------------------------

CREATE TABLE bronze.crm_cust_info (
    cst_id              INT,
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_materail_status NVARCHAR(50),
    cst_gndr            NVARCHAR(50),
    cst_create_date     DATE
);
GO


-- ----------------------------------------------------------------------------
-- Table: bronze.crm_prd_info
-- Purpose: Stores product information from the CRM source system.
-- ----------------------------------------------------------------------------

CREATE TABLE bronze.crm_prd_info (
    prd_id          INT,
    prd_key         NVARCHAR(50),
    prd_name        NVARCHAR(50),
    prd_cost        INT,
    prd_line        NVARCHAR(50),
    prd_start_date  DATE,
    prd_end_date    DATE
);
GO


-- ----------------------------------------------------------------------------
-- Table: bronze.crm_sales_details
-- Purpose: Stores sales transaction details from the CRM source system.
-- ----------------------------------------------------------------------------
IF OBJECT_ID('bronze.crm_sales_details','U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num     VARCHAR(50),
    sls_prd_key     VARCHAR(50),
    sls_cust_id     INT,
    sls_order_dt    int,
    sls_ship_dt     int,
    sls_due_dt      INT,
    sls_sales       DECIMAL(18,2),
    sls_quantity    INT,
    sls_price       DECIMAL(18,2)
);
GO


-- ============================================================================
-- ERP SOURCE TABLES
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Table: bronze.erp_cust_az12
-- Purpose: Stores additional customer information from the ERP source system.
-- ----------------------------------------------------------------------------

CREATE TABLE bronze.erp_cust_az12 (
    cid     NVARCHAR(50),
    bdate   DATE,
    gen     NVARCHAR(50)
);
GO


-- ----------------------------------------------------------------------------
-- Table: bronze.erp_loc_a101
-- Purpose: Stores customer location and country information from ERP.
-- ----------------------------------------------------------------------------
IF OBJECT_ID('bronze.erp_loc_a101','U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;

CREATE TABLE bronze.erp_loc_a101 (
    cid     NVARCHAR(50),
    cntry   NVARCHAR(50)
);
GO


-- ----------------------------------------------------------------------------
-- Table: bronze.erp_px_cat_g1v2
-- Purpose: Stores product category and maintenance information from ERP.
-- ----------------------------------------------------------------------------
IF OBJECT_ID('bronze.erp_px_cat_g1v2','U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id          NVARCHAR(50),
    cat         NVARCHAR(50),
    subcat      NVARCHAR(50),
    maintenace  NVARCHAR(50)
);
GO


/*
===============================================================================
END OF SCRIPT
===============================================================================
*/

