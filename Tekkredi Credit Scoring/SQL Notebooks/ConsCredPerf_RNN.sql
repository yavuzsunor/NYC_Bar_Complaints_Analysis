select CustomerId, ReferenceNo, CreditLimit, CredMon, Occp, Perf1516,
cast(cast(LEN(REPLACE(REPLACE(Perf1516, 'X', ''), 'Z', '')) as float) / NULLIF(cast(LEN(Perf1516) as float), 0) as numeric(18,2)) Occp1516,
LEFT(Perf1516, 1) Jan15, 
RIGHT(LEFT(Perf1516, 2), 1) Feb15,
RIGHT(LEFT(Perf1516, 3), 1) Mar15,
RIGHT(LEFT(Perf1516, 4), 1) Apr15,
RIGHT(LEFT(Perf1516, 5), 1) May15,
RIGHT(LEFT(Perf1516, 6), 1) Jun15,
RIGHT(LEFT(Perf1516, 7), 1) Jul15,
RIGHT(LEFT(Perf1516, 8), 1) Aug15,
RIGHT(LEFT(Perf1516, 9), 1) Sep15,
RIGHT(LEFT(Perf1516, 10), 1) Oct15,
RIGHT(LEFT(Perf1516, 11), 1) Nov15,
RIGHT(LEFT(Perf1516, 12), 1) Dec15,
RIGHT(LEFT(Perf1516, 13), 1) Jan16,
RIGHT(LEFT(Perf1516, 14), 1) Feb16,
RIGHT(LEFT(Perf1516, 15), 1) Mar16,
RIGHT(LEFT(Perf1516, 16), 1) Apr16,
RIGHT(LEFT(Perf1516, 17), 1) May16,
RIGHT(LEFT(Perf1516, 18), 1) Jun16,
RIGHT(LEFT(Perf1516, 19), 1) Jul16,
RIGHT(LEFT(Perf1516, 20), 1) Aug16,
RIGHT(LEFT(Perf1516, 21), 1) Sep16,
RIGHT(LEFT(Perf1516, 22), 1) Oct16,
RIGHT(LEFT(Perf1516, 23), 1) Nov16,
RIGHT(LEFT(Perf1516, 24), 1) Dec16 
from	
	(select t3.*, DATEDIFF(month, StartDate, '2015-01-01')-1 MonCut1, DATEDIFF(month, '2016-12-31', EndDate ) MonCut2,
	LEFT(RIGHT(CredPerf, CredMon - (DATEDIFF(month, StartDate, '2015-01-01')-1)), CredMon - (DATEDIFF(month, StartDate, '2015-01-01')-1) - DATEDIFF(month, '2016-12-31', EndDate )) Perf1516
	from
		(select t2.*,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(CredPerf, 'X', 0), 'Z', 0), 1, 0), 2, 0), 3, 1), 4, 1), 'I', 1), 'K', 1) CredDef,
		cast(cast(LEN(REPLACE(REPLACE(CredPerf, 'X', ''), 'Z', '')) as float) / NULLIF(cast(LEN(CredPerf) as float), 0) as numeric(18,2)) Occp
		from	
			(select t.*, 
			case when EndDate is not NULL then
			LEFT(RIGHT(LEFT(Performance, DATEDIFF(month, '2010-01-01', GETDATE())), 
				case when DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) < 0 then 0
				else DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) end), DATEDIFF(month, StartDate, EndDate))
			else RIGHT(LEFT(Performance, DATEDIFF(month, '2010-01-01', GETDATE())), 
				case when DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) < 0 then 0
				else DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) end) end CredPerf,
			DATEDIFF(month, StartDate, EndDate) CredMon
			from
				(select  
				b.CustomerId, b.ReferenceNo, b.CreditLimit, d.Description, b.StartDate, b.EndDate, 
				Year10 + Year11 + Year12 + Year13 + Year14 + Year15 + Year16 + Year17 + Year18 + Year19 Performance
				from dbo.Type d, dbo.CustomerTransactionSummary b
				where b.CreditTypeId = d.Id
				and d.Description = 'İhtiyaç Kredisi'    
				and b.CustomerId in (select CustomerId from dbo.IncomeTable)  
				and b.FollowUpDate is NULL
				) t ) t2
		where StartDate <= '2015-01-01'
		and EndDate >= '2016-12-01'
		) t3
	) t4


