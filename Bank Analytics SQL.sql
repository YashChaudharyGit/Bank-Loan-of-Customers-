-- to use database
use Banking;

-- Table 1
SELECT * FROM finance_1;

-- Table 2
SELECT * FROM finance_2;


-- Q1 Year wise loan amount Stats
SELECT 
    YEAR(issue_d) as Year,
    sum(loan_amnt) as Loan_amount FROM
    finance_1
GROUP BY YEAR(issue_d)
order by year(issue_d),sum(loan_amnt);


-- Q2 Grade and sub grade wise revol_bal
SELECT
    fi1.grade,
    fi1.sub_grade,
    round(sum(fi2.revol_bal)) AS revol_bal
FROM finance_1 AS fi1
JOIN finance_2 AS fi2 ON fi1.id = fi2.id
GROUP BY fi1.grade,fi1.sub_grade
ORDER BY fi1.grade,fi1.sub_grade,revol_bal;
    
    
    
-- Q3 Total Payment for Verified Status Vs Total Payment for Non Verified Status
select 
	fi1.verification_status,
    round(sum(fi2.total_pymnt)) as Total_Payment
from finance_1 as fi1
join finance_2 as fi2 on fi1.id=fi2.id
where verification_status in ('verified','Not verified')
group by fi1.verification_status;

    
-- Q4 State wise and month wise loan status

-- A. State wise loan status.
call State_wise_loan_status('fully paid');

-- B. Month wise loan status.
call Month_wise_loan_status('fully paid');

    
-- Q5 Home ownership Vs last payment date stats.
Select
	fi1.home_ownership,
    substring_index(last_pymnt_d,"-",-1) as year,
    count(*)
from finance_1 fi1
join finance_2 fi2 on fi1.id=fi2.id
group by home_ownership,year
order by home_ownership asc,year asc;
    