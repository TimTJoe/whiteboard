def fake_getter(idx):
  return idx

class myClass:
  pass

n = myClass()

# n.__getitem__ = fake_getter

# print(n[23])

def noway(dict, list):
  pass

noway([], ())