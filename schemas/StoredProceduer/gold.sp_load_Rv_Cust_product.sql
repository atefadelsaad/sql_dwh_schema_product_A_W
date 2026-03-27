CREATE OR ALTER PROCEDURE gold.load_Rv_Cust_product
AS
BEGIN 
     MERGE gold.fac_Rv_Cust_product AS target
     USING silver.dim_Rv_Cust_product AS source
           ON target.id_Rv = source.id_Rv
    WHEN MATCHED AND (
            target.NAME <> source.NAME
        OR target.Standard_Cost <> source.Standard_Cost
        OR target.productphotoid <> source.productphotoid
        OR target.Subcategory_Name <> source.Subcategory_Name
        OR target.Category_Name <> source.Category_Name
        OR target.ListPrice <> source.ListPrice
        OR target.ReviewerName_RV <> source.ReviewerName_RV
        OR target.Rating_RV <> source.Rating_RV
        OR target.Comments_RV <> source.Comments_RV
    )
    THEN UPDATE SET
            target.NAME = source.NAME,
            target.Standard_Cost = source.Standard_Cost,
            target.productphotoid = source.productphotoid,
            target.Subcategory_Name = source.Subcategory_Name,
            target.Category_Name = source.Category_Name,
            target.ListPrice = source.ListPrice,
            target.ReviewerName_RV = source.ReviewerName_RV,
            target.Rating_RV = source.Rating_RV,
            target.Comments_RV = source.Comments_RV
    WHEN NOT MATCHED BY target
    THEN
         INSERT(id_Rv,NAME,Standard_Cost,productphotoid,Subcategory_Name,Category_Name,ListPrice,ReviewerName_RV,Rating_RV,Comments_RV,Last_Update)
         VALUES(source.id_Rv,source.NAME,source.Standard_Cost,source.productphotoid,source.Subcategory_Name,source.Category_Name,source.ListPrice,source.ReviewerName_RV,source.Rating_RV,source.Comments_RV,GETDATE())
    WHEN NOT MATCHED BY source
    THEN DELETE
    OUTPUT $ACTION,
     inserted.id_Rv AS id_Rv,
     inserted.NAME AS NAME,
     inserted.Standard_Cost AS Standard_Cost,
     inserted.productphotoid AS productphotoid,
     inserted.Subcategory_Name AS Subcategory_Name,
     deleted.id_Rv AS id_Rv,
     deleted.NAME AS D_FullName,
     deleted.Standard_Cost AS Standard_Cost,
     deleted.productphotoid AS productphotoid,
     deleted.Subcategory_Name AS Subcategory_Name;
END
EXEC gold.load_Rv_Cust_product












