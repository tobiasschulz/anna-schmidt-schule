n = 1
while True:
	if (n-1)%3 == 0:
		benoetigte_linien = 1
		standorte = list(map(lambda j: j+1, list(range(0, n))))
		anfang = 1
		belegt = {}
		for i in range(0, 4):
			try:
				belegt[anfang+i] += 1
			except KeyError:
				belegt[anfang+i] = 1
		anfang = anfang+4-1
		while anfang < n-4+1:
			for i in range(0, 4):
				try:
					belegt[anfang+i] += 1
				except KeyError:
					belegt[anfang+i] = 1
			anfang += 4 - 1
			benoetigte_linien += 1
		while n not in belegt.keys() and anfang <= n:
			for i in range(0, 4):
				if anfang+i <= n:
					try:
						belegt[anfang+i] += 1
					except KeyError:
						belegt[anfang+i] = 1
			anfang += 4 - 1
			benoetigte_linien += 1
		print(belegt)
	n += 1
