Below is a well-structured `README.md` for **LeetCode 907 - Count Salary Categories**. It includes detailed explanations for the SQL solution using CTEs and a corresponding Pandas solution.

```md
# 💰 Count Salary Categories - LeetCode 907

## 📌 Problem Statement
You are given a table **Accounts** that contains information about bank accounts, including their monthly income.  
Your task is to calculate the number of bank accounts in each salary category.

The salary categories are defined as follows:
- **"Low Salary"**: Salaries strictly less than \$20,000.
- **"Average Salary"**: Salaries in the inclusive range [\$20,000, \$50,000].
- **"High Salary"**: Salaries strictly greater than \$50,000.

The result table must contain **all three categories**. If there are no accounts in a category, return 0.

Return the result in **any order**.

---

## 📊 Table Structure

### **Accounts Table**
| Column Name | Type |
| ----------- | ---- |
| account_id  | int  |
| income      | int  |

- `account_id` is the **primary key** for this table.
- Each row contains the monthly income for one bank account.

---

## 📊 Example 1:

### **Input:**
#### **Accounts Table**
| account_id | income |
| ---------- | ------ |
| 3          | 108939 |
| 2          | 12747  |
| 8          | 87709  |
| 6          | 91796  |

### **Output:**
| category       | accounts_count |
| -------------- | -------------- |
| Low Salary     | 1              |
| Average Salary | 0              |
| High Salary    | 3              |

### **Explanation:**
- **Low Salary**: Account with income 12747.
- **Average Salary**: No accounts have an income in the range [20000, 50000].
- **High Salary**: Accounts with incomes 108939, 87709, and 91796.

---

## 🖥 SQL Solution

### ✅ **Approach:**
1. **CTE "S"**: Create a static table with the three salary categories.
   ```sql
   WITH S AS (
       SELECT 'Low Salary' AS category
       UNION
       SELECT 'Average Salary'
       UNION
       SELECT 'High Salary'
   ),
   ```
   - This defines the three salary categories to ensure every category appears in the final result.

2. **CTE "T"**: Categorize each account from the **Accounts** table using a `CASE` statement and count the number of accounts in each category.
   ```sql
   T AS (
       SELECT
           CASE
               WHEN income < 20000 THEN 'Low Salary'
               WHEN income > 50000 THEN 'High Salary'
               ELSE 'Average Salary'
           END AS category,
           COUNT(1) AS accounts_count
       FROM Accounts
       GROUP BY 1
   )
   ```
   - The `CASE` statement assigns a salary category based on the income.
   - `COUNT(1)` counts the number of accounts in each category.

3. **Final SELECT with LEFT JOIN**: Combine the static category table `S` with the computed counts from `T` to ensure every category is included, using `IFNULL` to convert any missing count to 0.
   ```sql
   SELECT S.category, IFNULL(T.accounts_count, 0) AS accounts_count
   FROM S
   LEFT JOIN T USING (category);
   ```

### ✅ **Complete SQL Query:**
```sql
WITH S AS (
    SELECT 'Low Salary' AS category
    UNION
    SELECT 'Average Salary'
    UNION
    SELECT 'High Salary'
),
T AS (
    SELECT
        CASE
            WHEN income < 20000 THEN 'Low Salary'
            WHEN income > 50000 THEN 'High Salary'
            ELSE 'Average Salary'
        END AS category,
        COUNT(1) AS accounts_count
    FROM Accounts
    GROUP BY 1
)
SELECT S.category, IFNULL(T.accounts_count, 0) AS accounts_count
FROM S
LEFT JOIN T USING (category);
```

---

## 🐍 Python (Pandas) Solution

### ✅ **Approach:**
1. **Categorize Accounts**: Create a new column `category` in the DataFrame by applying the salary conditions.
2. **Group and Count**: Group by the `category` column and count the number of accounts.
3. **Merge with Static Categories**: Ensure all three salary categories appear by merging with a predefined DataFrame that contains all categories, filling missing counts with 0.

```python
import pandas as pd

def count_salary_categories(accounts: pd.DataFrame) -> pd.DataFrame:
    # Define the salary categorization function
    def categorize(income):
        if income < 20000:
            return 'Low Salary'
        elif income > 50000:
            return 'High Salary'
        else:
            return 'Average Salary'
    
    # Apply categorization
    accounts['category'] = accounts['income'].apply(categorize)
    
    # Count accounts in each category
    counts = accounts.groupby('category').size().reset_index(name='accounts_count')
    
    # Define static categories DataFrame
    categories = pd.DataFrame({
        'category': ['Low Salary', 'Average Salary', 'High Salary']
    })
    
    # Merge to ensure all categories are present, fill missing values with 0
    result = categories.merge(counts, on='category', how='left')
    result['accounts_count'] = result['accounts_count'].fillna(0).astype(int)
    
    return result

# Example usage:
# df = pd.read_csv("sample_accounts.csv")
# print(count_salary_categories(df))
```

---

## 📁 File Structure
```
📂 Count-Salary-Categories
│── README.md
│── solution.sql
│── solution_pandas.py
│── test_cases.sql
│── sample_accounts.csv
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/count-salary-categories/)
- 📝 [MySQL WITH Clause (CTE)](https://www.w3schools.com/sql/sql_with.asp)
- 🔍 [MySQL IFNULL Function](https://www.w3schools.com/sql/func_mysql_ifnull.asp)
- 🐍 [Pandas GroupBy Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.groupby.html)
```

---

### Features of this `README.md`:
- **Clear Problem Statement** with table structure and detailed example.
- **SQL Solution** with detailed explanation using CTEs and LEFT JOIN.
- **Python (Pandas) Solution** with step-by-step categorization and merging.
- **Organized File Structure** for repository management.
- **Helpful External Links** for further learning.

Let me know if you need any modifications or additional details!