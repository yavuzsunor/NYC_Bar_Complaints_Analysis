create view Apply_2018 as 

select t.ApplyId, t.ApplyTime, t.ApplyHour, t.ApplyMonth, t.CustomerId, t.Age, tp.Description Gender, t.CityName, 
t.MonthlyCanBePaid, t.Income, t.Score, t.Device, t.MailFlag, t.Source, t.Medium, t.Campaign, t.Adgroup, t.Keyword, tp2.Description Occupation,
tp3.Description Education, tp4.Description Profession, t.WorkName, Cit.Name WorkCity, County.Name WorkCounty, tp7.Description WorkSector,
tp8.Description WorkTitle, tp9.Description WorkPeriod, tp10.Description Homeowner, t.PreferBank1, t.PreferBank2,
tp14.Description DeedType, t.PaymentMessage, tp16.Description PaymentStatus, t.CardType, t.InsScore, 
t.Bounced, t.Unsubscribed, t.FacebookId, t.IsDeleted,
t.ReferenceNo, tp11.Description CreditType, t.CreditLimit, t.TotalDebt,
t.StartDate, t.EndDate, t.Installment, t.Interest, t.Performance,
case when EndDate is not NULL then
		LEFT(RIGHT(LEFT(Performance, DATEDIFF(month, '2010-01-01', GETDATE())), 
			case when DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) < 0 then 0
			else DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) end), DATEDIFF(month, StartDate, EndDate))
		else RIGHT(LEFT(Performance, DATEDIFF(month, '2010-01-01', GETDATE())), 
			case when DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) < 0 then 0
			else DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) end) end CredPerf,
		DATEDIFF(month, StartDate, EndDate) CredMon 

