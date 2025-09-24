-- Find the total sales across all orders
SELECT 
    SUM(Sales) TotalSales
FROM Sales.Orders;

-- Find the total sales for each product
SELECT 
    ProductID,
    SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY ProductID;

/* Find the total sales for each product. 
Additionally provide details such as order id and order date */
SELECT 
    OrderID,
    OrderDate,
    ProductID,
    SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProducts
FROM Sales.Orders;

/* Find the total sales for all orders. 
Additionally provide details such as order id and order date */
SELECT 
    OrderID,
    OrderDate,
    SUM(Sales) OVER() TotalSales
FROM Sales.Orders;

/* Find the total sales for each product and across all orders
Additionally provide details such as order id and order date */
SELECT 
    OrderID,
    OrderDate,
    ProductID,
    Sales,
    SUM(Sales) OVER() TotalSales,
    SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProducts
FROM Sales.Orders;

/* 
Find the total sales for each product and across all orders
Find the total sales for each combination of product and order status
Additionally provide details such as order id and order date 
*/
SELECT 
    OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER () TotalSales,
    SUM(Sales) OVER (PARTITION BY ProductID) TotalSalesByProducts,
    SUM(Sales) OVER (PARTITION BY ProductID, OrderStatus) SalesByProductsAndStatus
FROM Sales.Orders;

/* 
Rank each order based on their sales from the highest to the lowest
Additionally provide details such as order id and order date 
*/
SELECT 
    OrderID,
    OrderDate,
    ProductID,
    Sales,
    RANK() OVER(ORDER BY Sales DESC) RankedSales
FROM Sales.Orders;

/* 
Rank each order based on their sales from the lowest to the highest
Additionally provide details such as order id and order date 
*/
SELECT 
    OrderID,
    OrderDate,
    ProductID,
    Sales,
    RANK() OVER(ORDER BY Sales) RankedSales
FROM Sales.Orders;  

-- Frame clause
SELECT 
    OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER (
        PARTITION BY OrderStatus 
        ORDER BY OrderDate
        ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
        ) TotalSales
FROM Sales.Orders;

SELECT 
    OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER (
        PARTITION BY OrderStatus 
        ORDER BY OrderDate
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW -- same as ROWS 2 PRECEEDING
        ) TotalSales
FROM Sales.Orders;

-- Find the total sales for each order status, only for two products 101 and 102.
SELECT 
    OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER (PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders
WHERE ProductID IN (101, 102);

-- Rank customers based on their total sales
SELECT 
    CustomerID,
    SUM(Sales) TotalSales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) RankedCustomers
FROM Sales.Orders
GROUP BY CustomerID;