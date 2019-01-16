/*Bring 6 months performance for AppId's in Scope*/
select * into dbo._ScopeMay16Feb17_2
from 
	(select t1.*
	from
		(select distinct t1.CustomerId, t1.Age, t1.Gender, t1.Education, t1.HomeOwner, t1.Income, t1.CityName, t1.Profes, t1.Profes_2, 
		t1.WorkName, t1.WorkCity, t1.WorkCounty, t1.WorkSector, t1.WorkPeriod, t1.TransTime, t2.TransTime TransTime_2, t1.CustomerTransactionId, 
		t1.CustomerTransactionId CustomerTransactionId_Copy, t1.Score, t1.ApplyId, t1.ApplyTime, t1.AppStat, t1.TotLimit, t1.TotDebt, 
		t1.Avg30Delq6, t1.Avg30Delq18, t1.Avg60Delq6PerOpen, t1.AvgDebtAct3, t1.AvgLimitAct3, t1.AvgMonTimeKK3, t1.Avg90Delq6ODOpen, t1.AvgDelq18,
		t2.AvgDelq6 AvgDelq6_2, 
		DATEDIFF(day, t1.TransTime, t2.TransTime) DayDiff,
		MAX(t2.TransTime) OVER(PARTITION BY t1.CustomerTransactionId) MaxTransTime  
		from dbo._ScopeMay16Feb17 t1
		left join dbo._ScopeMay16Feb17 t2
		on t1.CustomerId=t2.CustomerId
		and DATEDIFF(month, t1.TransTime, t2.TransTime) >0
		where t1.ApplyTime between '2016-05-01' and '2017-02-28'
		and t1.AvgDelq3 = 0 
		and DATEDIFF(day, t1.TransTime, t2.TransTime) between 150 and 210) t1
	where CustomerTransactionId=CustomerTransactionId_Copy
	and TransTime_2 = MaxTransTime)	t2
order by CustomerId, TransTime asc

/*Averages for missing values */
select 
cast(count(Score) as float)/cast(count(CustomerTransactionId) as float) Coverage_Score, avg(Score) Average_Score, /*999*/
cast(count(AvgDelq18) as float)/cast(count(CustomerTransactionId) as float) Coverage_AvgDelq18, avg(AvgDelq18) Average_AvgDelq18, /*0.088308*/
cast(count(Avg60Delq6PerOpen) as float)/cast(count(CustomerTransactionId) as float) Coverage_Avg60Delq6PerOpen, avg(Avg60Delq6PerOpen) Average_Avg60Delq6PerOpen, /*0.193715*/
cast(count(AvgMonTimeKK3) as float)/cast(count(CustomerTransactionId) as float) Coverage_AvgMonTimeKK3, avg(AvgMonTimeKK3) Average_AvgMonTimeKK3, /*2.063910*/
cast(count(Avg90Delq6ODOpen) as float)/cast(count(CustomerTransactionId) as float) Coverage_Avg90Delq6ODOpen, avg(Avg90Delq6ODOpen) Average_Avg90Delq6ODOpen, /*0.003847*/
cast(count(AvgDebtAct3) as float)/cast(count(CustomerTransactionId) as float) Coverage_AvgDebtAct3, avg(AvgDebtAct3) Average_AvgDebtAct3,    /*4689.171226*/
cast(count(AvgLimitAct3) as float)/cast(count(CustomerTransactionId) as float) Coverage_AvgLimitAct3, avg(AvgLimitAct3) Average_AvgLimitAct3,  /*7230.382903*/
cast(count(Avg30Delq6) as float)/cast(count(CustomerTransactionId) as float) Coverage_Avg30Delq6, avg(Avg30Delq6) Average_Avg30Delq6, /*1.053691*/
cast(count(Avg30Delq18) as float)/cast(count(CustomerTransactionId) as float) Coverage_Avg30Delq18, avg(Avg30Delq18) Average_Avg30Delq18 /*2.339402*/
from dbo._ScopeMay16Feb17_2


/*Creating final dataset for modeling*/
select * into dbo._ScopeMay16Feb17_3
from
	(select t2.*, 
	case when RatioDebtLimit3 <> 0 then log(cast(RatioDebtLimit3 as real)) else log(cast(0.006282 as real)) end LogRatioDebtLimit3,
	case when Ratio30Delq6to18 <> 0 then cast(1/Ratio30Delq6to18 as real) else cast(1/0.030769 as real) end InverseRatio30Delq6to18,
	case when Avg60Delq6PerOpen <> 0 then log(cast(Avg60Delq6PerOpen as real)) else log(cast(0.142857 as real)) end LogAvg60Delq6PerOpen,
	case when Avg90Delq6ODOpen <> 0 then cast(1/Avg90Delq6ODOpen as real) else cast(1/0.003847 as real) end InverseAvg90Delq6ODOpen,
	case when Avg90Delq18 <> 0 then cast(1/Avg90Delq18 as real) else cast(1/0.047619 as real) end InverseAvg90Delq18
	from  
		(select t1.*, 
		case when AvgLimitAct3 <> 0 and AvgDebtAct3 > 0 then AvgDebtAct3 / AvgLimitAct3 else 0 end RatioDebtLimit3,  /*min 0.006282*/
		case when Avg30Delq18 <> 0 then Avg30Delq6 / Avg30Delq18 else 0 end Ratio30Delq6to18   /*min 0.030769*/
		from
			(select CustomerId, CustomerTransactionId, ApplyId, ApplyTime, 
			Age, Gender, Education, HomeOwner, Income, CityName, Profes_2, WorkSector, WorkPeriod, TotLimit, TotDebt,
			case when Score is NULL then 999 else Score end Score, 
			case when Avg30Delq6 is NULL then 1.053691 else Avg30Delq6 end Avg30Delq6,
			case when Avg30Delq18 is NULL then 2.339402 else Avg30Delq18 end Avg30Delq18,
			case when Avg60Delq6PerOpen is NULL then 0.193715 else Avg60Delq6PerOpen end Avg60Delq6PerOpen, /*min 0.142857*/
			case when Avg90Delq6ODOpen is NULL then 0.003847 else Avg90Delq6ODOpen end Avg90Delq6ODOpen,    /*min 0.003847*/
			case when AvgDelq18 is NULL then 0.088308 else AvgDelq18 end Avg90Delq18,            /*min 0.047619*/
			case when AvgDebtAct3 is NULL then 4689.171226 else AvgDebtAct3 end AvgDebtAct3,
			case when AvgLimitAct3 is NULL then 7230.382903 else AvgLimitAct3 end AvgLimitAct3,
			case when AvgMonTimeKK3 is NULL then 2.063910 else AvgMonTimeKK3 end AvgMonTimeKK3,
			case when AvgDelq6_2>0 then 1 else 0 end Target_Var
			from dbo._ScopeMay16Feb17_2) t1) t2) t3

select *
from dbo._ScopeMay16Feb17_3

		

