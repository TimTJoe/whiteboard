struct INSTANCE {
  int x;
  int y;
};

struct INSTANCE* createInstance();
void operateOnInstance(struct INSTANCE* inst);
void destroyInstance(struct INSTANCE* inst);

