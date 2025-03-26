
# def dummyparameter(x, /, base=10):
#   console.log(/)

# def namedcollector( **named ):
#   collection = named 
#   print(collection)

# namedcollector()

def f(x, y=[]):
  y.append(x)
  return id(y), y

# print(f(23))
# print(f(42))

def j(x, y=None):
  if y is None:
    y = []
  y.append(x)
  return id(y), y

# print(j(23))
# print(j(42))

def sum_sequence(*numbers):
  """Return the sume of multiple numerical arguments.

  The arguments are zero or more numbers.
  The result is their sum.
  """
  return sum(numbers)

print(sum_sequence(23, 42))

def inc_dict(d, **values):
  for key, value in values.items():
    if key in d:
      d[key] += value
    else:
      d[key] = value 


my_dict = {'one': 1, 'two': 2}

inc_dict(my_dict, one=1, new=42)

print(my_dict)

def counter():
  counter.count += 1
  return counter.count

print(counter())