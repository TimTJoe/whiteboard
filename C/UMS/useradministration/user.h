#ifndef USER_H
#define USER_H

#define MAX_SIZE 50

/* Return true if the provided username exist and
if the provided password is correct for the user.
*/
bool authenticateUser(char* username, char* pwd);

typedef enum{
  USER_SUCCESSFULLY_ADDED,
  USER_ALREADY_EXISTS,
  USER_ADMINISTRATION_FULL
}USER_ERROR_CODE;

/* Adds a new user with the provided `username' and the provided password
   `pwd' (asserts on NULL). Returns USER_SUCCESSFULLY_ADDED on success,
   USER_ALREADY_EXISTS if a user with the provided username already exists
   and USER_ADMINISTRATION_FULL if no more users can be added. */
USER_ERROR_CODE addUser(char* username, char* pwd);


typedef struct ITERATOR* ITERATOR;
 /* Create an iterator instance. Returns NULL on error. */
ITERATOR createIterator();
 /* Retrieves the next element from an iterator instance. */
char* getNextUser(ITERATOR iterator);
 /* Destroys an iterator instance. */
void destroyIterator(ITERATOR iterator);

#endif
