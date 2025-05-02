// RULE 01: SIMPLE BUT NOT SIMPLIER

int countSetBits(int value)
{
  int count = 0;
  while(value) {
    ++count;
    value = value & (value - 1);
  }
  return count;
}