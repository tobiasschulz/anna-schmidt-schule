
ca = ""

ca += "d = a=>b \n"
ca += "e = b=>c \n"
ca += "f = A && D && E \n"
ca += "h = F => C \n"
ca += "a | b | c | d | e | f | (A && (A=>B) && (B=>C)) => C\n"

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
			if a and d and e:
				aa += "1"
				f = 1
			else:
				aa += "0"
			aa += " | "
			h = 0
			if (f and c) or not f:
				h = 1
			aa += str(h)
			da.append(aa)

print ca
aaa = set(da)
for it in aaa:
	print it

