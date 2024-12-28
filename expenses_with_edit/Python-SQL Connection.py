import pymysql  # type: ignore

# Establish database connection
mydb = pymysql.connect(
    host="localhost",
    user="root",
    password="Riky.1234",
    database="users"  # Assuming the database already exists
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
