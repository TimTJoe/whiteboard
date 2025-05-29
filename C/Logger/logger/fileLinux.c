#ifdef __unix__

/* Opens the logfile at the first call.*/
void* initiallyOpenLogFile(){
#ifdef __unix__
  static int fd = 0;
  if(fd == 0){
    fd = open("log.txt", O_RDWR | O_CREAT, 0666);
  }
  return fd;
}

//Write the provided buffer to the logfile.
void writeLogFile(void* fileDescriptor, const char* buffer){
  write((int) fileDescriptor, buffer, strlen(buffer));
}
#endif