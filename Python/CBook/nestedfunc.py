def make_adder(augend):
    def add(addend):
        return addend + augend
    return add

add4 = make_adder(4)
add5 = make_adder(5)

print(add4(100))
print(add5(50))