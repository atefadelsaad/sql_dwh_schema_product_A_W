
CREATE TABLE gold.fac_Rv_Cust_product(
	id_Rv int PRIMARY KEY  NOT NULL,
	NAME NVARCHAR (50) NOT NULL,
	Standard_Cost decimal (18, 0) NOT NULL,
	productphotoid int NOT NULL,
	Subcategory_Name NVARCHAR(20) NOT NULL,
	Category_Name NVARCHAR(20) NOT NULL,
	ListPrice decimal(18, 0) NOT NULL,
	ReviewerName_RV nvarchar(20) NOT NULL,
	Rating_RV int NOT NULL,
	Comments_RV nvarchar (max) NOT NULL,
	Last_Update DATETIME NOT NULL
)
	