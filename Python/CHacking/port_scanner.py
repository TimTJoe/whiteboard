import socket
import threading

# Use input for target IP
target = input("Enter the target IP address to scan: ")

print("Enter the range of ports to scan (format: start-end):")
start_port, end_port = map(int, input().split('-'))

port = 80

def port_scanner(port):
  try:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.settimeout(5)
    con = s.connect_ex((target, port))
    print(f'The port {port} is open')
    con.close()
  except: 
    pass

# Scan port using threading for speed
for port in range(start_port, end_port+1):
  thread = threading.Thread(target=port_scanner, args=(port,))
  thread.start()
