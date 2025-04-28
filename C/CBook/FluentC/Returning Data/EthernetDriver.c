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
};