select ca.Id ApplyId, ca.CreatedDateTime ApplyTime, DATEPART(HOUR, ca.CreatedDateTime) ApplyHour, DATEPART(MONTH, ca.CreatedDateTime) ApplyMonth, 
	ca.CustomerId, ca.PreferBank1Id, ca.PreferBank2Id, (case when ca.CampaignCodes is NULL or ca.CampaignCodes = '' then NULL else ca.CampaignCodes end) CampaingCodes,
	c.Bounced, c.Unsubscribed, c.FacebookId, c.IsDeleted, (ca.MinMonthlyCanBePaid + ca.MaxMonthlyCanBePaid)/2 MonthlyCanBePaid, deed.DeedTypeId, 
	ApplyStatus.ApplyStatus, payment.Message PaymentMessage, payment.StatusTypeId PaymentStatus, ins.InsScore, 
	DATEDIFF(year, c.BirthDate, GETDATE()) Age, c.Gender, city.Name CityName,
	(ca.MinPayrollIncome + ca.MaxPayrollIncome)/2 Income, ct.Score, ca.OccupationId,
	cs.EducationId, cs.ProfessionId, cs.WorkName, cs.WorkCityId, cs.WorkCountyId, cs.WorkSectorId, cs.WorkTitleId, cs.WorkPeriodId, cs.HomeOwnerId,
	cts.ReferenceNo, cts.CreditTypeId, cts.CreditLimit, ctb.TotalDebt, cts.StartDate, cts.EndDate, ctb.Installment, ctb.Interest,
	cts.Year10 + cts.Year11 + cts.Year12 + cts.Year13 + cts.Year14 + cts.Year15 + cts.Year16 + cts.Year17 + cts.Year18 + cts.Year19 Performance    
	from dbo.Customer c, dbo.CustomerTransaction ct, dbo.CustomerTransactionSummary cts,
		(select a.RegisterReferenceNo, a.Installment, a.Interest, a.TotalDebt
		from dbo.CustomerTransactionBank a,	
			(select RegisterReferenceNo, max(CreatedDateTime) MaxTime
			from dbo.CustomerTransactionBank
			group by RegisterReferenceNo) ctb_first
		where a.RegisterReferenceNo = ctb_first.RegisterReferenceNo
		and a.CreatedDateTime = ctb_first.MaxTime) ctb, 
	dbo.CustomerApply ca
	left join dbo.CustomerSurvey cs
	on ca.Id = cs.CustomerApplyId
	left join dbo.City city 
	on ca.CityId = city.Id
	left join (select a.CustomerApplyId, a.StatusTypeId ApplyStatus
			   from dbo.CustomerApplyHistory a, (select CustomerApplyId, max(CreatedDateTime) StatusTime from dbo.CustomerApplyHistory group by CustomerApplyId) b
			   where a.CustomerApplyId = b.CustomerApplyId
			   and a.CreatedDateTime = b.StatusTime) ApplyStatus
	on ca.Id = ApplyStatus.CustomerApplyId 
	left join dbo.Payment payment
	on ca.Id = payment.CustomerApplyId
	left join (select a.Id CustomerId, b.Score InsScore from dbo.Customer a, dbo.x_ins_score b where a.SecurityNumber = b.Security_Number) ins
	on ca.CustomerId = ins.CustomerId
	left join dbo.CustomerApplyDeed deed
	on ca.Id = deed.CustomerApplyId
	where ca.CustomerId = c.Id
	and ca.CustomerTransactionId = ct.Id
	and ca.CustomerId = cts.CustomerId
	and cts.ReferenceNo = ctb.RegisterReferenceNo
	and ca.CustomerId = '5098E73E-886A-4BC8-B927-73456C5C8A73'
	and ca.Id = '1548BD2D-859C-41AC-9E47-003C54366150'
	and ca.CreatedDateTime between '2016-01-01' and '2016-12-31'