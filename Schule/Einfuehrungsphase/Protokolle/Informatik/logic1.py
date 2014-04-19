
ca = ""

ca += "d = a=>b \n"
ca += "e = b=>c \n"
ca += "f = a=>c \n"
ca += "h = d&&e \n"
ca += "a | b | c | d | e | f | h | ((A=>B)&&(B=>C))=>(A=>C)\n"

da = []

for a in (1, 0, 1, 0):
	for b in (1, 1, 0, 0):
		for c in (0, 1, 0, 1):
			aa = ""
			
			d = 0
			e = 0
			f = 0
			
			aa += str(a)
			aa += " | "
			aa += str(b)
			aa += " | "
			aa += str(c)
			aa += " | "
			if (a and b) or not a:
				aa += "1"
				d = 1
			else:
				aa += "0"
			aa += " | "
			if (b and c) or not b:
				aa += "1"
				e = 1
			else:
				aa += "0"
			aa += " | "
			if (a and c) or not a:
				aa += "1"
				f = 1
			else:
				aa += "0"
			aa += " | "
			h = 0
			if d and e:
				h = 1
			aa += str(h)
			aa += " | "
			if (h and f) or h == 0:
				aa += "1"
			else:
				aa += "0"

			da.append(aa)

print ca
aaa = set(da)
for it in aaa:
	print it

