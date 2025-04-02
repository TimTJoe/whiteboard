void someFunction(){ 
  char* buffer = malloc(LARGE_FILE);
  if (buffer)
  {
    mainfunctionality(buffer);
  }
  free(buffer);
}

void mainfunctionality() {
  //some implementations
}