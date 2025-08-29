with order_data(part_id, part_name, category, material, order_id,quantity, unit_price, total_cost, date_d, month_d,year_d, supplier_name, supplier_id, 
price_per_unit,sp_date, sp_month, sp_year) as (
select mp.part_id, mp.part_name, mp.category, mp.material, oh.order_id, oh.quantity, oh.unit_price, oh.total_cost, oh.order_date as date_d,
datename(month, oh.order_date) as month_d , DATENAME(year, oh.order_date) as year_d, sp.supplier_name, sp.supplier_id, sp.price_per_unit,
sp.last_updated as sp_date, DATENAME(month, sp.last_updated) sp_month, datename(year, sp.last_updated) sp_year from pricing_db.dbo.Mechanical_Parts mp 
inner join pricing_db.dbo.OrderHistory_Updated oh on mp.part_id = oh.part_id
inner join pricing_db.dbo.Supplier_Pricing sp on oh.part_id = sp.part_id 
)
select  od.part_id, od.part_name, od.category, od.order_id, od.quantity, floor(od.unit_price) as unit_order_price, floor(od.total_cost) as total_order_price, 
od.supplier_id, od.supplier_name, floor(od.price_per_unit) as supplier_unit_price,floor((od.price_per_unit)*od.quantity) as supplier_total_price, 
floor(max(od.unit_price - od.price_per_unit)) as unit_profit, 
floor(max((od.unit_price - od.price_per_unit)*od.quantity)) as total_profit ,
floor(max(((od.unit_price - od.price_per_unit)/od.unit_price)*100))  as profit_margin,
od.date_d as Order_Date , od.sp_date as Supply_Date
from order_data od
group by od.part_id, od.part_name, od.category, od.order_id, od.quantity, od.unit_price , od.total_cost , 
od.supplier_id, od.supplier_name, od.price_per_unit, od.date_d , od.sp_date  
order by unit_profit desc