select CustomerId,
max(REPLACE(REPLACE(Jan15, 'Z', '.'), 'X', '.')) Jan15,
max(REPLACE(REPLACE(Feb15, 'Z', '.'), 'X', '.')) Feb15,
max(REPLACE(REPLACE(Mar15, 'Z', '.'), 'X', '.')) Mar15,
max(REPLACE(REPLACE(Apr15, 'Z', '.'), 'X', '.')) Apr15,
max(REPLACE(REPLACE(May15, 'Z', '.'), 'X', '.')) May15,
max(REPLACE(REPLACE(Jun15, 'Z', '.'), 'X', '.')) Jun15,
max(REPLACE(REPLACE(Jul15, 'Z', '.'), 'X', '.')) Jul15,
max(REPLACE(REPLACE(Aug15, 'Z', '.'), 'X', '.')) Aug15,
max(REPLACE(REPLACE(Sep15, 'Z', '.'), 'X', '.')) Sep15,
max(REPLACE(REPLACE(Oct15, 'Z', '.'), 'X', '.')) Oct15,
max(REPLACE(REPLACE(Nov15, 'Z', '.'), 'X', '.')) Nov15,
max(REPLACE(REPLACE(Dec15, 'Z', '.'), 'X', '.')) Dec15,
max(REPLACE(REPLACE(Jan16, 'Z', '.'), 'X', '.')) Jan16,
max(REPLACE(REPLACE(Feb16, 'Z', '.'), 'X', '.')) Feb16,
max(REPLACE(REPLACE(Mar16, 'Z', '.'), 'X', '.')) Mar16,
max(REPLACE(REPLACE(Apr16, 'Z', '.'), 'X', '.')) Apr16,
max(REPLACE(REPLACE(May16, 'Z', '.'), 'X', '.')) May16,
max(REPLACE(REPLACE(Jun16, 'Z', '.'), 'X', '.')) Jun16,
max(REPLACE(REPLACE(Jul16, 'Z', '.'), 'X', '.')) Jul16,
max(REPLACE(REPLACE(Aug16, 'Z', '.'), 'X', '.')) Aug16,
max(REPLACE(REPLACE(Sep16, 'Z', '.'), 'X', '.')) Sep16,
max(REPLACE(REPLACE(Oct16, 'Z', '.'), 'X', '.')) Oct16,
max(REPLACE(REPLACE(Nov16, 'Z', '.'), 'X', '.')) Nov16,
max(REPLACE(REPLACE(Dec16, 'Z', '.'), 'X', '.')) Dec16 
from (select upper query)
where Occp1516 = 1
group by CustomerId


/*Trying a new query to replace upper first query*/
	(select t3.*, 
	case when StartDate <= '2015-01-01' then DATEDIFF(month, StartDate, '2015-01-01')-1 else -DATEDIFF(month, '2015-01-01', StartDate)-1 end MonCut1, 
	case when EndDate >= '2016-12-31' then DATEDIFF(month, '2016-12-31', EndDate) else -DATEDIFF(month, EndDate, '2016-12-31') end MonCut2,
	case when StartDate <= '2015-01-01' and EndDate >= '2016-12-31' then 
	LEFT(RIGHT(CredPerf, CredMon - (DATEDIFF(month, StartDate, '2015-01-01')-1)), CredMon - (DATEDIFF(month, StartDate, '2015-01-01')-1) - DATEDIFF(month, '2016-12-31', EndDate )) 
		 when StartDate <= '2015-01-01' and EndDate < '2016-12-31' then
	RIGHT(CredPerf, CredMon - (DATEDIFF(month, StartDate, '2015-01-01')-1))	 
		 when StartDate > '2015-01-01' and EndDate >= '2016-12-31'
		 
		 else 'Else' end Perf1516
	
	from
		(select t2.*,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(CredPerf, 'X', 0), 'Z', 0), 1, 0), 2, 0), 3, 1), 4, 1), 'I', 1), 'K', 1) CredDef,
		cast(cast(LEN(REPLACE(REPLACE(CredPerf, 'X', ''), 'Z', '')) as float) / NULLIF(cast(LEN(CredPerf) as float), 0) as numeric(18,2)) Occp
		from	
			(select t.*, 
			case when EndDate is not NULL then
			LEFT(RIGHT(LEFT(Performance, DATEDIFF(month, '2010-01-01', GETDATE())), 
				case when DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) < 0 then 0
				else DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) end), DATEDIFF(month, StartDate, EndDate))
			else RIGHT(LEFT(Performance, DATEDIFF(month, '2010-01-01', GETDATE())), 
				case when DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) < 0 then 0
				else DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) end) end CredPerf,
			DATEDIFF(month, StartDate, EndDate) CredMon
			from
				(select  
				b.CustomerId, b.ReferenceNo, b.CreditLimit, d.Description, b.StartDate, b.EndDate, 
				Year10 + Year11 + Year12 + Year13 + Year14 + Year15 + Year16 + Year17 + Year18 + Year19 Performance
				from dbo.Type d, dbo.CustomerTransactionSummary b
				where b.CreditTypeId = d.Id
				and d.Description = 'İhtiyaç Kredisi'    
				and b.CustomerId = 'EE588E0B-9A4A-4D8A-BDA2-00C605E2FF14'  
				and b.FollowUpDate is NULL
				) t ) t2
		) t3
	) t4

in (select CustomerId from dbo.IncomeTable)


