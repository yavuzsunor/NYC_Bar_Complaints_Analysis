select c.Id ApplyId, c.CustomerId, b.Id CtId, a.Id CtbId, a.RegisterReferenceNo,
c.CreatedDateTime ApplyTime, a.CreatedDateTime CtbTime, DATEDIFF(DAY, c.CreatedDateTime, a.CreatedDateTime) Diff,
a.TotalDebt, a.Installment, a.Interest
from dbo.CustomerTransactionBank a, dbo.CustomerTransaction b, dbo.CustomerApply c
where a.CustomerTransactionId = b.Id
and b.CustomerId = c.CustomerId
and c.Id = '62D1C531-B561-4108-AF8E-145D5D08FB64'
and a.RegisterReferenceNo = '2892201645466E'


		select c.Id ApplyId, a.RegisterReferenceNo, a.CreditCreatedDate, a.CreditEndDate, a.Installment, a.Interest, a.CreditLimit, a.TotalDebt
		from dbo.CustomerTransactionBank a, dbo.CustomerTransaction b, dbo.CustomerApply c,
			(select RegisterReferenceNo, min(ABS(DATEDIFF(DAY, c.CreatedDateTime, a.CreatedDateTime))) Diff
			from dbo.CustomerTransactionBank a, dbo.CustomerTransaction b, dbo.CustomerApply c
			where a.CustomerTransactionId = b.Id
			and b.CustomerId = c.CustomerId
			and a.RegisterReferenceNo = '2892201645466E'
			group by a.RegisterReferenceNo) ctb_first
		where a.CustomerTransactionId = b.Id
		and b.CustomerId = c.CustomerId
		and a.RegisterReferenceNo = ctb_first.RegisterReferenceNo
		and DATEDIFF(DAY, c.CreatedDateTime, a.CreatedDateTime) = ctb_first.Diff
		and c.Id= '62D1C531-B561-4108-AF8E-145D5D08FB64'

		select *
		from dbo.CustomerTransactionBank
		where RegisterReferenceNo = '2892201645466E'
				
		select *
		from dbo.CustomerTransactionSummary
		where ReferenceNo = '2892201645466E'

		'9083998095179J'

select *
from dbo.CustomerTransactionBank
where RegisterReferenceNo = '2292738113250B'


select *
from dbo.CustomerTransactionSummary
where ReferenceNo = '2292738113250B'


/*old version*/
(select a.RegisterReferenceNo, a.Installment, a.Interest, a.TotalDebt
from dbo.CustomerTransactionBank a,	
	(select RegisterReferenceNo, max(CreatedDateTime) MaxTime
	from dbo.CustomerTransactionBank
	group by RegisterReferenceNo) ctb_first
where a.RegisterReferenceNo = ctb_first.RegisterReferenceNo
and a.CreatedDateTime = ctb_first.MaxTime) ctb,

/*bottom condition*/ and cts.ReferenceNo = ctb.RegisterReferenceNo


/*sampling*/
select count(a.Id)
from dbo.CustomerApply a 
where DATEPART(YEAR, a.CreatedDateTime) = 2018
and a.CustomerTransactionId = b.Id


select distinct ApplyId
from dbo.Apply_2018
where ApplyTime > DATEADD(month, -2, StartDate) and ApplyTime < StartDate
and LEN(CredPerf) >= 12
and ((cast(cast(LEN(REPLACE(REPLACE(CredPerf, 'X', ''), 'Z', '')) as float) / NULLIF(cast(LEN(CredPerf) as float), 0) as numeric(18,2)) > 0.5 and CredPerf NOT LIKE '%K%') or (CredPerf LIKE '%K%') or (CredPerf LIKE '%I%') or (CredPerf LIKE '%3%'))
and LEFT(CredPerf, 1) <> 'K' and LEFT(CredPerf, 1) <> 'I'

select b.CreditCreatedDate, c.StartDate,  a.*
from dbo.Apply_2015 a, dbo.CustomerTransactionBank b, dbo.CustomerTransactionSummary c
where a.ReferenceNo = b.RegisterReferenceNo
and a.ReferenceNo = c.ReferenceNo


select a.*, b.CreditCreatedDate, c.StartDate CTS_Start
from	
	(select distinct ApplyId, ApplyTime, CustomerId, ReferenceNo, StartDate, EndDate
	from dbo.Apply_2018
	) a,
dbo.CustomerTransactionBank b, dbo.CustomerTransactionSummary c
where a.ReferenceNo = b.RegisterReferenceNo
and a.ReferenceNo = c.ReferenceNo
and  ApplyTime > DATEADD(month, -2, a.StartDate) and ApplyTime < a.StartDate


select c.Id, c.CustomerId, a.RegisterReferenceNo, c.CreatedDateTime ApplyTime, a.CreatedDateTime TransTime, a.CreditCreatedDate CreditStartDate
from dbo.CustomerTransactionBank a, dbo.CustomerTransaction b, dbo.CustomerApply c
where a.CustomerTransactionId = b.Id
and b.CustomerId = c.CustomerId
and a.RegisterReferenceNo = '7209923669091G'


select a.CustomerTransactionId TransId, c.Id ApplyId, RegisterReferenceNo, c.CreatedDateTime ApplyTime, a.CreatedDateTime TransTime, 
a.CreditCreatedDate CreditDate, a.Installment, a.Interest, a.CreditLimit, a.TotalDebt, 
ABS(DATEDIFF(DAY, c.CreatedDateTime, a.CreatedDateTime)) Diff
from dbo.CustomerTransactionBank a, dbo.CustomerTransaction b, dbo.CustomerApply c
where a.CustomerTransactionId = b.Id
and b.CustomerId = c.CustomerId
and RegisterReferenceNo = '7209923669091G'
group by a.RegisterReferenceNo


select top 10 *
from dbo.CustomerApply



SELECT ca.Id, ca.CreatedDateTime, ca.TotalAmount, ctb.RegisterReferenceNo, ctb.CreditCreatedDate, ctb.CreditEndDate, ctb.TotalDebt
from CustomerApply ca
INNER JOIN CustomerTransaction ct on ct.Id=ca.CustomerTransactionId
INNER JOIN CustomerTransactionBank ctb on ctb.CustomerTransactionId=ct.Id
where ca.Id IN ('5835AB4B-F8EF-4FB8-84F0-F7D2330F79BD','FD882736-CC2A-44CE-A704-C9F8200E40E2')
order by ca.CreatedDateTime, ctb.RegisterReferenceNo


