#replacing using slice
x = [10,20,30,40]
x[1:3] = [50,60,70,80,90]
# print(x)

#remove the target slice
y=[10,20,30]
# y[0:1] = []
y[0:2] *= 0
# print(y)
z = [0,1,2,3]
z[:] = [10,20,30]
# print(z)

l = [30,40,50,60,70]
i = l.index(30)
i = l.count(2)
print(i)