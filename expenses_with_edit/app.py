from flask import Flask, render_template, request, redirect, url_for, flash # type: ignore
from datetime import datetime
import os
from sqlalchemy import create_engine, MetaData, Table, Column, Integer, String, Date, Time # type: ignore
from sqlalchemy.sql import select # type: ignore

app = Flask(__name__)
app.secret_key='hello'
app.config['UPLOAD_FOLDER'] = 'uploads'

# Ensure the upload directory exists
os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)

# Database Configuration
DATABASE_URI = 'mysql+pymysql://root:Riky.1234@localhost/finance_tracker'
engine = create_engine(DATABASE_URI)
metadata = MetaData()

# Define the `expenses` table
expenses = Table(
    'expenses', metadata,
    Column('ExpenseID', Integer, primary_key=True, autoincrement=True),
    Column('UserID', Integer, nullable=False),
    Column('categoryid', String(50), nullable=False),
    Column('amount', Integer, nullable=False),
    Column('expensedate', Date, nullable=False),
    Column('expensedesc', String(500)),
    Column('receiptpath', String(500)),
    Column('expensetime', Time, nullable=False)
)
# Define the `category` table
category=Table(
    'categories',metadata,
    Column('category_id',Integer,nullable=False,autoincrement=True),
    Column('category_name',String(100),nullable=False),
    Column('description',String(300),nullable=True)
)
# Create the table if it doesn't exist
metadata.create_all(engine)

def insert_expense(category, amount, expense_date, description, receipt_path, expense_time):
    """Insert a new expense into the database."""
    with engine.connect() as conn:
        conn.execute(expenses.insert().values(
            UserID=1001,  # Hardcoded for demonstration
            categoryid=category,
            amount=amount,
            expensedate=expense_date,
            expensedesc=description,
            receiptpath=receipt_path,
            expensetime=expense_time
        ))
        conn.commit()

@app.route('/')
def index():
    """Default route to display all expenses."""
    with engine.connect() as conn:
        result = conn.execute(select(expenses)).fetchall()
    return render_template('expenses.html', expenses=result)

@app.route('/form', methods=['GET'])
def form():
    """Render the expense form."""
    with engine.connect() as conn:
        result = conn.execute(select(category)).fetchall()
    print(result)
    return render_template('form.html',categories=result)

@app.route('/submit', methods=['POST'])
def submit():
    """Handle expense submission."""
    try:
        # Get required fields
        category = request.form.get('category')  # Use .get() to safely retrieve form data
        amount = int(request.form.get('amount'))
        date = request.form.get('date')
        time = request.form.get('time')
        print(category,amount,date,time)
        # Validate that we got all required fields
        if not category or not amount or not date or not time:
            return "<h1>Error: Missing required fields!</h1>", 400

        # Validate date and time
        submitted_datetime = datetime.strptime(f"{date} {time}", "%Y-%m-%d %H:%M")
        current_datetime = datetime.now()
        if submitted_datetime > current_datetime:
            return "<h1>Error: Date and time cannot be in the future!</h1>", 400

        # Get optional fields
        description = request.form.get('description', 'No description provided')
        receipt = request.files.get('receipt')

        # Save the uploaded file if provided
        receipt_path = None
        if receipt and receipt.filename:
            receipt_path = os.path.join(app.config['UPLOAD_FOLDER'], receipt.filename)
            receipt.save(receipt_path)
        else:
            receipt_path = 'No file uploaded'

        # Insert data into the database
        insert_expense(category, amount, date, description, receipt_path, time)
        # flash('New expense added successfully','info')

        # Redirect to the expenses page
        return redirect(url_for('index'))

    except Exception as e:
        return f"<h1>Error: {str(e)}</h1>", 500
    

@app.route('/edit/<int:ExpenseID>',methods=['GET','POST'])
def edit(ExpenseID):
    with engine.connect() as conn:
        updating_expense = conn.execute(select(expenses).where(expenses.c.ExpenseID==ExpenseID)).fetchone()
        categories = conn.execute(select(category)).fetchall()
    #print(updating_expense)
    #print(categories)
        if request.method == 'POST':
            try:
                # Get updated data from the form
                cat = request.form.get('category')
                amount = int(request.form.get('amount'))
                date = request.form.get('date')
                time = request.form.get('time')
                print(cat,amount,date,time)
                # Validate the data
                if not cat or not amount or not date or not time:
                    flash("Error: Missing required fields!", 'danger')
                    return redirect(request.url)

                # Validate the date and time
                submitted_datetime = datetime.strptime(f"{date} {time}", "%Y-%m-%d %H:%M")
                current_datetime = datetime.now()
                if submitted_datetime > current_datetime:
                    flash("Error: Date and time cannot be in the future!", 'danger')
                    return redirect(request.url)

                # Optional fields
                description = request.form.get('description', 'No description provided')
                receipt = request.files.get('receipt')

                # Save the uploaded file if provided
                receipt_path = None
                if receipt and receipt.filename:
                    receipt_path = os.path.join(app.config['UPLOAD_FOLDER'], receipt.filename)
                    receipt.save(receipt_path)
                else:
                    receipt_path = 'No file uploaded'
                # Update the expense in the database
                conn.execute(
                    expenses.update()
                    .where(expenses.c.ExpenseID == ExpenseID)
                    .values(
                        categoryid=cat,
                        amount=amount,
                        expensedate=date,
                        expensetime=time,
                        expensedesc=description,
                        receiptpath=receipt_path,
                    )
                )
                conn.commit()

                # flash("Expense updated successfully!", 'success')
                return redirect(url_for('index'))

            except Exception as e:
                flash(f"Error updating expense: {str(e)}", 'danger')
                return redirect(request.url)
        # Render the edit form with current expense data and category list
    return render_template('edit.html',expense=updating_expense,categories=categories)

    


if __name__ == '__main__':
    app.run(debug=True)
