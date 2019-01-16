select cust.Id CustomerId, job.Period, cast(REPLACE(REPLACE(job.Payroll_Income, '.', ''), ',', '.') as numeric(18,2)) Payroll_Income
into dbo.JobStudy
from dbo.x_job_info job, dbo.Customer cust
where job.Security_Number = cust.SecurityNumber
and Payroll_Income <> 'Kayıt Bulunamadı'

select t.*, 
	  ((case when Jan15 ='' then 0 else 1 end)+(case when Feb15 ='' then 0 else 1 end)+(case when Mar15 ='' then 0 else 1 end)+
	   (case when Apr15 ='' then 0 else 1 end)+(case when May15 ='' then 0 else 1 end)+(case when Jun15 ='' then 0 else 1 end)+
	   (case when Jul15 ='' then 0 else 1 end)+(case when Aug15 ='' then 0 else 1 end)+(case when Sep15 ='' then 0 else 1 end)+
	   (case when Oct15 ='' then 0 else 1 end)+(case when Nov15 ='' then 0 else 1 end)+(case when Dec15 ='' then 0 else 1 end)+
	   (case when Jan16 ='' then 0 else 1 end)+(case when Feb16 ='' then 0 else 1 end)+(case when Mar16 ='' then 0 else 1 end)+
	   (case when Apr16 ='' then 0 else 1 end)+(case when May16 ='' then 0 else 1 end)+(case when Jun16 ='' then 0 else 1 end)+
	   (case when Jul16 ='' then 0 else 1 end)+(case when Aug16 ='' then 0 else 1 end)+(case when Sep16 ='' then 0 else 1 end)+
	   (case when Oct16 ='' then 0 else 1 end)+(case when Nov16 ='' then 0 else 1 end)+(case when Dec16 ='' then 0 else 1 end)) Occp
into dbo.IncomeTable
from
	(select CustomerId,
	REPLACE(max(case when Period='01/2015' then log(Payroll_Income+1) else -1 end), -1, '') Jan15,
	REPLACE(max(case when Period='02/2015' then log(Payroll_Income+1) else -1 end), -1, '') Feb15,
	REPLACE(max(case when Period='03/2015' then log(Payroll_Income+1) else -1 end), -1, '') Mar15,
	REPLACE(max(case when Period='04/2015' then log(Payroll_Income+1) else -1 end), -1, '') Apr15,
	REPLACE(max(case when Period='05/2015' then log(Payroll_Income+1) else -1 end), -1, '') May15,
	REPLACE(max(case when Period='06/2015' then log(Payroll_Income+1) else -1 end), -1, '') Jun15,
	REPLACE(max(case when Period='07/2015' then log(Payroll_Income+1) else -1 end), -1, '') Jul15,
	REPLACE(max(case when Period='08/2015' then log(Payroll_Income+1) else -1 end), -1, '') Aug15,
	REPLACE(max(case when Period='09/2015' then log(Payroll_Income+1) else -1 end), -1, '') Sep15,
	REPLACE(max(case when Period='10/2015' then log(Payroll_Income+1) else -1 end), -1, '') Oct15,
	REPLACE(max(case when Period='11/2015' then log(Payroll_Income+1) else -1 end), -1, '') Nov15,
	REPLACE(max(case when Period='12/2015' then log(Payroll_Income+1) else -1 end), -1, '') Dec15,
	REPLACE(max(case when Period='01/2016' then log(Payroll_Income+1) else -1 end), -1, '') Jan16,
	REPLACE(max(case when Period='02/2016' then log(Payroll_Income+1) else -1 end), -1, '') Feb16,
	REPLACE(max(case when Period='03/2016' then log(Payroll_Income+1) else -1 end), -1, '') Mar16,
	REPLACE(max(case when Period='04/2016' then log(Payroll_Income+1) else -1 end), -1, '') Apr16,
	REPLACE(max(case when Period='05/2016' then log(Payroll_Income+1) else -1 end), -1, '') May16,
	REPLACE(max(case when Period='06/2016' then log(Payroll_Income+1) else -1 end), -1, '') Jun16,
	REPLACE(max(case when Period='07/2016' then log(Payroll_Income+1) else -1 end), -1, '') Jul16,
	REPLACE(max(case when Period='08/2016' then log(Payroll_Income+1) else -1 end), -1, '') Aug16,
	REPLACE(max(case when Period='09/2016' then log(Payroll_Income+1) else -1 end), -1, '') Sep16,
	REPLACE(max(case when Period='10/2016' then log(Payroll_Income+1) else -1 end), -1, '') Oct16,
	REPLACE(max(case when Period='11/2016' then log(Payroll_Income+1) else -1 end), -1, '') Nov16,
	REPLACE(max(case when Period='12/2016' then log(Payroll_Income+1) else -1 end), -1, '') Dec16
	from dbo.JobStudy
	group by CustomerId
	) t





