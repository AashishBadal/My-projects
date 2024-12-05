import os
import json
import datetime

def load_data():
    admins = []
    customers = []
    account_counter = 1000
    super_user = {}
    try:
        with open("admins.json", "r") as file:
            admins = json.load(file)
    except FileNotFoundError:
        pass

    try:
        with open("customers.json", "r") as file:
            customers = json.load(file)
    except FileNotFoundError:
        pass

    try:
        with open("account_counter.txt", "r") as file:
            account_counter = int(file.read())
    except FileNotFoundError:
        pass

    return admins, customers, account_counter, super_user

def save_data(admins, customers, account_counter):
    with open("admins.json", "w") as file:
        json.dump(admins, file)

    with open("customers.json", "w") as file:
        json.dump(customers, file)

    with open("account_counter.txt", "w") as file:
        file.write(str(account_counter))

def create_super_user(admins):
    username = "admin"
    password = "admin123"
    name = "Super User"
    address = ""
    email = ""
    phone = ""
    super_user = {"username": username, "password": password, "name": name,
                  "address": address, "email": email, "phone": phone}
    admins.append(super_user)
    save_data(admins, [], 1000)
    return super_user

def save_admin_to_file(admin):
    filename = f"admin_{admin['username']}.txt"
    directory = "admins"
    if not os.path.exists(directory):
        os.makedirs(directory)
    filepath = os.path.join(directory, filename)
    try:
        with open(filepath, "w") as file:
            file.write(f"Admin Details for Username: {admin['username']}\n")
            file.write(f"Name: {admin['name']}\n")
            file.write(f"Address: {admin['address']}\n")
            file.write(f"Email: {admin['email']}\n")
            file.write(f"Phone: {admin['phone']}\n")
        print(f"Admin details saved to {filepath}")  
    except Exception as e:
        print(f"An error occurred while saving admin details to {filepath}: {e}")

def save_customer_to_file(customer):
    filename = f"customer_{customer['account_number']}.txt"
    directory = "customers"
    if not os.path.exists(directory):
        os.makedirs(directory)
    filepath = os.path.join(directory, filename)
    try:
        with open(filepath, "w") as file:
            file.write(f"Customer Details for Account Number: {customer['account_number']}\n")
            file.write(f"Name: {customer['name']}\n")
            file.write(f"Address: {customer['address']}\n")
            file.write(f"Email: {customer['email']}\n")
            file.write(f"Phone: {customer['phone']}\n")
            file.write(f"Account Type: {customer['account_type']}\n")
            file.write(f"Balance: RM{customer['balance']}\n")
        print(f"Customer details saved to {filepath}")  
    except Exception as e:
        print(f"An error occurred while saving customer details to {filepath}: {e}")

def save_transaction_to_file(customer, transaction_date, transaction_type, amount):
    filename = f"transaction_history_{customer['account_number']}.txt"
    directory = "transactions"
    if not os.path.exists(directory):
        os.makedirs(directory)
    filepath = os.path.join(directory, filename)
    try:
        with open(filepath, "a") as file:
            file.write(f"{transaction_date}: {transaction_type} RM{amount}\n")
        print(f"Transaction details saved to {filepath}")  
    except Exception as e:
        print(f"An error occurred while saving transaction details to {filepath}: {e}")

def modify_default_password(customers, new_default_password):
    for customer in customers:
        customer["password"] = new_default_password
    save_data([], customers, 1000)

def delete_customer_account(customers, account_number):
    for customer in customers:
        if customer["account_number"] == account_number:
            customers.remove(customer)
            save_data([], customers, 1000)
            print("Customer account deleted successfully.")
            return
    print("Customer account not found.")

def update_customer_account_type(customers, account_number, new_account_type):
    for customer in customers:
        if customer["account_number"] == account_number:
            customer["account_type"] = new_account_type
            save_data([], customers, 1000)
            print("Customer account type updated successfully.")
            return
    print("Customer account not found.")

def update_customer_balance(customers, account_number, new_balance):
    for customer in customers:
        if customer["account_number"] == account_number:
            customer["balance"] = new_balance
            save_data([], customers, 1000)
            print("Customer balance updated successfully.")
            return
    print("Customer account not found.")

def super_user_login(super_user, username, password):
    return super_user.get("username") == username and super_user.get("password") == password

def update_admin_details(admins, admin_username, address, email, phone):
    admin = find_admin(admins, admin_username)
    if admin:
        admin["address"] = address
        admin["email"] = email
        admin["phone"] = phone
        save_data(admins, [], 1000)
        print("Admin details updated successfully.")
    else:
        print("Admin not found.")

def update_customer_details(admins, customers, admin_username, account_number, address, email, phone):
    admin = find_admin(admins, admin_username)
    if admin:
        customer = find_customer(customers, account_number)
        if customer:
        
            
            customer["address"] = address
            customer["email"] = email
            customer["phone"] = phone
            save_data(admins, customers, 1000)
            print("Customer details updated successfully.")
        else:
            print("Invalid account number.")
    else:
        print("Admin not found.")

