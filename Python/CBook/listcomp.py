#list comprehension
s = [i+1 for i in range(10)]
print(sorted(s))

#set comprehension
l = {n//2 for n in range(10)}
print(sorted(l))

#dict comprehension
d = {s:i for (s, i) in enumerate(['zero', 'one', 'two'])}
print(d)