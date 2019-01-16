select * into IndusTrain_Model
from
	(select 
	[index], 
	ca_customertransactionid, 
	c_gender, 
	cast(ca_avgmonthlycanbepaid as int) ca_avgmonthlycanbepaid,
	cast(ca_avgpayrollincome as int) ca_avgpayrollincome,	
	cast(ca_maxmonthlycanbepaid as int) ca_maxmonthlycanbepaid,	
	cast(ca_maxpayrollincome as int) ca_maxpayrollincome ,
	cast(ca_minmonthlycanbepaid as int) ca_minmonthlycanbepaid ,	
	cast(ca_minpayrollincome as int) ca_minpayrollincome,	
	ca_occupation,	
	ca_preferbank1,	
	ca_preferbank2,	
	cast(ca_score as int) VAR_ca_score,	
	cast(ca_totalamount as float) ca_totalamount,	
	cs_education,	
	cs_homeowner,	
	cs_workcity,	
	cs_workperiod,	
	cs_worksector,	
	cs_worktitle,
	cast(ctb_average_months_on_time_x_creditcard_loan_last_3months as float) VAR_ctb_average_months_on_time_x_creditcard_loan_last_3months,
	cast(ctb_avg_months_60day_delinquent_x_open_loan_x_personal_loan_last_6months as float) ctb_avg_months_60day_delinquent_x_open_loan_x_personal_loan_last_6months,
	cast(ctb_avg_months_90day_delinquent_last_18months as float) ctb_avg_months_90day_delinquent_last_18months,
	cast(ctb_avg_months_90day_delinquent_x_overdraft_acct_last_6months as float) ctb_avg_months_90day_delinquent_x_overdraft_acct_last_6months,
	cast(avg_ratio_totaldebt_to_creditlimit_last_3months as float) avg_ratio_totaldebt_to_creditlimit_last_3months,
	cast(ratio_avg_months_30day_delinquent_last_6months_to_avg_months_30day_delinquent_last_18months as float) ratio_avg_months_30day_delinquent_last_6months_to_avg_months_30day_delinquent_last_18months ,

	case when cast(ratio_avg_months_30day_delinquent_last_6months_to_avg_months_30day_delinquent_last_18months as real) <> 0 
	then 1/cast(ratio_avg_months_30day_delinquent_last_6months_to_avg_months_30day_delinquent_last_18months as real)
	else 1/0.04166667 end VAR_Inverse_of_ratio_avg_months_30day_delinquent_last_6months_to_avg_months_30day_delinquent_last_18months,
	
	case when cast(ctb_avg_months_90day_delinquent_last_18months as real) <> 0 
	then 1/cast(ctb_avg_months_90day_delinquent_last_18months as real)
	else 1/0.03333 end VAR_Inverse_of_ctb_avg_months_90day_delinquent_last_18months,

	case when cast(ctb_avg_months_60day_delinquent_x_open_loan_x_personal_loan_last_6months as real) <> 0 
	then log(cast(ctb_avg_months_60day_delinquent_x_open_loan_x_personal_loan_last_6months as real))
	else log(0.1) end VAR_Log_of_ctb_avg_months_60day_delinquent_x_open_loan_x_personal_loan_last_6months,

	case when cast(avg_ratio_totaldebt_to_creditlimit_last_3months as real) <> 0 
	then log(cast(avg_ratio_totaldebt_to_creditlimit_last_3months as real)+1)
	else 0.506399539 end VAR_Log_of_avg_ratio_totaldebt_to_creditlimit_last_3months,

	case when cast(ctb_avg_months_90day_delinquent_x_overdraft_acct_last_6months as real) <> 0 
	then 1/cast(ctb_avg_months_90day_delinquent_x_overdraft_acct_last_6months as real)
	else 1/0.0137 end VAR_Inverse_of_ctb_avg_months_90day_delinquent_x_overdraft_acct_last_6months,

	target_var
	
	from dbo.IndusTrain) t
	



	select *
	from dbo.IndusTrain_Model
	
	select min(cast(ctb_avg_months_90day_delinquent_x_overdraft_acct_last_6months as real))
	from dbo.IndusTrain
	where cast(ctb_avg_months_90day_delinquent_x_overdraft_acct_last_6months as real) <> 0

	select exp(0.506399539)
	from dbo.IndusTrain
	