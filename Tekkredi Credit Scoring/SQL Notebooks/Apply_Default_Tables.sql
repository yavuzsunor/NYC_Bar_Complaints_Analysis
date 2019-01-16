select ApplyId, ApplyTime, CustomerId, 
	   max(case when CreditType = 'İhtiyaç Kredisi' then Def else NULL end) ConsCred,
	   max(case when CreditType = 'Kredi Kartı' then Def else NULL end) CredCard,
	   max(case when CreditType = 'Kredili Mevduat Hesabı' then Def else NULL end) Overdraft,
	   max(case when CreditType = 'Konut Kredisi' then Def else NULL end) Mortgage,
	   max(case when CreditType = 'Taşıt Kredisi' then Def else NULL end) Car 

from		
	(select a.*, b.CredMon2, b.Occp,
		   case when LEFT(CredPerf, 12) LIKE '%K%' or LEFT(CredPerf, 12) LIKE '%I%' or LEFT(CredPerf, 12) LIKE '%3%' then 1 else 0 end Def 
	from dbo.Apply_2014 a, 
		(select CustomerId, ReferenceNo, max(ApplyTime) MaxApply,
		LEN(CredPerf) CredMon2, cast(cast(LEN(REPLACE(REPLACE(CredPerf, 'X', ''), 'Z', '')) as float) / NULLIF(cast(LEN(CredPerf) as float), 0) as numeric(18,2)) Occp
		from dbo.Apply_2016 a
		where ApplyTime > DATEADD(month, -2, StartDate) and ApplyTime < StartDate
		and CustomerId = '861AE362-8DA6-46BB-99B8-E772E68CB40F'
		group by CustomerId, ReferenceNo,
		LEN(CredPerf), cast(cast(LEN(REPLACE(REPLACE(CredPerf, 'X', ''), 'Z', '')) as float) / NULLIF(cast(LEN(CredPerf) as float), 0) as numeric(18,2))
		) b
	where a.CustomerId = b.CustomerId
	and a.ReferenceNo = b.ReferenceNo
	and a.ApplyTime = b.MaxApply
	and LEN(a.CredPerf) >= 12
	and ((b.Occp > 0.5 and a.CredPerf NOT LIKE '%K%') or (a.CredPerf LIKE '%K%') or (a.CredPerf LIKE '%I%') or (a.CredPerf LIKE '%3%'))
	and LEFT(a.CredPerf, 1) <> 'K' and LEFT(a.CredPerf, 1) <> 'I'
	) t
group by ApplyId, ApplyTime, CustomerId




DECLARE @Constant VARCHAR(120) = 'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ'

