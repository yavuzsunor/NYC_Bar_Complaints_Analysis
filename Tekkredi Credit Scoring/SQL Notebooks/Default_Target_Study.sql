select b.CustomerId, a.ca_customertransactionid, c.*
from IndusTrain a, dbo.CustomerTransaction b, dbo.CustomerTransactionSummary c
where right(left(a.ca_customertransactionid, 37), 36) = b.Id
and b.CustomerId = c.CustomerId
and b.CustomerId = '4886342F-011A-441C-B358-00319D7F9E02'

select b.CustomerId, a.ca_customertransactionid 
from IndusTrain a, dbo.CustomerTransaction b 
where right(left(a.ca_customertransactionid, 37), 36) = b.Id

select b.CustomerId, a.*
from dbo.CustomerTransactionBank a, dbo.CustomerTransaction b
where a.CustomerTransactionId=b.Id
and b.Id='0057F04D-5F1B-4710-A9F5-C7BE1989874F'

select *
from dbo.CustomerTransaction
where Id='0005AF40-07A8-4B30-A96B-04B27B6B39D4'

select b.Description, a.*
from dbo.CustomerTransactionSummary a, dbo.Type b
where a.CustomerId='4886342F-011A-441C-B358-00319D7F9E02'
and a.CreditTypeId=b.Id
and b.Description='İhtiyaç Kredisi'

select top 10 *
from dbo.CustomerTransaction


