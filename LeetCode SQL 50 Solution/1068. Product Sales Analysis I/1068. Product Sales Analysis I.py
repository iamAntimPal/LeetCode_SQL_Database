import pandas as pd

# Sample Data
sales_data = {'sale_id': [1, 2, 7], 
              'product_id': [100, 100, 200], 
              'year': [2008, 2009, 2011], 
              'quantity': [10, 12, 15], 
              'price': [5000, 5000, 9000]}

product_data = {'product_id': [100, 200, 300], 
                'product_name': ['Nokia', 'Apple', 'Samsung']}

# Create DataFrames
sales_df = pd.DataFrame(sales_data)
product_df = pd.DataFrame(product_data)

# Perform Join
result = sales_df.merge(product_df, on='product_id')[['product_name', 'year', 'price']]

print(result)