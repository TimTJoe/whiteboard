#define ARRAY_SIZE 1024

int global_arr[ARRAY_SIZE];
static int global_file[ARRAY_SIZE];

void someCode() {
  static local_file[ARRAY_SIZE];
}