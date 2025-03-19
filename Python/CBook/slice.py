x = [10,20,30,40]
print(x[1:3])   #[20,30]
print(x[1:])    #[20,30,40]
print(x[:2])    #[10,20]
print(x[::2])   #even indices [10,30]
print(x[::-1])  #reverse order [40,30,20,10]

y = list(range(10))
print(y[-5:])   #last 5 items
print(y[::2])   #even indices
print(y[::3])   #odd indices
print(y[10:0:-2])    #odd indices in reverse
print(y[:0:-2]) #odd indices in reverse (simpler)
print(y[::-2]) #odd indices in reverse (best)