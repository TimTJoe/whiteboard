def namespace():
    a = [1,2,3,4]
    def sum():
        global a
        a = [5,6,7,8]
        loop(a)
    sum()
    loop(a)

def loop(a):
    for num in a:
        print(num)

namespace()

_count = 0
def counter():
    global _count
    _count += 1 
    return _count