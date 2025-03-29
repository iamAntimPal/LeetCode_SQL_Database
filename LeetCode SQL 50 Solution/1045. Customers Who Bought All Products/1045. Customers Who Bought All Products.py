import pandas as pd

# Sample data
customer_data = {'customer_id': [1, 2, 3, 3, 1],
                 'product_key': [5, 6, 5, 6, 6]}
product_data = {'product_key': [5, 6]}

# Create DataFrames
customer_df = pd.DataFrame(customer_data)
product_df = pd.DataFrame(product_data)

# Get the total number of products
total_products = product_df['product_key'].nunique()

# Count distinct products per customer
customer_purchase = customer_df.groupby('customer_id')['product_key'].nunique()

# Filter customers who bought all products
result = customer_purchase[customer_purchase == total_products].reset_index()

print(result)