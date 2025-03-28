class C1:
    x = 23
print(C1.x)

class C(C1):
    x = 21

class C2:
    pass 

#__name__ and __bases___
print(C2.__name__, C1.__bases__)

#referencing attribute in class boby
class C3:
    x = 23
    y = x + 21 #use simple name reference

class C4:
    x = 24 
    def amethod(self):
        print(C4.x)

#class with method definition
class C5:
    def hello(self):
        print('Hello')

#===DESCRIPTOR===

class Const:
    def __init__(self, value):
        self.__dict__['value'] = value
    def __set__(self, *_):
        pass 
    def __get__(self, *_):
        return self.__dict__['value']
    def __delete__(self, *_):
        pass

class X:
    c = Const(23)
x = X()
print(x.c)
x.c = 24 
print(x.c)
del x.c 
print(x.c)

#INSTANCE
an_instance = C5()
print(id(an_instance))
ano_instance = C5()
print(id(an_instance))

class C6:
    def __init__(self, n):
        self.x = n

another_instance = C6(42)
print(another_instance.x)

#FACTORY FUNCTION
class SpecialCase:
    def amethod(self):
        print("Special")

class NormalCase:
    def amethod(self):
        print("Normal")

def appropriate_case(isnormal=True):
    if isnormal:
        return NormalCase()
    else:
        return SpecialCase()

aninstance = appropriate_case(isnormal=False)
print(aninstance.amethod())
    
#__NEW__ overiding __new___
class Singleton:
    _singletons = {}
    def __new__(cls, *args, **kwds):
        if cls not in cls._singletons:
            cls._singletons[cls] = obj = super().__new__(cls)
            obj._initialized = False
        return cls._singletons[cls]