select top 10 *
from dbo.CustomerTransactionBank


(select c.Id ApplyId, a.RegisterReferenceNo, a. CreditCreatedDate, a.Installment, a.Interest, a.CreditLimit, a.TotalDebt
		from dbo.CustomerTransactionBank a, dbo.CustomerTransaction b, dbo.CustomerApply c,
			(select RegisterReferenceNo, min(ABS(DATEDIFF(DAY, c.CreatedDateTime, a.CreatedDateTime))) Diff
			from dbo.CustomerTransactionBank a, dbo.CustomerTransaction b, dbo.CustomerApply c
			where a.CustomerTransactionId = b.Id
			and b.CustomerId = c.CustomerId
			group by a.RegisterReferenceNo) ctb_first
		where a.CustomerTransactionId = b.Id
		and b.CustomerId = c.CustomerId
		and a.RegisterReferenceNo = ctb_first.RegisterReferenceNo
		and DATEDIFF(DAY, c.CreatedDateTime, a.CreatedDateTime) = ctb_first.Diff) ctb,

select CustomerTransactionId
from dbo.CustomerApply
where Id = 'FD882736-CC2A-44CE-A704-C9F8200E40E2'

select *
from dbo.CustomerTransactionBank
where CustomerTransactionId = '209B25E4-738C-4745-A869-E631B038F356'


select DATEPART(YEAR,ca.CreatedDateTime) Term, count(ca.Id) #ofApplyId
from dbo.CustomerApply ca
group by DATEPART(YEAR,ca.CreatedDateTime)
order by DATEPART(YEAR,ca.CreatedDateTime)

select DATEPART(YEAR,ca.CreatedDateTime) Term, count(ca.Id) #ofApplyId 
from dbo.CustomerApply ca, dbo.Customer c, dbo.CustomerTransaction ct
where ca.CustomerId = c.Id
and ca.CustomerTransactionId = ct.Id
group by DATEPART(YEAR,ca.CreatedDateTime)
order by DATEPART(YEAR,ca.CreatedDateTime)


select count(distinct ApplyId) 
from
	(select t2.*, 
	LEN(CredPerf) CredMon2, cast(cast(LEN(REPLACE(REPLACE(CredPerf, 'X', ''), 'Z', '')) as float) / NULLIF(cast(LEN(CredPerf) as float), 0) as numeric(18,2)) Occp
	from
		(select t.*,
		case when EndDate is not NULL then
				LEFT(RIGHT(LEFT(Performance, DATEDIFF(month, '2010-01-01', GETDATE())), 
					case when DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) < 0 then 0
					else DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) end), DATEDIFF(month, StartDate, EndDate))
				else RIGHT(LEFT(Performance, DATEDIFF(month, '2010-01-01', GETDATE())), 
					case when DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) < 0 then 0
					else DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) end) end CredPerf,
				DATEDIFF(month, StartDate, EndDate) CredMon
		from
			(select ca.Id ApplyId, ca.CreatedDateTime ApplyTime, ca.CustomerId, cts.ReferenceNo, cts.StartDate, cts.EndDate,
			cts.Year10 + cts.Year11 + cts.Year12 + cts.Year13 + cts.Year14 + cts.Year15 + cts.Year16 + cts.Year17 + cts.Year18 + cts.Year19 Performance 
			from dbo.CustomerApply ca, dbo.Customer c, dbo.CustomerTransaction ct, dbo.CustomerTransactionSummary cts
			where ca.CustomerId = c.Id
			and ca.CustomerTransactionId = ct.Id
			and c.Id = cts.CustomerId
			and DATEPART(YEAR, ca.CreatedDateTime) = '2018') t 

		where EndDate >= StartDate or EndDate is NULL) t2 ) t3
where ApplyTime > DATEADD(month, -2, StartDate) and ApplyTime < StartDate
and LEN(CredPerf) >= 12
and ((Occp > 0.5 and CredPerf NOT LIKE '%K%') or (CredPerf LIKE '%K%') or (CredPerf LIKE '%I%') or (CredPerf LIKE '%3%'))
and LEFT(CredPerf, 1) <> 'K' and LEFT(CredPerf, 1) <> 'I'

group by ApplyId

where ApplyTime > DATEADD(month, -2, StartDate) and ApplyTime < StartDate

max(case when ApplyTime > DATEADD(month, -2, StartDate) and ApplyTime < StartDate then 1 else 0 end) Month2Flag,
max(case when LEN(CredPerf) >= 12 then 1 else 0 end) Len12Flag,
max(case when Occp > 0.5 and CredPerf NOT LIKE '%K%' then 1 
		 when CredPerf LIKE '%K%' then 1 
		 when CredPerf LIKE '%I%' then 1  
		 when CredPerf LIKE '%3%' then 1 else 0 end) OccpFlag,
max(case when LEFT(CredPerf, 1) = 'K' then 0
		 when LEFT(CredPerf, 1) = 'I' then 0 else 1 end) KIFlag  



select t.*,
		case when EndDate is not NULL then
				LEFT(RIGHT(LEFT(Performance, DATEDIFF(month, '2010-01-01', GETDATE())), 
					case when DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) < 0 then 0
					else DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) end), DATEDIFF(month, StartDate, EndDate))
				else RIGHT(LEFT(Performance, DATEDIFF(month, '2010-01-01', GETDATE())), 
					case when DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) < 0 then 0
					else DATEDIFF(month, '2010-01-01', GETDATE()) - (DATEDIFF(month, '2010-01-01', StartDate)+1) end) end CredPerf,
				DATEDIFF(month, StartDate, EndDate) CredMon
