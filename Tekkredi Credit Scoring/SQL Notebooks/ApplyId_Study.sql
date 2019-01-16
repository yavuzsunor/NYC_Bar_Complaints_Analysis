/*ApplyId's Consumer Credit 18m Performance with KKB_Part1*/
select t2.*,
case 
when DATEDIFF(month, StartDate, GETDATE()) < 18 and EndDate is NULL
then LEFT(Mon18_After_Credit, DATEDIFF(month, StartDate, GETDATE()))
when DATEDIFF(month, StartDate, EndDate) < 18
then LEFT(Mon18_After_Credit, DATEDIFF(month, StartDate, EndDate))
else Mon18_After_Credit end Mon18_After_Credit_2  
into dbo.ApplyIdStudy
from	
	(select t.*, 
	REPLACE(REPLACE(RIGHT(LEFT(t.Performance, (DATEDIFF(month,'2010-01-01', t.CreatedDateTime)+1)), 3), 'Z', '.'), 'X', '/') Last3,
	REPLACE(REPLACE(LEFT(RIGHT(t.Performance, len(t.Performance)-(DATEDIFF(month,'2010-01-01', t.CreatedDateTime)+1)), 18), 'Z', '.'), 'X', '/') Mon18_After_Apply,
	REPLACE(REPLACE(LEFT(RIGHT(t.Performance, len(t.Performance)-(DATEDIFF(month,'2010-01-01', t.StartDate)+1)), 18), 'Z', '.'), 'X', '/') Mon18_After_Credit
	from
		(select 
		a.Id ApplyId, c.CustomerTransactionId, c.risk_value, a.CustomerId, a.CreatedDateTime, 
		b.ReferenceNo, b.CreditLimit, d.Description, b.StartDate, b.EndDate, 
		Year10 + Year11 + Year12 + Year13 + Year14 + Year15 + Year16 + Year17 + Year18 + Year19 Performance
		from dbo.Type d, dbo.CustomerTransactionSummary b, dbo.CustomerApply a
		left join dbo.x_indus_badr_final c
		on a.Id = c.CustomerApplyId
		where a.CustomerId = b.CustomerId
		and b.CreditTypeId = d.Id
		and d.Description = 'İhtiyaç Kredisi'
		and a.CustomerId in (select CustomerId from dbo.KKB_15K_Part1)    
		) t ) t2
where EndDate >= StartDate or EndDate is NULL


/*18m Performance after ApplyTime*/
select t2.*, 
cast(cast(LEN(REPLACE(REPLACE(Performance, '/', ''), '.', '')) as float) / cast(LEN(Performance) as float) as numeric(18,2)) Occp
into dbo.ApplyId_KKB_Part1
from
	(select ApplyId, CustomerId, CreatedDateTime, max(DefLast3) DefLast3,
	max(Mon1)+max(Mon2)+max(Mon3)+max(Mon4)+max(Mon5)+max(Mon6)+max(Mon7)+max(Mon8)+max(Mon9)+   
	max(Mon10)+max(Mon11)+max(Mon12)+max(Mon13)+max(Mon14)+max(Mon15)+max(Mon16)+max(Mon17)+max(Mon18) Performance
	from
		(select ApplyId, CustomerId, CreatedDateTime, ReferenceNo, 
		Last3,
		case when
		Last3 like '%K%' 
		or Last3 like '%I%' 
		or Last3 like '%3%' 
		or Last3 like '%4%' then 1 else 0 end DefLast3, 
		Mon18_After_Apply, 
		LEFT(Mon18_After_Apply, 1) Mon1, RIGHT(LEFT(Mon18_After_Apply, 2), 1) Mon2, RIGHT(LEFT(Mon18_After_Apply, 3), 1) Mon3, RIGHT(LEFT(Mon18_After_Apply, 4), 1) Mon4, 
		RIGHT(LEFT(Mon18_After_Apply, 5), 1) Mon5, RIGHT(LEFT(Mon18_After_Apply, 6), 1) Mon6, RIGHT(LEFT(Mon18_After_Apply, 7), 1) Mon7, 
		RIGHT(LEFT(Mon18_After_Apply, 8), 1) Mon8, RIGHT(LEFT(Mon18_After_Apply, 9), 1) Mon9, RIGHT(LEFT(Mon18_After_Apply, 10), 1) Mon10, 
		RIGHT(LEFT(Mon18_After_Apply, 11), 1) Mon11, RIGHT(LEFT(Mon18_After_Apply, 12), 1) Mon12, RIGHT(LEFT(Mon18_After_Apply, 13), 1) Mon13, 
		RIGHT(LEFT(Mon18_After_Apply, 14), 1) Mon14, RIGHT(LEFT(Mon18_After_Apply, 15), 1) Mon15, RIGHT(LEFT(Mon18_After_Apply, 16), 1) Mon16,
		RIGHT(LEFT(Mon18_After_Apply, 17), 1) Mon17, RIGHT(LEFT(Mon18_After_Apply, 18), 1) Mon18
		from dbo.ApplyIdStudy 
		) t
	group by ApplyId, CustomerId, CreatedDateTime
	) t2
