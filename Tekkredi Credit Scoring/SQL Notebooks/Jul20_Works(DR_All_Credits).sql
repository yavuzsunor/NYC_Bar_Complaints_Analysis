select t.*,
		case when EndDate is not NULL then
				LEFT(RIGHT(LEFT(Performance, DATEDIFF(month, '2010-01-01', GETDATE())), 
					case when DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) < 0 then 0
					else DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) end), DATEDIFF(month, StartDate, EndDate))
				else RIGHT(LEFT(Performance, DATEDIFF(month, '2010-01-01', GETDATE())), 
					case when DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) < 0 then 0
					else DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) end) end CredPerf
into dbo.KKBApplyDefault		
		from
			(select ca.Id ApplyId, ca.CustomerTransactionId, ca.CreatedDateTime ApplyTime, ca.CustomerId, 
			cts.ReferenceNo, cts.CreditTypeId, cts.StartDate, cts.EndDate,
			cts.Year10 + cts.Year11 + cts.Year12 + cts.Year13 + cts.Year14 + cts.Year15 + cts.Year16 + cts.Year17 + cts.Year18 + cts.Year19 Performance 
			from dbo.CustomerApply ca, dbo.Customer c, dbo.CustomerTransactionSummary cts,
				(select ca.Id, ca.CustomerId
				from dbo.CustomerApply ca, dbo.CustomerReportQueue crq,
				(select CustomerId CustomerId, min(CreatedDateTime) MinApplyTime from dbo.CustomerApply group by CustomerId) minApply
				where ca.CustomerId = crq.CustomerId
				and ca.CustomerId = minApply.CustomerId 
				and ca.CreatedDateTime = minApply.MinApplyTime
				) KKBsample
			where ca.CustomerId = c.Id
			and c.Id = cts.CustomerId
			and ca.CustomerId = KKBsample.CustomerId
			and ca.Id = KKBsample.Id
			) t 
where EndDate >= StartDate or EndDate is NULL



DECLARE @Constant VARCHAR(120) = 'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ'

select CustomerId, max(Def), max(DefFut) 
from
	(
	DECLARE @Constant VARCHAR(120) = 'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ'
	select t2.*, 
	case when Last3 LIKE '%K%' or Last3 LIKE '%I%' or Last3 LIKE '%3%' then 1 else 0 end Def, 
	cast(cast(LEN(REPLACE(REPLACE(Last3, 'X', ''), 'Z', '')) as float) / NULLIF(cast(LEN(Last3) as float), 0) as numeric(18,2)) Occp,
	case when FutPerf LIKE '%K%' or FutPerf LIKE '%I%' or FutPerf LIKE '%3%' then 1 else 0 end DefFut, 
	cast(cast(LEN(REPLACE(REPLACE(FutPerf, 'X', ''), 'Z', '')) as float) / NULLIF(cast(LEN(FutPerf) as float), 0) as numeric(18,2)) OccpFut

	from
		(
		
		select t.*, case when LEN(CredPerf) >= LEN(HistPerf) then RIGHT(CredPerf, LEN(CredPerf)-LEN(HistPerf)) else 'Z' end FutPerf, 
					   case when MonDif < 3 then LEFT(@Constant, 3-MonDif)+HistPerf else RIGHT(HistPerf, 3) end Last3, 
					   case when MonDif < 6 then LEFT(@Constant, 6-MonDif)+HistPerf else RIGHT(HistPerf, 6) end Last6,
					   case when MonDif < 12 then LEFT(@Constant, 12-MonDif)+HistPerf else RIGHT(HistPerf, 12) end Last12,
					   case when MonDif < 18 then LEFT(@Constant, 18-MonDif)+HistPerf else RIGHT(HistPerf, 18) end Last18
		from
					(
				
					select distinct a.*,
					LEN(CredPerf) CredMon, DATEDIFF(month, StartDate, ApplyTime)-1 MonDif,
						case when LEN(CredPerf) >= DATEDIFF(month, StartDate, ApplyTime)-1 then LEFT(CredPerf, DATEDIFF(month, StartDate, ApplyTime)-1)
						else CredPerf+ LEFT(@Constant, (DATEDIFF(month, StartDate, ApplyTime)-1)-LEN(CredPerf)) end HistPerf  				
					from dbo.KKBApplyDefault a
					where DATEDIFF(month, StartDate, ApplyTime) >=1 
					and ApplyId = '7951138B-9479-42E5-9032-0000DB4B395E'		
					) t
		) t2
	) t3

group by CustomerId 


select count(distinct CustomerId)
from dbo.CustomerReportQueue


select CreditType, 
sum(case when Def = 1 then 1 else 0 end) Def, 
sum(case when Def = 0 then 1 else 0 end) Perf,
sum(case when Occp > 0 then 1 else 0 end) Occp,
sum(case when Occp = 0 then 1 else 0 end) NotOccp
from
	(select t3.*, 
	case when PerfString LIKE '%K%' or PerfString LIKE '%I%' or PerfString LIKE '%3%' then 1 else 0 end Def, 
	cast(cast(LEN(REPLACE(REPLACE(PerfString, 'X', ''), 'Z', '')) as float) / NULLIF(cast(LEN(PerfString) as float), 0) as numeric(18,2)) Occp
	from
		(select t2.CustomerId, t2.ReferenceNo, t2.CreditType, t2.StartDate, t2.EndDate, 
		case when LEN(CredPerf) > 0  then CredPerf else 'Z' end PerfString 
		from
			(select t.*,
					case when EndDate is not NULL then
							LEFT(RIGHT(LEFT(Performance, DATEDIFF(month, '2010-01-01', GETDATE())), 
								case when DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) < 0 then 0
								else DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) end), DATEDIFF(month, StartDate, EndDate))
							else RIGHT(LEFT(Performance, DATEDIFF(month, '2010-01-01', GETDATE())), 
								case when DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) < 0 then 0
								else DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) end) end CredPerf
		
			from
				(select cts.CustomerId,  
				cts.ReferenceNo, CredType.Description CreditType, cts.StartDate, cts.EndDate,
				cts.Year10 + cts.Year11 + cts.Year12 + cts.Year13 + cts.Year14 + cts.Year15 + cts.Year16 + cts.Year17 + cts.Year18 + cts.Year19 Performance 
				from dbo.CustomerTransactionSummary cts, dbo.Type CredType
				where cts.CreditTypeId = CredType.Id) t 
			where EndDate >= StartDate or EndDate is NULL
			) t2
		) t3
	) t4
group by CreditType



select *
from dbo.CustomerApply
where CustomerId in 
('3E70AA52-3309-4AF9-8AB5-69A993921D40',
'06B90C85-CD0D-4C07-8BCB-1A9D8D828E09',
'2325E21C-3031-4758-B6FA-AF52F9844AB1',
'3C02A0F0-E601-4A12-891E-32DC6C63E73C',
'5216EB99-20C4-41C1-9BC4-29E69BB40728',
'857A92FF-0AC5-4464-B29C-DD423371EB19',
'5A29C9FB-213D-4674-9458-D07A31E03B8F',
'81D5FF0A-5A6B-4D30-9AA2-365FC625977D',
'A796D4ED-1722-468B-B60F-6435848267F3',
'BA554E26-3DF3-4FD1-B5E9-AD6F797C14A4'
)