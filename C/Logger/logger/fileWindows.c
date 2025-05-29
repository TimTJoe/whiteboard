#ifdef __WIN32__
/* Opens the logfile at the first call.*/

void* initiallyOpenLogFile(){
  static HANDLE hFile = NULL;
  if(hFile == NULL){
    hfile = CreateFileA("log.txt", GENERIC_WRITE, 0, NULL, CREATE_NEW, FILE_ATTRIBUTE_NORMAL, NULL);
  }
  return hFile;

//Write the provided buffer to the logfile.
void writeLogFile(void* fileDescriptor, const char* buffer){
  Writefile((HANDLE) fileDescriptor, buffer, strlen(buffer), NULL, NULL);
}
#endif