// Caller code
int result = sum(10, 20);

// API (Header File)
// Return the sum of the two params
int sum(int summand1, int summand2);

// Implementation

int sum(int summand1, int summand2)
{
  /**
   * calculate result only depending on parameters
   * not requiring any state information
   */
  return summand1 + summand2;
}