// API (Header file)
void sendByte(char data, char* destination_api);
char recieveByte();

// Implementation
void sendByte(char data, char* destination_api)
{
  // open socket to destination_api, 
  // send data via this socket 
  // and close the socket.
}

char recieveByte() {
  // Open socket for recieving data
  // wait some time and return the recieved data
}