CREATE TABLE OnlineRetail (
    InvoiceNo NVARCHAR(20),
    StockCode NVARCHAR(20),
    Description NVARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice FLOAT,
    CustomerID INT,
    Country NVARCHAR(50)
);

SELECT 
    FORMAT(InvoiceDate, 'yyyy-MM-dd HH:00') AS InvoiceHour,
    SUM(Quantity * UnitPrice) AS TotalSalesAmount
FROM 
    OnlineRetail
WHERE 
    InvoiceDate >= '2009-12-01' 
    AND InvoiceDate < '2010-01-01'
GROUP BY 
    FORMAT(InvoiceDate, 'yyyy-MM-dd HH:00')
ORDER BY 
    InvoiceHour;


CREATE PROCEDURE GetTopProductsByCustomer
    @CustomerID INT
AS
BEGIN
    SELECT TOP 3
        StockCode AS Stock_Code,
        Description,
        SUM(Quantity) AS TotalQuantity
    FROM 
        OnlineRetail
    WHERE 
        CustomerID = @CustomerID
    GROUP BY 
        StockCode, Description
    ORDER BY 
        SUM(Quantity) DESC;
END

EXEC GetTopProductsByCustomer @CustomerID = 12345;


CREATE VIEW HighValueUKPurchases AS
SELECT 
    CustomerID,
    StockCode,
    SUM(Quantity) AS TotalQty,
    SUM(Quantity * UnitPrice) AS TotalSpent
FROM 
    OnlineRetail
WHERE 
    Country = 'United Kingdom'
GROUP BY 
    CustomerID, StockCode
HAVING 
    SUM(Quantity * UnitPrice) > 100;

