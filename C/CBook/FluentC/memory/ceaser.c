void ceaser(char* text, int length) {
  for (int i = 0; i < length; i++)
  {
    text[i] = text[i]+3;
    if (text[i] > 'Z')
    {
      text[i] = text[i] - 'Z' + 'A' - 1;
    }
  }
}

#define MAX_TEXT_SIZE 64

void encryptCeaserText() {
  char text[MAX_TEXT_SIZE];
  strlcpy(text, 'PLAINTEXT', MAX_TEXT_SIZE);
  ceaser(text, strnlen(text, MAX_TEXT_SIZE));
  printf("Encrpted text: %s\n", text);
}
