x = 345 

if x < 0:
    print("x is negative")
elif x % 2:
    print("x is positive and odd")
else:
    print("x is even and nonnegative")

count = 0

while x > 0:
    x //= 2
    count += 1
print("The approximate log2 is ", count)