def create_admin_account(admins, username, name, address, email, phone):
    default_password = "123"  
    admin = {"username": username, "password": default_password, "name": name,
             "address": address, "email": email, "phone": phone}
    admins.append(admin)
    save_data(admins, [], 1000)
    save_admin_to_file(admin)
    print("Admin account created successfully.")
    print(f"Default password for the admin '{username}' is: {default_password}")
    return admin

def create_customer_account(customers, name, address, email, phone, account_type):
    account_counter = generate_account_number()
    default_password = "123"  
    customer = {"name": name, "address": address, "email": email, "phone": phone,
                "account_number": account_counter, "password": default_password, "account_type": account_type,
                "balance": 0, "transactions": []}
    customers.append(customer)
    save_data([], customers, account_counter)
    save_customer_to_file(customer)
    print("Customer account created successfully.")
    print(f"Default password for the customer '{name}' is: {default_password}")
    return customer

def generate_account_number():
    with open("account_counter.txt", "r") as file:
        account_counter = int(file.read())
    account_counter += 1
    with open("account_counter.txt", "w") as file:
        file.write(str(account_counter))
    return account_counter

def admin_login(admins, username, password):
    for admin in admins:
        if admin["username"] == username and admin["password"] == password:
            return True
    print("Invalid username or password.")
    return False

def customer_login(customers, account_number, password):
    for customer in customers:
        if customer["account_number"] == account_number and customer["password"] == password:
            return customer
    print("Invalid account number or password.")
    return None

def display_admins(admins):
    print("\nAdmin Accounts:")
    if not admins:
        print("No admin accounts found.")
    else:
        for admin in admins:
            print(admin)

def display_customers(customers):
    print("\nCustomer Accounts:")
    if not customers:
        print("No customer accounts found.")
    else:
        for customer in customers:
            print(customer)

def find_admin(admins, username):
    for admin in admins:
        if admin["username"] == username:
            return admin
    return None

def find_customer(customers, account_number):
    for customer in customers:
        if customer["account_number"] == account_number:
            return customer
    return None

def deposit(customers, account_number, amount):
    customer = find_customer(customers, account_number)
    if customer:
        transaction_date = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        customer["balance"] += amount
        customer["transactions"].append({"type": "Deposit", "amount": amount, "date": transaction_date})
        save_data([], customers, 1000)
        save_transaction_to_file(customer, transaction_date, "Deposit", amount)
        print(f"Deposit of RM{amount} made successfully. New balance: RM{customer['balance']}")
    else:
        print("Invalid account number.")

def withdraw(customers, account_number, amount):
    customer = find_customer(customers, account_number)
    if customer:
        transaction_date = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        min_balance = 100 if customer["account_type"].lower() == "savings" else 500
        if customer["balance"] - amount >= min_balance:
            customer["balance"] -= amount
            customer["transactions"].append({"type": "Withdrawal", "amount": amount, "date": transaction_date})
            save_data([], customers, 1000)
            save_transaction_to_file(customer, transaction_date, "Withdrawal", amount)
            print(f"Withdrawal of RM{amount} made successfully. New balance: RM{customer['balance']}")
        else:
            print("Withdrawal amount will affect minimum balance. Transaction not permitted.")
    else:
        print("Invalid account number.")

def change_password(customers, account_number, new_password):
    customer = find_customer(customers, account_number)
    if customer:
        customer["password"] = new_password
        save_data([], customers, 1000)
        print("Password changed successfully.")
    else:
        print("Invalid account number.")

def generate_statement_of_account(customers, account_number, start_date, end_date):
    customer = find_customer(customers, account_number)
    if customer:
        filename = f"statement_of_account_{customer['account_number']}.txt"
        with open(filename, "w") as file:
            file.write(f"Statement of Account for Account Number: {customer['account_number']}\n")
            file.write(f"Customer Name: {customer['name']}\n")
            file.write(f"Account Type: {customer['account_type']}\n")
            file.write(f"Period: {start_date} to {end_date}\n")
            file.write("\n")
            total_deposits = 0
            total_withdrawals = 0
            for transaction in customer["transactions"]:
                if start_date <= transaction["date"] <= end_date:
                    file.write(f"{transaction['date']}: {transaction['type']} RM{transaction['amount']}\n")
                    if transaction["type"] == "Deposit":
                        total_deposits += transaction["amount"]
                    elif transaction["type"] == "Withdrawal":
                        total_withdrawals += transaction["amount"]
            file.write("\n")
            file.write(f"Total Deposits: RM{total_deposits}\n")
            file.write(f"Total Withdrawals: RM{total_withdrawals}\n")
            file.write(f"Final Balance: RM{customer['balance']}\n")
            print(f"Statement of Account generated and saved to {filename}")
    else:
        print("Invalid account number.")

