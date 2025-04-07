import math

class Rectangle:
    __slots__ = {'width': 'rectangle width in pixels',
                 'height': 'rectangle height in pixels'}
    def __init__(self, width, height):
        self.width = width
        self.height = height 

    @property
    def area(self):
        """Area of the rectangle"""
        return self.width * self.height
    
    @area.setter
    def area(self, value):
        scale = math.sqrt(value/self.area)
        self.width *= scale
        self.height *= scale

class B:
    def f(self):
        return 23
    g = property(f)

class C(B):
    def f(self):
        return 42

c = C()
print(c.g)