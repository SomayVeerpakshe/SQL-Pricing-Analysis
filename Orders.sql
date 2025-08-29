with order_data(part_id, part_name, category, material, order_id,quantity, unit_price, total_cost, date_d, month_d,year_d) as (
select mp.part_id, mp.part_name, mp.category, mp.material, oh.order_id, oh.quantity, oh.unit_price, oh.total_cost, oh.order_date as date_d,
datename(month, oh.order_date) as month_d , DATENAME(year, oh.order_date) as year_d  from pricing_db.dbo.Mechanical_Parts mp 
inner join pricing_db.dbo.OrderHistory_Updated oh on mp.part_id = oh.part_id
inner join pricing_db.dbo.Supplier_Pricing sp on oh.part_id = sp.part_id 
)
select * from order_data od