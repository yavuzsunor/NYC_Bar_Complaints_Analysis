select a.ApplyId, a.ApplyTime, ApplyHour, ApplyMonth, a.CustomerId, Age, Gender, CityName, MonthlyCanBePaid, Income, Score,
Device, MailFlag, [Source], Medium, Campaign, Adgroup, Keyword, 
Occupation, Education, Profession, WorkName, WorkCity, WorkCounty, WorkSector, WorkTitle, WorkPeriod, Homeowner,
PreferBank1, PreferBank2, DeedType, PaymentMessage, PaymentStatus, CardType, InsScore, Bounced, Unsubscribed, FacebookId, IsDeleted,
min(ReferenceNo) minRef

into dbo.Full_Apply
from dbo.Apply_2014 a, dbo.Apply_2014_Def b

where a.CustomerId = b.CustomerId
and a.ApplyId = b.ApplyId
group by a.ApplyId, a.ApplyTime, ApplyHour, ApplyMonth, a.CustomerId, Age, Gender, CityName, MonthlyCanBePaid, Income, Score,
Device, MailFlag, [Source], Medium, Campaign, Adgroup, Keyword, 
Occupation, Education, Profession, WorkName, WorkCity, WorkCounty, WorkSector, WorkTitle, WorkPeriod, Homeowner,
PreferBank1, PreferBank2, DeedType, PaymentMessage, PaymentStatus, CardType, InsScore, Bounced, Unsubscribed, FacebookId, IsDeleted
  
union

select distinct a.ApplyId, a.ApplyTime, ApplyHour, ApplyMonth, a.CustomerId, Age, Gender, CityName, MonthlyCanBePaid, Income, Score,
Device, MailFlag, [Source], Medium, Campaign, Adgroup, Keyword, 
Occupation, Education, Profession, WorkName, WorkCity, WorkCounty, WorkSector, WorkTitle, WorkPeriod, Homeowner,
PreferBank1, PreferBank2, DeedType, PaymentMessage, PaymentStatus, CardType, InsScore, Bounced, Unsubscribed, FacebookId, IsDeleted,
min(ReferenceNo) minRef

from dbo.Apply_2015 a, dbo.Apply_2015_Def b
where a.CustomerId = b.CustomerId
and a.ApplyId = b.ApplyId
group by a.ApplyId, a.ApplyTime, ApplyHour, ApplyMonth, a.CustomerId, Age, Gender, CityName, MonthlyCanBePaid, Income, Score,
Device, MailFlag, [Source], Medium, Campaign, Adgroup, Keyword, 
Occupation, Education, Profession, WorkName, WorkCity, WorkCounty, WorkSector, WorkTitle, WorkPeriod, Homeowner,
PreferBank1, PreferBank2, DeedType, PaymentMessage, PaymentStatus, CardType, InsScore, Bounced, Unsubscribed, FacebookId, IsDeleted

union

select distinct a.ApplyId, a.ApplyTime, ApplyHour, ApplyMonth, a.CustomerId, Age, Gender, CityName, MonthlyCanBePaid, Income, Score,
Device, MailFlag, [Source], Medium, Campaign, Adgroup, Keyword, 
Occupation, Education, Profession, WorkName, WorkCity, WorkCounty, WorkSector, WorkTitle, WorkPeriod, Homeowner,
PreferBank1, PreferBank2, DeedType, PaymentMessage, PaymentStatus, CardType, InsScore, Bounced, Unsubscribed, FacebookId, IsDeleted,
min(ReferenceNo) minRef

from dbo.Apply_2016 a, dbo.Apply_2016_Def b
where a.CustomerId = b.CustomerId
and a.ApplyId = b.ApplyId
group by a.ApplyId, a.ApplyTime, ApplyHour, ApplyMonth, a.CustomerId, Age, Gender, CityName, MonthlyCanBePaid, Income, Score,
Device, MailFlag, [Source], Medium, Campaign, Adgroup, Keyword, 
Occupation, Education, Profession, WorkName, WorkCity, WorkCounty, WorkSector, WorkTitle, WorkPeriod, Homeowner,
PreferBank1, PreferBank2, DeedType, PaymentMessage, PaymentStatus, CardType, InsScore, Bounced, Unsubscribed, FacebookId, IsDeleted

union

select distinct a.ApplyId, a.ApplyTime, ApplyHour, ApplyMonth, a.CustomerId, Age, Gender, CityName, MonthlyCanBePaid, Income, Score,
Device, MailFlag, [Source], Medium, Campaign, Adgroup, Keyword, 
Occupation, Education, Profession, WorkName, WorkCity, WorkCounty, WorkSector, WorkTitle, WorkPeriod, Homeowner,
PreferBank1, PreferBank2, DeedType, PaymentMessage, PaymentStatus, CardType, InsScore, Bounced, Unsubscribed, FacebookId, IsDeleted,
min(ReferenceNo) minRef

from dbo.Apply_2017 a, dbo.Apply_2017_Def b
where a.CustomerId = b.CustomerId
and a.ApplyId = b.ApplyId
group by a.ApplyId, a.ApplyTime, ApplyHour, ApplyMonth, a.CustomerId, Age, Gender, CityName, MonthlyCanBePaid, Income, Score,
Device, MailFlag, [Source], Medium, Campaign, Adgroup, Keyword, 
Occupation, Education, Profession, WorkName, WorkCity, WorkCounty, WorkSector, WorkTitle, WorkPeriod, Homeowner,
PreferBank1, PreferBank2, DeedType, PaymentMessage, PaymentStatus, CardType, InsScore, Bounced, Unsubscribed, FacebookId, IsDeleted

