# Generator
# Snytax: yield expression

# def updown(N):
#     for x in range(1, N):
#         yield x 
#     for x in range(N, 0, -1):
#         yield x 
# for i in updown(3):
#     print(i)

def frange(start, stop, stride=1.0):
    start = float(start)
    while start < stop:
        yield start 
        start += stride

def updown(N):
    yield from range(1,N)
    yield from range(N,0,-1)
for i in updown(3):
    print(i)


print(sum([x*x for x in range(10)]))

squares = (x*x for x in range(5))
print(list(squares))
print(sum(squares))