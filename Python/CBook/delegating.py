# class Base:
#     def greet(self, name):
#         print("Welcome", name)

# class Sub(Base):
#     def greet(self, name):
#         print('Well met and ', end='')
#         Base.greet(self, name)

# x = Sub()
# print(x.greet('Alex'))

# class Base:
#     def __init__(self):
#         self.anattribute = 23

# class Derived(Base):
#     def __init__(self):
#         Base.__init__(self)
#         self.anotherattribute = 45

class A:
    def met(self):
        print("A.met")

class B(A): 
    def met(self):
        print('B.met')
        super().met()

class C(A): 
    def met(self):
        print('C.met')
        super().met()

class D(B, C):
    def met(self):
        print('D.met')
        super().met()

d = D()
print(d.met())
