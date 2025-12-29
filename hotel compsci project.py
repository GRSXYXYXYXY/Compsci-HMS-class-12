import mysql.connector

# ================= GLOBAL VARIABLES =================
mycon = None
cursor = None
userName = ""
password = ""
cid = ""

room_rent_amount = 0
restaurant_bill_amount = 0

# ================= SAFE INPUT =================
def safe_int(msg):
    while True:
        try:
            return int(input(msg))
        except ValueError:
            print("Invalid input. Please try again!")

def safe_input(msg):
    try:
        return input(msg)
    except Exception as e:
        print("Input error:", e)
        return ""

# ================= MYSQL CONNECTION CHECK =================
def MYSQLconnectionCheck():
    global mycon, userName, password
    try:
        userName = safe_input("\nENTER MySQL SERVER'S USERNAME: ")
        password = safe_input("\nENTER MySQL SERVER'S PASSWORD: ")

        mycon = mysql.connector.connect(
            host="localhost",
            user=userName,
            passwd=password,
            auth_plugin='mysql_native_password'
        )

        if mycon:
            print("\nMySQL CONNECTION ESTABLISHED SUCCESSFULLY!")
            cursor = mycon.cursor()
            cursor.execute("CREATE DATABASE IF NOT EXISTS HMS")
            mycon.commit()
            cursor.close()
            return mycon

    except mysql.connector.Error as err:
        print("\nERROR ESTABLISHING MySQL CONNECTION. RECHECK USERNAME AND PASSWORD !")
        print(err)

    except Exception as e:
        print("Unexpected Error:", e)

    return None

# ================= MYSQL DATABASE CONNECTION =================
def MYSQLconnection():
    global mycon
    try:
        mycon = mysql.connector.connect(
            host="localhost",
            user=userName,
            passwd=password,
            database="HMS",
            auth_plugin='mysql_native_password'
        )
        if mycon:
            print('Running database "HMS".')
    except mysql.connector.Error as err:
        print("\nERROR ESTABLISHING MySQL CONNECTION !")
        print(err)

# ================= GUEST DETAILS =================
def guest_details():
    global cid
    try:
        cursor = mycon.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS C_DETAILS(
                CID VARCHAR(20),
                C_NAME VARCHAR(30),
                C_ADDRESS VARCHAR(30),
                C_AGE VARCHAR(30),
                C_COUNTRY VARCHAR(30),
                P_NO VARCHAR(30),
                C_EMAIL VARCHAR(30))
        """)

        cid = safe_input("Enter Guest Identification Number: ")
        name = safe_input("Enter Guest Name: ")
        address = safe_input("Enter Guest Address: ")
        age = safe_input("Enter Guest Age: ")
        nationality = safe_input("Enter Guest Country: ")
        phone_no = safe_input("Enter Guest Contact Number: ")
        email = safe_input("Enter Guest E-mail: ")

        cursor.execute(
            "INSERT INTO C_DETAILS VALUES(%s,%s,%s,%s,%s,%s,%s)",
            (cid,name,address,age,nationality,phone_no,email)
        )
        mycon.commit()
        print("\nNew Guest Registered Successfully!")

    except Exception as e:
        print("\nERROR ESTABLISHING MySQL CONNECTION !")
        print(e)

    finally:
        try:
            cursor.close()
        except:
            pass

# ================= GUEST SEARCH =================
def guest_search():
    global cid
    try:
        cid = safe_input("ENTER GUEST ID: ")
        cursor = mycon.cursor()
        cursor.execute("SELECT * FROM C_DETAILS WHERE CID=%s",(cid,))
        data = cursor.fetchall()

        if data:
            print(data)
            return True
        else:
            print("Record Not Found. Please Enter Valid ID!")
            return False

    except Exception as e:
        print("\nERROR ESTABLISHING MySQL CONNECTION!")
        print(e)
        return False

    finally:
        try:
            cursor.close()
        except:
            pass

# ================= BOOKING =================
def booking():
    try:
        if not guest_search():
            return

        cursor = mycon.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS BOOKING_RECORD(
                CID VARCHAR(20),
                CHECK_IN DATE,
                CHECK_OUT DATE)
        """)

        checkin = safe_input("\nEnter Guest Check-in Date [YYYY-MM-DD] : ")
        checkout = safe_input("\nEnter Guest Check-out Date [YYYY-MM-DD] : ")

        cursor.execute(
            "INSERT INTO BOOKING_RECORD VALUES(%s,%s,%s)",
            (cid,checkin,checkout)
        )
        mycon.commit()
        print("\nCHECK-IN AND CHECK-OUT ENTRIES MADE SUCCESSFULLY!")

    except Exception as e:
        print("\nERROR ESTABLISHING MySQL CONNECTION!")
        print(e)

    finally:
        try:
            cursor.close()
        except:
            pass

# ================= ROOM RENT =================
def room_rent():
    global room_rent_amount
    try:
        if not guest_search():
            return

        cursor = mycon.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS ROOM_RENT(
                CID VARCHAR(20),
                ROOM_CHOICE INT,
                NO_OF_DAYS INT,
                ROOM_NO INT,
                ROOM_RENT INT)
        """)

        print("""
