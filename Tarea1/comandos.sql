create  table mexico_ts as select SQLDATE ,  count(*) as count,  avg(GoldsteinScale) as promedio 
from temporal
group by SQLDATE;
drop table temporal;