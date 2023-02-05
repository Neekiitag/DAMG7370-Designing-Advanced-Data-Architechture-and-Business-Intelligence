/*Total Sales using SalesOrderHeader*/
select sum(SalesOH.SubTotal) Total_Sales 
from SalesLT.SalesOrderHeader SalesOH

/*Total Sales using SalesOrderDetail*/
select sum(SalesOD.LineTotal) Total_Sales 
from SalesLT.SalesOrderDetail SalesOD;

/*Total Sales Comparison querying with SalesOrderHeader vs SalesOrderDetail*/
Select (Select sum(LineTotal) from SalesLT.SalesOrderDetail) SalesOrderDetail , sum(subtotal) as SalesOrderHeader 
from SalesLT.SalesOrderHeader;


/*Total Sales by Country*/
Select adr.CountryRegion as Country, sum(SalesOH.SubTotal) TotalSalesByCountry
FROM SalesLT.Address adr join SalesLT.CustomerAddress cusadr on adr.AddressID = cusadr.AddressID 
join SalesLT.SalesOrderHeader SalesOH on SalesOH.CustomerID = cusadr.CustomerID
group by adr.CountryRegion 
order by TotalSalesByCountry DESC;


/*Total Sales by Country, State & City*/
Select adr.CountryRegion Country, adr.StateProvince State, adr.City, sum(SalesOH.SubTotal) TotalSales_Country_State_City
FROM SalesLT.Address adr join SalesLT.CustomerAddress cusadr on adr.AddressID = cusadr.AddressID 
join SalesLT.SalesOrderHeader SalesOH on SalesOH.CustomerID = cusadr.CustomerID
group by adr.CountryRegion, adr.StateProvince, adr.City  
order by TotalSales_Country_State_City DESC;


/*Total Sales by Customer*/
Select (cus.LastName + ', ' + cus.FirstName) Customer_Name, SUM(SalesOH.SubTotal) TotalSales_ByCustomer
from SalesLT.Customer cus join SalesLT.SalesOrderHeader SalesOH on cus.CustomerID = SalesOH.CustomerID
group by (cus.LastName + ', ' + cus.FirstName)
order by TotalSales_ByCustomer DESC;


/*Total Sales by Customer(Company)*/
Select cus.CompanyName as Company_Name, SUM(SalesOH.SubTotal) TotalSales_ByCompany 
from SalesLT.Customer cus join SalesLT.SalesOrderHeader SalesOH on cus.CustomerID = SalesOH.CustomerID
group by cus.CompanyName 
order by TotalSales_ByCompany DESC;


/*Sales $ by product category hierarchy – Product & vGetAllCategories*/
Select cat.ParentProductCategoryName, pcat.Name ProductCategory ,p.Name as ProductName,
sum(SalesOD.LineTotal) as TotalSales_ByProductCategory
from SalesLT.SalesOrderDetail SalesOD
join SalesLT.Product p on SalesOD.ProductID =p.ProductID
join SalesLT.ProductCategory pcat on pcat.ProductCategoryID =p.ProductCategoryID
join SalesLT.vGetAllCategories cat on p.ProductCategoryID=cat.ProductCategoryID
group by cat.ParentProductCategoryName, pcat.Name ,p.Name
order by cat.ParentProductCategoryName, pcat.Name ,p.Name;

/*Sales $ by product name – ranked/sorted (highest to lowest)*/
Select pd.Name Product_name, sum(SalesOD.LineTotal) TotalSales_ByProductName
from SalesLT.Product pd join SalesLT.SalesOrderDetail SalesOD on pd.ProductID = SalesOD.ProductID
group by pd.Name 
order by TotalSales_ByProductName DESC;


/*Sales $ by Company (Reseller)*/
Select cus.CompanyName as Company_Name, SUM(SalesOH.SubTotal) TotalSales 
from SalesLT.SalesOrderHeader SalesOH 
join SalesLT.Customer cus on cus.CustomerID = SalesOH.CustomerID 
group by cus.CompanyName 
order by TotalSales DESC;


/*Product Category Sales $ by Company (Reseller)*/
Select procat.Name Product_Category, cus.CompanyName , sum(SalesOD.LineTotal) TotalSales_ByCompany
from SalesLT.ProductCategory procat join SalesLT.Product p on procat.ProductCategoryID = p.ProductCategoryID 
join SalesLT.SalesOrderDetail SalesOD on SalesOD.ProductID = p.ProductID
join SalesLT.SalesOrderHeader SalesOH on SalesOD.SalesOrderID = SalesOH.SalesOrderID 
join SalesLT.Customer cus  on SalesOH.CustomerID = cus.CustomerID 
group by procat.Name , cus.CompanyName
order by TotalSales_ByCompany desc;





