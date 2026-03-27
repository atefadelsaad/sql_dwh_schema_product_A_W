    DROP TABLE IF EXISTS silver.dim_Rv__Cust_product
CREATE TABLE silver.dim_Rv__Cust_product(
    id_Rv int  IDENTITY(1,1) PRIMARY KEY ,
    NAME NVARCHAR(50) NOT NULL,
    Standard_Cost decimal(18, 0) NOT NULL,
    productphotoid INT NOT NULL,
    Subcategory_Name NVARCHAR(20) NOT NULL,
    Category_Name NVARCHAR(20) NOT NULL,
    ListPrice  DECIMAL(18, 0) NOT NULL,
    ReviewerName_RV NVARCHAR(20) NOT NULL,
    Rating_RV INT NOT NULL,
    Comments_RV NVARCHAR(MAX) NOT NULL

)