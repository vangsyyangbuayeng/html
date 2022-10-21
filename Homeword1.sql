SELECT * FROM production.products
SELECT * FROM production.stocks
SELECT * FROM sales.customers
SELECT * FROM sales.stores
SELECT * FROM sales.staffs
SELECT * FROM sales.orders
SELECT * FROM sales.order_items

SELECT COUNT(product_id)FROM production.products

-- production.products
SELECT production.products.product_id'ລະຫັດ',production.products.product_name'ຊື່ສິນຄ້າ', 
production.brands.brand_name'ຍີ່ຫໍ',production.categories.category_name'ປະເພດສິນຄ້າ', model_year,list_price FROM production.products,production.brands,
production.categories WHERE production.brands.brand_id = production.products.brand_id AND production.products.category_id=production.categories.category_id

-- production.stocks
SELECT * FROM production.stocks
SELECT store_id,production.products.product_name, quantity FROM production.stocks,production.products WHERE production.products.product_id=production.stocks.product_id

--sales.customers
SELECT customer_id'ລະຫັດລູກຄ້າ',first_name'ຊື່ລູກຄ້າ',last_name'ນາສະກຸມ', phone'ເບີ', email'ເມວ', street'ສະຖົນ',city'ເມືອງ', state'ລັດ',zip_code'ລະຫັດປະເທດ' FROM sales.customers

--sales.stores
SELECT store_id 'ລະຫັດຮ້ານ', store_name 'ຊື່ຮ້ານ', phone 'ເບີໂທ', email 'ເມວ',street 'ສະຖົນ', city 'ເມືອງ', zip_code 'ລະຫັດປະເທດ' FROM sales.stores

--sales.orders
SELECT order_id'ລະຫັດ',sales.customers.first_name'ຊື່ລູກຄ້າ',order_status'ສະຖານະສັ່ງຊື້',order_date'ວັນທີ່ສັ່ງຊື້',required_date'ວັນທີ່ຕ້ອງການ',shipped_date'ວັນທີ່ຈັດສົ່ງ',
sales.stores.store_name'ຊື່ຮ້ານ',sales.staffs.first_name'ຊື່ພະນັກງານ' FROM sales.stores,sales.orders,sales.staffs, sales.customers WHERE 
sales.orders.store_id = sales.stores.store_id AND sales.orders.staff_id = sales.staffs.staff_id AND sales.orders.staff_id = sales.customers.customer_id

-- sales.staffs
SELECT staff_id'ລະຫັດ', first_name'ຊື່',last_name'ນາສະກຸມ',sales.staffs.email'ເມວ',sales.staffs.phone'ເບີ',active'ການເຄື່ອນໄຫວ',
sales.stores.store_name'ຊື່ຮ້ານ', manager_id'ລະຫັດຜູ້ບໍລິຫານ' FROM  sales.staffs, sales.stores WHERE sales.staffs.store_id = sales.stores.store_id

-- sales.order_items
SELECT * FROM sales.order_items SELECT order_id'ລະຫັດ',item_id 'ລາຍການ', production.products.product_name'ຊື່ສິນຄ້າ',sales.order_items.quantity'ຄຸນະພາບ', 
sales.order_items.list_price'ລາຄາ',discount'ສ່ວນຫຼຸດ' FROM sales.order_items,production.products WHERE sales.order_items.product_id=production.products.product_id