into dbo.Apply_2016Pre		
		from
			(select ca.Id ApplyId, ca.CustomerTransactionId, ca.CreatedDateTime ApplyTime, ca.CustomerId, ct.Score, ctb.CreditLimit, ctb.TotalDebt,
			cts.ReferenceNo, cts.CreditTypeId, cts.StartDate, cts.EndDate,
			cts.Year10 + cts.Year11 + cts.Year12 + cts.Year13 + cts.Year14 + cts.Year15 + cts.Year16 + cts.Year17 + cts.Year18 + cts.Year19 Performance 
			from dbo.CustomerApply ca, dbo.Customer c, dbo.CustomerTransaction ct, dbo.CustomerTransactionSummary cts, dbo.CustomerTransactionBank ctb
			where ca.CustomerId = c.Id
			and ca.CustomerTransactionId = ct.Id
			and c.Id = cts.CustomerId
			and ca.CustomerTransactionId = ctb.CustomerTransactionId
			and cts.ReferenceNo = ctb.RegisterReferenceNo
			and DATEPART(YEAR, ca.CreatedDateTime) = '2016'
			) t 
where EndDate >= StartDate or EndDate is NULL



DECLARE @Constant VARCHAR(120) = 'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ'

select ApplyId, ApplyTime, CustomerId, Score, 

max(case when CreditType = 'İhtiyaç Kredisi' then CountActiveLoan else NULL end) ConsCountActiveLoan,
max(case when CreditType = 'İhtiyaç Kredisi' then CountLoan else NULL end) ConsCountLoan,
max(case when CreditType = 'Kredi Kartı' then CountActiveLoan else NULL end) CredCountActiveLoan,
max(case when CreditType = 'Kredi Kartı' then CountLoan else NULL end) CredCountLoan,
max(case when CreditType = 'Kredili Mevduat Hesabı' then CountActiveLoan else NULL end) ODCountActiveLoan,
max(case when CreditType = 'Kredili Mevduat Hesabı' then CountLoan else NULL end) ODCountLoan,
max(case when CreditType = 'Konut Kredisi' then CountActiveLoan else NULL end) MorgCountActiveLoan,
max(case when CreditType = 'Konut Kredisi' then CountLoan else NULL end) MorgCountLoan,
max(case when CreditType = 'Taşıt Kredisi' then CountActiveLoan else NULL end) CarCountActiveLoan,
max(case when CreditType = 'Taşıt Kredisi' then CountLoan else NULL end) CarCountLoan,

sum(SumLimitActive)/sum(CountActiveLoan*1.0) FullAvgLimitActive,
sum(SumLimit)/sum(CountLoan*1.0) FullAvgLimit,
max(case when CreditType = 'İhtiyaç Kredisi' then AvgLimitActive else NULL end) ConsAvgLimitActive,
max(case when CreditType = 'İhtiyaç Kredisi' then AvgLimit else NULL end) ConsAvgLimit,
max(case when CreditType = 'Kredi Kartı' then AvgLimitActive else NULL end) CredAvgLimitActive,
max(case when CreditType = 'Kredi Kartı' then AvgLimit else NULL end) CredAvgLimit,
max(case when CreditType = 'Kredili Mevduat Hesabı' then AvgLimitActive else NULL end) ODAvgLimitActive,
max(case when CreditType = 'Kredili Mevduat Hesabı' then AvgLimit else NULL end) ODAvgLimit,
max(case when CreditType = 'Konut Kredisi' then AvgLimitActive else NULL end) MorgAvgLimitActive,
max(case when CreditType = 'Konut Kredisi' then AvgLimit else NULL end) MorgAvgLimit,
max(case when CreditType = 'Taşıt Kredisi' then AvgLimitActive else NULL end) CarAvgLimitActive,
max(case when CreditType = 'Taşıt Kredisi' then AvgLimit else NULL end) CarAvgLimit,

sum(SumDebtActive)/sum(CountActiveLoan*1.0) FullAvgDebtActive,
sum(SumDebt)/sum(CountLoan*1.0) FullAvgDebt,
max(case when CreditType = 'İhtiyaç Kredisi' then AvgDebtActive else NULL end) ConsAvgDebtActive,
max(case when CreditType = 'İhtiyaç Kredisi' then AvgDebt else NULL end) ConsAvgDebt,
max(case when CreditType = 'Kredi Kartı' then AvgDebtActive else NULL end) CredAvgDebtActive,
max(case when CreditType = 'Kredi Kartı' then AvgDebt else NULL end) CredAvgDebt,
max(case when CreditType = 'Kredili Mevduat Hesabı' then AvgDebtActive else NULL end) ODAvgDebtActive,
max(case when CreditType = 'Kredili Mevduat Hesabı' then AvgDebt else NULL end) ODAvgDebt,
max(case when CreditType = 'Konut Kredisi' then AvgDebtActive else NULL end) MorgAvgDebtActive,
max(case when CreditType = 'Konut Kredisi' then AvgDebt else NULL end) MorgAvgDebt,
max(case when CreditType = 'Taşıt Kredisi' then AvgDebtActive else NULL end) CarAvgDebtActive,
max(case when CreditType = 'Taşıt Kredisi' then AvgDebt else NULL end) CarAvgDebt,

sum(Sum30Mon3Active*1.0)/sum(CountActiveLoan*1.0) FullAvg30Mon3Active,
sum(Sum30Mon3*1.0)/sum(CountLoan*1.0) FullAvg30Mon3,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg30Mon3Active else NULL end) ConsAvg30Mon3Active,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg30Mon3 else NULL end) ConsAvg30Mon3,
max(case when CreditType = 'Kredi Kartı' then Avg30Mon3Active else NULL end) CredAvg30Mon3Active,
max(case when CreditType = 'Kredi Kartı' then Avg30Mon3 else NULL end) CredAvg30Mon3,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg30Mon3Active else NULL end) ODAvg30Mon3Active,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg30Mon3 else NULL end) ODAvg30Mon3,
max(case when CreditType = 'Konut Kredisi' then Avg30Mon3Active else NULL end) MorgAvg30Mon3Active,
max(case when CreditType = 'Konut Kredisi' then Avg30Mon3 else NULL end) MorgAvg30Mon3,
max(case when CreditType = 'Taşıt Kredisi' then Avg30Mon3Active else NULL end) CarAvg30Mon3Active,
max(case when CreditType = 'Taşıt Kredisi' then Avg30Mon3 else NULL end) CarAvg30Mon3,

