CREATE SCHEMA Production; GO
CREATE SCHEMA Sales; GO

CREATE TABLE Production.Categories(
	Category_id INT IDENTITY (1,1) PRIMARY KEY,
	Category_name NVARCHAR (300) NOT NULL,
);

CREATE TABLE Production.Brand(
	Brand_id INT IDENTITY (1,1) PRIMARY KEY,
	Brand_name NVARCHAR (300) NOT NULL,
);

CREATE TABLE Production.Products(
	Product_id INT IDENTITY (1,1) PRIMARY KEY,
	Product_name NVARCHAR (255) NOT NULL,
	Brand_id INT NOT NULL,
	Category_id INT NOT NULL,
	model_year SMALLINT NOT NULL,
	list_price DECIMAL (10,2) NOT NULL,
	FOREIGN KEY (Category_id) REFERENCES Production.Categories (Category_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Brand_id) REFERENCES Production.Brand (Brand_id) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE Sales.Customer(
	Customer_id INT IDENTITY (1,1) PRIMARY KEY,
	First_name NVARCHAR (255) NOT NULL,
	Last_name NVARCHAR (255) NOT NULL,
	Phone VARCHAR (25),
	Email VARCHAR (255) NOT NULL,
	Street VARCHAR (255),
	City VARCHAR (50),
	State VARCHAR (25),
	Zip_code VARCHAR (5),
);

CREATE TABLE Sales.Store(
	Store_id INT IDENTITY (1,1) PRIMARY KEY,
	Store_name NVARCHAR (255) NOT NULL,
	Phone VARCHAR (25),
	Email VARCHAR (255) NOT NULL,
	Street VARCHAR (255),
	City VARCHAR (255),
	State VARCHAR (10),
	Zip_code VARCHAR (5),
);

CREATE TABLE Sales.Staffs(
	Staff_id INT IDENTITY (1,1) PRIMARY KEY,
	First_name NVARCHAR (50) NOT NULL,
	Last_name NVARCHAR (50) NOT NULL,
	Email VARCHAR (255) NOT NULL,
	Phone VARCHAR (25),
	Active tinyint NOT NULL,
	Store_id INT NOT NULL,
	Manager_id INT,
	FOREIGN KEY (Store_id) REFERENCES Sales.Store (Store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Manager_id) REFERENCES Sales.Staffs (Staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
);

CREATE TABLE Sales.Orders(
	Order_id INT IDENTITY (1,1) PRIMARY KEY,
	Customer_id INT,
	Order_status tinyint NOT NULL,
	Order_date DATE NOT NULL,
	Required_date DATE NOT NULL,
	Shipped_date DATE,
	Store_id INT NOT NULL,
	Staff_id INT NOT NULL,
	FOREIGN KEY (Customer_id) REFERENCES Sales.Customer (Customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Store_id) REFERENCES Sales.Store (Store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Staff_id) REFERENCES Sales.Staffs (Staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
);

CREATE TABLE Sales.Order_Items(
	Order_id INT,
	Item_id INT,
	Product_id INT NOT NULL,
	Quantity INT NOT NULL,
	list_price DECIMAL (4,2) NOT NULL,
	Discount DECIMAL (4,2) NOT NULL DEFAULT 0,
	PRIMARY KEY (Order_id, Item_id),
	FOREIGN KEY (Order_id) REFERENCES Sales.Orders (Order_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Product_id) REFERENCES Production.Products (Product_id) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE Production.Stocks(
	Store_id INT,
	Product_id INT,
	Quantity INT,
	PRIMARY KEY (Store_id, Product_id),
	FOREIGN KEY (Store_id) REFERENCES Sales.Store (Store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Product_id) REFERENCES Production.Products (Product_id) ON DELETE CASCADE ON UPDATE CASCADE,
);

select * from Production.Brand
select * from Production.Stocks
select * from Production.Categories
select * from Production.Products
select * from Sales.Customer
select * from Sales.Order_Items
select * from Sales.Orders
select * from Sales.Staffs
select * from Sales.Store

insert into production.categories
values (N'ຢາງລົດ')

select Category_id'ລຳດັບ', Category_name'ປະເພດສີນຄ້າ' from Production.Categories
select brand_id'ລຳດັບ',brand_name'ຢີຫໍ່'from production.brand
select product_id'ລະຫັດຜະລິດຕະພັນ',product_name'ຊື່ຜະລິດຕະພັນ'from production.Products
select store_id'ລະຫັດຮ້ານ',product_id'ລະຫັດຜະລິດຕະພັນ',quantity'ປະລິມານ' from production.stocks
select customer_id'ລະຫັດລູກຄ້າ',first_name'ຊື່',last_name'ນາມສະກຸ່ນ',phone'ເບີໂທລະສັບ',email'ອີເມວ',street'ຖະໜົນ',city'ເມືອງ',State'ລັດ',zip_code'ລະຫັດໄປສະນີ' from sales.customer
select order_id'ລະຫັດບີນ',item_id'ລະຫັດລາຍການ',product_id'ລະຫັດຜະລິດຕະພັນ',quantity'ປະລິມາາ',list_price'ລາຄາ',discount'ສ່ວນຫຼຸດ' from sales.Order_Items
select order_id'ລະຫັດບີນ',customer_id'ລະຫັດລູກຄ້າ',order_status'ສະຖານະການສັ່ງ',order_date'ວັນທີ່ສັ່ງ',shipped_date'ວັນທີ່ຈັດສົ່ງ',store_id'ລະຫັດຮ້ານ',staff_id'ລະຫັດພະນັກງານ' from sales.orders
select staff_id'ລະຫັດພະນັກງານ',first_name'ຊື່',last_name'ນາມສະກຸ່ນ',phone'ເບີໂທ',email'ອີເມວ',active'ເຄື່ອນໄຫວ',manager_id'ລະຫັດຜູ້ຈັດການ' from sales.staffs
select store_id'ລະຫັດຮ້ານ',store_name'ຊື່ຮ້ານ',phone'ເບີໂທລະສັບ',email'ອີເມວ' from sales.store