select *
from dbo.CustomerApply
where CustomerId = '5098E73E-886A-4BC8-B927-73456C5C8A73'
and Id = '1548BD2D-859C-41AC-9E47-003C54366150'


select CampaingCodes, 
LEFT(CampaingCodes, CHARINDEX('|', CampaingCodes)-1) FirstCamp,
RIGHT(CampaingCodes, LEN(CampaingCodes)-CHARINDEX('|', CampaingCodes)) Sec, 

LEFT(RIGHT(CampaingCodes, LEN(CampaingCodes)-CHARINDEX('|', CampaingCodes)), 
CHARINDEX('|', RIGHT(CampaingCodes, LEN(CampaingCodes)-CHARINDEX('|', CampaingCodes)))-1) SecondCamp,
RIGHT(RIGHT(CampaingCodes, LEN(CampaingCodes)-CHARINDEX('|', CampaingCodes)), 
LEN(RIGHT(CampaingCodes, LEN(CampaingCodes)-CHARINDEX('|', CampaingCodes)))-CHARINDEX('|', RIGHT(CampaingCodes, LEN(CampaingCodes)-CHARINDEX('|', CampaingCodes)))) Third,

LEFT(RIGHT(RIGHT(CampaingCodes, LEN(CampaingCodes)-CHARINDEX('|', CampaingCodes)), 
LEN(RIGHT(CampaingCodes, LEN(CampaingCodes)-CHARINDEX('|', CampaingCodes)))-CHARINDEX('|', RIGHT(CampaingCodes, LEN(CampaingCodes)-CHARINDEX('|', CampaingCodes)))), 
CHARINDEX('|', RIGHT(RIGHT(CampaingCodes, LEN(CampaingCodes)-CHARINDEX('|', CampaingCodes)), 
LEN(RIGHT(CampaingCodes, LEN(CampaingCodes)-CHARINDEX('|', CampaingCodes)))-CHARINDEX('|', RIGHT(CampaingCodes, LEN(CampaingCodes)-CHARINDEX('|', CampaingCodes)))))-1) ThirdCamp

from
	(select 
	case when CampaignCodes is NULL or CampaignCodes = '' then NULL else CampaignCodes end CampaingCodes
	from dbo.CustomerApply
	where Id in 
	('723A1439-43F1-434C-AF03-00005B4077E0',
	'5F5814CB-D175-48D2-9200-00008EE95FA0',
	'7951138B-9479-42E5-9032-0000DB4B395E',
	'34138245-AA33-4F36-A956-00013E5ED527',
	'8E28F869-CD01-48F5-8393-0001951A9BA7',
	'B773B3E8-5505-4ED9-A10D-0002B99D48CA',
	'A9BC7CB5-8ED0-4709-8879-00038AC6EA29',
	'3973745E-F5AC-43C1-A56E-0004475EC1DB',
	'51727057-CE2D-474B-B300-0004569197E8',
	'6876EFC6-EAE3-4F86-A583-0005A210A419')
	) t
where CampaingCodes is not NULL


select Id, Email, FirstName, LastName, 

case 
when Email LIKE '%'+REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(FirstName,'ç','c'),'ğ','g'),'ı','i'),'ö','o'),'ş','s'),'ü','u')+'%' and 
	 Email NOT LIKE '%'+REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LastName,'ç','c'),'ğ','g'),'ı','i'),'ö','o'),'ş','s'),'ü','u')+'%' then 1
when Email NOT LIKE '%'+REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(FirstName,'ç','c'),'ğ','g'),'ı','i'),'ö','o'),'ş','s'),'ü','u')+'%' and 
	 Email LIKE '%'+REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LastName,'ç','c'),'ğ','g'),'ı','i'),'ö','o'),'ş','s'),'ü','u')+'%' then 2
when Email LIKE '%'+REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(FirstName,'ç','c'),'ğ','g'),'ı','i'),'ö','o'),'ş','s'),'ü','u')+'%' and 
	 Email LIKE '%'+REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LastName,'ç','c'),'ğ','g'),'ı','i'),'ö','o'),'ş','s'),'ü','u')+'%' then 3 else 0 end MailFlag

from dbo.Customer
where Id in 
('8F9840C2-8564-4B93-8D16-000036E540A0',
'03A1AB03-4C05-4116-9414-00015CFF84C3',
'7B7EEA92-EF26-41CE-B701-0001D56A8E4A',
'9DDC4C2D-8B02-42E3-AE6E-0002B858F404',
'34C82981-3546-48C8-AA3B-0002CD7E7B7B',
'6E4D7983-C58E-4977-BE0F-0002E07D5910',
'8987174C-A5E2-4357-A12B-0004194D862D',
'31C805FD-BDE9-42D8-BDC9-0005A50C9659',
'5C7B62B3-4AF9-411D-BF7D-0006F255F5C7',
'FF38288B-A425-46D9-A115-000736BB392F')

select LEFT(CardNumber,1) CardType, count(CustomerApplyId) [Count]
from dbo.Payment
group by LEFT(CardNumber,1)

select CampaignCodes, dbo.fnGetSplittedText(CampaignCodes,'|',0)
from dbo.Customer
where CampaignCodes = 'facebook_ybk|linkad|clicks|loans_desktop|kredi_karti_kisa' 


select distinct CampaingCodes, 
LEFT(CampaingCodes, CHARINDEX('|', CampaingCodes)-1) FirstCamp

from
	(select 
	case when CampaignCodes is NULL or CampaignCodes = '' then NULL else CampaignCodes end CampaingCodes
	from dbo.CustomerApply 
	) t
where CampaingCodes is not NULL or CampaingCodes = ''

select top 10 *
from dbo.Apply_2016

select *
from dbo.CustomerTransactionBank
where RegisterReferenceNo = '2694862390282A'

CHARINDEX('|',CampaignCodes) 
where Id = '1548BD2D-859C-41AC-9E47-003C54366150'


select top 10 *
from dbo.Payment
where CustomerApplyId = '1548BD2D-859C-41AC-9E47-003C54366150'

select b.*, a.*
from dbo.CustomerApply a
left join dbo.Payment b
on a.Id = b.CustomerApplyId
where a.Id='4870408D-26F6-4D96-9DE1-085AD4E31A61'





(select a.CustomerApplyId, a.StatusTypeId
from dbo.CustomerApplyHistory a, 
	(select CustomerApplyId, max(CreatedDateTime) StatusTime from dbo.CustomerApplyHistory group by CustomerApplyId) b
where a.CustomerApplyId = b.CustomerApplyId
and a.CreatedDateTime = b.StatusTime)

4F6ECD5C-9F8D-4992-A6B4-61DF315AF25B
03D77D65-F0AD-42EC-9D3C-93E137DE00AF
8CDF561E-D42A-4119-B056-9AD4E695ADEF
FFC17532-FCF1-4EC5-B226-A9AAA7D8041F
08949AE0-D809-4E4C-8EC3-A2ABF8376315
