/* Old Table */
select * into dbo.IndusConsCredit
from
(select
e.Description,  
case when c.StartDate > b.CreatedDatetime then 'Later' else 'Earlier' end TimeFlag, 
b.Id ApplyId, concat(month(b.CreatedDateTime), year(b.CreatedDateTime)) ApplyTime, 
a.CustomerTransactionId, concat(month(a.TransTime), year(a.TransTime)) TransTime, a.CustomerId,
c.ReferenceNo, c.CreditLimit, case when c.StartDate > c.EndDate and c.EndDate is not NULL then 'NotCorrect' else 'Correct' end CreditTruce, 
DATEDIFF(month, a.TransTime, c.StartDate), c.StartDate, c.EndDate,  
Def3, AvgOccp3, Def3_6, AvgOccp3_6, Def6_9, AvgOccp6_9, Def9_12, AvgOccp9_12, Def12_15, AvgOccp12_15, Def15_18, AvgOccp15_18    
from dbo.IndusScore a
left join dbo.CustomerApply b
on a.CustomerId = b.CustomerId
left join dbo.CustomerTransactionSummary c
on a.CustomerId = c.CustomerId
left join dbo.BankOffer d
on b.Id = d.CustomerApplyId 
left join dbo.Type e
on d.StatusTypeId = e.Id
where c.CreditTypeId = '3D25E727-C6B9-42CF-86FE-403482393E4D'
and concat(month(b.CreatedDateTime), year(b.CreatedDateTime)) = concat(month(a.TransTime), year(a.TransTime))
and c.CustomerId = 'FE2F0C87-B236-4A17-B93B-B51409EF5AEB'
) t


/*New Table*/

select t.*, 
REPLACE(REPLACE(LEFT(RIGHT(t.Performance, len(t.Performance)-(DATEDIFF(month,'2010-01-01', t.StartDate)+1)), 18), 'Z', '.'), 'X', '/') Mon18  
into dbo.ConsCredit
from
(select case when b.StartDate > a.CreatedDateTime then 'Later' else 'Earlier' end TimeFlag,
case when b.StartDate > b.EndDate and b.EndDate is not NULL then 'NotCorrect' else 'Correct' end CreditTruce,
a.Id ApplyId, a.CustomerId, a.CreatedDateTime, 
b.ReferenceNo, b.CreditLimit, b.StartDate, b.EndDate, Year10 + Year11 + Year12 + Year13 + Year14 + Year15 + Year16 + Year17 + Year18 + Year19 Performance
from dbo.CustomerApply a, dbo.CustomerTransactionSummary b
where a.CustomerId = b.CustomerId
and CreditTypeId = '3D25E727-C6B9-42CF-86FE-403482393E4D'
) t


select CustomerId, count(ReferenceNo) #ofCredit, max(BankStatus) BankStatus,
max(cast(Default3 as int)) Def3, cast(avg(OccpDef3) as numeric(18,2)) AvgOccp3,
max(cast(Default3_6 as int)) Def3_6, cast(avg(OccpDef3_6) as numeric(18,2)) AvgOccp3_6
from
	(select distinct CustomerId, case when b.Description = 'Tamamlandı' then 1 else 0 end BankStatus, 
	
	ReferenceNo, StartDate, Mon18, LEFT(Mon18, 3) Def3, RIGHT(LEFT(Mon18,6),3) Def3_6,

	case when LEFT(Mon18, 3) like '%K%' or LEFT(Mon18, 3) like '%I%' or LEFT(Mon18, 3) like '%3%' or LEFT(Mon18, 3) like '%4%' then 1 else 0 end Default3,
	cast(LEN(REPLACE(REPLACE(LEFT(Mon18, 3), '/', ''), '.', '')) as float)/
	cast(LEN(LEFT(Mon18,3)) as float) OccpDef3,

	case when 
	RIGHT(LEFT(Mon18,6),3) like '%K%' 
	or RIGHT(LEFT(Mon18,6),3) like '%I%' 
	or RIGHT(LEFT(Mon18,6),3) like '%3%' 
	or RIGHT(LEFT(Mon18,6),3) like '%4%' then 1 else 0 end Default3_6,
	cast(LEN(REPLACE(REPLACE(RIGHT(LEFT(Mon18,6),3), '/', ''), '.', '')) as float)/
	cast(LEN(RIGHT(LEFT(Mon18,6),3)) as float) OccpDef3_6  

	from dbo.ConsCredit a
	left join (select distinct a.CustomerApplyId, b.Description 
			   from dbo.BankOffer a, dbo.Type b
			   where a.StatusTypeId = b.Id
			   and b.Description = 'Tamamlandı') b
	on a.ApplyId = b.CustomerApplyId
	where CreditTruce = 'Correct'
	and TimeFlag = 'Later') t
group by CustomerId


select count(distinct CustomerId)
from dbo.ConsCredit
where CreditTruce = 'Correct'
and TimeFlag = 'Later'

select top 10 *
from dbo.ConsCredit
