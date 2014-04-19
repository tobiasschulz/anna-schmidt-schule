
ca = ""

ca += "!b \n"
ca += "!a \n"
ca += "D = (!b => !a)\n"
ca += "E = A && D\n"
ca += "F = (E => B)\n"
ca += "a | b | d | e | f | (A && (!B => !A)) => B\n"

da = []

for a in (1, 0, 1, 0):
	for b in (1, 1, 0, 0):
		aa = ""
		
		d = 0
		e = 0
		f = 0
		
		aa += str(a)
		aa += " | "
		aa += str(b)
		aa += " | "
		if ((not b) and (not a)) or not (not b):
			aa += "1"
			d = 1
		else:
			aa += "0"
		aa += " | "
		if a and d:
			aa += "1"
			e = 1
		else:
			aa += "0"
		aa += " | "
		if (a and b) or not e:
			aa += "1"
			f = 1
		else:
			aa += "0"

		da.append(aa)

print ca
aaa = set(da)
for it in aaa:
	print it

