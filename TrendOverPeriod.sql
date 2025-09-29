CREATE ALGORITHM=UNDEFINED DEFINER=`GFGDA3`@`%` SQL SECURITY DEFINER VIEW `northwind`.`monthly_growth` AS with `monthlys` as (
select month(`s`.`orderDate`) AS `months`,sum((`o`.`quantity` * `o`.`unitPrice`)) AS `total`
from (`northwind`.`salesorder` `s` join `northwind`.`orderdetail` `o` on((`s`.`orderId` = `o`.`orderId`))) group by `months`)
select `monthlys`.`months` AS `months`,`monthlys`.`total` AS `total`,
lag(`monthlys`.`total`,1) OVER (ORDER BY `monthlys`.`months` )  AS `previous_months`,round((((`monthlys`.`total` - lag(`monthlys`.`total`,1)
OVER (ORDER BY `monthlys`.`months` ) ) / nullif(lag(`monthlys`.`total`,1) OVER (ORDER BY `monthlys`.`months` ) ,0)) * 100),2) AS `growth` 
from `monthlys` order by `monthlys`.`months`