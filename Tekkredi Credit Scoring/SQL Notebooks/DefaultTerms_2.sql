	select DefFlag, count(CustomerId) #of
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
		t2.*   
		from (select CustomerId, max(DefLast3) DefLast3, 
			  max(Def3) Def3, avg(AvgOccp3) AvgOccp3,
			  max(Def3_6) Def3_6, avg(AvgOccp3_6) AvgOccp3_6,
			  max(Def6_9) Def6_9, avg(AvgOccp6_9) AvgOccp6_9,
			  max(Def9_12) Def9_12, avg(AvgOccp9_12) AvgOccp9_12,
			  max(Def12_15) Def12_15, avg(AvgOccp12_15) AvgOccp12_15,
			  max(Def15_18) Def15_18, avg(AvgOccp15_18) AvgOccp15_18
			  from 
				  (select b.CreatedDateTime, a.*
				   from dbo.IndusScore_New a, dbo.CustomerApply b
				   where a.CustomerApplyId = b.Id
				   and b.CreatedDateTime > '2016-10-01') t1
			  group by CustomerId) t2
		where DefLast3 = 0
		and AvgOccp3 = 1
		and AvgOccp3_6 = 1
		and AvgOccp6_9 = 1
		and AvgOccp9_12 = 1
		and AvgOccp12_15 = 1
		and AvgOccp15_18 = 1) t3
	group by DefFlag
	order by DefFlag


select CustomerId, max(DefLast3) DefLast3, 
max(Def3) Def3, avg(AvgOccp3) AvgOccp3,
max(Def3_6) Def3_6, avg(AvgOccp3_6) AvgOccp3_6,
max(Def6_9) Def6_9, avg(AvgOccp6_9) AvgOccp6_9,
max(Def9_12) Def9_12, avg(AvgOccp9_12) AvgOccp9_12,
max(Def12_15) Def12_15, avg(AvgOccp12_15) AvgOccp12_15,
max(Def15_18) Def15_18, avg(AvgOccp15_18) AvgOccp15_18
from 
	(select b.CreatedDateTime, a.*
	from dbo.IndusScore_New a, dbo.CustomerApply b
	where a.CustomerApplyId = b.Id
	and b.CreatedDateTime < '2015-03-30') t
group by CustomerId

