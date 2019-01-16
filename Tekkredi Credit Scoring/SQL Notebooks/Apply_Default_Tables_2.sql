select ApplyId, ApplyTime, CustomerId, 
	   max(case when CreditType = 'İhtiyaç Kredisi' then Def else NULL end) ConsCred,
	   max(case when CreditType = 'Kredi Kartı' then Def else NULL end) CredCard,
	   max(case when CreditType = 'Kredili Mevduat Hesabı' then Def else NULL end) Overdraft,
	   max(case when CreditType = 'Konut Kredisi' then Def else NULL end) Mortgage,
	   max(case when CreditType = 'Taşıt Kredisi' then Def else NULL end) Car 
into dbo.Apply_2018_Def
from		
	(select ApplyId, ApplyTime, CustomerId, ReferenceNo, CreditType, StartDate, EndDate, CredPerf, Mon12, Mon12Occp, 
	case when Mon12 LIKE '%K%' or Mon12 LIKE '%I%' or Mon12 LIKE '%3%' then 1 else 0 end Def 
	
	from 
		(select ApplyId, ApplyTime, CustomerId, ReferenceNo, CreditType, StartDate, EndDate, CredPerf, 		 
		 SUBSTRING(Performance,DATEDIFF(MONTH,'2010-01-01', ApplyTime)+2,12) Mon12,
		 cast(cast(LEN(REPLACE(REPLACE(SUBSTRING(Performance,DATEDIFF(MONTH,'20100101', ApplyTime)+2,12), 'X', ''), 'Z', '')) as float) / 
		 NULLIF(cast(LEN(SUBSTRING(Performance,DATEDIFF(MONTH,'20100101', ApplyTime)+2,12)) as float), 0) as numeric(18,2)) Mon12Occp		 
		 from dbo.Apply_2018
		 ) a	

	where (LEN(CredPerf) >= 12  or (CredPerf LIKE '%K%') or (CredPerf LIKE '%I%') or (CredPerf LIKE '%3%'))
	and (Mon12Occp >= 0.5 or (Mon12 LIKE '%K%') or (Mon12 LIKE '%I%') or (Mon12 LIKE '%3%'))
	and LEFT(Mon12, 1) <> 'K' and LEFT(Mon12, 1) <> 'I'
	) t
group by ApplyId, ApplyTime, CustomerId


select count(*)
from dbo.Full_Def_2