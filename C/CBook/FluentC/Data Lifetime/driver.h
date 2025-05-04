struct Sender {
  char destination_ip[16];
  int socket;
};

struct Sender* createSender(char* destination_ip);
void sendByte(struct Sender* s, char data);
char recieveByte();
int getNumofSentBytes();
int getNumofRecievedBytes();

