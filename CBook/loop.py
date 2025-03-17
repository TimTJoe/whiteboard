s = [2,3,4,5,6,7,8,9]

#destructive loop
while s:
    item = s.pop()
    # print(item)

#nondestructive loop
for item in s:
    print(item)