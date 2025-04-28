container = True

# avoid because __bool__ __len__
if (container) > 0:
    print("avoid")

if container:
    print("do.")