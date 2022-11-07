import psycopg2
def connectDB(username, passwrd):
    try:
        conn= psycopg2.connect(
            database="Lab10",
            user=username,
            password=passwrd,
            host='localhost',
            port='5432'
        )
        conn.autocommit=True
        return conn.cursor()
    except:
        print("none")
        return None

def studentCreate(username, password):
    carnet = int(input("Enter the carnet for the student: "))
    names = input("Enter the names for the student: ")
    surname = input("Enter the surnames for the student: ")
    query = '''insert into student(carne, names, surnames)
    values({},'{}','{}')'''.format(carnet,names,surname)
    cursor = connectDB(username=username, passwrd=password)
    cursor.execute(query)
    cursor.close()
def curseCreate(username, password):
    code = int(input("Enter the curse code: "))
    name = input("Enter the curse name: ")
    quota_act = int(input("Enter the actual quota: "))#Cupo actual
    quota_max = int(input("Enter the max quota: "))#Cupo maximo
    query = '''insert into curse(code, name, actual_quota, max_quota)
    values({},'{}',{},{})'''.format(code,name,quota_act,quota_max)
    cursor = connectDB(username=username, passwrd=password)
    cursor.execute(query)
    cursor.close()
def asignation(username, password):
    cursor = connectDB(username=username, passwrd=password)
    carnet = enterUserCarnet(username=username, password=password)
    code = enterCodeCurse(username=username, password=password)
    query1 = '''insert into asignation(carne,code)
    values({},{})'''.format(carnet,code)
    cursor.execute(query1)
    cursor.close()
def asignationForNotAdminl1(username, password):
    cursor = connectDB(username=username, passwrd=password)
    carnet = input("Enter a valid carne for the student: ")
    code = input("Enter a valid code for the curse: ")
    query1 = '''insert into asignation(carne,code)
    values({},{})'''.format(carnet,code)
    cursor.execute(query1)
    cursor.close()

def enterCodeCurse(username,password):
    while(True):
        try:
            code = input("Enter a valid code for the curse: ")
            cursor = connectDB(username=username, passwrd=password)
            print("k")
            query = '''select count(code) from curse where code = {}'''.format(code)
            print("k")
            cursor.execute(query)
            print("k")
            getamount = str(cursor.fetchone()[0])
            cursor.close()
            if (int(getamount)>0):
                return code
        except:
            print("The entered code is invalid, pleasse try again")
def enterUserCarnet(username,password):
     while(True):
        try:

            carne = input("Enter a valid carne for the student: ")
            cursor = connectDB(username=username, passwrd=password)
            query = '''select count(carne) from student where carne = {}'''.format(carne)
            cursor.execute(query)
            getamount = str(cursor.fetchone()[0])
            cursor.close()
            if (int(getamount)==1):
                return carne
        except:
            print("The entered carne is invalid, pleasse try again")
def login():
    username = input("Enter the username: ")
    password = input("Enter your password: ")
    if (connectDB(username=username, passwrd=password)!=None):
        return username,password
    else: return None
userp = login()
if (userp!=None): 
    print("Succesfully logged in "+userp[0]+"!!!")   
    while (True):
        option = input("Enter the option between\n1- Create a student\n2- Create a curse\n3- Asign a student\n4- Exit\n")
        if (option == "1"):
            studentCreate(username = userp[0],password = userp[1])
        elif (option == "2"):
            curseCreate(username = userp[0],password = userp[1])
        elif (option == "3"):
            asignationForNotAdminl1(username = userp[0],password = userp[1])
        elif (option == "4"):
            print("Thanks for using our app")
            break
else:
    print("Couldn't be logged in")