sum(Sum60Mon3Active*1.0)/sum(CountActiveLoan*1.0) FullAvg60Mon3Active,
sum(Sum60Mon3*1.0)/sum(CountLoan*1.0) FullAvg60Mon3,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg60Mon3Active else NULL end) ConsAvg60Mon3Active,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg60Mon3 else NULL end) ConsAvg60Mon3,
max(case when CreditType = 'Kredi Kartı' then Avg60Mon3Active else NULL end) CredAvg60Mon3Active,
max(case when CreditType = 'Kredi Kartı' then Avg60Mon3 else NULL end) CredAvg60Mon3,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg60Mon3Active else NULL end) ODAvg60Mon3Active,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg60Mon3 else NULL end) ODAvg60Mon3,
max(case when CreditType = 'Konut Kredisi' then Avg60Mon3Active else NULL end) MorgAvg60Mon3Active,
max(case when CreditType = 'Konut Kredisi' then Avg60Mon3 else NULL end) MorgAvg60Mon3,
max(case when CreditType = 'Taşıt Kredisi' then Avg60Mon3Active else NULL end) CarAvg60Mon3Active,
max(case when CreditType = 'Taşıt Kredisi' then Avg60Mon3 else NULL end) CarAvg60Mon3,

sum(Sum90Mon3Active*1.0)/sum(CountActiveLoan*1.0) FullAvg90Mon3Active,
sum(Sum90Mon3*1.0)/sum(CountLoan*1.0) FullAvg90Mon3,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg90Mon3Active else NULL end) ConsAvg90Mon3Active,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg90Mon3 else NULL end) ConsAvg90Mon3,
max(case when CreditType = 'Kredi Kartı' then Avg90Mon3Active else NULL end) CredAvg90Mon3Active,
max(case when CreditType = 'Kredi Kartı' then Avg90Mon3 else NULL end) CredAvg90Mon3,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg90Mon3Active else NULL end) ODAvg90Mon3Active,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg90Mon3 else NULL end) ODAvg90Mon3,
max(case when CreditType = 'Konut Kredisi' then Avg90Mon3Active else NULL end) MorgAvg90Mon3Active,
max(case when CreditType = 'Konut Kredisi' then Avg90Mon3 else NULL end) MorgAvg90Mon3,
max(case when CreditType = 'Taşıt Kredisi' then Avg90Mon3Active else NULL end) CarAvg90Mon3Active,
max(case when CreditType = 'Taşıt Kredisi' then Avg90Mon3 else NULL end) CarAvg90Mon3,

sum(SumOnTimeMon3Active*1.0)/sum(CountActiveLoan*1.0) FullAvgOnTimeMon3Active,
sum(SumOnTimeMon3*1.0)/sum(CountLoan*1.0) FullAvgOnTimeMon3,
max(case when CreditType = 'İhtiyaç Kredisi' then AvgOnTimeMon3Active else NULL end) ConsAvgOnTimeMon3Active,
max(case when CreditType = 'İhtiyaç Kredisi' then AvgOnTimeMon3 else NULL end) ConsAvgOnTimeMon3,
max(case when CreditType = 'Kredi Kartı' then AvgOnTimeMon3Active else NULL end) CredAvgOnTimeMon3Active,
max(case when CreditType = 'Kredi Kartı' then AvgOnTimeMon3 else NULL end) CredAvgOnTimeMon3,
max(case when CreditType = 'Kredili Mevduat Hesabı' then AvgOnTimeMon3Active else NULL end) ODAvgOnTimeMon3Active,
max(case when CreditType = 'Kredili Mevduat Hesabı' then AvgOnTimeMon3 else NULL end) ODAvgOnTimeMon3,
max(case when CreditType = 'Konut Kredisi' then AvgOnTimeMon3Active else NULL end) MorgAvgOnTimeMon3Active,
max(case when CreditType = 'Konut Kredisi' then AvgOnTimeMon3 else NULL end) MorgAvgOnTimeMon3,
max(case when CreditType = 'Taşıt Kredisi' then AvgOnTimeMon3Active else NULL end) CarAvgOnTimeMon3Active,
max(case when CreditType = 'Taşıt Kredisi' then AvgOnTimeMon3 else NULL end) CarAvgOnTimeMon3,

sum(Sum30Mon6Active*1.0)/sum(CountActiveLoan*1.0) FullAvg30Mon6Active,
sum(Sum30Mon6*1.0)/sum(CountLoan*1.0) FullAvg30Mon6,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg30Mon6Active else NULL end) ConsAvg30Mon6Active,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg30Mon6 else NULL end) ConsAvg30Mon6,
max(case when CreditType = 'Kredi Kartı' then Avg30Mon6Active else NULL end) CredAvg30Mon6Active,
max(case when CreditType = 'Kredi Kartı' then Avg30Mon6 else NULL end) CredAvg30Mon6,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg30Mon6Active else NULL end) ODAvg30Mon6Active,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg30Mon6 else NULL end) ODAvg30Mon6,
max(case when CreditType = 'Konut Kredisi' then Avg30Mon6Active else NULL end) MorgAvg30Mon6Active,
max(case when CreditType = 'Konut Kredisi' then Avg30Mon6 else NULL end) MorgAvg30Mon6,
max(case when CreditType = 'Taşıt Kredisi' then Avg30Mon6Active else NULL end) CarAvg30Mon6Active,
max(case when CreditType = 'Taşıt Kredisi' then Avg30Mon6 else NULL end) CarAvg30Mon6,

sum(Sum60Mon6Active*1.0)/sum(CountActiveLoan*1.0) FullAvg60Mon6Active,
sum(Sum60Mon6*1.0)/sum(CountLoan*1.0) FullAvg60Mon6,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg60Mon6Active else NULL end) ConsAvg60Mon6Active,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg60Mon6 else NULL end) ConsAvg60Mon6,
max(case when CreditType = 'Kredi Kartı' then Avg60Mon6Active else NULL end) CredAvg60Mon6Active,
max(case when CreditType = 'Kredi Kartı' then Avg60Mon6 else NULL end) CredAvg60Mon6,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg60Mon6Active else NULL end) ODAvg60Mon6Active,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg60Mon6 else NULL end) ODAvg60Mon6,
max(case when CreditType = 'Konut Kredisi' then Avg60Mon6Active else NULL end) MorgAvg60Mon6Active,
max(case when CreditType = 'Konut Kredisi' then Avg60Mon6 else NULL end) MorgAvg60Mon6,
max(case when CreditType = 'Taşıt Kredisi' then Avg60Mon6Active else NULL end) CarAvg60Mon6Active,
max(case when CreditType = 'Taşıt Kredisi' then Avg60Mon6 else NULL end) CarAvg60Mon6,

