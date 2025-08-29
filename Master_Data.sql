with order_data(part_id, part_name, category, material, order_id,quantity, unit_price, total_cost, date_d, month_d,year_d, supplier_name, supplier_id, 
price_per_unit,sp_date, sp_month, sp_year) as (
select mp.part_id, mp.part_name, mp.category, mp.material, oh.order_id, oh.quantity, oh.unit_price, oh.total_cost, oh.order_date as date_d,
datename(month, oh.order_date) as month_d , DATENAME(year, oh.order_date) as year_d, sp.supplier_name, sp.supplier_id, sp.price_per_unit,
sp.last_updated as sp_date, DATENAME(month, sp.last_updated) sp_month, datename(year, sp.last_updated) sp_year from pricing_db.dbo.Mechanical_Parts mp 
inner join pricing_db.dbo.OrderHistory_Updated oh on mp.part_id = oh.part_id
inner join pricing_db.dbo.Supplier_Pricing sp on oh.part_id = sp.part_id 
)
select od.part_id, od.part_name, od.category, od.order_id, od.quantity, od.unit_price as unit_order_price, od.total_cost as total_order_price, 
od.supplier_id, od.supplier_name, od.price_per_unit, max(od.unit_price - od.price_per_unit) as profit, od.date_d as Order_Date, od.month_d as Order_month, 
od.year_d as Order_year , od.sp_date as Supply_Date, od.sp_month as Supply_month, od.sp_year as Supply_year
from order_data od
group by od.part_id, od.part_name, od.category, od.order_id, od.quantity, od.unit_price , od.total_cost , 
od.supplier_id, od.supplier_name, od.price_per_unit, od.date_d , od.month_d , 
od.year_d  , od.sp_date , od.sp_month , od.sp_year 
