select *
into dbo.Full_Def_2
from dbo.Apply_2014_Def
union
select *
from dbo.Apply_2015_Def
union
select *
from dbo.Apply_2016_Def
union
select *
from dbo.Apply_2017_Def
union
select *
from dbo.Apply_2018_Def


select *
from dbo.Full_Def


select Def.*, Survey.*, KKB.*, Income.*, Twit.*
from dbo.Full_Def Def

left join 
	(select distinct ApplyId, Education, Profession, WorkName, WorkCity, WorkCounty, WorkSector, WorkTitle, WorkPeriod, HomeOwner
	from dbo.Apply_2014
	union
	select distinct ApplyId, Education, Profession, WorkName, WorkCity, WorkCounty, WorkSector, WorkTitle, WorkPeriod, HomeOwner
	from dbo.Apply_2015
	union
	select distinct ApplyId, Education, Profession, WorkName, WorkCity, WorkCounty, WorkSector, WorkTitle, WorkPeriod, HomeOwner
	from dbo.Apply_2016
	union
	select distinct ApplyId, Education, Profession, WorkName, WorkCity, WorkCounty, WorkSector, WorkTitle, WorkPeriod, HomeOwner
	from dbo.Apply_2017
	) Survey
on Def.ApplyId = Survey.ApplyId

left join (select distinct CustomerId, CampaignCodes from dbo.CustomerReportQueue) KKB 
on Def.CustomerId = KKB.CustomerId
	
left join (select CustomerId, Occp from dbo.IncomeTable) Income
on Def.CustomerId = Income.CustomerId

left join (select distinct CustomerId, xName TwitName from dbo.x_twitter_customer) Twit
on Def.CustomerId = Twit.CustomerId



select *
from dbo.CustomerSurvey
where WorkCountyId is not NULL

select *
from dbo.City



where ApplyId = '5DB4618C-D680-435E-A617-C96893612594'

