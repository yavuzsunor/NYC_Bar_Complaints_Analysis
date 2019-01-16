select DefFlag, count(CustomerTransactionId) #of
from
(select 
case when Def3=1 and Def3_6=0 and Def6_9=0 and Def9_12=0 and Def12_15=0 and Def15_18=0 then '1_Def3'
when Def3=1 and Def3_6=1 and Def6_9=0 and Def9_12=0 and Def12_15=0 and Def15_18=0 then '2_Def3_6'  
when Def3=1 and Def3_6=1 and Def6_9=1 and Def9_12=0 and Def12_15=0 and Def15_18=0 then '3_Def3_9'
when Def3=1 and Def3_6=1 and Def6_9=1 and Def9_12=1 and Def12_15=0 and Def15_18=0 then '4_Def3_12'
when Def3=1 and Def3_6=1 and Def6_9=1 and Def9_12=1 and Def12_15=1 and Def15_18=0 then '5_Def3_15'  
when Def3=1 and Def3_6=1 and Def6_9=1 and Def9_12=1 and Def12_15=1 and Def15_18=1 then '6_Def3_18'
when Def3=0 and Def3_6=1 and Def6_9=0 and Def9_12=0 and Def12_15=0 and Def15_18=0 then '7_Def6'
when Def3=0 and Def3_6=1 and Def6_9=1 and Def9_12=0 and Def12_15=0 and Def15_18=0 then '8_Def6_9'
when Def3=0 and Def3_6=1 and Def6_9=1 and Def9_12=1 and Def12_15=0 and Def15_18=0 then '9_Def6_12'
when Def3=0 and Def3_6=1 and Def6_9=1 and Def9_12=1 and Def12_15=1 and Def15_18=0 then '10_Def6_15'  
when Def3=0 and Def3_6=1 and Def6_9=1 and Def9_12=1 and Def12_15=1 and Def15_18=1 then '11_Def6_18'
when Def3=0 and Def3_6=0 and Def6_9=1 and Def9_12=0 and Def12_15=0 and Def15_18=0 then '12_Def9'
when Def3=0 and Def3_6=0 and Def6_9=1 and Def9_12=1 and Def12_15=0 and Def15_18=0 then '13_Def9_12'
when Def3=0 and Def3_6=0 and Def6_9=1 and Def9_12=1 and Def12_15=1 and Def15_18=0 then '14_Def9_15'  
when Def3=0 and Def3_6=0 and Def6_9=1 and Def9_12=1 and Def12_15=1 and Def15_18=1 then '15_Def9_18'
when Def3=0 and Def3_6=0 and Def6_9=0 and Def9_12=1 and Def12_15=0 and Def15_18=0 then '16_Def12'
when Def3=0 and Def3_6=0 and Def6_9=0 and Def9_12=1 and Def12_15=1 and Def15_18=0 then '17_Def12_15'  
when Def3=0 and Def3_6=0 and Def6_9=0 and Def9_12=1 and Def12_15=1 and Def15_18=1 then '18_Def12_18'
when Def3=0 and Def3_6=0 and Def6_9=0 and Def9_12=0 and Def12_15=1 and Def15_18=0 then '19_Def15'  
when Def3=0 and Def3_6=0 and Def6_9=0 and Def9_12=0 and Def12_15=1 and Def15_18=1 then '20_Def15_18'
when Def3=0 and Def3_6=0 and Def6_9=0 and Def9_12=0 and Def12_15=0 and Def15_18=1 then '21_Def18'
when Def3=0 and Def3_6=0 and Def6_9=0 and Def9_12=0 and Def12_15=0 and Def15_18=0 then '22_NoDefault'
else '23_OutofScope' end DefFlag,
CustomerTransactionId, TransTime, CustomerId, count(CustomerTransactionId) OVER(PARTITION BY CustomerId) CountCust,
DefLast3, Def3, AvgOccp3, Def3_6, AvgOccp3_6, Def6_9, AvgOccp6_9, Def9_12, AvgOccp9_12, Def12_15, AvgOccp12_15, Def15_18, AvgOccp15_18   
from IndusScore_ConsCred 
where DefLast3 = 0
and AvgOccp3 > 0.5
and AvgOccp3_6 > 0.5
and AvgOccp6_9 > 0.5
and AvgOccp9_12 > 0.5
and AvgOccp12_15 >= 0
and AvgOccp15_18 >= 0
and CustomerApplyId is not NULL) t
group by DefFlag
order by DefFlag


select *
from dbo.IndusScore
where DefLast3 = 0
and AvgOccp3 = 1
and AvgOccp3_6 = 1
and AvgOccp6_9 = 1
and AvgOccp9_12 = 1
and AvgOccp12_15 = 1
and AvgOccp15_18 = 1
and Def3 = 0
and Def3_6 = 0
and Def6_9 = 0
and Def9_12 = 0
and Def12_15 = 0
and Def15_18 = 1

