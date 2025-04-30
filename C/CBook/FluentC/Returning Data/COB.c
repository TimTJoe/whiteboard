// Caller-Owned Buffer

// Caller's code

struct Buffer buffer;

getDate(&buffer);
// use buffer.data

// Callee's API
#define BUFFER_SIZE 256

struct buffer
{
  char data[BUFFER_SIZE];
};

void getData(struct buffer* buffer);

// Callee Implementation

// void getData(struct Buffer* buffer) {
//   memcpy(buffer->data, some_data, BUFFER_SIZE);
// }

