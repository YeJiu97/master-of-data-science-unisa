import os
import json
from tkinter import *

# Function to handle login
def login():
    username = uname.get()
    password = pwd.get()

    # Check if the 'accounts' directory exists
    if not os.path.exists('accounts'):
        print('No accounts exist')
        return

    # Define the file path for the user's account
    user_file = os.path.join('accounts', f'{username}.json')

    # Check if the user file exists
    if os.path.exists(user_file):
        # Load user data from JSON file
        with open(user_file, 'r') as f:
            user_data = json.load(f)
        
        # Check if the password matches
        if user_data['password'] == password:
            print('Login successful')
        else:
            print('Incorrect password')
    else:
        print('User does not exist')

# Function to handle registration
def register():
    username = uname.get()
    password = pwd.get()

    # Check if the 'accounts' directory exists, if not, create it
    if not os.path.exists('accounts'):
        os.makedirs('accounts')

    # Define the file path for the user's account
    user_file = os.path.join('accounts', f'{username}.json')

    # Check if the user already exists
    if os.path.exists(user_file):
        print('User already exists')
    else:
        # Create user data dictionary
        user_data = {'username': username, 'password': password}

        # Write user data to JSON file
        with open(user_file, 'w') as f:
            json.dump(user_data, f)
        print('Registration successful')

# Set up the tkinter window
win = Tk()
win.title('Login')
win.geometry('300x150')
win.resizable(0, 0)

# Set up the account
Label(text='Username:').place(x=50, y=30)
uname = Entry(win)
uname.place(x=100, y=30)

# Set up the password
Label(text='Password:').place(x=50, y=70)
pwd = Entry(win)
pwd.place(x=100, y=70)

# Login button
Button(text='Login', command=login).place(x=100, y=110)

# Register button
Button(text='Register', command=register).place(x=160, y=110)

win.mainloop()
