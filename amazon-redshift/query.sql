SELECT * FROM dev.onlineloan.train;

SELECT name, email, phone_number, userid FROM dev.onlineloan.test WHERE event = 'Sign Up Account';

SELECT loan_id, credit_score, employment_status, income, loan_amount, loan_term, property_ownership, purpose_loan FROM dev.onlineloan.test WHERE event = 'Send Loan Proposal';

SELECT property_ownership , count(*) FROM dev.onlineloan.train WHERE property_ownership IS NOT NULL GROUP BY property_ownership;

SELECT purpose_loan , count(*) FROM dev.onlineloan.train WHERE purpose_loan IS NOT NULL GROUP BY purpose_loan;

SELECT loan_term , count(*) FROM dev.onlineloan.train WHERE loan_term IS NOT NULL GROUP BY loan_term;

SELECT employment_status , count(*) FROM dev.onlineloan.train WHERE employment_status IS NOT NULL GROUP BY employment_status;

SELECT credit_score , count(*) FROM dev.onlineloan.train WHERE credit_score IS NOT NULL GROUP BY credit_score;

SELECT approval_status , count(*) FROM dev.onlineloan.train WHERE approval_status IS NOT NULL GROUP BY approval_status;

SELECT property_ownership , count(*) FROM dev.onlineloan.test WHERE property_ownership IS NOT NULL GROUP BY property_ownership;

SELECT purpose_loan , count(*) FROM dev.onlineloan.test WHERE purpose_loan IS NOT NULL GROUP BY purpose_loan;

SELECT loan_term , count(*) FROM dev.onlineloan.test WHERE loan_term IS NOT NULL GROUP BY loan_term;

SELECT employment_status , count(*) FROM dev.onlineloan.test WHERE employment_status IS NOT NULL GROUP BY employment_status;

SELECT credit_score , count(*) FROM dev.onlineloan.test WHERE credit_score IS NOT NULL GROUP BY credit_score;

--approval rate for income levels
SELECT
  CASE
    WHEN income < 5000 THEN 'Low Income'
    WHEN income BETWEEN 5000 AND 7500 THEN 'Medium Income'
    ELSE 'High Income'
  END AS income_level,
  COUNT(*) AS total_applications,
  SUM(CASE WHEN approval_status = 1 THEN 1 ELSE 0 END) AS approved_applications,
  AVG(CASE WHEN approval_status = 1 THEN 1.0 ELSE 0.0 END) AS approval_rate
FROM dev.onlineloan.train --can change to test OR test_result OR test_result_10
GROUP BY income_level;

--purposes of loans of approval
SELECT
  purpose_loan,
  COUNT(*) AS total_applications,
  SUM(CASE WHEN approval_status = 1 THEN 1 ELSE 0 END) AS approved_applications,
  AVG(CASE WHEN approval_status = 1 THEN 1.0 ELSE 0.0 END) AS approval_rate
FROM dev.onlineloan.train --can change to test OR test_result OR test_result_10
GROUP BY purpose_loan;