sum(Sum90Mon6Active*1.0)/sum(CountActiveLoan*1.0) FullAvg90Mon6Active,
sum(Sum90Mon6*1.0)/sum(CountLoan*1.0) FullAvg90Mon6,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg90Mon6Active else NULL end) ConsAvg90Mon6Active,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg90Mon6 else NULL end) ConsAvg90Mon6,
max(case when CreditType = 'Kredi Kartı' then Avg90Mon6Active else NULL end) CredAvg90Mon6Active,
max(case when CreditType = 'Kredi Kartı' then Avg90Mon6 else NULL end) CredAvg90Mon6,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg90Mon6Active else NULL end) ODAvg90Mon6Active,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg90Mon6 else NULL end) ODAvg90Mon6,
max(case when CreditType = 'Konut Kredisi' then Avg90Mon6Active else NULL end) MorgAvg90Mon6Active,
max(case when CreditType = 'Konut Kredisi' then Avg90Mon6 else NULL end) MorgAvg90Mon6,
max(case when CreditType = 'Taşıt Kredisi' then Avg90Mon6Active else NULL end) CarAvg90Mon6Active,
max(case when CreditType = 'Taşıt Kredisi' then Avg90Mon6 else NULL end) CarAvg90Mon6,

sum(SumOnTimeMon6Active*1.0)/sum(CountActiveLoan*1.0) FullAvgOnTimeMon6Active,
sum(SumOnTimeMon6*1.0)/sum(CountLoan*1.0) FullAvgOnTimeMon6,
max(case when CreditType = 'İhtiyaç Kredisi' then AvgOnTimeMon6Active else NULL end) ConsAvgOnTimeMon6Active,
max(case when CreditType = 'İhtiyaç Kredisi' then AvgOnTimeMon6 else NULL end) ConsAvgOnTimeMon6,
max(case when CreditType = 'Kredi Kartı' then AvgOnTimeMon6Active else NULL end) CredAvgOnTimeMon6Active,
max(case when CreditType = 'Kredi Kartı' then AvgOnTimeMon6 else NULL end) CredAvgOnTimeMon6,
max(case when CreditType = 'Kredili Mevduat Hesabı' then AvgOnTimeMon6Active else NULL end) ODAvgOnTimeMon6Active,
max(case when CreditType = 'Kredili Mevduat Hesabı' then AvgOnTimeMon6 else NULL end) ODAvgOnTimeMon6,
max(case when CreditType = 'Konut Kredisi' then AvgOnTimeMon6Active else NULL end) MorgAvgOnTimeMon6Active,
max(case when CreditType = 'Konut Kredisi' then AvgOnTimeMon6 else NULL end) MorgAvgOnTimeMon6,
max(case when CreditType = 'Taşıt Kredisi' then AvgOnTimeMon6Active else NULL end) CarAvgOnTimeMon6Active,
max(case when CreditType = 'Taşıt Kredisi' then AvgOnTimeMon6 else NULL end) CarAvgOnTimeMon6,

sum(Sum30Mon12Active*1.0)/sum(CountActiveLoan*1.0) FullAvg30Mon12Active,
sum(Sum30Mon12*1.0)/sum(CountLoan*1.0) FullAvg30Mon12,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg30Mon12Active else NULL end) ConsAvg30Mon12Active,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg30Mon12 else NULL end) ConsAvg30Mon12,
max(case when CreditType = 'Kredi Kartı' then Avg30Mon12Active else NULL end) CredAvg30Mon12Active,
max(case when CreditType = 'Kredi Kartı' then Avg30Mon12 else NULL end) CredAvg30Mon12,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg30Mon12Active else NULL end) ODAvg30Mon12Active,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg30Mon12 else NULL end) ODAvg30Mon12,
max(case when CreditType = 'Konut Kredisi' then Avg30Mon12Active else NULL end) MorgAvg30Mon12Active,
max(case when CreditType = 'Konut Kredisi' then Avg30Mon12 else NULL end) MorgAvg30Mon12,
max(case when CreditType = 'Taşıt Kredisi' then Avg30Mon12Active else NULL end) CarAvg30Mon12Active,
max(case when CreditType = 'Taşıt Kredisi' then Avg30Mon12 else NULL end) CarAvg30Mon12,

sum(Sum60Mon12Active*1.0)/sum(CountActiveLoan*1.0) FullAvg60Mon12Active,
sum(Sum60Mon12*1.0)/sum(CountLoan*1.0) FullAvg60Mon12,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg60Mon12Active else NULL end) ConsAvg60Mon12Active,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg60Mon12 else NULL end) ConsAvg60Mon12,
max(case when CreditType = 'Kredi Kartı' then Avg60Mon12Active else NULL end) CredAvg60Mon12Active,
max(case when CreditType = 'Kredi Kartı' then Avg60Mon12 else NULL end) CredAvg60Mon12,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg60Mon12Active else NULL end) ODAvg60Mon12Active,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg60Mon12 else NULL end) ODAvg60Mon12,
max(case when CreditType = 'Konut Kredisi' then Avg60Mon12Active else NULL end) MorgAvg60Mon12Active,
max(case when CreditType = 'Konut Kredisi' then Avg60Mon12 else NULL end) MorgAvg60Mon12,
max(case when CreditType = 'Taşıt Kredisi' then Avg60Mon12Active else NULL end) CarAvg60Mon12Active,
max(case when CreditType = 'Taşıt Kredisi' then Avg60Mon12 else NULL end) CarAvg60Mon12,

sum(Sum90Mon12Active*1.0)/sum(CountActiveLoan*1.0) FullAvg90Mon12Active,
sum(Sum90Mon12*1.0)/sum(CountLoan*1.0) FullAvg90Mon12,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg90Mon12Active else NULL end) ConsAvg90Mon12Active,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg90Mon12 else NULL end) ConsAvg90Mon12,
max(case when CreditType = 'Kredi Kartı' then Avg90Mon12Active else NULL end) CredAvg90Mon12Active,
max(case when CreditType = 'Kredi Kartı' then Avg90Mon12 else NULL end) CredAvg90Mon12,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg90Mon12Active else NULL end) ODAvg90Mon12Active,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg90Mon12 else NULL end) ODAvg90Mon12,
max(case when CreditType = 'Konut Kredisi' then Avg90Mon12Active else NULL end) MorgAvg90Mon12Active,
max(case when CreditType = 'Konut Kredisi' then Avg90Mon12 else NULL end) MorgAvg90Mon12,
max(case when CreditType = 'Taşıt Kredisi' then Avg90Mon12Active else NULL end) CarAvg90Mon12Active,
max(case when CreditType = 'Taşıt Kredisi' then Avg90Mon12 else NULL end) CarAvg90Mon12,

