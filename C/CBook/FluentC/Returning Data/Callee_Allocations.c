
// caller's code
char buffer;
int size;
getData(&buffer, &size);
// use buffer
free(buffer);

// callee's code
void getData(char** buffer, int* size)
{
  *size = data_size;
  *buffer = malloc(data_size);
  // write data to buffer
}