order by CustomerId, CreatedDateTime

/*Use for Data Exploratory*/
select *
from dbo.ApplyId_KKB_Part1
where DefLast3 = 0
and (Performance like '%K%' or Performance like '%I%')

/*Default Analysis*/
select t2.*, 
case when Def3=1 then '1_Def3'
when Def3=0 and Def3_6=1 then '2_Def3_6'
when Def3=0 and Def3_6=0 and Def6_9=1 then '3_Def6_9'
when Def3=0 and Def3_6=0 and Def6_9=0 and Def9_12=1 then '4_Def9_12'
when Def3=0 and Def3_6=0 and Def6_9=0 and Def9_12=0 and Def12_15=1 then '5_Def12_15'
when Def3=0 and Def3_6=0 and Def6_9=0 and Def9_12=0 and Def12_15=0 and Def15_18=1 then '6_Def15_18'
when Def3=0 and Def3_6=0 and Def6_9=0 and Def9_12=0 and Def12_15=0 and Def15_18=0 then '7_NonDefault'
else '8_OutofScope' end DefFlag 
from
	(select t.*, 
	case when 
	LEFT(Performance, 3) like '%K%' or
	LEFT(Performance, 3) like '%I%' or
	LEFT(Performance, 3) like '%3%' or
	LEFT(Performance, 3) like '%4%' then 1 else 0 end Def3,
	case when 
	RIGHT(LEFT(Performance, 6), 3) like '%K%' or
	RIGHT(LEFT(Performance, 6), 3) like '%I%' or
	RIGHT(LEFT(Performance, 6), 3) like '%3%' or
	RIGHT(LEFT(Performance, 6), 3) like '%4%' then 1 else 0 end Def3_6,
	case when 
	RIGHT(LEFT(Performance, 9), 3) like '%K%' or
	RIGHT(LEFT(Performance, 9), 3) like '%I%' or
	RIGHT(LEFT(Performance, 9), 3) like '%3%' or
	RIGHT(LEFT(Performance, 9), 3) like '%4%' then 1 else 0 end Def6_9,
	case when 
	RIGHT(LEFT(Performance, 12), 3) like '%K%' or
	RIGHT(LEFT(Performance, 12), 3) like '%I%' or
	RIGHT(LEFT(Performance, 12), 3) like '%3%' or
	RIGHT(LEFT(Performance, 12), 3) like '%4%' then 1 else 0 end Def9_12,
	case when 
	RIGHT(LEFT(Performance, 15), 3) like '%K%' or
	RIGHT(LEFT(Performance, 15), 3) like '%I%' or
	RIGHT(LEFT(Performance, 15), 3) like '%3%' or
	RIGHT(LEFT(Performance, 15), 3) like '%4%' then 1 else 0 end Def12_15,
	case when 
	RIGHT(LEFT(Performance, 18), 3) like '%K%' or
	RIGHT(LEFT(Performance, 18), 3) like '%I%' or
	RIGHT(LEFT(Performance, 18), 3) like '%3%' or
	RIGHT(LEFT(Performance, 18), 3) like '%4%' then 1 else 0 end Def15_18
	from dbo.ApplyId_KKB_Part1 t
	) t2
where DefLast3 = 0
and Occp >= 0.8