select *
from dbo.x_job_info

select *
from dbo.JobStudy
where CustomerId = 'CBA47D61-03E7-4154-8A3F-AAAD9F8699E2'



select CustomerId,
REPLACE(max(case when ApplyDate='201409' then log(Income+1) else -1 end), -1, '') Sep14,
REPLACE(max(case when ApplyDate='201410' then log(Income+1) else -1 end), -1, '') Oct14,
REPLACE(max(case when ApplyDate='201411' then log(Income+1) else -1 end), -1, '') Nov14,
REPLACE(max(case when ApplyDate='201412' then log(Income+1) else -1 end), -1, '') Dec14,
REPLACE(max(case when ApplyDate='201501' then log(Income+1) else -1 end), -1, '') Jan15,
REPLACE(max(case when ApplyDate='201502' then log(Income+1) else -1 end), -1, '') Feb15,
REPLACE(max(case when ApplyDate='201503' then log(Income+1) else -1 end), -1, '') Mar15,
REPLACE(max(case when ApplyDate='201504' then log(Income+1) else -1 end), -1, '') Apr15,
REPLACE(max(case when ApplyDate='201505' then log(Income+1) else -1 end), -1, '') May15,
REPLACE(max(case when ApplyDate='201506' then log(Income+1) else -1 end), -1, '') Jun15,
REPLACE(max(case when ApplyDate='201507' then log(Income+1) else -1 end), -1, '') Jul15,
REPLACE(max(case when ApplyDate='201508' then log(Income+1) else -1 end), -1, '') Aug15,
REPLACE(max(case when ApplyDate='201509' then log(Income+1) else -1 end), -1, '') Sep15,
REPLACE(max(case when ApplyDate='201510' then log(Income+1) else -1 end), -1, '') Oct15,
REPLACE(max(case when ApplyDate='201511' then log(Income+1) else -1 end), -1, '') Nov15,
REPLACE(max(case when ApplyDate='201512' then log(Income+1) else -1 end), -1, '') Dec15,
REPLACE(max(case when ApplyDate='201601' then log(Income+1) else -1 end), -1, '') Jan16,
REPLACE(max(case when ApplyDate='201602' then log(Income+1) else -1 end), -1, '') Feb16,
REPLACE(max(case when ApplyDate='201603' then log(Income+1) else -1 end), -1, '') Mar16,
REPLACE(max(case when ApplyDate='201604' then log(Income+1) else -1 end), -1, '') Apr16,
REPLACE(max(case when ApplyDate='201605' then log(Income+1) else -1 end), -1, '') May16,
REPLACE(max(case when ApplyDate='201606' then log(Income+1) else -1 end), -1, '') Jun16,
REPLACE(max(case when ApplyDate='201607' then log(Income+1) else -1 end), -1, '') Jul16,
REPLACE(max(case when ApplyDate='201608' then log(Income+1) else -1 end), -1, '') Aug16,
REPLACE(max(case when ApplyDate='201609' then log(Income+1) else -1 end), -1, '') Sep16,
REPLACE(max(case when ApplyDate='201610' then log(Income+1) else -1 end), -1, '') Oct16,
REPLACE(max(case when ApplyDate='201611' then log(Income+1) else -1 end), -1, '') Nov16,
REPLACE(max(case when ApplyDate='201612' then log(Income+1) else -1 end), -1, '') Dec16,
REPLACE(max(case when ApplyDate='201701' then log(Income+1) else -1 end), -1, '') Jan17,
REPLACE(max(case when ApplyDate='201702' then log(Income+1) else -1 end), -1, '') Feb17,
REPLACE(max(case when ApplyDate='201703' then log(Income+1) else -1 end), -1, '') Mar17,
REPLACE(max(case when ApplyDate='201704' then log(Income+1) else -1 end), -1, '') Apr17,
REPLACE(max(case when ApplyDate='201705' then log(Income+1) else -1 end), -1, '') May17,
REPLACE(max(case when ApplyDate='201706' then log(Income+1) else -1 end), -1, '') Jun17,
REPLACE(max(case when ApplyDate='201707' then log(Income+1) else -1 end), -1, '') Jul17,
REPLACE(max(case when ApplyDate='201708' then log(Income+1) else -1 end), -1, '') Aug17,
REPLACE(max(case when ApplyDate='201709' then log(Income+1) else -1 end), -1, '') Sep17,
REPLACE(max(case when ApplyDate='201710' then log(Income+1) else -1 end), -1, '') Oct17,
REPLACE(max(case when ApplyDate='201711' then log(Income+1) else -1 end), -1, '') Nov17,
REPLACE(max(case when ApplyDate='201712' then log(Income+1) else -1 end), -1, '') Dec17,
REPLACE(max(case when ApplyDate='201801' then log(Income+1) else -1 end), -1, '') Jan18,
REPLACE(max(case when ApplyDate='201802' then log(Income+1) else -1 end), -1, '') Feb18,
REPLACE(max(case when ApplyDate='201803' then log(Income+1) else -1 end), -1, '') Mar18,
REPLACE(max(case when ApplyDate='201804' then log(Income+1) else -1 end), -1, '') Apr18,
REPLACE(max(case when ApplyDate='201805' then log(Income+1) else -1 end), -1, '') May18
into dbo.IncomeApply
from
	(select CustomerId, concat(DATEPART(YYYY, CreatedDateTime), RIGHT('0'+CAST(MONTH(CreatedDateTime) AS varchar(2)),2)) ApplyDate, 
	(MinPayrollIncome + MaxPayrollIncome)/2 Income
	from dbo.CustomerApply
	) t
