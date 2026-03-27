CREATE OR ALTER PROCEDURE silver.load_Rv_Cust_product
AS
BEGIN
    SET NOCOUNT ON;

    WITH Product_1 AS (
        SELECT 
            TRIM(pp.Name) AS NAME,
            pch.standardcost AS Standard_Cost,
            ppp.productphotoid,
            pp.ProductSubcategoryID,
            pp.productid
        FROM bronze.Product pp  
        INNER JOIN bronze.ProductCostHistory pch 
            ON pp.productid = pch.productid
        INNER JOIN bronze.ProductProductPhoto ppp
            ON ppp.productid = pp.productid
    ),

    Product_2 AS (
        SELECT 
            P.productid,
            P.NAME,
            P.Standard_Cost,
            P.productphotoid,
            ps.Name AS Subcategory_Name,
            pc.name AS Category_Name,
            plp.listprice
        FROM Product_1 P 
        INNER JOIN bronze.ProductSubcategory ps
            ON ps.ProductSubcategoryID = P.ProductSubcategoryID
        INNER JOIN bronze.ProductCategory pc
            ON pc.productcategoryid = ps.productcategoryid 
        INNER JOIN bronze.ProductListPriceHistory plp
            ON plp.productid = P.productid
    ),

    Product_3 AS (
        SELECT 
            P.NAME,
            P.Standard_Cost,
            P.productphotoid,
            P.Subcategory_Name,
            P.Category_Name,
            P.listprice AS ListPrice,
            pd.reviewername AS ReviewerName_RV,
            pd.rating AS Rating_RV,
            pd.comments AS Comments_RV
        FROM Product_2 P
        INNER JOIN bronze.ProductReview pd
            ON P.productid = pd.productid
    )

    INSERT INTO silver.dim_Rv__Cust_product
    (
        NAME,
        Standard_Cost,
        productphotoid,
        Subcategory_Name,
        Category_Name,
        ListPrice,
        ReviewerName_RV,
        Rating_RV,
        Comments_RV
    )
    SELECT 
        NAME,
        Standard_Cost,
        productphotoid,
        Subcategory_Name,
        Category_Name,
        ListPrice,
        ReviewerName_RV,
        Rating_RV,
        Comments_RV
    FROM Product_3;
END
GO


EXEC silver.load_Rv_Cust_product;




