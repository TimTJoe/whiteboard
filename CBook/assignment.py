import re

input_string = input('Enter string.')

#evaluate and assign
#example: var = re.match(name, string)
#to: if var := re.match(name,string)
#inner: print(var)
if re_match := re.match(r'Name: (\S)', input_string):
    print(re_match.group(1))