group by CustomerId


select a.CustomerId,
Sep14, Oct14, Nov14, Dec14,

a.Jan15, b.Jan15 Jan15b, a.Feb15, b.Feb15 Feb15b, a.Mar15, b.Mar15 Mar15b, a.Apr15, b.Apr15 Apr15b, a.May15, b.May15 May15b, a.Jun15, b.Jun15 Jun15b,
a.Jul15, b.Jul15 Jul15b, a.Aug15, b.Aug15 Aug15b, a.Sep15, b.Sep15 Sep15b, a.Oct15, b.Oct15 Oct15b, a.Nov15, b.Nov15 Nov15b, a.Dec15, b.Dec15 Dec15b, 

a.Jan16, b.Jan16 Jan16b, a.Feb16, b.Feb16 Feb16b, a.Mar16, b.Mar16 Mar16b, a.Apr16, b.Apr16 Apr16b, a.May16, b.May16 May16b, a.Jun16, b.Jun16 Jun16b,
a.Jul16, b.Jul16 Jul16b, a.Aug16, b.Aug16 Aug16b, a.Sep16, b.Sep16 Sep16b, a.Oct16, b.Oct16 Oct16b, a.Nov16, b.Nov16 Nov16b, a.Dec16, b.Dec16 Dec16b,

Jan17, Feb17, Mar17, Apr17, May17, Jun17, Jul17, Aug17, Sep17, Oct17, Nov17, Dec17,

Jan18, Feb18, Mar18, Apr18, May18
into dbo.IncomeFull
from dbo.IncomeApply a
left join dbo.IncomeTable b
on a.CustomerId = b.CustomerId 




