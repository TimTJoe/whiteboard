# lambda paramters: expression

a_list = [-2, -1, 0, 1, 2]
print(sorted(a_list, key=lambda x: x * x))

def squard(value):
    return value * value
print(sorted(a_list, key=squard))