\n^^^^^^^^^^ We Have The Following Rooms For You ^^^^^^^^^^
---------------------------------------------------------
    1. Ultra Royal - 10,000 INR
    2. Royal - 5,000 INR
    3. Elite - 3,500 INR
    4. Budget - 2,500 INR
---------------------------------------------------------
""")

        room_choice = safe_int("Enter Your Option : ")
        room_no = safe_int("Enter Customer Room No : ")
        no_of_days = safe_int("Enter No. Of Days : ")

        rates = {1:10000,2:5000,3:3500,4:2500}
        if room_choice not in rates:
            print("Invalid Input. Please Try Again!")
            return

        room_rent_amount = rates[room_choice] * no_of_days

        cursor.execute(
            "INSERT INTO ROOM_RENT VALUES(%s,%s,%s,%s,%s)",
            (cid,room_choice,no_of_days,room_no,room_rent_amount)
        )
        mycon.commit()

        print("Thank You! Your room has been booked for: ",no_of_days," days.")
        print("Your total room rent is: ",room_rent_amount," INR.")

    except Exception as e:
        print("\nERROR ESTABLISHING MySQL CONNECTION !")
        print(e)

    finally:
        try:
            cursor.close()
        except:
            pass

# ================= RESTAURANT =================
def Restaurant():
    global restaurant_bill_amount
    try:
        if not guest_search():
            return

        cursor = mycon.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS Restaurant(
                CID VARCHAR(20),
                CUISINE VARCHAR(30),
                QUANTITY VARCHAR(30),
                BILL VARCHAR(30))
        """)

        print("""
\n^^^^^^^^^^ We Have The Following Cuisine For You ^^^^^^^^^^
-----------------------------------------------------------
    1. Vegetarian Combo - 300 INR
    2. Non-Vegetarian Combo - 500 INR
    3. Veg & Non-Veg Combo - 750 INR
-----------------------------------------------------------
""")

        choice_dish = safe_int("Enter Your Cusine : ")
        quantity = safe_int("Enter Quantity : ")

        prices = {1:300,2:500,3:750}
        if choice_dish not in prices:
            print("Invalid Input. Please Try Again!")
            return

        restaurant_bill_amount = prices[choice_dish] * quantity

        cursor.execute(
            "INSERT INTO Restaurant VALUES(%s,%s,%s,%s)",
            (cid,choice_dish,quantity,restaurant_bill_amount)
        )
        mycon.commit()

        print("Your Total Bill Amount Is : Rs. ",restaurant_bill_amount)
        print("\n^^^^^^^^^^ HOPE YOU ENJOY YOUR MEAL! ^^^^^^^^^\n")

    except Exception as e:
        print("\nERROR ESTABLISHING MYSQL CONNECTION !")
        print(e)

    finally:
        try:
            cursor.close()
        except:
            pass

# ================= TOTAL BILL =================
def totalAmount():
    try:
        if not guest_search():
            return

        grandTotal = room_rent_amount + restaurant_bill_amount
        name = safe_input("Enter Guest Name : ")

        print("""
\n-------------------------------------------------------------------
~~~~~~~~~~~~~~~~~~~~~~~~ Greenfield Hotel ~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~ Customer Billing ~~~~~~~~~~~~~~~~~~~~~~~~~
""")
        print("Customer Name: " ,name)
        print("Room Rent: ",room_rent_amount,"INR")
        print("Restaurant Bill: ",restaurant_bill_amount,"INR")
        print("--------------------------------------------")
        print("TOTAL AMOUNT : ",grandTotal,"INR")
        print("""
-------------------------------------------------------------------
""")

    except Exception as e:
        print("\nERROR ESTABLISHING MySQL CONNECTION !")
        print(e)

# ================= MAIN =================
print('''
-----------------------------------------------------------------------------
---------------------- DPS PANIPAT REFINERY TOWNSHIP ------------------------
------------------------- HOTEL MANAGEMENT SYSTEM ---------------------------
-----------------------------------------------------------------------------
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Greenfield Hotel ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Designed and Maintained by:
    SANSHUBH KANAUJIA  - CLASS XII A [2025-'26]
    AYUSH SAMANTA      - CLASS XII A [2025-'26]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----------------------------------------------------------------------------
''')

mycon = MYSQLconnectionCheck()
if mycon:
    MYSQLconnection()

    while True:
        try:
            print("""
**************************************************
    Press |         To
   -------+----------------------------
      1   | Enter Guest Details.
      2   | Enter Booking Details.
      3   | Calculate Room Rent.
      4   | Calculate Restaurant Bill.
      5   | Display Guest Details.
      6   | Generate Total Bill Amount.
      7   | Finish Up and Exit.
**************************************************
""")

            choice = safe_int("Select the required operation: ")

            if choice == 1:
                guest_details()
            elif choice == 2:
                booking()
            elif choice == 3:
                room_rent()
            elif choice == 4:
                Restaurant()
            elif choice == 5:
                guest_search()
            elif choice == 6:
                totalAmount()
            elif choice == 7:
                break
            else:
                print("Invalid input. Please try again!")

        except Exception as e:
            print("Error occurred but program is continuing.")
            print(e)

    print("Greenfield Hotel management system shutting down...")

else:
    print("\nERROR ESTABLISHING MySQL CONNECTION!")