/*Creating ConsCred Perf for 2015-2016  - Extract directly from TransactionSummary*/
select CustomerId, ReferenceNo, CreditLimit, StartDate, EndDate, Year15, Year16, 
		LEFT(Year15, 1) Jan15, 
		RIGHT(LEFT(Year15, 2), 1) Feb15,
		RIGHT(LEFT(Year15, 3), 1) Mar15,
		RIGHT(LEFT(Year15, 4), 1) Apr15,
		RIGHT(LEFT(Year15, 5), 1) May15,
		RIGHT(LEFT(Year15, 6), 1) Jun15,
		RIGHT(LEFT(Year15, 7), 1) Jul15,
		RIGHT(LEFT(Year15, 8), 1) Aug15,
		RIGHT(LEFT(Year15, 9), 1) Sep15,
		RIGHT(LEFT(Year15, 10), 1) Oct15,
		RIGHT(LEFT(Year15, 11), 1) Nov15,
		RIGHT(LEFT(Year15, 12), 1) Dec15,
		LEFT(Year16, 1) Jan16,
		RIGHT(LEFT(Year16, 2), 1) Feb16,
		RIGHT(LEFT(Year16, 3), 1) Mar16,
		RIGHT(LEFT(Year16, 4), 1) Apr16,
		RIGHT(LEFT(Year16, 5), 1) May16,
		RIGHT(LEFT(Year16, 6), 1) Jun16,
		RIGHT(LEFT(Year16, 7), 1) Jul16,
		RIGHT(LEFT(Year16, 8), 1) Aug16,
		RIGHT(LEFT(Year16, 9), 1) Sep16,
		RIGHT(LEFT(Year16, 10), 1) Oct16,
		RIGHT(LEFT(Year16, 11), 1) Nov16,
		RIGHT(LEFT(Year16, 12), 1) Dec16
into dbo.ConsPerf1516
from dbo.CustomerTransactionSummary
where CreditTypeId = '3D25E727-C6B9-42CF-86FE-403482393E4D'
		

select t2.*, 
cast(cast(LEN(REPLACE(Jan15+Feb15+Mar15+Apr15+May15+Jun15+Jul15+Aug15+Sep15+Oct15+Nov15+Dec15+Jan16+Feb16+Mar16+Apr16+May16+Jun16+Jul16+Aug16+Sep16+Oct16+Nov16+Dec16, '.', '')) as float) / 
NULLIF(cast(LEN(Jan15+Feb15+Mar15+Apr15+May15+Jun15+Jul15+Aug15+Sep15+Oct15+Nov15+Dec15+Jan16+Feb16+Mar16+Apr16+May16+Jun16+Jul16+Aug16+Sep16+Oct16+Nov16+Dec16) as float), 0) as numeric(18,2)) Occp1516
into dbo.ConsPerf1516_2
from	
	(select CustomerId,
	max(REPLACE(REPLACE(Jan15, 'Z', '.'), 'X', '.')) Jan15,
	max(REPLACE(REPLACE(Feb15, 'Z', '.'), 'X', '.')) Feb15,
	max(REPLACE(REPLACE(Mar15, 'Z', '.'), 'X', '.')) Mar15,
	max(REPLACE(REPLACE(Apr15, 'Z', '.'), 'X', '.')) Apr15,
	max(REPLACE(REPLACE(May15, 'Z', '.'), 'X', '.')) May15,
	max(REPLACE(REPLACE(Jun15, 'Z', '.'), 'X', '.')) Jun15,
	max(REPLACE(REPLACE(Jul15, 'Z', '.'), 'X', '.')) Jul15,
	max(REPLACE(REPLACE(Aug15, 'Z', '.'), 'X', '.')) Aug15,
	max(REPLACE(REPLACE(Sep15, 'Z', '.'), 'X', '.')) Sep15,
	max(REPLACE(REPLACE(Oct15, 'Z', '.'), 'X', '.')) Oct15,
	max(REPLACE(REPLACE(Nov15, 'Z', '.'), 'X', '.')) Nov15,
	max(REPLACE(REPLACE(Dec15, 'Z', '.'), 'X', '.')) Dec15,
	max(REPLACE(REPLACE(Jan16, 'Z', '.'), 'X', '.')) Jan16,
	max(REPLACE(REPLACE(Feb16, 'Z', '.'), 'X', '.')) Feb16,
	max(REPLACE(REPLACE(Mar16, 'Z', '.'), 'X', '.')) Mar16,
	max(REPLACE(REPLACE(Apr16, 'Z', '.'), 'X', '.')) Apr16,
	max(REPLACE(REPLACE(May16, 'Z', '.'), 'X', '.')) May16,
	max(REPLACE(REPLACE(Jun16, 'Z', '.'), 'X', '.')) Jun16,
	max(REPLACE(REPLACE(Jul16, 'Z', '.'), 'X', '.')) Jul16,
	max(REPLACE(REPLACE(Aug16, 'Z', '.'), 'X', '.')) Aug16,
	max(REPLACE(REPLACE(Sep16, 'Z', '.'), 'X', '.')) Sep16,
	max(REPLACE(REPLACE(Oct16, 'Z', '.'), 'X', '.')) Oct16,
	max(REPLACE(REPLACE(Nov16, 'Z', '.'), 'X', '.')) Nov16,
	max(REPLACE(REPLACE(Dec16, 'Z', '.'), 'X', '.')) Dec16 
	from 
	dbo.ConsPerf1516	
	group by CustomerId
	) t2



select *
from dbo.CustomerTransactionSummary
where CustomerId = 'B1113724-8A05-4979-865F-15A9D20F4684A'