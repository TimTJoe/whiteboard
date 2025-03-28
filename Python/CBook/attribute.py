# Attribute Reference Basics

class B:
    a = 23
    b = 45
    def f(self):
        print("Method f in class B")
    def g(self):
        print("Method g in class B")
class C(B):
    b = 67
    c = 89
    d = 123
    def g(self):
        print("Method g in class C")
    def h(self):
        print("Method h in class C")

x = C()
x.d = 77
x.e = 88

print(x.e, x.d, x.c, x.b, x.a)

def f(a, b):
    print("Function f")

class D:
    name = f 
y = D()

def make_adder(augend):
    class Adder:
        def __init__(self, augend):
            self.augend = augend
        def __call__(self, addend):
            return addend + self.augend
    return Adder(augend)

class Base:
    def gree(self, name):
        print('Welcome', name)

class Sub(Base):
    def greet("")