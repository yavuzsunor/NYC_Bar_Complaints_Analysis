select DefFlag, count(CustomerTransactionId) #of
from
(select 
case when Def3=1 and Def6_3=0 and Def12_6=0 and Def18_6=0 then '1_Def3'
when Def3=1 and Def6_3=1 and Def12_6=0 and Def18_6=0 then '2_Def3_6'
when Def3=1 and Def6_3=1 and Def12_6=1 and Def18_6=0 then '3_Def3_12'
when Def3=1 and Def6_3=1 and Def12_6=1 and Def18_6=1 then '4_Def3_18'
when Def3=0 and Def6_3=1 and Def12_6=0 and Def18_6=0 then '5_Def6'
when Def3=0 and Def6_3=1 and Def12_6=1 and Def18_6=0 then '6_Def6_12'
when Def3=0 and Def6_3=1 and Def12_6=1 and Def18_6=1 then '7_Def6_18'
when Def3=0 and Def6_3=0 and Def12_6=1 and Def18_6=0 then '8_Def12'
when Def3=0 and Def6_3=0 and Def12_6=1 and Def18_6=1 then '9_Def12_18'
when Def3=0 and Def6_3=0 and Def12_6=0 and Def18_6=1 then '10_Def18'
when Def3=0 and Def6_3=0 and Def12_6=0 and Def18_6=0 then '12_NoDefault'
else '11_OutofScope' end DefFlag,
CustomerTransactionId, TransTime, CustomerId, count(CustomerTransactionId) OVER(PARTITION BY CustomerId) CountCust,
DefLast3, Def3, AvgOccp3, Def6_3, AvgOccp6_3, Def12_6, AvgOccp12_6, Def18_6, AvgOccp18_6   
from dbo.IndusFull
where DefLast3 = 0
and AvgOccp3 > 0.5
and AvgOccp6_3 > 0.5
and AvgOccp12_6 > 0.5
and AvgOccp18_6 > 0.5) t
group by DefFlag
order by DefFlag


select top 10 *
from dbo.IndusFull