/*Customer's Consumer Credit Performance */
select distinct CustomerId, ReferenceNo, CreditLimit, StartDate, EndDate, Occp, 
LEN(LEFT(CredDef, CHARINDEX('1',CredDef))) DefMon,
LEN(CredPerf) CredTime, Installment, MonthlyPayment,
case when CredMon is NULL then 'Open' else 'Closed' end CredStat
into dbo.ConsCredPerf_2

select distinct t3.*
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
			Year10 + Year11 + Year12 + Year13 + Year14 + Year15 + Year16 + Year17 + Year18 + Year19 Performance, c.Installment, c.MonthlyPayment
			from dbo.Type d, dbo.CustomerTransactionSummary b, dbo.CustomerTransactionBank c
			where b.CreditTypeId = d.Id
			and d.Description = 'İhtiyaç Kredisi'
			and b.ReferenceNo = c.RegisterReferenceNo    
			and b.CustomerId = 'A5D2362D-E182-4499-B894-646A6A85E693'
			and b.FollowUpDate is NULL
			) t ) t2
	where EndDate >= StartDate or EndDate is NULL
	) t3


select top 10 *
from dbo.ConsCredPerf_2

select top 10 *
from dbo.CustomerTransactionBank



select Term, DefMon, CredLong, count(ReferenceNo) #ofCredit
from
	(select distinct ReferenceNo, CreditLimit, concat(DATEPART(YYYY, StartDate), RIGHT('0'+CAST(MONTH(StartDate) AS varchar(2)),2)) Term, DefMon, CredTime,
	case when CredTime <= 6 then 'Mon6'
	when CredTime <= 12 then 'Mon12'
	when CredTime <= 18 then 'Mon18'
	when CredTime <= 24 then 'Mon24'
	when CredTime <= 30 then 'Mon30'
	when CredTime <= 36 then 'Mon36'
	when CredTime <= 42 then 'Mon42'
	when CredTime <= 48 then 'Mon48'
	when CredTime <= 54 then 'Mon54'
	when CredTime <= 60 then 'Mon60'
	else '>Mon60' end CredLong	
	from dbo.ConsCredPerf 
	where Occp >= 0.5
	) t
group by Term, DefMon, CredLong


select *
from dbo.ConsCredPerf
where DATEPART(year, StartDate) = 2013
and CredTime between 36 and 48
and DefMon > 0
	

where CustomerId = '0A0A33F6-7828-4AD5-BA82-05EA0A02EB39'

select top 10 *
from dbo.CustomerTransactionSummary
where CustomerId = '0A0A33F6-7828-4AD5-BA82-05EA0A02EB39'
and ReferenceNo = '2159948115182I'

select *
from dbo.CustomerTransactionBank
where RegisterReferenceNo = '2159948115182I'

select top 10 *
from dbo.CustomerTransaction