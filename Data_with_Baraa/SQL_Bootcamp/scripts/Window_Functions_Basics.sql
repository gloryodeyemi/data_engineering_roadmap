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