sum(SumOnTimeMon12Active*1.0)/sum(CountActiveLoan*1.0) FullAvgOnTimeMon12Active,
sum(SumOnTimeMon12*1.0)/sum(CountLoan*1.0) FullAvgOnTimeMon12,
max(case when CreditType = 'İhtiyaç Kredisi' then AvgOnTimeMon12Active else NULL end) ConsAvgOnTimeMon12Active,
max(case when CreditType = 'İhtiyaç Kredisi' then AvgOnTimeMon12 else NULL end) ConsAvgOnTimeMon12,
max(case when CreditType = 'Kredi Kartı' then AvgOnTimeMon12Active else NULL end) CredAvgOnTimeMon12Active,
max(case when CreditType = 'Kredi Kartı' then AvgOnTimeMon12 else NULL end) CredAvgOnTimeMon12,
max(case when CreditType = 'Kredili Mevduat Hesabı' then AvgOnTimeMon12Active else NULL end) ODAvgOnTimeMon12Active,
max(case when CreditType = 'Kredili Mevduat Hesabı' then AvgOnTimeMon12 else NULL end) ODAvgOnTimeMon12,
max(case when CreditType = 'Konut Kredisi' then AvgOnTimeMon12Active else NULL end) MorgAvgOnTimeMon12Active,
max(case when CreditType = 'Konut Kredisi' then AvgOnTimeMon12 else NULL end) MorgAvgOnTimeMon12,
max(case when CreditType = 'Taşıt Kredisi' then AvgOnTimeMon12Active else NULL end) CarAvgOnTimeMon12Active,
max(case when CreditType = 'Taşıt Kredisi' then AvgOnTimeMon12 else NULL end) CarAvgOnTimeMon12,

sum(Sum30Mon18Active*1.0)/sum(CountActiveLoan*1.0) FullAvg30Mon18Active,
sum(Sum30Mon18*1.0)/sum(CountLoan*1.0) FullAvg30Mon18,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg30Mon18Active else NULL end) ConsAvg30Mon18Active,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg30Mon18 else NULL end) ConsAvg30Mon18,
max(case when CreditType = 'Kredi Kartı' then Avg30Mon18Active else NULL end) CredAvg30Mon18Active,
max(case when CreditType = 'Kredi Kartı' then Avg30Mon18 else NULL end) CredAvg30Mon18,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg30Mon18Active else NULL end) ODAvg30Mon18Active,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg30Mon18 else NULL end) ODAvg30Mon18,
max(case when CreditType = 'Konut Kredisi' then Avg30Mon18Active else NULL end) MorgAvg30Mon18Active,
max(case when CreditType = 'Konut Kredisi' then Avg30Mon18 else NULL end) MorgAvg30Mon18,
max(case when CreditType = 'Taşıt Kredisi' then Avg30Mon18Active else NULL end) CarAvg30Mon18Active,
max(case when CreditType = 'Taşıt Kredisi' then Avg30Mon18 else NULL end) CarAvg30Mon18,

sum(Sum60Mon18Active*1.0)/sum(CountActiveLoan*1.0) FullAvg60Mon18Active,
sum(Sum60Mon18*1.0)/sum(CountLoan*1.0) FullAvg60Mon18,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg60Mon18Active else NULL end) ConsAvg60Mon18Active,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg60Mon18 else NULL end) ConsAvg60Mon18,
max(case when CreditType = 'Kredi Kartı' then Avg60Mon18Active else NULL end) CredAvg60Mon18Active,
max(case when CreditType = 'Kredi Kartı' then Avg60Mon18 else NULL end) CredAvg60Mon18,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg60Mon18Active else NULL end) ODAvg60Mon18Active,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg60Mon18 else NULL end) ODAvg60Mon18,
max(case when CreditType = 'Konut Kredisi' then Avg60Mon18Active else NULL end) MorgAvg60Mon18Active,
max(case when CreditType = 'Konut Kredisi' then Avg60Mon18 else NULL end) MorgAvg60Mon18,
max(case when CreditType = 'Taşıt Kredisi' then Avg60Mon18Active else NULL end) CarAvg60Mon18Active,
max(case when CreditType = 'Taşıt Kredisi' then Avg60Mon18 else NULL end) CarAvg60Mon18,

sum(Sum90Mon18Active*1.0)/sum(CountActiveLoan*1.0) FullAvg90Mon18Active,
sum(Sum90Mon18*1.0)/sum(CountLoan*1.0) FullAvg90Mon18,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg90Mon18Active else NULL end) ConsAvg90Mon18Active,
max(case when CreditType = 'İhtiyaç Kredisi' then Avg90Mon18 else NULL end) ConsAvg90Mon18,
max(case when CreditType = 'Kredi Kartı' then Avg90Mon18Active else NULL end) CredAvg90Mon18Active,
max(case when CreditType = 'Kredi Kartı' then Avg90Mon18 else NULL end) CredAvg90Mon18,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg90Mon18Active else NULL end) ODAvg90Mon18Active,
max(case when CreditType = 'Kredili Mevduat Hesabı' then Avg90Mon18 else NULL end) ODAvg90Mon18,
max(case when CreditType = 'Konut Kredisi' then Avg90Mon18Active else NULL end) MorgAvg90Mon18Active,
max(case when CreditType = 'Konut Kredisi' then Avg90Mon18 else NULL end) MorgAvg90Mon18,
max(case when CreditType = 'Taşıt Kredisi' then Avg90Mon18Active else NULL end) CarAvg90Mon18Active,
max(case when CreditType = 'Taşıt Kredisi' then Avg90Mon18 else NULL end) CarAvg90Mon18,

