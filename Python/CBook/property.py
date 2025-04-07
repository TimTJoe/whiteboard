import math

class Rectangle:
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