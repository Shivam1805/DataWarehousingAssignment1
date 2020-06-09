select AreaName from (
SELECT  AreaName, count(*) numberschool FROM mydb.school, mydb.area where area.idArea=school.Area_idArea and 
AreaName in ('Halifax NS','Dartmouth NS','Bedford NS', 'barrington NS') group by AreaName) as table1 
where numberschool = (select max(numberschool) 
from (SELECT  AreaName, count(*) numberschool FROM mydb.school, mydb.area where area.idArea=school.Area_idArea and 
AreaName in ('Halifax NS','Dartmouth NS','Bedford NS', 'barrington NS') group by AreaName) as table2) ;	