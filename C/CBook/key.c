typedef struct Key* Regkey;
Regkey createKey(char* key_name);
void storeValue(Regkey key, char* value);
void publishKey(Regkey key);

typedef enum {
  OK,
  OUT_OF_MEMORY,
  INVALID_KEY,
  INVALID_STRING,
  STRING_TOO_LONG,
  CANNOT_ADD_KEY
}RegError;

#define STRING_SIZE 100
#define MAX_KEYS 40

struct Key  
{
  char key_name[STRING_SIZE];
  char key_value[STRING_SIZE];
};

// file-global array holding all registry
static struct Key* key_list[MAX_KEYS];

Regkey createKey(char* key_name) {
  Regkey newKey = calloc(1, sizeof(struct Key));
  strcpy(newKey->key_name, key_name);
  return newKey;
}

void storeValue(Regkey key, char* value) {
  strcpy(key->key_value, value);
}

void publishKey(Regkey key) {
  int i;
  for(i = 0; i < MAX_KEYS; i++) {
    if(key_list[i] == NULL) {
      key_list[i] = key;
      return;
    }
  }
}