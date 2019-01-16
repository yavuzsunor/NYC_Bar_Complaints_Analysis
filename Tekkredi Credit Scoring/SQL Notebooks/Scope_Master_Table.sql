	select * into dbo._ScopeMay16Feb17
	from
	(select t3.*, t4.*
	from
	(select CustomerId, Age, Gender, Education, HomeOwner, Income, CityName, Profes, Profes_2, WorkName, WorkCity, WorkCounty, WorkSector, WorkPeriod,
		TransTime, CustomerTransactionId, Score, ApplyId, ApplyTime, AppStat, 
		MIN(ApplyTime) OVER (PARTITION BY CustomerId) MinApplyTime, MAX(ApplyTime) OVER (PARTITION BY CustomerId) MaxApplyTime,
		MAX(CreditCreatedDate) MaxCreditDate,  
		sum(CreditLimit) TotLimit, sum(TotalDebt) TotDebt,
		avg(cast(Delq30day6mon as numeric(20,5))) Avg30Delq6,
		avg(cast(Delq30day18mon as numeric(20,5))) Avg30Delq18,
		avg(cast(Delq60day6monPerOpen as numeric(20,5))) Avg60Delq6PerOpen,
		avg(cast(TotDebtActiveLoan3mon as numeric(20,5))) AvgDebtAct3,
		avg(cast(LimitActiveLoan3mon as numeric(20,5))) AvgLimitAct3,
		avg(cast(MonOnTimeKK3mon as numeric(20,5))) AvgMonTimeKK3,
		avg(cast(Delq90dayOD6mon as numeric(20,5))) Avg90Delq6ODOpen,  
		avg(cast(Delq90day3mon as numeric(20,5))) AvgDelq3,
		avg(cast(Delq90day6mon as numeric(20,5))) AvgDelq6, 
		avg(cast(Delq90day9mon as numeric(20,5))) AvgDelq9,
		avg(cast(Delq90day12mon as numeric(20,5))) AvgDelq12,
		avg(cast(Delq90day15mon as numeric(20,5))) AvgDelq15,
		avg(cast(Delq90day18mon as numeric(20,5))) AvgDelq18
		 
		from	
			(select 
			
			/*30 day delinquent in last 6 months */
			case when len(PerformanceNew)>=6 then
			(case when LineStatus='Open' then len(LEFT(PerformanceNew,6)) -len(replace(LEFT(PerformanceNew,6),'1',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=6 then null
			when LineStatus='Closed' and DiffApplyClosedDate <6 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 6-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 6-DiffApplyClosedDate),'1','')) end)
			else null end Delq30day6mon,

			/*30 day delinquent in last 18 months */
			case when len(PerformanceNew)>=18 then
			(case when LineStatus='Open' then len(LEFT(PerformanceNew,18)) -len(replace(LEFT(PerformanceNew,18),'1',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=18 then null
			when LineStatus='Closed' and DiffApplyClosedDate <18 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 18-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 18-DiffApplyClosedDate),'1','')) end)
			else null end Delq30day18mon,

			/*60 day delinquent in last 6 months Open Personal Loan */
			case when len(PerformanceNew)>=6 and CredType='İhtiyaç Kredisi' and LineStatus='Open' then
			(case when LineStatus='Open' then len(LEFT(PerformanceNew,6)) -len(replace(LEFT(PerformanceNew,6),'2',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=6 then null
			when LineStatus='Closed' and DiffApplyClosedDate <6 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 6-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 6-DiffApplyClosedDate),'2','')) end)
			else null end Delq60day6monPerOpen,

			/*Active Loan Flag in last 3 months */
			case when LineStatus='Closed' and DiffApplyClosedDate <= 3 then 1
			when LineStatus='Open' then 1
			else 0 end ActiveLoan3mon,

			/*Total Debt with ActiveLoan3mon */
			case when (LineStatus='Closed' and DiffApplyClosedDate <= 3) or LineStatus='Open'
			then TotalDebt else NULL end TotDebtActiveLoan3mon,

			/*Credit Limit with ActiveLoan3mon */
			case when (LineStatus='Closed' and DiffApplyClosedDate <= 3) or LineStatus='Open'
			then CreditLimit else NULL end LimitActiveLoan3mon,

			/*Number of months on time in last 3 months */	
			case when len(PerformanceNew)>=3 then
			(case when LineStatus='Open' then len(LEFT(PerformanceNew,3)) -len(replace(LEFT(PerformanceNew,3),'0',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=3 then null
			when LineStatus='Closed' and DiffApplyClosedDate <3 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 3-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 3-DiffApplyClosedDate),'0','')) end)
			else null end MonOnTime3mon,

			/*Number of months on time for Credit Card in last 3 months */	
			case when len(PerformanceNew)>=3 and CredType='Kredi Kartı' then
			(case when LineStatus='Open' then len(LEFT(PerformanceNew,3)) -len(replace(LEFT(PerformanceNew,3),'0',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=3 then null
			when LineStatus='Closed' and DiffApplyClosedDate <3 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 3-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 3-DiffApplyClosedDate),'0','')) end)
			else null end MonOnTimeKK3mon,
			
			/*90 day delinquent for Overdraft in last 6 months */
			case when len(PerformanceNew)>=6 and CredType='Kredili Mevduat Hesabı' then
			(case when LineStatus='Open' then len(LEFT(PerformanceNew,6)) -len(replace(LEFT(PerformanceNew,6),'3',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=6 then null
			when LineStatus='Closed' and DiffApplyClosedDate <6 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 6-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 6-DiffApplyClosedDate),'3','')) end)
			else null end Delq90dayOD6mon,

			/*3 months Performance */
			case when len(PerformanceNew)>=3 then
			(case when LineStatus='Open' then len(LEFT(PerformanceNew,3)) -len(replace(LEFT(PerformanceNew,3),'3',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=3 then null
			when LineStatus='Closed' and DiffApplyClosedDate <3 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 3-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 3-DiffApplyClosedDate),'3','')) end +
		
			case when LineStatus='Open' then len(LEFT(PerformanceNew,3)) -len(replace(LEFT(PerformanceNew,3),'K',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=3 then null
			when LineStatus='Closed' and DiffApplyClosedDate <3 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 3-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 3-DiffApplyClosedDate),'K','')) end +

			case when LineStatus='Open' then len(LEFT(PerformanceNew,3)) -len(replace(LEFT(PerformanceNew,3),'I',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=3 then null
			when LineStatus='Closed' and DiffApplyClosedDate <3 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 3-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 3-DiffApplyClosedDate),'I','')) end)
			else null end Delq90day3mon,
		
			/*6 months Performance */
			case when len(PerformanceNew)>=6 then
			(case when LineStatus='Open' then len(LEFT(PerformanceNew,6)) -len(replace(LEFT(PerformanceNew,6),'3',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=6 then null
			when LineStatus='Closed' and DiffApplyClosedDate <6 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 6-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 6-DiffApplyClosedDate),'3','')) end +

			case when LineStatus='Open' then len(LEFT(PerformanceNew,6)) -len(replace(LEFT(PerformanceNew,6),'K',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=6 then null
			when LineStatus='Closed' and DiffApplyClosedDate <6 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 6-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 6-DiffApplyClosedDate),'K','')) end +

			case when LineStatus='Open' then len(LEFT(PerformanceNew,6)) -len(replace(LEFT(PerformanceNew,6),'I',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=6 then null
			when LineStatus='Closed' and DiffApplyClosedDate <6 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 6-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 6-DiffApplyClosedDate),'I','')) end)
			else null end Delq90day6mon,

			/*9 months Performance */
			case when len(PerformanceNew)>=9 then
			(case when LineStatus='Open' then len(LEFT(PerformanceNew,9)) -len(replace(LEFT(PerformanceNew,9),'3',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=9 then null
			when LineStatus='Closed' and DiffApplyClosedDate <9 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 9-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 9-DiffApplyClosedDate),'3','')) end +
			
			case when LineStatus='Open' then len(LEFT(PerformanceNew,9)) -len(replace(LEFT(PerformanceNew,9),'K',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=9 then null
			when LineStatus='Closed' and DiffApplyClosedDate <9 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 9-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 9-DiffApplyClosedDate),'K','')) end +

			case when LineStatus='Open' then len(LEFT(PerformanceNew,9)) -len(replace(LEFT(PerformanceNew,9),'I',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=9 then null
			when LineStatus='Closed' and DiffApplyClosedDate <9 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 9-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 9-DiffApplyClosedDate),'I','')) end)
			else null end Delq90day9mon,
		
			/*12 months Performance */
			case when len(PerformanceNew)>=12 then 
			(case when LineStatus='Open' then len(LEFT(PerformanceNew,12)) -len(replace(LEFT(PerformanceNew,12),'3',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=12 then null
			when LineStatus='Closed' and DiffApplyClosedDate <12 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 12-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 12-DiffApplyClosedDate),'3','')) end +
			
			case when LineStatus='Open' then len(LEFT(PerformanceNew,12)) -len(replace(LEFT(PerformanceNew,12),'K',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=12 then null
			when LineStatus='Closed' and DiffApplyClosedDate <12 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 12-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 12-DiffApplyClosedDate),'K','')) end +

			case when LineStatus='Open' then len(LEFT(PerformanceNew,12)) -len(replace(LEFT(PerformanceNew,12),'I',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=12 then null
			when LineStatus='Closed' and DiffApplyClosedDate <12 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 12-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 12-DiffApplyClosedDate),'I','')) end)
			else null end Delq90day12mon,

			/*15 months Performance */
			case when len(PerformanceNew)>=15 then 
			(case when LineStatus='Open' then len(LEFT(PerformanceNew,15)) -len(replace(LEFT(PerformanceNew,15),'3',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=15 then null
			when LineStatus='Closed' and DiffApplyClosedDate <15 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 15-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 15-DiffApplyClosedDate),'3','')) end +
			
			case when LineStatus='Open' then len(LEFT(PerformanceNew,15)) -len(replace(LEFT(PerformanceNew,15),'K',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=15 then null
			when LineStatus='Closed' and DiffApplyClosedDate <15 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 15-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 15-DiffApplyClosedDate),'K','')) end +

			case when LineStatus='Open' then len(LEFT(PerformanceNew,15)) -len(replace(LEFT(PerformanceNew,15),'I',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=15 then null
			when LineStatus='Closed' and DiffApplyClosedDate <15 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 15-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 15-DiffApplyClosedDate),'I','')) end)
			else null end Delq90day15mon,
		
			/*18 months Performance */
			case when len(PerformanceNew)>=18 then 
			(case when LineStatus='Open' then len(LEFT(PerformanceNew,18)) -len(replace(LEFT(PerformanceNew,18),'3',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=18 then null
			when LineStatus='Closed' and DiffApplyClosedDate <18 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 18-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 18-DiffApplyClosedDate),'3','')) end +
		
			case when LineStatus='Open' then len(LEFT(PerformanceNew,18)) -len(replace(LEFT(PerformanceNew,18),'K',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=18 then null
			when LineStatus='Closed' and DiffApplyClosedDate <18 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 18-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 18-DiffApplyClosedDate),'K','')) end +

			case when LineStatus='Open' then len(LEFT(PerformanceNew,18)) -len(replace(LEFT(PerformanceNew,18),'I',''))
			when LineStatus='Closed' and DiffApplyClosedDate >=18 then null
			when LineStatus='Closed' and DiffApplyClosedDate <18 and DiffApplyClosedDate >=0  
			then len(LEFT(PerformanceNew, 18-DiffApplyClosedDate)) - len(replace(LEFT(PerformanceNew, 18-DiffApplyClosedDate),'I','')) end)
			else null end Delq90day18mon,
		
			t1.*
			from
				(select d.CustomerId, DATEDIFF(year, Cust.BirthDate, GETDATE()) Age, Gender.Description Gender, 
				Education.Description Education, HomeOwner.Description HomeOwner, (b.MinPayrollIncome+b.MaxPayrollIncome )/2 Income,
				City.Name CityName, Profes.Description Profes, Profes_2.Description Profes_2, Survey.WorkName, WorkCity.Name WorkCity, WorkCounty.Name WorkCounty,
				WorkSector.Description WorkSector, WorkPeriod.Description WorkPeriod, d.Score, b.Id ApplyId, b.CreatedDateTime ApplyTime, 
				AppStat.Description AppStat, d.CreatedDateTime TransTime, 
				case when CreditEndDate is not null then DATEDIFF(month,a.CreditEndDate, b.CreatedDateTime) else null end DiffApplyClosedDate,
				case when CreditCreatedDate is not null then DATEDIFF(month,a.CreditCreatedDate, b.CreatedDateTime) else null end DiffApplyOpenedDate,
				CredType.Description CredType, rtrim(ltrim(a.Performance)) PerformanceNew, 
				case when CreditEndDate is null then 'Open' else 'Closed' end LineStatus,
				a.*
				from 			  
				dbo.CustomerTransactionBank a 
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
				left join (select distinct Id, Description from dbo.Type where ParentId='B3F0BA58-284C-4A7D-8001-41BBA98A05BA') Education
				on Survey.EducationId=Education.Id
				left join (select distinct Id, Description from dbo.Type where ParentId='B05B5386-B1C3-44DC-83A5-B9B7EE52F254') HomeOwner
				on Survey.HomeOwnerId=HomeOwner.Id
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
				left join dbo.City City 
				on b.CityId=City.Id 
				where d.CustomerId in (select distinct Cust.Id CustId
									   from dbo.Customer Cust, dbo.CustomerTransaction Trans
									   left join dbo.CustomerApply App
									   on Trans.Id=App.CustomerTransactionId
									   where Cust.Id=Trans.CustomerId
									   and App.CreatedDateTime between '2016-05-01' and '2017-02-28')  
				) t1) t2
		group by CustomerId, CustomerTransactionId, Score, ApplyId, ApplyTime, TransTime, Age, Gender, Income, Education, HomeOwner,
		CityName, Profes, Profes_2, WorkName, WorkCity, WorkCounty, WorkSector, WorkPeriod, AppStat) t3

		left join
		(select a.Id BankdOfferId, a.CustomerApplyId, a.StatusDateTime BankStatusTime, b.Name BankName, c.Description BankStatus
		from dbo.BankOffer a, dbo.Bank b, dbo.Type c 
		where a.BankId=b.Id
		and a.StatusTypeId=c.Id) t4
		on t3.ApplyId=t4.CustomerApplyId

		) t5

	


	--where DATEDIFF(month, MinApplyTime, MaxApplyTime)>=6

	in (select distinct Cust.Id CustId
		from dbo.Customer Cust, dbo.CustomerTransaction Trans
		left join dbo.CustomerApply App
		on Trans.Id=App.CustomerTransactionId
		where Cust.Id=Trans.CustomerId
		and App.CreatedDateTime between '2016-05-01' and '2017-02-28')

		--BankQuoteGiven
		(select distinct d.CustomerId			
									   from dbo.BankOffer a, dbo.Bank b, dbo.Type c, dbo.CustomerApply d 
									   where a.BankId=b.Id
									   and a.StatusTypeId=c.Id
									   and a.CustomerApplyId=d.Id
									   and c.Description in ('Teklif Yapildi',
															 'Teklif Süresi Doldu',
															 'Kabul Edildi',
															 'Subeye Iletildi',
															 'Banka Iptal',
															 'Müsteri Iptal',
															 'Tamamlandi'))

	--deneme study
	select distinct a.CustomerId, b.CreditCreatedDate, c.CreatedDateTime
	from dbo.CustomerTransaction a, dbo.CustomerTransactionBank b, dbo.CustomerApply c
	where a.Id=b.CustomerTransactionId
	and a.Id=c.CustomerTransactionId	
	and c.CreatedDateTime<'2018-01-01'
	order by c.CreatedDateTime desc, b.CreditCreatedDate desc
	
	and a.CustomerId='87839371-7850-47EF-96D2-0009B9632291'

	and b.CreditCreatedDate>c.CreatedDateTime
	 
	a.CustomerId, a.Id TransId, a.CreatedDateTime TransTime, b.CreditCreatedDate, b.CreditEndDate, b.Performance, 
	c.Id ApplyId, c.CreatedDateTime ApplyTime