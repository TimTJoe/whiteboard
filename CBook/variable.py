a1 = {1:2, 3:4}
b2 = {5:6, 7:8}
del b2[5]
b2 = {5:6}
c2 = a1 | b2 

x = [1,2]
# a,b,c = x

# a,b = b,a
# x[1:-1]
first,*middle,last = x
print(first,middle, last)