def main_menu():
    admins, customers, account_counter, super_user = load_data()
    if not super_user:
        super_user = create_super_user(admins)
    while True:
        print("\nMain Menu:")
        print("1. Login as Admin")
        print("2. Login as Customer")
        print("3. Super User Login")
        print("4. Exit")
        choice = input("Enter your choice: ")

        if choice == "1":
            print("\nAdmin Login:")
            username = input("Enter username: ")
            password = input("Enter password: ")
            if admin_login(admins, username, password):
                print("Admin login successful.")
                admin_menu(username, admins, customers)
            else:
                print("Invalid username or password.")

        elif choice == "2":
            print("\nCustomer Login:")
            account_number = int(input("Enter account number: "))
            password = input("Enter password: ")
            customer = customer_login(customers, account_number, password)
            if customer:
                print("Customer login successful.")
                while True:
                    print("\nCustomer Menu:")
                    print("1. Deposit")
                    print("2. Withdraw")
                    print("3. Change Password")
                    print("4. Generate Statement of Account")
                    print("5. Logout")
                    customer_choice = input("Enter your choice: ")
                    if customer_choice == "1":
                        amount = float(input("Enter amount to deposit: "))
                        deposit(customers, account_number, amount)
                    elif customer_choice == "2":
                        amount = float(input("Enter amount to withdraw: "))
                        withdraw(customers, account_number, amount)
                    elif customer_choice == "3":
                        new_password = input("Enter new password: ")
                        change_password(customers, account_number, new_password)
                    elif customer_choice == "4":
                        start_date = input("Enter start date (YYYY-MM-DD): ")
                        end_date = input("Enter end date (YYYY-MM-DD): ")
                        generate_statement_of_account(customers, account_number, start_date, end_date)
                    elif customer_choice == "5":
                        print("Logging out...")
                        break
                    else:
                        print("Invalid choice. Please try again.")
            else:
                print("Invalid account number or password.")

        elif choice == "3":
            print("\nSuper User Login:")
            username = input("Enter username: ")
            password = input("Enter password: ")
            if super_user_login(super_user, username, password):
                print("Super User login successful.")
                super_user_menu(admins, customers, super_user)
            else:
                print("Invalid username or password.")

        elif choice == "4":
            print("Exiting...")
            save_data(admins, customers, account_counter)
            break

        else:
            print("Invalid choice. Please try again.")

def admin_menu(admin_username, admins, customers):
    while True:
        print("\nAdmin Menu:")
        print("1. Create Customer Account")
        print("2. Modify Default Password")
        print("3. Delete Customer Account")
        print("4. Update Customer Account Type")
        print("5. Update Customer Balance")
        print("6. Update Admin Details")
        print("7. Update Customer Details")
        print("8. Display Admins")
        print("9. Display Customers")
        print("10. Logout")
        admin_choice = input("Enter your choice: ")

        if admin_choice == "1":
            name = input("Enter customer name: ")
            address = input("Enter customer address: ")
            email = input("Enter customer email: ")
            phone = input("Enter customer phone: ")
            account_type = input("Enter account type (Savings/Current): ")
            create_customer_account(customers, name, address, email, phone, account_type)

        elif admin_choice == "2":
            new_default_password = input("Enter new default password: ")
            modify_default_password(customers, new_default_password)

        elif admin_choice == "3":
            account_number = int(input("Enter account number to delete: "))
            delete_customer_account(customers, account_number)

        elif admin_choice == "4":
            account_number = int(input("Enter account number to update: "))
            new_account_type = input("Enter new account type (Savings/Current): ")
            update_customer_account_type(customers, account_number, new_account_type)

        elif admin_choice == "5":
            account_number = int(input("Enter account number to update: "))
            new_balance = float(input("Enter new balance: "))
            update_customer_balance(customers, account_number, new_balance)

        elif admin_choice == "6":
            address = input("Enter new address: ")
            email = input("Enter new email: ")
            phone = input("Enter new phone: ")
            update_admin_details(admins, admin_username, address, email, phone)

        elif admin_choice == "7":
            account_number = int(input("Enter customer account number to update: "))
            address = input("Enter new address: ")
            email = input("Enter new email: ")
            phone = input("Enter new phone: ")
            update_customer_details(admins, customers, admin_username, account_number, address, email, phone)

        elif admin_choice == "8":
            display_admins(admins)

        elif admin_choice == "9":
            display_customers(customers)

        elif admin_choice == "10":
            print("Logging out...")
            break

        else:
            print("Invalid choice. Please try again.")

def super_user_menu(admins, customers, super_user):
    while True:
        print("\nSuper User Menu:")
        print("1. Create Admin Account")
        print("2. Display Admins")
        print("3. Display Customers")
        print("4. Logout")
        super_user_choice = input("Enter your choice: ")

        if super_user_choice == "1":
            username = input("Enter admin username: ")
            name = input("Enter admin name: ")
            address = input("Enter admin address: ")
            email = input("Enter admin email: ")
            phone = input("Enter admin phone: ")
            create_admin_account(admins, username, name, address, email, phone)

        elif super_user_choice == "2":
            display_admins(admins)

        elif super_user_choice == "3":
            display_customers(customers)

        elif super_user_choice == "4":
            print("Logging out...")
            break

        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main_menu()
