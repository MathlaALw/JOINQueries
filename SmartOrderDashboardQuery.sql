
-- Smart Order Dashboard --

-- Widget 1: Active Orders Summary 
-- Show all active orders (Status = 'Preparing') with customer name, restaurant name, and order date. 

select O.* , C.FullName , R.Name from Customers C
inner join Orders O on C.CustomerID = O.CustomerID
inner join Restaurants R on O.RestaurantID=R.RestaurantID where O.Status= 'Preparing' order by O.OrderDate

-- Widget 2: Restaurant Menu Coverage 
-- List all menu items offered by each restaurant and whether they have ever been ordered. Include items that have never been ordered. 
select * from OrderItems
select * from Menu
select * from Orders
select * from Restaurants
select M.* ,R.Name from Menu M inner join Restaurants R on R.RestaurantID = M.RestaurantID 
Left outer join Orders O on O.RestaurantID = M.RestaurantID



-- Widget 3: Customers Without Orders 
--Display all customers, including those who have never placed any orders. 

select * from Customers C inner join Orders O on O.CustomerID = C.CustomerID where O.OrderID = null ;


-- Widget 4: Full Engagement Report 
-- Display a full list of customer and order combinations, including customers who never ordered and orders that belong to non-existent customers. 

select C.* , O.* from Customers C Left outer join Orders O on O.CustomerID = C.CustomerID 

-- Widget 5: Referral Tree 
-- List each customer along with the full name of the person who referred them, if any. 

select * from Customers

select C.* , N.FullName as 'Refered Name' from Customers C ,Customers N where N.CustomerID = C.ReferralID

-- Widget 6: Menu Performance Tracker 
-- For each restaurant, show item name, number of times it was ordered, and total quantity sold. Include items even if they were never ordered. 

select R.Name from Restaurants R 
select R.Name as Restaurant,M.ItemName,COUNT(oi.OrderItemID) as TimesOrdered,
COALESCE(SUM(OI.Quantity), 0) as TotalQuantitySold
from Menu M
inner join Restaurants R on M.RestaurantID = R.RestaurantID
left join OrderItems OI on M.ItemName = OI.ItemName
and M.RestaurantID in ( select RestaurantID from Orders O where O.OrderID = OI.OrderID) GROUP BY R.Name, M.ItemName;

-- Widget 7: Unused Customers and Items 
-- Display customers who never placed an order and menu items that were never ordered. Return a unified list with a type column ('Unused Customer' or 'Unused Item'). 

select 
    FullName AS Name,
    'Unused Customer' AS Type
from Customers c
left join Orders o on c.CustomerID = o.CustomerID
where o.OrderID IS NULL

UNION

-- Unused Items
select 
    m.ItemName AS Name,
    'Unused Item' AS Type
from Menu m
left join OrderItems oi on m.ItemName = oi.ItemName
    and m.RestaurantID in (
        select RestaurantID from Orders o where o.OrderID = oi.OrderID
    )
where oi.OrderItemID IS NULL;

-- Widget 8: Orders with Missing Menu Price Match 
-- Show all orders where the ordered item does not exist in the current menu of the restaurant. 
select 
    o.OrderID,
    oi.ItemName,
    r.Name AS Restaurant,
    oi.Price
from Orders o
inner join Restaurants r on o.RestaurantID = r.RestaurantID
inner join OrderItems oi on o.OrderID = oi.OrderID
left join Menu m on oi.ItemName = m.ItemName and m.RestaurantID = r.RestaurantID
WHERE m.MenuID IS NULL;

-- Widget 9: Repeat Customers Report 
-- List customers who have placed more than one order, showing customer name, total number of orders, first and last order dates. 
SELECT 
    c.FullName,
    COUNT(o.OrderID) AS TotalOrders,
    MIN(o.OrderDate) AS FirstOrderDate,
    MAX(o.OrderDate) AS LastOrderDate
FROM Customers c
inner join Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FullName
HAVING COUNT(o.OrderID) > 1;

-- Widget 10: Item Referral Revenue 
-- For each referral chain, show the customer, the person who referred them, and the total amount spent by the referred customer. 
 
 SELECT 
    c.FullName AS ReferredCustomer,
    r.FullName AS ReferredBy,
    SUM(oi.Price * oi.Quantity) AS TotalSpent
FROM Customers c
inner join Customers r ON c.ReferralID = r.CustomerID
inner join Orders o ON c.CustomerID = o.CustomerID
inner join OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY c.FullName, r.FullName;

-------------------------------------
--Data Modification Widgets – JOINs for UPDATE, DELETE, and INSERT 
-- Real dashboards don’t just read data — they maintain it. 
-- In real-world platforms like Talabat, backend developers regularly perform operations 
--that adjust prices, clean inactive data, or move old records to archives. These operations 
-- often rely on JOINs to make sure the right records are updated or removed based on conditions from related tables. 
-- In this section, your role shifts from data analyst to data maintainer. Each widget below 
-- represents a realistic task you might encounter as a backend developer or data 
-- engineer. Use JOINs smartly to apply changes across related tables. 


-- Widget 11: Update Prices for Bestsellers 
-- Scenario: 
-- The business team wants to automatically increase prices for high-demand items. 
-- Update the price of any menu item that has been ordered more than 3 times by 10%. 
-- Use UPDATE with a JOIN between Menu and aggregated OrderItems. 

UPDATE m
SET m.Price = ROUND(m.Price * 1.10, 2)
FROM Menu m
JOIN (
    SELECT ItemName
    FROM OrderItems
    GROUP BY ItemName
    HAVING COUNT(*) > 3
) AS oi ON m.ItemName = oi.ItemName;

-- Widget 12: Delete Inactive Customers 
-- Scenario: 
-- To comply with data privacy regulations, the system must remove customers who: 
-- • Have never placed an order, 
-- • And were not referred by another customer. 
-- Use DELETE with a LEFT JOIN to Orders and check ReferralID IS NULL. 

DELETE c
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL
  AND c.ReferralID IS NULL;

-- Widget 13: Adjust Prices for Inactive Restaurants 
-- Scenario: 
-- The pricing team wants to reduce menu prices by 15% for all items belonging to restaurants that never received any orders. 
-- This is a quick way to encourage more orders from underperforming partners. 
-- Your Task: 
-- Update prices in the Menu table using a JOIN with Restaurants and Orders. 
-- Only update menu items for restaurants that do not appear at all in the Orders table.


UPDATE m
SET m.Price = ROUND(m.Price * 0.85, 2)
FROM Menu m
JOIN Restaurants r ON m.RestaurantID = r.RestaurantID
LEFT JOIN Orders o ON r.RestaurantID = o.RestaurantID
WHERE o.OrderID IS NULL;


-----------------------------------
