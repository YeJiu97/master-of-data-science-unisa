#import modules
 
from tkinter import *
import os

# Function to toggle password visibility in registration page based on checkbox state

def toggle_password_visibility_register():
    if show_password_var_register.get() == 1:
        password_entry.config(show='')
    else:
        password_entry.config(show='*')
 
# Designing window for registration

def register():
    global register_screen
    register_screen = Toplevel(main_screen)
    register_screen.title("Register")
    register_screen.geometry("500x300")
 
    global username
    global password
    global password_repeat
    global username_entry
    global password_entry
    global password_repeat_entry
    username = StringVar()
    password = StringVar()
    password_repeat = StringVar()
 
    Label(register_screen, text="Please enter details below").pack()
    Label(register_screen, text="").pack()
    username_label = Label(register_screen, text="Username * ")
    username_label.pack()
    username_entry = Entry(register_screen, textvariable=username)
    username_entry.pack()
    password_label = Label(register_screen, text="Password * ")
    password_label.pack()
    password_entry = Entry(register_screen, textvariable=password, show='*')
    password_entry.pack()
    password_repeat_label = Label(register_screen, text="Repeat Password * ")
    password_repeat_label.pack()
    password_repeat_entry = Entry(register_screen, textvariable=password_repeat, show='*')
    password_repeat_entry.pack()
    
    global show_password_var_register
    show_password_var_register = IntVar()
    show_password_checkbox_register = Checkbutton(register_screen, text="Show Password", variable=show_password_var_register, command=toggle_password_visibility_register)
    show_password_checkbox_register.pack()
    
    Label(register_screen, text="").pack()
    Button(register_screen, text="Register", width=10, height=1, command=register_user).pack()


 
# Designing window for login 
 
def login():
    global login_screen
    login_screen = Toplevel(main_screen)
    login_screen.title("Login")
    login_screen.geometry("300x250")
    Label(login_screen, text="Please enter details below to login").pack()
    Label(login_screen, text="").pack()
 
    global username_verify
    global password_verify
 
    username_verify = StringVar()
    password_verify = StringVar()
 
    global username_login_entry
    global password_login_entry
 
    Label(login_screen, text="Username * ").pack()
    username_login_entry = Entry(login_screen, textvariable=username_verify)
    username_login_entry.pack()
    Label(login_screen, text="").pack()
    Label(login_screen, text="Password * ").pack()
    password_login_entry = Entry(login_screen, textvariable=password_verify, show='*')
    password_login_entry.pack()
    
    global show_password_var
    show_password_var = IntVar()
    show_password_checkbox = Checkbutton(login_screen, text="Show Password", variable=show_password_var, command=toggle_password_visibility)
    show_password_checkbox.pack()
    
    Label(login_screen, text="").pack()
    Button(login_screen, text="Login", width=10, height=1, command=login_verify).pack()
 

# Implementing event on register button 
def register_user():
    username_info = username.get()
    password_info = password.get()
    password_repeat_info = password_repeat.get()

    # Check if username is empty
    if not username_info:
        Label(register_screen, text="Username cannot be empty", fg="red").pack()
        return

    # Check if passwords match
    if password_info != password_repeat_info:
        Label(register_screen, text="Passwords do not match", fg="red").pack()
        return

    # Check password complexity
    if len(password_info) < 6 or not any(char.isdigit() for char in password_info) or not any(char.isalpha() for char in password_info):
        Label(register_screen, text="Password must be at least 6 characters long and contain both letters and numbers", fg="red").pack()
        return

    # Registration success
    # Create the 'accounts' directory if it doesn't exist
    if not os.path.exists('accounts'):
        os.makedirs('accounts')

    # Write user information to a file in the 'accounts' directory
    file_path = os.path.join('accounts', username_info)
    with open(file_path, "w") as file:
        file.write(username_info + "\n")
        file.write(password_info)

    username_entry.delete(0, END)
    password_entry.delete(0, END)
    password_repeat_entry.delete(0, END)

    Label(register_screen, text="Registration Success", fg="green", font=("calibri", 11)).pack()


# Implementing event on login button

def login_verify():
    username1 = username_verify.get()
    password1 = password_verify.get()
    username_login_entry.delete(0, END)
    password_login_entry.delete(0, END)

    # Search for the user file in the 'accounts' directory
    file_path = os.path.join('accounts', username1)
    if os.path.exists(file_path):
        with open(file_path, "r") as file:
            verify = file.readlines()
            stored_username = verify[0].strip()
            stored_password = verify[1].strip()

        if username1 == stored_username and password1 == stored_password:
            login_success()
        else:
            password_not_recognised()
    else:
        user_not_found()
 
# Designing popup for login success
 
def login_success():
    global login_success_screen
    login_success_screen = Toplevel(login_screen)
    login_success_screen.title("Success")
    login_success_screen.geometry("150x100")
    Label(login_success_screen, text="Login Success").pack()
    Button(login_success_screen, text="OK", command=delete_login_success).pack()
 
# Designing popup for login invalid password
 
def password_not_recognised():
    global password_not_recog_screen
    password_not_recog_screen = Toplevel(login_screen)
    password_not_recog_screen.title("Success")
    password_not_recog_screen.geometry("150x100")
    Label(password_not_recog_screen, text="Invalid Password ").pack()
    Button(password_not_recog_screen, text="OK", command=delete_password_not_recognised).pack()
 
# Designing popup for user not found
 
def user_not_found():
    global user_not_found_screen
    user_not_found_screen = Toplevel(login_screen)
    user_not_found_screen.title("Success")
    user_not_found_screen.geometry("150x100")
    Label(user_not_found_screen, text="User Not Found").pack()
    Button(user_not_found_screen, text="OK", command=delete_user_not_found_screen).pack()
 
# Deleting popups
 
def delete_login_success():
    login_success_screen.destroy()
 
 
def delete_password_not_recognised():
    password_not_recog_screen.destroy()
 
 
def delete_user_not_found_screen():
    user_not_found_screen.destroy()

# Function to toggle password visibility based on checkbox state
def toggle_password_visibility():
    if show_password_var.get() == 1:
        password_login_entry.config(show='')
    else:
        password_login_entry.config(show='*')
 
# Designing Main(first) window
 
def main_account_screen():
    global main_screen
    main_screen = Tk()
    main_screen.geometry("500x300")
    main_screen.title("Account Login")
    Label(text="Select Your Choice", width="300", height="2", font=("Calibri", 13)).pack()
    Label(text="").pack()
    Button(text="Login", height="2", width="30", command=login).pack()
    Label(text="").pack()
    Button(text="Register", height="2", width="30", command=register).pack()
    Label(text = "      ").pack()
    Label(text="Power by UniSA Students @Copyright", width="300", height="2", font=("Calibri", 13)).pack()
 
    main_screen.mainloop()
 
 
main_account_screen()