union

select distinct a.ApplyId, a.ApplyTime, ApplyHour, ApplyMonth, a.CustomerId, Age, Gender, CityName, MonthlyCanBePaid, Income, Score,
Device, MailFlag, [Source], Medium, Campaign, Adgroup, Keyword, 
Occupation, Education, Profession, WorkName, WorkCity, WorkCounty, WorkSector, WorkTitle, WorkPeriod, Homeowner,
PreferBank1, PreferBank2, DeedType, PaymentMessage, PaymentStatus, CardType, InsScore, Bounced, Unsubscribed, FacebookId, IsDeleted,
min(ReferenceNo) minRef

from dbo.Apply_2018 a, dbo.Apply_2018_Def b
where a.CustomerId = b.CustomerId
and a.ApplyId = b.ApplyId
group by a.ApplyId, a.ApplyTime, ApplyHour, ApplyMonth, a.CustomerId, Age, Gender, CityName, MonthlyCanBePaid, Income, Score,
Device, MailFlag, [Source], Medium, Campaign, Adgroup, Keyword, 
Occupation, Education, Profession, WorkName, WorkCity, WorkCounty, WorkSector, WorkTitle, WorkPeriod, Homeowner,
PreferBank1, PreferBank2, DeedType, PaymentMessage, PaymentStatus, CardType, InsScore, Bounced, Unsubscribed, FacebookId, IsDeleted




select top 10 *
from dbo.Full_Apply



select DATEPART(YEAR, a.ApplyTime) ApplyYear, count(a.ApplyId) Whole, count(b.ApplyId) DefTarget,
sum(case when a.Age is not NULL then 1 else 0 end) Age,
sum(case when a.Gender is not NULL then 1 else 0 end) Gender,
sum(case when a.CityName is not NULL then 1 else 0 end) CityName,
sum(case when a.MonthlyCanBePaid is not NULL then 1 else 0 end) MonthlyCanBePaid,
sum(case when a.Income is not NULL then 1 else 0 end) Income,
sum(case when a.Score is not NULL then 1 else 0 end) Score,
sum(case when a.Occupation is not NULL then 1 else 0 end) Occupation,
sum(case when a.Education is not NULL then 1 else 0 end) Education,
sum(case when a.Profession is not NULL then 1 else 0 end) Profession, 
sum(case when a.WorkName is not NULL then 1 else 0 end) WorkName,
sum(case when a.WorkCity is not NULL then 1 else 0 end) WorkCity,
sum(case when a.WorkCounty is not NULL then 1 else 0 end) WorkCounty,
sum(case when a.WorkSector is not NULL then 1 else 0 end) WorkSector,
sum(case when a.WorkTitle is not NULL then 1 else 0 end) WorkTitle,
sum(case when a.WorkPeriod is not NULL then 1 else 0 end) WorkPeriod,
sum(case when a.Homeowner is not NULL then 1 else 0 end) Homeowner,
sum(case when a.PreferBank1 is not NULL then 1 else 0 end) PreferBank1,
sum(case when a.PreferBank2 is not NULL then 1 else 0 end) PreferBank2,
sum(case when a.DeedType is not NULL then 1 else 0 end) DeedType,
sum(case when a.ApplyStatus is not NULL then 1 else 0 end) ApplyStatus,
sum(case when a.PaymentMessage is not NULL then 1 else 0 end) PaymentMessage,
sum(case when a.PaymentStatus is not NULL then 1 else 0 end) PaymentStatus,
sum(case when a.InsScore is not NULL then 1 else 0 end) InsScore,
sum(case when a.Bounced is not NULL then 1 else 0 end) Bounced,
sum(case when a.Unsubscribed is not NULL then 1 else 0 end) Unsubscribed,
sum(case when a.FacebookId is not NULL then 1 else 0 end) FacebookId,
sum(case when a.IsDeleted is not NULL then 1 else 0 end) IsDeleted,
sum(case when a.ConsInt is not NULL then 1 else 0 end) ConsInt,
sum(case when a.CredInt is not NULL then 1 else 0 end) CredInt,
sum(case when a.ODInt is not NULL then 1 else 0 end) ODInt,
sum(case when a.MorgInt is not NULL then 1 else 0 end) MorgInt,
sum(case when a.CarInt is not NULL then 1 else 0 end) CarInt
from dbo.Full_Apply a, dbo.Full_Def b
where a.ApplyId = b.ApplyId
group by DATEPART(YEAR, a.ApplyTime)
order by DATEPART(YEAR, a.ApplyTime) asc


select *
from dbo.Correlation_Check

select
case when ConsCred=1 or CredCard=1 or Overdraft=1 or Mortgage=1 or Car=1 then 1 else 0 end Def,
b.*        
into dbo.Correlation_Check 
from dbo.Full_Def a, dbo.Full_Apply b
where a.ApplyId = b.ApplyId 

select top 10 *
from dbo.Customer
