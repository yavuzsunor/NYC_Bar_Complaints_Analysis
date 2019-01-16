select t.ApplyId, t.ApplyTime, t.CustomerId, t.Age, tp.Description Gender, t.CityName, t.Income, t.Score, tp2.Description Occupation,
tp3.Description Education, tp4.Description Profession, t.WorkName, Cit.Name WorkCity, County.Name WorkCounty, tp7.Description WorkSector,
tp8.Description WorkTitle, tp9.Description WorkPeriod, tp10.Description Homeowner, t.ReferenceNo, tp11.Description CreditType, t.CreditLimit, t.TotalDebt,
t.StartDate, t.EndDate, t.Installment, t.Performance,
case when EndDate is not NULL then
		LEFT(RIGHT(LEFT(Performance, DATEDIFF(month, '2010-01-01', GETDATE())), 
			case when DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) < 0 then 0
			else DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) end), DATEDIFF(month, StartDate, EndDate))
		else RIGHT(LEFT(Performance, DATEDIFF(month, '2010-01-01', GETDATE())), 
			case when DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) < 0 then 0
			else DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) end) end CredPerf,
		DATEDIFF(month, StartDate, EndDate) CredMon 
into dbo.Apply_2018 
from
	(select ca.Id ApplyId, ca.CreatedDateTime ApplyTime, ca.CustomerId, DATEDIFF(year, c.BirthDate, GETDATE()) Age, c.Gender, city.Name CityName,
	(ca.MinPayrollIncome + ca.MaxPayrollIncome)/2 Income, ct.Score, ca.OccupationId,
	cs.EducationId, cs.ProfessionId, cs.WorkName, cs.WorkCityId, cs.WorkCountyId, cs.WorkSectorId, cs.WorkTitleId, cs.WorkPeriodId, cs.HomeOwnerId,
	cts.ReferenceNo, cts.CreditTypeId, cts.CreditLimit, ctb.TotalDebt, cts.StartDate, cts.EndDate, ctb.Installment,
	cts.Year10 + cts.Year11 + cts.Year12 + cts.Year13 + cts.Year14 + cts.Year15 + cts.Year16 + cts.Year17 + cts.Year18 + cts.Year19 Performance    
	from dbo.Customer c, dbo.CustomerTransaction ct, dbo.CustomerTransactionSummary cts,
		(select a.RegisterReferenceNo, a.Installment, a.TotalDebt
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
	where ca.CustomerId = c.Id
	and ca.CustomerTransactionId = ct.Id
	and ca.CustomerId = cts.CustomerId
	and cts.ReferenceNo = ctb.RegisterReferenceNo
	and ca.CustomerId = '5098E73E-886A-4BC8-B927-73456C5C8A73'
	and ca.Id = '1548BD2D-859C-41AC-9E47-003C54366150'
	and ca.CreatedDateTime between '2016-01-01' and '2016-12-31') t
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

where EndDate >= StartDate or EndDate is NULL


select top 10 *
from dbo.Apply_2016
where WorkCity is not NULL
and WorkCounty is not NULL

select *
from dbo.Apply_2015
where CustomerId = 'A5D2362D-E182-4499-B894-646A6A85E693'
order by ApplyTime

select *
from dbo.CustomerTransactionSummary
where CustomerId = 'A5D2362D-E182-4499-B894-646A6A85E693'
order by StartDate