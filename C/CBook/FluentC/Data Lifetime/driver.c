#include "./driver.h"

static int num_of_sent_bytes = 0;
static int num_of_recieved_bytes = 0;

struct Sender* createSender(char* destination_ip) {
  struct Sender* s = malloc(sizeof(struct Sender));
  return s;
}

void sendByte(struct Sender* s, char data)
{
  num_of_sent_bytes++;
}

char recieveByte() 
{
  num_of_recieved_bytes++;
}

int getNumofSentBytes() 
{
  return num_of_sent_bytes;
}

int getNumofRecievedBytes()
{
  return num_of_recieved_bytes;
}

// Caller's Code
struct Sender* s = createSender("192.168.0.1");
char* dataToSend = "Hello World";
char* pointer = dataToSend;

while (*pointer != '\0')
{
  sendByte(s, *pointer);
  pointer++;
}

destroySender(s)
