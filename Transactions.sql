SELECT * FROM banking_data.transactions;
use banking_data;
select * from transactions;
# Total Credit Amount
select sum(amount)as Total_Credit_Amount from transactions where transaction_type='Credit';
# Total Debit Amount
select sum(amount)as Total_Debit_Amount from transactions where transaction_type='Debit';
# Net Transactions
SELECT (SUM(CASE WHEN transaction_type = 'Credit' THEN amount ELSE 0 END)-SUM(CASE WHEN transaction_type = 'Debit' THEN amount ELSE 0 END)) AS net_amount
FROM transactions;
# Credit to Debit Ratio
SELECT ROUND((SUM(CASE WHEN transaction_type = 'Credit' THEN amount ELSE 0 END) /SUM(CASE WHEN transaction_type = 'Debit' THEN amount ELSE 0 END)) * 100, 2) 
AS credit_to_debit_ratio FROM transactions;
# Account Activity Ratio
SELECT COUNT(Transaction_date) / (SELECT sum(balance))* 100
AS account_activity_ratio from transactions;

# Total Amount according to the categories/description
Select description,SUM(amount) AS total_amount FROM transactions
GROUP BY description ORDER BY total_amount DESC;

# Total amount spent according to the bankwise
Select bank_name,SUM(amount) AS total_amount
FROM transactions GROUP BY bank_name ORDER BY total_amount DESC;

# Transaction Count with Transaction method
select transaction_method,COUNT(amount) AS Customer_count
FROM transactions GROUP BY transaction_method;

# Total amount according to the Month
select MONTHNAME(transaction_date) AS month,
SUM(amount) AS total_amount FROM transactions
GROUP BY month ORDER BY sum(amount) desc;

# Total amount spent according to the Days
select dayname(transaction_date) AS Days,
SUM(amount) AS total_amount
FROM transactions GROUP BY dayname(transaction_date)
ORDER BY days desc;

# Total amount spent according to the Branch
select branch_name,SUM(amount) AS total_amount
FROM transactions GROUP BY branch_name
ORDER BY total_amount DESC;

SELECT MONTHNAME(transaction_date) AS month_name,transaction_date,
ROUND(SUM(amount) / 1000000, 3) AS total_amount_million
FROM transactions WHERE transaction_type = 'Debit'
GROUP BY MONTH(transaction_date),
transaction_date WITH ROLLUP;




