binary = (23, (42, (5, None, None), (55, None, None)), (94, None, None))

#With recursion
def rec(t):
    yield t[0]
    for i in (1, 2):
        if t[i] is not None:
            yield from rec(t[i])

#Without recursion
def norec(t):
    stack = [t]
    while stack:
        t = stack.pop()
        yield t[0]
        for i in (2, 1):
            if t[i] is not None:
                stack.append(t[i])

print(rec(binary))
print(norec(binary))