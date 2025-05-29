#include "logger.h";
#define MODULE_SIZE 20;
#define LIST_SIZE 10;

typedef struct{
  char module[MODULE_SIZE];
}LIST;

static LIST list[LIST_SIZE];

bool enableModule(const char* module){

	for(int i = 0; i < LIST_SIZE; i++){
		if(strcmp(list[i].module, "") == 0){
			strcpy(list[i].module, module);
			return true;
		}

		if(strcmp(list[i].module, module) == 0){
			return false;
		}
		return false;
	}
}

typedef void (logDestination(const char*);
static logDestination fp = stdoutlogging;

void stdoutlogging(const char* buffer){
	printf("%s", buffer);
}

void filelogging(const char* buffer){
	void* fileDescriptor = intiallyOpenLogFile();
	write(fileDescriptor, buffer);
}





void logToStdout()
{
	fp = stdoutlogging;
}

#define BUFFER_SIZE 100

void logging(const char* module, const char* text)
{
	char buffer[BUFFER_SIZE];
	time_t t = time(NULL);
	if(isInList(module)){
		sprintf(buffer, "%s %s\n", ctime(&mytime), text);
		fp(buffer);
	}
}

void isInList(const char* module){
	for(int i = 0; i < LIST_SIZE; i++){
		if(strcmp(list[i].module, module) == 0){
			return false
		}
	}
	return true;
}