sum(SumOnTimeMon18Active*1.0)/sum(CountActiveLoan*1.0) FullAvgOnTimeMon18Active,
sum(SumOnTimeMon18*1.0)/sum(CountLoan*1.0) FullAvgOnTimeMon18,
max(case when CreditType = 'İhtiyaç Kredisi' then AvgOnTimeMon18Active else NULL end) ConsAvgOnTimeMon18Active,
max(case when CreditType = 'İhtiyaç Kredisi' then AvgOnTimeMon18 else NULL end) ConsAvgOnTimeMon18,
max(case when CreditType = 'Kredi Kartı' then AvgOnTimeMon18Active else NULL end) CredAvgOnTimeMon18Active,
max(case when CreditType = 'Kredi Kartı' then AvgOnTimeMon18 else NULL end) CredAvgOnTimeMon18,
max(case when CreditType = 'Kredili Mevduat Hesabı' then AvgOnTimeMon18Active else NULL end) ODAvgOnTimeMon18Active,
max(case when CreditType = 'Kredili Mevduat Hesabı' then AvgOnTimeMon18 else NULL end) ODAvgOnTimeMon18,
max(case when CreditType = 'Konut Kredisi' then AvgOnTimeMon18Active else NULL end) MorgAvgOnTimeMon18Active,
max(case when CreditType = 'Konut Kredisi' then AvgOnTimeMon18 else NULL end) MorgAvgOnTimeMon18,
max(case when CreditType = 'Taşıt Kredisi' then AvgOnTimeMon18Active else NULL end) CarAvgOnTimeMon18Active,
max(case when CreditType = 'Taşıt Kredisi' then AvgOnTimeMon18 else NULL end) CarAvgOnTimeMon18

