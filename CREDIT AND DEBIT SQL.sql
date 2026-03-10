
select count(*) from transactions;
describe transactions;

# 1. TOTAL CREDIT AMOUNT
SELECT SUM(amount) AS total_credit_amount
FROM transactions
WHERE transaction_type = 'Credit';

 # 2. TOTAL DEBIT AMOUNT
SELECT SUM(amount) AS total_debit_amount
FROM transactions
WHERE transaction_type = 'Debit';

# 3. CREDIT TO DEBIT RATIO
SELECT 
    (SELECT SUM(amount) FROM transactions WHERE transaction_type = 'Credit') /
    (SELECT SUM(amount) FROM transactions WHERE transaction_type = 'Debit') 
    AS credit_to_debit_ratio;
    
    # 4. NET TRANSACTION AMOUNT
    SELECT 
    (SELECT SUM(amount) FROM transactions WHERE transaction_type = 'Credit') -
    (SELECT SUM(amount) FROM transactions WHERE transaction_type = 'Debit') 
    AS net_transaction_amount;
    
# 5. ACCOUNT ACTIVITY RATIO
    SELECT COUNT(*) / AVG(balance) AS account_activity_ratio FROM transactions;
    
# 6. TRANSACTION PER DAY
SELECT transaction_date, COUNT(*) AS transactions_per_day
FROM transactions GROUP BY transaction_date ORDER BY transaction_date;

# 7. TRANSACTION PER MONTH
SELECT 
    YEAR(transaction_date) AS year,MONTH(transaction_date) AS month,COUNT(*) AS transactions_per_month
FROM transactions
GROUP BY YEAR(transaction_date), MONTH(transaction_date)
ORDER BY year, month;

# 8. TOTAL TRANSACTION AMOUNT BY BRANCH
SELECT branch, SUM(amount) AS total_amount FROM transactions GROUP BY branch;

# 9. TOTAL TRANSACTION AMOUNT BY BANK
SELECT bank_name, SUM(amount) AS total_amount
FROM transactions
GROUP BY bank_name;

# 10.TRANSACTION METHOD DISTRIBUTION
    select `transaction_method`,
count(*) as "Transaction Method Distribution" 
from transactions 
group by `transaction_method`;

# 11. HIGH RISK TRANSACTION FLAG
select
   `account_number`,`bank_name`,`branch`,`amount`,
    case 
        when `amount` > 4000 then 'HIGH_RISK'
        else 'NORMAL'
    end as High_Risk
from transactions;

# 12. Suspicious Transaction Frequency
SELECT 
    'HIGH_RISK' AS Status,
    MONTHNAME(transaction_date) AS transaction_month,
    YEAR(transaction_date) AS transaction_year,
    COUNT(*) AS suspicious_count
FROM transactions
WHERE amount > 4000
GROUP BY 
    YEAR(transaction_date),
    MONTHNAME(transaction_date),
    MONTH(transaction_date)
ORDER BY 
    transaction_year DESC,
    MONTH(transaction_date);
    
    