select ApplyId, ApplyTime, CustomerId, CreditType, ActiveLast3, 
avg(Delq30Last3) Avg30Mon3, avg(Delq30Last6) Avg30Mon6, avg(Delq30Last12) Avg30Mon12, avg(Delq30Last18) Avg30Mon18,
avg(Delq60Last3) Avg60Mon3, avg(Delq60Last6) Avg60Mon6, avg(Delq60Last12) Avg60Mon12, avg(Delq60Last18) Avg60Mon18,
avg(Delq90Last3) Avg90Mon3, avg(Delq90Last6) Avg90Mon6, avg(Delq90Last12) Avg90Mon12, avg(Delq90Last18) Avg90Mon18
from
	(select t2.*, 
		   case when LEN(REPLACE(REPLACE(Last3, 'Z', ''), 'X', '')) = 0 then NULL
		   else 3-LEN(REPLACE(Last3, '1', '')) end Delq30Last3, 
		   case when LEN(REPLACE(REPLACE(Last6, 'Z', ''), 'X', '')) = 0 then NULL
		   else 6-LEN(REPLACE(Last6, '1', '')) end Delq30Last6,
		   case when LEN(REPLACE(REPLACE(Last12, 'Z', ''), 'X', '')) = 0 then NULL
		   else 12-LEN(REPLACE(Last12, '1', '')) end Delq30Last12,
		   case when LEN(REPLACE(REPLACE(Last18, 'Z', ''), 'X', '')) = 0 then NULL
		   else 18-LEN(REPLACE(Last18, '1', '')) end Delq30Last18,

		   case when LEN(REPLACE(REPLACE(Last3, 'Z', ''), 'X', '')) = 0 then NULL
		   else 3-LEN(REPLACE(Last3, '2', '')) end Delq60Last3, 
		   case when LEN(REPLACE(REPLACE(Last6, 'Z', ''), 'X', '')) = 0 then NULL
		   else 6-LEN(REPLACE(Last6, '2', '')) end Delq60Last6,
		   case when LEN(REPLACE(REPLACE(Last12, 'Z', ''), 'X', '')) = 0 then NULL
		   else 12-LEN(REPLACE(Last12, '2', '')) end Delq60Last12,
		   case when LEN(REPLACE(REPLACE(Last18, 'Z', ''), 'X', '')) = 0 then NULL
		   else 18-LEN(REPLACE(Last18, '2', '')) end Delq60Last18,

		   case when LEN(REPLACE(REPLACE(Last3, 'Z', ''), 'X', '')) = 0 then NULL
		   else 3-LEN(REPLACE(Last3, '3', '')) end Delq90Last3, 
		   case when LEN(REPLACE(REPLACE(Last6, 'Z', ''), 'X', '')) = 0 then NULL
		   else 6-LEN(REPLACE(Last6, '3', '')) end Delq90Last6,
		   case when LEN(REPLACE(REPLACE(Last12, 'Z', ''), 'X', '')) = 0 then NULL
		   else 12-LEN(REPLACE(Last12, '3', '')) end Delq90Last12,
		   case when LEN(REPLACE(REPLACE(Last18, 'Z', ''), 'X', '')) = 0 then NULL
		   else 18-LEN(REPLACE(Last18, '3', '')) end Delq90Last18
	from
		
		(select t.*, 
			   case when MonDif < 3 then LEFT(@Constant, 3-MonDif)+HistPerf else RIGHT(HistPerf, 3) end Last3, 
			   case when MonDif < 6 then LEFT(@Constant, 6-MonDif)+HistPerf else RIGHT(HistPerf, 6) end Last6,
			   case when MonDif < 12 then LEFT(@Constant, 12-MonDif)+HistPerf else RIGHT(HistPerf, 12) end Last12,
			   case when MonDif < 18 then LEFT(@Constant, 18-MonDif)+HistPerf else RIGHT(HistPerf, 18) end Last18
		from
			(select distinct a.*, b.ReferenceNo, b.CreditType, b.StartDate, b.EndDate,
				case when DATEDIFF(month, b.EndDate, a.ApplyTime) <= 3 or b.EndDate is NULL then 1 else 0 end ActiveLast3,
			b.CredPerf, LEN(b.CredPerf) CredMon, DATEDIFF(month, b.StartDate, a.ApplyTime)-1 MonDif,
				case when LEN(b.CredPerf) >= DATEDIFF(month, b.StartDate, a.ApplyTime)-1 then LEFT(CredPerf, DATEDIFF(month, b.StartDate, a.ApplyTime)-1)
				else CredPerf+ LEFT(@Constant, (DATEDIFF(month, b.StartDate, a.ApplyTime)-1)-LEN(b.CredPerf)) end HistPerf  				
			from dbo.Apply_2016_Def a, dbo.Apply_2016 b
			where a.CustomerId = b.CustomerId 
			and a.CustomerId = '64CF94D1-0605-4274-8305-24F714D00CFD'
			and a.ApplyId = 'CFB6321A-B74C-46A3-BAA3-7F66B99EC21C'
			and DATEDIFF(month, b.StartDate, a.ApplyTime) >=1
			) t
		) t2
	) t3

group by ApplyId, ApplyTime, CustomerId, CreditType, ActiveLast3


select t.*
from
	(select a.*, 
	case when ConsCred is NULL then 0 else 1 end +
	case when CredCard is NULL then 0 else 1 end +
	case when Overdraft is NULL then 0 else 1 end +
	case when Mortgage is NULL then 0 else 1 end +
	case when Car is NULL then 0 else 1 end Occp       
	from dbo.Apply_2016_Def a
	) t
where Occp = 2
and ConsCred = 1 
