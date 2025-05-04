#include "./coi.h";

// Implementations codes
struct INSTANCE* createInstance(){
  struct INSTANCE* inst;
  inst = malloc(sizeof(struct INSTANCE));
  return inst;
}

void operateOnInstance(struct INSTANCE* inst){
  // Work on inst-> x, inst->y
}

void destroyInstance(struct INSTANCE* inst) {
  free(inst)
}

// Caller's code
struct INSTANCE* inst;
inst = createInstance();
operateOnInstance(inst);
// use: inst->x, inst->y
destroyInstance(inst);
