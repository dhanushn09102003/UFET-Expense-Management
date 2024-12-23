import pymysql  # type: ignore

# Establish database connection
mydb = pymysql.connect(
    host="localhost",
    user="root",
    password="1234",
    database="updated_finance_tracker"  # Assuming the database already exists
)

mycursor = mydb.cursor()

# Verify connection
try:
    print("Connected to the database successfully!")
except Exception as e:
    print(f"Error: {e}")

# Close the connection
mycursor.close()
mydb.close()
