# 🎓 Find the Number of Times Each Student Attended Each Exam - LeetCode 1204

## 📌 Problem Statement
You are given three tables: **Students**, **Subjects**, and **Examinations**, which contain information about students, subjects, and exam attendance.

### 📊 Students Table
| Column Name  | Type    |
| ------------ | ------- |
| student_id   | int     |
| student_name | varchar |
- `student_id` is the **primary key**.
- Each row represents a **unique student**.

### 📊 Subjects Table
| Column Name  | Type    |
| ------------ | ------- |
| subject_name | varchar |
- `subject_name` is the **primary key**.
- Each row represents a **unique subject**.

### 📊 Examinations Table
| Column Name  | Type    |
| ------------ | ------- |
| student_id   | int     |
| subject_name | varchar |
- **No primary key** (may contain duplicates).
- Each row indicates that a student attended an exam for a specific subject.

### 🔢 Goal:
Find the **number of times each student attended each exam**.  
If a student did **not attend an exam**, return `0`.  
Return the results **ordered by** `student_id` and `subject_name`.

---

## 📊 Example 1:
### Input:

### **Students Table**
| student_id | student_name |
| ---------- | ------------ |
| 1          | Alice        |
| 2          | Bob          |
| 13         | John         |
| 6          | Alex         |

### **Subjects Table**
| subject_name |
| ------------ |
| Math         |
| Physics      |
| Programming  |

### **Examinations Table**
| student_id | subject_name |
| ---------- | ------------ |
| 1          | Math         |
| 1          | Physics      |
| 1          | Programming  |
| 2          | Programming  |
| 1          | Physics      |
| 1          | Math         |
| 13         | Math         |
| 13         | Programming  |
| 13         | Physics      |
| 2          | Math         |
| 1          | Math         |

### Output:
| student_id | student_name | subject_name | attended_exams |
| ---------- | ------------ | ------------ | -------------- |
| 1          | Alice        | Math         | 3              |
| 1          | Alice        | Physics      | 2              |
| 1          | Alice        | Programming  | 1              |
| 2          | Bob          | Math         | 1              |
| 2          | Bob          | Physics      | 0              |
| 2          | Bob          | Programming  | 1              |
| 6          | Alex         | Math         | 0              |
| 6          | Alex         | Physics      | 0              |
| 6          | Alex         | Programming  | 0              |
| 13         | John         | Math         | 1              |
| 13         | John         | Physics      | 1              |
| 13         | John         | Programming  | 1              |

---

## 🖥 SQL Solution

### 1️⃣ Standard MySQL Query
#### **Explanation:**
- **Use `CROSS JOIN`** to generate **all possible student-subject combinations**.
- **Use `LEFT JOIN`** to attach attendance records from `Examinations`.
- **Use `COUNT(e.subject_name)`** to count how many times a student attended an exam.
- **Sort results by** `student_id` and `subject_name`.

```sql
SELECT s.student_id, s.student_name, sb.subject_name, 
       COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sb
LEFT JOIN Examinations e
ON s.student_id = e.student_id AND sb.subject_name = e.subject_name
GROUP BY s.student_id, sb.subject_name
ORDER BY s.student_id, sb.subject_name;
```

---

### 2️⃣ Alternative SQL Query (Using `COALESCE`)
```sql
SELECT s.student_id, s.student_name, sb.subject_name, 
       COALESCE(COUNT(e.subject_name), 0) AS attended_exams
FROM Students s
CROSS JOIN Subjects sb
LEFT JOIN Examinations e
ON s.student_id = e.student_id AND sb.subject_name = e.subject_name
GROUP BY s.student_id, sb.subject_name
ORDER BY s.student_id, sb.subject_name;
```
- **Uses `COALESCE(COUNT(...), 0)`** to explicitly handle `NULL` values.

---

### 3️⃣ Alternative SQL Query (Using `WITH ROLLUP`)
```sql
SELECT s.student_id, s.student_name, sb.subject_name, 
       COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sb
LEFT JOIN Examinations e
ON s.student_id = e.student_id AND sb.subject_name = e.subject_name
GROUP BY s.student_id, sb.subject_name WITH ROLLUP
HAVING GROUPING(subject_name) = 0
ORDER BY s.student_id, sb.subject_name;
```
- **Uses `WITH ROLLUP`** to generate **aggregated results**.

---

## 🐍 Pandas Solution (Python)
#### **Explanation:**
- **Generate all possible (student, subject) pairs** using `pd.merge()`.
- **Group by student_id and subject_name**, then count occurrences.
- **Fill missing values with `0`**.

```python
import pandas as pd

def student_exam_attendance(students: pd.DataFrame, subjects: pd.DataFrame, exams: pd.DataFrame) -> pd.DataFrame:
    # Create all possible student-subject combinations
    all_combinations = students.merge(subjects, how="cross")

    # Merge with exam data
    merged = all_combinations.merge(exams, on=["student_id", "subject_name"], how="left")

    # Count the number of times each student attended each exam
    result = merged.groupby(["student_id", "student_name", "subject_name"]).size().reset_index(name="attended_exams")

    return result.sort_values(["student_id", "subject_name"])
```

---

## 📁 File Structure
```
📂 Student-Exam-Attendance
│── 📜 README.md
│── 📜 solution.sql
│── 📜 solution_pandas.py
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/find-the-number-of-times-each-student-attended-each-exam/)
- 📚 [SQL `CROSS JOIN` Documentation](https://www.w3schools.com/sql/sql_join_cross.asp)
- 🐍 [Pandas Merge Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.merge.html)