from
	(
	select ApplyId, ApplyTime, CustomerId, Score, CreditType,   

	count(case when ActiveLast3 = 1 then CreditType else NULL end) CountActiveLoan,
	count(CreditType) CountLoan,

	avg(case when ActiveLast3 = 1 then CreditLimit else NULL end) AvgLimitActive, avg(CreditLimit) AvgLimit,
	sum(case when ActiveLast3 = 1 then CreditLimit else NULL end) SumLimitActive, sum(CreditLimit) SumLimit,
	avg(case when ActiveLast3 = 1 then TotalDebt else NULL end) AvgDebtActive, avg(TotalDebt) AvgDebt,
	sum(case when ActiveLast3 = 1 then TotalDebt else NULL end) SumDebtActive, sum(TotalDebt) SumDebt,

	avg(case when ActiveLast3 = 1 then Delq30Last3*1.0 else NULL end) Avg30Mon3Active, avg(Delq30Last3*1.0) Avg30Mon3,
	sum(case when ActiveLast3 = 1 then Delq30Last3 else NULL end) Sum30Mon3Active, sum(Delq30Last3) Sum30Mon3,
	avg(case when ActiveLast3 = 1 then Delq30Last6*1.0 else NULL end) Avg30Mon6Active, avg(Delq30Last6*1.0) Avg30Mon6,
	sum(case when ActiveLast3 = 1 then Delq30Last6 else NULL end) Sum30Mon6Active, sum(Delq30Last6) Sum30Mon6,
	avg(case when ActiveLast3 = 1 then Delq30Last12*1.0 else NULL end) Avg30Mon12Active, avg(Delq30Last12*1.0) Avg30Mon12,
	sum(case when ActiveLast3 = 1 then Delq30Last12 else NULL end) Sum30Mon12Active, sum(Delq30Last12) Sum30Mon12,
	avg(case when ActiveLast3 = 1 then Delq30Last18*1.0 else NULL end) Avg30Mon18Active, avg(Delq30Last18*1.0) Avg30Mon18,
	sum(case when ActiveLast3 = 1 then Delq30Last18 else NULL end) Sum30Mon18Active, sum(Delq30Last18) Sum30Mon18,

	avg(case when ActiveLast3 = 1 then Delq60Last3*1.0 else NULL end) Avg60Mon3Active, avg(Delq60Last3*1.0) Avg60Mon3,
	sum(case when ActiveLast3 = 1 then Delq60Last3 else NULL end) Sum60Mon3Active, sum(Delq60Last3) Sum60Mon3,
	avg(case when ActiveLast3 = 1 then Delq60Last6*1.0 else NULL end) Avg60Mon6Active, avg(Delq60Last6*1.0) Avg60Mon6,
	sum(case when ActiveLast3 = 1 then Delq60Last6 else NULL end) Sum60Mon6Active, sum(Delq60Last6) Sum60Mon6,
	avg(case when ActiveLast3 = 1 then Delq60Last12*1.0 else NULL end) Avg60Mon12Active, avg(Delq60Last12*1.0) Avg60Mon12,
	sum(case when ActiveLast3 = 1 then Delq60Last12 else NULL end) Sum60Mon12Active, sum(Delq60Last12) Sum60Mon12,
	avg(case when ActiveLast3 = 1 then Delq60Last18*1.0 else NULL end) Avg60Mon18Active, avg(Delq60Last18*1.0) Avg60Mon18,
	sum(case when ActiveLast3 = 1 then Delq60Last18 else NULL end) Sum60Mon18Active, sum(Delq60Last18) Sum60Mon18,

	avg(case when ActiveLast3 = 1 then Delq90Last3*1.0 else NULL end) Avg90Mon3Active, avg(Delq90Last3*1.0) Avg90Mon3,
	sum(case when ActiveLast3 = 1 then Delq90Last3 else NULL end) Sum90Mon3Active, sum(Delq90Last3) Sum90Mon3,
	avg(case when ActiveLast3 = 1 then Delq90Last6*1.0 else NULL end) Avg90Mon6Active, avg(Delq90Last6*1.0) Avg90Mon6,
	sum(case when ActiveLast3 = 1 then Delq90Last6 else NULL end) Sum90Mon6Active, sum(Delq90Last6) Sum90Mon6,
	avg(case when ActiveLast3 = 1 then Delq90Last12*1.0 else NULL end) Avg90Mon12Active, avg(Delq90Last12*1.0) Avg90Mon12,
	sum(case when ActiveLast3 = 1 then Delq90Last12 else NULL end) Sum90Mon12Active, sum(Delq90Last12) Sum90Mon12,
	avg(case when ActiveLast3 = 1 then Delq90Last18*1.0 else NULL end) Avg90Mon18Active, avg(Delq90Last18*1.0) Avg90Mon18,
	sum(case when ActiveLast3 = 1 then Delq90Last18 else NULL end) Sum90Mon18Active, sum(Delq90Last18) Sum90Mon18,

	avg(case when ActiveLast3 = 1 then OnTimeLast3*1.0 else NULL end) AvgOnTimeMon3Active, avg(OnTimeLast3*1.0) AvgOnTimeMon3,
	sum(case when ActiveLast3 = 1 then OnTimeLast3 else NULL end) SumOnTimeMon3Active, sum(OnTimeLast3) SumOnTimeMon3,
	avg(case when ActiveLast3 = 1 then OnTimeLast6*1.0 else NULL end) AvgOnTimeMon6Active, avg(OnTimeLast6*1.0) AvgOnTimeMon6,
	sum(case when ActiveLast3 = 1 then OnTimeLast6 else NULL end) SumOnTimeMon6Active, sum(OnTimeLast6) SumOnTimeMon6,
	avg(case when ActiveLast3 = 1 then OnTimeLast12*1.0 else NULL end) AvgOnTimeMon12Active, avg(OnTimeLast12*1.0) AvgOnTimeMon12,
	sum(case when ActiveLast3 = 1 then OnTimeLast12 else NULL end) SumOnTimeMon12Active, sum(OnTimeLast12) SumOnTimeMon12,
	avg(case when ActiveLast3 = 1 then OnTimeLast18*1.0 else NULL end) AvgOnTimeMon18Active, avg(OnTimeLast18*1.0) AvgOnTimeMon18,
	sum(case when ActiveLast3 = 1 then OnTimeLast18 else NULL end) SumOnTimeMon18Active, sum(OnTimeLast18) SumOnTimeMon18
	
	from
		(
		
		select t2.*, 
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
			   else 18-LEN(REPLACE(Last18, '3', '')) end Delq90Last18,

			   case when LEN(REPLACE(REPLACE(Last3, 'Z', ''), 'X', '')) = 0 then NULL
			   else 3-LEN(REPLACE(Last3, '0', '')) end OnTimeLast3, 
			   case when LEN(REPLACE(REPLACE(Last6, 'Z', ''), 'X', '')) = 0 then NULL
			   else 6-LEN(REPLACE(Last6, '0', '')) end OnTimeLast6,
			   case when LEN(REPLACE(REPLACE(Last12, 'Z', ''), 'X', '')) = 0 then NULL
			   else 12-LEN(REPLACE(Last12, '0', '')) end OnTimeLast12,
			   case when LEN(REPLACE(REPLACE(Last18, 'Z', ''), 'X', '')) = 0 then NULL
			   else 18-LEN(REPLACE(Last18, '0', '')) end OnTimeLast18

		from
		
			(select t.*, 
				   case when MonDif < 3 then LEFT(@Constant, 3-MonDif)+HistPerf else RIGHT(HistPerf, 3) end Last3, 
				   case when MonDif < 6 then LEFT(@Constant, 6-MonDif)+HistPerf else RIGHT(HistPerf, 6) end Last6,
				   case when MonDif < 12 then LEFT(@Constant, 12-MonDif)+HistPerf else RIGHT(HistPerf, 12) end Last12,
				   case when MonDif < 18 then LEFT(@Constant, 18-MonDif)+HistPerf else RIGHT(HistPerf, 18) end Last18
			from
				(
				
				select distinct a.*, b.Score, b.ReferenceNo, b.CreditType, b.StartDate, b.EndDate, b.CreditLimit, b.TotalDebt, 
					case when DATEDIFF(month, b.EndDate, a.ApplyTime) <= 3 or b.EndDate is NULL then 1 else 0 end ActiveLast3,
				b.CredPerf, LEN(b.CredPerf) CredMon, DATEDIFF(month, b.StartDate, a.ApplyTime)-1 MonDif,
					case when LEN(b.CredPerf) >= DATEDIFF(month, b.StartDate, a.ApplyTime)-1 then LEFT(CredPerf, DATEDIFF(month, b.StartDate, a.ApplyTime)-1)
					else CredPerf+ LEFT(@Constant, (DATEDIFF(month, b.StartDate, a.ApplyTime)-1)-LEN(b.CredPerf)) end HistPerf  				
				from dbo.Apply_2016_Def a, dbo.Apply_2016 b
				where a.CustomerId = b.CustomerId
				and a.ApplyId = b.ApplyId
				and a.CustomerId = '861AE362-8DA6-46BB-99B8-E772E68CB40F'
				and a.ApplyId = '62D1C531-B561-4108-AF8E-145D5D08FB64'
				and DATEDIFF(month, b.StartDate, a.ApplyTime) >=1
				) t
			) t2
		) t3

	group by ApplyId, ApplyTime, CustomerId, Score, CreditType
	) t4

group by ApplyId, ApplyTime, CustomerId, Score





DECLARE @Constant VARCHAR(120) = 'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ'

select distinct a.*, b.Score, b.ReferenceNo, b.CreditTypeId, b.StartDate, b.EndDate, b.CreditLimit, b.TotalDebt,
case when DATEDIFF(month, b.EndDate, a.ApplyTime) <= 3 or b.EndDate is NULL then 1 else 0 end ActiveLast3,
b.CredPerf, LEN(b.CredPerf) CredMon, DATEDIFF(month, b.StartDate, a.ApplyTime)-1 MonDif,
case when LEN(b.CredPerf) >= DATEDIFF(month, b.StartDate, a.ApplyTime)-1 then LEFT(CredPerf, DATEDIFF(month, b.StartDate, a.ApplyTime)-1)
else CredPerf+ LEFT(@Constant, (DATEDIFF(month, b.StartDate, a.ApplyTime)-1)-LEN(b.CredPerf)) end HistPerf  				
				
from dbo.Apply_2016_Def a, dbo.Apply_2016Pre b
where a.CustomerId = b.CustomerId
and a.ApplyId = b.ApplyId
and a.CustomerId = '861AE362-8DA6-46BB-99B8-E772E68CB40F'
and a.ApplyId = '62D1C531-B561-4108-AF8E-145D5D08FB64'
and DATEDIFF(month, b.StartDate, a.ApplyTime) >=1


