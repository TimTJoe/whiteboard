struct DriverStat
{
  int recieved_packets;
  int total_sent_packets;
  int successfully_sent_packets;
  int failed_sent_packets;
};

struct DriverInfo
{
  char name[64];
  char description[1024];
};

struct DriverStat getStats();
const struct DriverInfo* getInfo();

struct IpAddress 
{
  char address[16];
  char subnet[16];
};

struct Packet 
{
  char data[5000];
  int size;
};
// Return a pointer to a package that has to be freed by the caller
struct Packet* getPacket();

/* Store the IP information in 'ip', which has to be provided by the caller*/
void getIP(struct IpAddress* ip);



void ethShow() 
{
  struct DriverStat stats = getStats();
  printf("%i packet recieved\n", stats.recieved_packets);
  printf("%i packet sent\n", stats.failed_sent_packets);
  printf("%i packet successfully sent\n", stats.successfully_sent_packets);
  printf("%i packet failed to send\n", stats.failed_sent_packets);

  const struct DriverInfo* info = getInfo();
  printf("Driver name: %s\n", info->name);
  printf("Driver description: %s\n", info->description);

  struct IpAddress* ip;
  getIP(&ip);
  printf("Ip Address: %s\n", ip->address);

  struct Packet* packet = getPacket();
  printf("Packet Dumb:");
  fwrite(packet->data, 1, packet->size, stdout);
  free(packet);

};