from
	(select ca.Id ApplyId, ca.CreatedDateTime ApplyTime, DATEPART(HOUR, ca.CreatedDateTime) ApplyHour, DATEPART(MONTH, ca.CreatedDateTime) ApplyMonth, 
	ca.CustomerId, bank1.Name PreferBank1, bank2.Name PreferBank2, 
	case when c.Browser LIKE '%Android%' then 'Android' 
		 when c.Browser LIKE '%iPhone%' then 'iPhone'
		 when c.Browser LIKE '%Firefox%' then 'Firefox'
		 when c.Browser LIKE '%Chrome%' then 'Chrome'
		 when c.Browser LIKE '%Safari%' then 'Safari'
		 when c.Browser LIKE '%Trident%' then 'IE'
		 when c.Browser LIKE '%Opera%' then 'Opera'
		 else 'Other'end Device,
	case when Email LIKE '%'+REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(FirstName,'ç','c'),'ğ','g'),'ı','i'),'ö','o'),'ş','s'),'ü','u')+'%' and 
			  Email NOT LIKE '%'+REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LastName,'ç','c'),'ğ','g'),'ı','i'),'ö','o'),'ş','s'),'ü','u')+'%' then 1
		 when Email NOT LIKE '%'+REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(FirstName,'ç','c'),'ğ','g'),'ı','i'),'ö','o'),'ş','s'),'ü','u')+'%' and 
			  Email LIKE '%'+REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LastName,'ç','c'),'ğ','g'),'ı','i'),'ö','o'),'ş','s'),'ü','u')+'%' then 2
		 when Email LIKE '%'+REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(FirstName,'ç','c'),'ğ','g'),'ı','i'),'ö','o'),'ş','s'),'ü','u')+'%' and 
			  Email LIKE '%'+REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LastName,'ç','c'),'ğ','g'),'ı','i'),'ö','o'),'ş','s'),'ü','u')+'%' then 3 else 0 end MailFlag,
	dbo.fnGetSplittedText(c.CampaignCodes,'|',0) [Source],
	dbo.fnGetSplittedText(c.CampaignCodes,'|',1) [Medium],
	dbo.fnGetSplittedText(c.CampaignCodes,'|',2) [Campaign],
	dbo.fnGetSplittedText(c.CampaignCodes,'|',3) [Adgroup],
	dbo.fnGetSplittedText(c.CampaignCodes,'|',4) [Keyword],
	c.Bounced, c.Unsubscribed, c.FacebookId, c.IsDeleted, (ca.MinMonthlyCanBePaid + ca.MaxMonthlyCanBePaid)/2 MonthlyCanBePaid, deed.DeedTypeId, 
	ins.InsScore,
	payment.Message PaymentMessage, payment.StatusTypeId PaymentStatus, 
	case when LEFT(payment.CardNumber,1)=3 then 'AmEx'
		 when LEFT(payment.CardNumber,1)=4 then 'Visa'
		 when LEFT(payment.CardNumber,1)=5 then 'MasterCard'
		 when payment.CardNumber is NULL then NULL
		 else 'Other' end CardType, 
	DATEDIFF(year, c.BirthDate, GETDATE()) Age, c.Gender, city.Name CityName,
	(ca.MinPayrollIncome + ca.MaxPayrollIncome)/2 Income, ct.Score, ca.OccupationId,
	cs.EducationId, cs.ProfessionId, cs.WorkName, cs.WorkCityId, cs.WorkCountyId, cs.WorkSectorId, cs.WorkTitleId, cs.WorkPeriodId, cs.HomeOwnerId,
	cts.ReferenceNo, cts.CreditTypeId, ctb.CreditLimit, ctb.TotalDebt, cts.StartDate StartDate, cts.EndDate, ctb.Installment, ctb.Interest,
	cts.Year10 + cts.Year11 + cts.Year12 + cts.Year13 + cts.Year14 + cts.Year15 + cts.Year16 + cts.Year17 + cts.Year18 + cts.Year19 Performance    
	from dbo.Customer c, dbo.CustomerTransaction ct,		 
	dbo.CustomerApply ca
	left join dbo.CustomerTransactionSummary cts
	on ca.CustomerId = cts.CustomerId
	left join dbo.CustomerTransactionBank ctb
	on ca.CustomerTransactionId = ctb.CustomerTransactionId
	and cts.ReferenceNo = ctb.RegisterReferenceNo
	left join dbo.CustomerSurvey cs
	on ca.Id = cs.CustomerApplyId
	left join dbo.City city 
	on ca.CityId = city.Id 
	left join dbo.Bank bank1
	on ca.PreferBank1Id = bank1.Id
	left join dbo.Bank bank2
	on ca.PreferBank2Id = bank2.Id
	left join (select * from dbo.Payment where LEFT(CardNumber,1) <> '*') payment
	on ca.Id = payment.CustomerApplyId
	left join (select a.Id CustomerId, b.Score InsScore from dbo.Customer a, dbo.x_ins_score b where a.SecurityNumber = b.Security_Number) ins
	on ca.CustomerId = ins.CustomerId
	left join dbo.CustomerApplyDeed deed
	on ca.Id = deed.CustomerApplyId
	where ca.CustomerId = c.Id
	and ca.CustomerTransactionId = ct.Id
	and DATEPART(YEAR, ca.CreatedDateTime) = '2018' 
	and ISNULL(cts.EndDate,'20991231') > cts.StartDate) t
left join dbo.Type tp
on t.Gender = tp.Id
left join dbo.Type tp2
on t.OccupationId = tp2.Id
left join dbo.Type tp3
on t.EducationId = tp3.Id
left join dbo.Type tp4
on t.ProfessionId = tp4.Id
left join dbo.City Cit
on t.WorkCityId = Cit.Id
left join dbo.County County
on t.WorkCountyId = County.Id	
left join dbo.Type tp7
on t.WorkSectorId = tp7.Id
left join dbo.Type tp8
on t.WorkTitleId = tp8.Id
left join dbo.Type tp9
on t.WorkPeriodId = tp9.Id
left join dbo.Type tp10
on t.HomeOwnerId = tp10.Id
left join dbo.Type tp11
on t.CreditTypeId = tp11.Id
left join dbo.Type tp14
on t.DeedTypeId = tp14.Id
left join dbo.Type tp16
on t.PaymentStatus = tp16.Id
