// Caller's code
int result;
result = addNext(10);
result = addNext(20);

// API (Header file)
int addNext(int value);

// Implementation
static int sum = 0;

int addNext(int value)
{
  sum = sum + value;
  return sum;
}

