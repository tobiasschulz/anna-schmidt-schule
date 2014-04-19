# Die Tankstelle Asso
class Asso:
	anzahl_der_kunden_letzte_stunde = 0
	preis = 100
	einkaufspreis = 50
	gewinne = {}

	def tanken(self):
		self.anzahl_der_kunden_letzte_stunde += 1
	
	def naechste_stunde(self, stunde, tag):
		self.gewinne[str(tag) + "_" + str(stunde)] = (self.preis - self.einkaufspreis) * self.anzahl_der_kunden_letzte_stunde

		if self.anzahl_der_kunden_letzte_stunde > 35:
			self.preis += 0.3
		elif self.anzahl_der_kunden_letzte_stunde < 25:
			self.preis -= 1

		if self.preis < self.einkaufspreis:
			self.preis = self.einkaufspreis
		
		self.anzahl_der_kunden_letzte_stunde = 0

	def gewinn(self, stunde, tag):
		return self.gewinne[str(tag) + "_" + str(stunde)]

