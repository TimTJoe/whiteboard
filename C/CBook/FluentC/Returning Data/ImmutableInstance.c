const struct ImmutableInstance* instance;
instance = getData();
/**
 * use instance->x;
 * use instance->y;
 */

struct ImmutableInstance
{
  int x;
  int y;
};

static struct ImmutableInstance inst = {12, 13};
const struct ImmutableInstance* getData()
{
  return &inst;
};


