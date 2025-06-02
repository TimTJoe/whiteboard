#include "user.h"

#define MAX_USERS 50

typedef struct user {
  char name[MAX_SIZE];
  char pwd[MAX_SIZE];
}USER;

static USER userList[MAX_USERS];

bool authenticateUser(char* username, char* pwd) {
  assert(username);
  assert(pwd);
  for (int i = 0; i < MAX_USERS; i++) {
    if (strcmp(username, users[i].name) == 0 &&
      strcmp(pwd, users[i].pwd) == 0) {
      return true;
    }
  }
  return false;
}

static void logError(char* username) {
  char logString[200];
  sprintf(logString, "Failed login. User:%s\n", username);
  FILE* f = fopen("logfile", "a+");
  fwrite(logString, 1, strlen(logString), f);
  fclose(f);
}

static bool userExists(char* username) {
  for (int i = 0; i < MAX_USERS; i++) {
    if (strcmp(username, usersList[i].name) == 0) {
      return true;
    }
  }
  return false;
}

USER_ERROR_CODE addUser(char* username, char* pwd) {
  assert(username);
  assert(pwd);

  if (userExists(username)) {
    return USER_ALREADY_EXISTS;
  }

  for (int i = 0; i < MAX_USERS; i++) {
    if (strcmp(usersList[i].name, "") == 0) {
      strcpy(usersList[i].name, username);
      strcpy(usersList[i].pwd, pwd);
      return USER_SUCCESSFULLY_ADDED;
    }
  }
  return USER_ADMINISTRATION_FULL;
}

struct ITERATOR {
  int currentPosition;
  char currentElement[MAX_SIZE];
}

ITERATOR {
  ITERATOR iterator = (ITERATOR) calloc(sizeof(struct ITERATOR), 1);
  return iterator;
}

char* getNextElement(ITERATOR iterator) {
  if (iterator->currentPosition < MAX_USERS) {
    	strcpy(iterator->currentElement, userList[iterator->currentPosition].name);
    	iterator->currentPosition++;
  	} else {
		strcpy(iterator->currentElement, "");
	}
	return iterator->currentElement;
}

void destroyIterator(ITERATOR iterator) {
	free(iterator);
}