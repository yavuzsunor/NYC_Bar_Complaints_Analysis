select * into dbo.IndusFull
from dbo.IndusTrain_Edit

INSERT INTO dbo.IndusFull
SELECT * FROM dbo.IndusTest_Edit

select *
from dbo.IndusScore
where DefLast3 = 0
and AvgOccp12_15 > 0.5
and AvgOccp15_18 > 0.5

select *
from dbo.CustomerTransactionSummary
where CustomerId='9D674CFA-852D-4C65-B0B5-001917E3DC0F'

select distinct ReferenceNo, StartDate, CustomerId
from 
(select b.ReferenceNo, b.CreditTypeId, b.CreditLimit, b.StartDate, b.EndDate,  
a.CustomerTransactionId, a.TransTime, a.CustomerId, AvgDef3, AvgOccp3, AvgDef6_3, AvgOccp6_3, AvgDef12_6, AvgOccp12_6, AvgDef18_6, AvgOccp18_6  
from dbo.IndusFull a
left join dbo.CustomerTransactionSummary b
on a.CustomerId = b.CustomerId
where b.StartDate > a.TransTime
and b.CreditTypeId = '3D25E727-C6B9-42CF-86FE-403482393E4D') t


select b.Description, a.*
from dbo.BankOffer a, dbo.Type b
where a.StatusTypeId = b.Id
and b.Description = 'Tamamlandı'


select b.CustomerId, a.*
from dbo.CustomerTransactionBank a, dbo.CustomerTransaction b
where CreditTypeId = '3D25E727-C6B9-42CF-86FE-403482393E4D'
and a.CreditLimit is not NULL
and a.Installment is not NULL
and a.MonthlyPayment is not NULL
and a.CustomerTransactionId = b.Id
and b.CustomerId = '142E6B12-3447-4AB2-BF7D-9428B6B74689'



select distinct a.CustomerId, b.RegisterReferenceNo, b.CreditLimit, b.Installment, b.MonthlyPayment
from dbo.CustomerTransactionSummary a, dbo.CustomerTransactionBank b
where a.ReferenceNo = b.RegisterReferenceNo
and b.CreditTypeId = '3D25E727-C6B9-42CF-86FE-403482393E4D'
and b.CreditLimit is not NULL
and b.Installment is not NULL
and b.MonthlyPayment is not NULL


select distinct CustomerTransactionId from dbo.KKB_15K_Part1


select *
from dbo.CustomerTransactionSummary
where CustomerId = 'B91D054B-726C-4702-87A8-A1C5894599E9'