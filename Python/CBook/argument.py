
_b = 10

def add(a):
    global _b
    _b += a
    print(a)

print(add(_b))
print(_b)