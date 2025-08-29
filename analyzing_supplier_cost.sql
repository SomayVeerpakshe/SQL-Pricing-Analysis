with supplier_data(part_id, part_name, category, weight_kg, supplier_id, price_per_unit, date_d, month_d) as (
select mp.part_id, mp.part_name, mp.category, mp.weight_kg, sp.supplier_id, sp.price_per_unit, sp.last_updated as date_d ,
DATENAME(month, sp.last_updated) month_d from pricing_db.dbo.Mechanical_Parts mp
inner join pricing_db.dbo.Supplier_Pricing sp on mp.part_id = sp.part_id 
)
select sd.part_id, sd.part_name,sd.category, MIN(sd.price_per_unit) as lowest_price from supplier_data sd 
group by sd.part_id, sd.part_name, sd.category, sd.price_per_unit
order by  sd.part_name asc , sd.price_per_unit asc