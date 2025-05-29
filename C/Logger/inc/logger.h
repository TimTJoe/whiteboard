#ifndef LOGGER_H
#define LOGGER_H

/* Prints the current timestamp followed by the provided string to stdout.
   The string must be valid until this function returns. The provided module
   identifies the software-module that calles this function. */
void logging(const char* module, const char* text){
  time_t mytime = time(NULL);
  printf("%s %s\n", ctime(&mytime), text);
}

bool enableModule(const char* module);

/* All future log file will be logged to stdout */
void logToStdout();

/* void future log message will be to be file*/
void logToFile();

#endif