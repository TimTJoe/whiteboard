void main() {
  int my_data; //this variable is on the stack
}

// STACK FIRST - CLEAN-UP AUTOMATICALLY
void someCode() {
  int my_val; //will clean up at func end
  {
    int my_arr[10]; //will clean up at block end
  }
}