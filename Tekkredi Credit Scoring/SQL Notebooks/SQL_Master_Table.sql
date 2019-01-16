select t3.*, t4.*
from
	(select CustomerId, Age, Gender, Income, CityName, Profes, Profes_2, WorkName, WorkCity, WorkCounty, WorkSector, WorkPeriod,
	TransTime, CustomerTransactionId, Score, ApplyId, ApplyTime, AppStat, 
	sum(CreditLimit) TotLimit, sum(TotalDebt) TotDebt, 
	avg(cast(Delq90day6mon as numeric(20,5))) AvgDelq, avg(cast(KI6mon as numeric(20,5))) AvgKI
	from	
		(select 
		case when LineStatus='Open' then len(LEFT(PerformanceNew,6)) -len(replace(LEFT(PerformanceNew,6),'3',''))
		when LineStatus='Closed' and DiffApplyClosedDate >=6 then null
		when LineStatus='Closed' and DiffApplyClosedDate <6 and DiffApplyClosedDate >=0  
		then len(LEFT(PerformanceNew, 6-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 6-DiffApplyClosedDate),'3','')) end Delq90day6mon,

		case when LineStatus='Open' then len(LEFT(PerformanceNew,6)) -len(replace(LEFT(PerformanceNew,6),'K',''))
		when LineStatus='Closed' and DiffApplyClosedDate >=6 then null
		when LineStatus='Closed' and DiffApplyClosedDate <6 and DiffApplyClosedDate >=0  
		then len(LEFT(PerformanceNew, 6-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 6-DiffApplyClosedDate),'K','')) end +

		case when LineStatus='Open' then len(LEFT(PerformanceNew,6)) -len(replace(LEFT(PerformanceNew,6),'I',''))
		when LineStatus='Closed' and DiffApplyClosedDate >=6 then null
		when LineStatus='Closed' and DiffApplyClosedDate <6 and DiffApplyClosedDate >=0  
		then len(LEFT(PerformanceNew, 6-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 6-DiffApplyClosedDate),'I','')) end KI6mon,

		t1.*
		from
			(select d.CustomerId, DATEDIFF(year, Cust.BirthDate, GETDATE()) Age, Gender.Description Gender, (b.MinPayrollIncome+b.MaxPayrollIncome )/2 Income,
			City.Name CityName, Profes.Description Profes, Profes_2.Description Profes_2, Survey.WorkName, WorkCity.Name WorkCity, WorkCounty.Name WorkCounty,
			WorkSector.Description WorkSector, WorkPeriod.Description WorkPeriod, d.Score, b.Id ApplyId, b.CreatedDateTime ApplyTime, 
			AppStat.Description AppStat, d.CreatedDateTime TransTime, 
			case when CreditEndDate is not null then DATEDIFF(month,a.CreditEndDate, b.CreatedDateTime) else null end DiffApplyClosedDate,
			case when CreditCreatedDate is not null then DATEDIFF(month,a.CreditCreatedDate, b.CreatedDateTime) else null end DiffApplyOpenedDate,
			CredType.Description CredType, rtrim(ltrim(a.Performance)) PerformanceNew, 
			case when CreditEndDate is null then 'Open' else 'Closed' end LineStatus,
			a.*
			from 			  
			dbo.City City, dbo.CustomerTransactionBank a 
			left join dbo.CustomerApply b
			on a.CustomerTransactionId=b.CustomerTransactionId
			left join (select distinct Id, Description from dbo.Type where ParentId='29755DE3-E99D-4F96-915E-6C59ACFE79C1') CredType 
			on a.CreditTypeId=CredType.Id
			left join (select distinct Id, Description from dbo.Type where ParentId='25E2C165-BA5B-4FEC-A3DF-F0205FF72C67') AppStat
			on b.StatusTypeId=AppStat.Id
			left join (select distinct Id, Description from dbo.Type where ParentId='CCCB8266-3743-4A2A-B55B-E252E9A14EA5') Profes 
			on b.OccupationId=Profes.Id
			left join dbo.CustomerTransaction d
			on a.CustomerTransactionId=d.Id
			left join dbo.Customer Cust
			on  d.CustomerId=Cust.Id 
			left join (select distinct Id, Description from dbo.Type where ParentId='C548CFBF-7D77-4B6B-A2E6-B9D8F0C00CA9') Gender
			on Cust.Gender=Gender.Id
			left join dbo.CustomerSurvey Survey
			on b.Id=Survey.CustomerApplyId
			left join (select distinct Id, Description from dbo.Type where ParentId='6CF80785-BE02-4671-B09C-0DAC4BA8B575') Profes_2
			on Survey.ProfessionId=Profes_2.Id
			left join (select distinct Id, Name from dbo.City) WorkCity
			on Survey.WorkCityId=WorkCity.Id
			left join (select distinct Id, Name from dbo.County) WorkCounty
			on Survey.WorkCountyId=WorkCounty.Id
			left join (select distinct Id, Description from dbo.Type where ParentId='63C6B6E3-A643-4365-89AF-7AD8925113F2') WorkSector
			on Survey.WorkSectorId=WorkSector.Id
			left join (select distinct Id, Description from dbo.Type where ParentId='4403CB82-2C79-4002-9512-7D1B55E865AD') WorkPeriod
			on Survey.WorkPeriodId=WorkPeriod.Id			
			where b.CityId=City.Id
			and d.CustomerId='98C90682-417B-4C1C-A1E3-002C6B5EB6FE') t1) t2
	group by CustomerId, CustomerTransactionId, Score, ApplyId, ApplyTime, TransTime, Age, Gender, Income, CityName, Profes, Profes_2, WorkName, 
	WorkCity, WorkCounty, WorkSector, WorkPeriod, AppStat) t3

	left join
	(select a.Id BankdOfferId, a.CustomerApplyId, a.StatusDateTime BankStatusTime, b.Name BankName, c.Description BankStatus
	from dbo.BankOffer a, dbo.Bank b, dbo.Type c 
	where a.BankId=b.Id
	and a.StatusTypeId=c.Id) t4
	on t3.ApplyId=t4.CustomerApplyId

	order by TransTime desc



	left join (select * from dbo._tckn) Burak
			on d.CustomerId=Burak.customerId
	d.CustomerId in (select customerId from dbo._tckn)
	d.CustomerId='67829F9D-FFC3-431B-B5D7-DD69D9B7129B'