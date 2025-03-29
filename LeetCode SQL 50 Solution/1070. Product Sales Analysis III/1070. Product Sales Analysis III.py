import pandas as pd

# Sample Data
sales_data = {'sale_id': [1, 2, 7], 
              'product_id': [100, 100, 200], 
              'year': [2008, 2009, 2011], 
              'quantity': [10, 12, 15], 
              'price': [5000, 5000, 9000]}

# Create DataFrame
sales_df = pd.DataFrame(sales_data)

# Find the first sale per product
first_sales = sales_df.loc[sales_df.groupby('product_id')['year'].idxmin(), ['product_id', 'year', 'quantity', 'price']]

# Rename columns
first_sales.rename(columns={'year': 'first_year'}, inplace=True)

print(first_sales)