select CustomerTransactionId, TransTime, CustomerId, 
avg(DefMon3), avg(OccpMon3),
avg(DefMon6), avg(OccpMon6),
avg(DefMon12), avg(OccpMon12),
avg(DefMon18), avg(OccpMon18) 
from
	(select b.Id CustomerTransactionId, b.CreatedDateTime TransTime, DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1 MonthCount,
	b.CustomerId, t3.Description, t3.Performance,
  
	LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 3) Mon3,
	case when LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 3) like '%K%' 
	or LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 3) like '%I%' 
	or LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 3) like '%3%' then 1 else 0 end DefMon3,
	cast(LEN(REPLACE(REPLACE(LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 3), '/', ''), '.', '')) as float)/
	cast(LEN(LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 3)) as float) OccpMon3,

	LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 6) Mon6,
	case when LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 6) like '%K%' 
	or LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 6) like '%I%' 
	or LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 6) like '%3%' then 1 else 0 end DefMon6,
	cast(LEN(REPLACE(REPLACE(LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 6), '/', ''), '.', '')) as float)/
	cast(LEN(LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 6)) as float) OccpMon6,

	LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 12) Mon12,
	case when LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 12) like '%K%' 
	or LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 12) like '%I%' 
	or LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 12) like '%3%' then 1 else 0 end DefMon12,
	cast(LEN(REPLACE(REPLACE(LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 12), '/', ''), '.', '')) as float)/
	cast(LEN(LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+12)), 12)) as float) OccpMon12,

	LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 18) Mon18,
	case when LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 18) like '%K%' 
	or LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 18) like '%I%' 
	or LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 18) like '%3%' then 1 else 0 end DefMon18,
	cast(LEN(REPLACE(REPLACE(LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 18), '/', ''), '.', '')) as float)/
	cast(LEN(LEFT(RIGHT(t3.Performance, len(t3.Performance)-(DATEDIFF(month,'2010-01-01', b.CreatedDateTime)+1)), 18)) as float) OccpMon18,

	a.*
	from dbo.IndusTrain_Model a, dbo.CustomerTransaction b
	left join
		(select CustomerId, Description, 
		(max(Jan10) + max(Feb10) + max(Mar10) + max(Apr10) + max(May10) + max(Jun10) + max(Jul10) + max(Aug10) + max(Sep10) + max(Oct10) + max(Nov10) + max(Dec10) +
		max(Jan11) + max(Feb11) + max(Mar11) + max(Apr11) + max(May11) + max(Jun11) + max(Jul11) + max(Aug11) + max(Sep11) + max(Oct11) + max(Nov11) + max(Dec11) +
		max(Jan12) + max(Feb12) + max(Mar12) + max(Apr12) + max(May12) + max(Jun12) + max(Jul12) + max(Aug12) + max(Sep12) + max(Oct12) + max(Nov12) + max(Dec12) +
		max(Jan13) + max(Feb13) + max(Mar13) + max(Apr13) + max(May13) + max(Jun13) + max(Jul13) + max(Aug13) + max(Sep13) + max(Oct13) + max(Nov13) + max(Dec13) +
		max(Jan14) + max(Feb14) + max(Mar14) + max(Apr14) + max(May14) + max(Jun14) + max(Jul14) + max(Aug14) + max(Sep14) + max(Oct14) + max(Nov14) + max(Dec14) +
		max(Jan15) + max(Feb15) + max(Mar15) + max(Apr15) + max(May15) + max(Jun15) + max(Jul15) + max(Aug15) + max(Sep15) + max(Oct15) + max(Nov15) + max(Dec15) +
		max(Jan16) + max(Feb16) + max(Mar16) + max(Apr16) + max(May16) + max(Jun16) + max(Jul16) + max(Aug16) + max(Sep16) + max(Oct16) + max(Nov16) + max(Dec16) +
		max(Jan17) + max(Feb17) + max(Mar17) + max(Apr17) + max(May17) + max(Jun17) + max(Jul17) + max(Aug17) + max(Sep17) + max(Oct17) + max(Nov17) + max(Dec17) +
		max(Jan18) + max(Feb18) + max(Mar18) + max(Apr18) + max(May18) + max(Jun18) + max(Jul18) + max(Aug18) + max(Sep18) + max(Oct18) + max(Nov18) + max(Dec18) +
		max(Jan19) + max(Feb19) + max(Mar19) + max(Apr19) + max(May19) + max(Jun19) + max(Jul19) + max(Aug19) + max(Sep19) + max(Oct19) + max(Nov19) + max(Dec19)) Performance
		from
			(select t.CustomerId, t.Description, t.CreditLimit, t.StartDate, t.EndDate, 

			left(t.Year10, 1) Jan10, left(right(t.Year10, 11), 1) Feb10, left(right(t.Year10, 10), 1) Mar10, left(right(t.Year10, 9), 1) Apr10,
			left(right(t.Year10, 8), 1) May10, left(right(t.Year10, 7), 1) Jun10, left(right(t.Year10, 6), 1) Jul10, left(right(t.Year10, 5), 1) Aug10,
			left(right(t.Year10, 4), 1) Sep10, left(right(t.Year10, 3), 1) Oct10, left(right(t.Year10, 2), 1) Nov10, left(right(t.Year10, 1), 1) Dec10,   

			left(t.Year11, 1) Jan11, left(right(t.Year11, 11), 1) Feb11, left(right(t.Year11, 10), 1) Mar11, left(right(t.Year11, 9), 1) Apr11,
			left(right(t.Year11, 8), 1) May11, left(right(t.Year11, 7), 1) Jun11, left(right(t.Year11, 6), 1) Jul11, left(right(t.Year11, 5), 1) Aug11,
			left(right(t.Year11, 4), 1) Sep11, left(right(t.Year11, 3), 1) Oct11, left(right(t.Year11, 2), 1) Nov11, left(right(t.Year11, 1), 1) Dec11,

			left(t.Year12, 1) Jan12, left(right(t.Year12, 12), 1) Feb12, left(right(t.Year12, 10), 1) Mar12, left(right(t.Year12, 9), 1) Apr12,
			left(right(t.Year12, 8), 1) May12, left(right(t.Year12, 7), 1) Jun12, left(right(t.Year12, 6), 1) Jul12, left(right(t.Year12, 5), 1) Aug12,
			left(right(t.Year12, 4), 1) Sep12, left(right(t.Year12, 3), 1) Oct12, left(right(t.Year12, 2), 1) Nov12, left(right(t.Year12, 1), 1) Dec12,

			left(t.Year13, 1) Jan13, left(right(t.Year13, 13), 1) Feb13, left(right(t.Year13, 10), 1) Mar13, left(right(t.Year13, 9), 1) Apr13,
			left(right(t.Year13, 8), 1) May13, left(right(t.Year13, 7), 1) Jun13, left(right(t.Year13, 6), 1) Jul13, left(right(t.Year13, 5), 1) Aug13,
			left(right(t.Year13, 4), 1) Sep13, left(right(t.Year13, 3), 1) Oct13, left(right(t.Year13, 2), 1) Nov13, left(right(t.Year13, 1), 1) Dec13,

			left(t.Year14, 1) Jan14, left(right(t.Year14, 14), 1) Feb14, left(right(t.Year14, 10), 1) Mar14, left(right(t.Year14, 9), 1) Apr14,
			left(right(t.Year14, 8), 1) May14, left(right(t.Year14, 7), 1) Jun14, left(right(t.Year14, 6), 1) Jul14, left(right(t.Year14, 5), 1) Aug14,
			left(right(t.Year14, 4), 1) Sep14, left(right(t.Year14, 3), 1) Oct14, left(right(t.Year14, 2), 1) Nov14, left(right(t.Year14, 1), 1) Dec14,

			left(t.Year15, 1) Jan15, left(right(t.Year15, 15), 1) Feb15, left(right(t.Year15, 10), 1) Mar15, left(right(t.Year15, 9), 1) Apr15,
			left(right(t.Year15, 8), 1) May15, left(right(t.Year15, 7), 1) Jun15, left(right(t.Year15, 6), 1) Jul15, left(right(t.Year15, 5), 1) Aug15,
			left(right(t.Year15, 4), 1) Sep15, left(right(t.Year15, 3), 1) Oct15, left(right(t.Year15, 2), 1) Nov15, left(right(t.Year15, 1), 1) Dec15,

			left(t.Year16, 1) Jan16, left(right(t.Year16, 16), 1) Feb16, left(right(t.Year16, 10), 1) Mar16, left(right(t.Year16, 9), 1) Apr16,
			left(right(t.Year16, 8), 1) May16, left(right(t.Year16, 7), 1) Jun16, left(right(t.Year16, 6), 1) Jul16, left(right(t.Year16, 5), 1) Aug16,
			left(right(t.Year16, 4), 1) Sep16, left(right(t.Year16, 3), 1) Oct16, left(right(t.Year16, 2), 1) Nov16, left(right(t.Year16, 1), 1) Dec16,

			left(t.Year17, 1) Jan17, left(right(t.Year17, 17), 1) Feb17, left(right(t.Year17, 10), 1) Mar17, left(right(t.Year17, 9), 1) Apr17,
			left(right(t.Year17, 8), 1) May17, left(right(t.Year17, 7), 1) Jun17, left(right(t.Year17, 6), 1) Jul17, left(right(t.Year17, 5), 1) Aug17,
			left(right(t.Year17, 4), 1) Sep17, left(right(t.Year17, 3), 1) Oct17, left(right(t.Year17, 2), 1) Nov17, left(right(t.Year17, 1), 1) Dec17,

			left(t.Year18, 1) Jan18, left(right(t.Year18, 18), 1) Feb18, left(right(t.Year18, 10), 1) Mar18, left(right(t.Year18, 9), 1) Apr18,
			left(right(t.Year18, 8), 1) May18, left(right(t.Year18, 7), 1) Jun18, left(right(t.Year18, 6), 1) Jul18, left(right(t.Year18, 5), 1) Aug18,
			left(right(t.Year18, 4), 1) Sep18, left(right(t.Year18, 3), 1) Oct18, left(right(t.Year18, 2), 1) Nov18, left(right(t.Year18, 1), 1) Dec18,

			left(t.Year19, 1) Jan19, left(right(t.Year19, 19), 1) Feb19, left(right(t.Year19, 10), 1) Mar19, left(right(t.Year19, 9), 1) Apr19,
			left(right(t.Year19, 8), 1) May19, left(right(t.Year19, 7), 1) Jun19, left(right(t.Year19, 6), 1) Jul19, left(right(t.Year19, 5), 1) Aug19,
			left(right(t.Year19, 4), 1) Sep19, left(right(t.Year19, 3), 1) Oct19, left(right(t.Year19, 2), 1) Nov19, left(right(t.Year19, 1), 1) Dec19,

			t.Year10, t.Year11, t.Year12, t.Year13, t.Year14, t.Year15, t.Year16, t.Year17, t.Year18, t.Year19
			from 
				(select b.Description, a.CustomerId, a.CreditLimit, a.StartDate, a.EndDate,
				REPLACE(REPLACE(Year10, 'Z', '.'), 'X', '/') Year10, REPLACE(REPLACE(Year11, 'Z', '.'), 'X', '/') Year11, 
				REPLACE(REPLACE(Year12, 'Z', '.'), 'X', '/') Year12, REPLACE(REPLACE(Year13, 'Z', '.'), 'X', '/') Year13,
				REPLACE(REPLACE(Year14, 'Z', '.'), 'X', '/') Year14, REPLACE(REPLACE(Year15, 'Z', '.'), 'X', '/') Year15,
				REPLACE(REPLACE(Year16, 'Z', '.'), 'X', '/') Year16, REPLACE(REPLACE(Year17, 'Z', '.'), 'X', '/') Year17,
				REPLACE(REPLACE(Year18, 'Z', '.'), 'X', '/') Year18, REPLACE(REPLACE(Year19, 'Z', '.'), 'X', '/') Year19  
				from dbo.CustomerTransactionSummary a, dbo.Type b
				where CustomerId='4886342F-011A-441C-B358-00319D7F9E02'
				and a.CreditTypeId=b.Id) t ) t2
		group by CustomerId, Description) t3
	on b.CustomerId = t3.CustomerId
	where right(left(a.ca_customertransactionid, 37), 36) = b.Id
	and b.CustomerId='4886342F-011A-441C-B358-00319D7F9E02')