import sys
import math

### Variablen ###

# Hash zur Zuordnung Buchstabe -> Haeufigkeit
buchstabe_zu_haeufigkeit = {}

#### Funktionen ###

# Abbrechen der Applikation
def abort():
    print "Bitte geben Sie einen gueltigen Dateinamen als ersten Parameter an."
    sys.exit(1)

# Einlesen der Datei mit den Haeufigkeitswerten
def einlesen(file):
    try:
        datei = open(file, 'r')
        for buchstabe in range(ord("a"), ord("z")+1):
            zeile = datei.readline()
            if zeile == '':
                break
            buchstabe_zu_haeufigkeit[buchstabe] = float(zeile)
        datei.close()
    except IOError:
        abort()

def zeichne_taste(tastenarray):
    return " ".join(tastenarray) + " "*(20-len(tastenarray)*2)

# erstelle eine tabellarische Darstellung der Belegung (ASCII-Art)
def zeichne_belegung(belegung):
    print "+" + "-"*65 + "+"
    print "|", zeichne_taste(belegung["taste 1"]), "|", zeichne_taste(belegung["taste 2"]), "|", zeichne_taste(belegung["taste 3"]), "|"
    print "+" + "-"*65 + "+"
    print "|", zeichne_taste(belegung["taste 4"]), "|", zeichne_taste(belegung["taste 5"]), "|", zeichne_taste(belegung["taste 6"]), "|"
    print "+" + "-"*65 + "+"
    print "|", zeichne_taste(belegung["taste 7"]), "|", zeichne_taste(belegung["taste 8"]), "|", zeichne_taste(belegung["taste 9"]), "|"
    print "+" + "-"*65 + "+"

def erstelle_belegungen():
    kosten_zu_belegungen = {}
    # Der ASCII-Wert des Buchstabens "a" wird zwischengespeichert
    a = ord("a")
    # Damit der RAM-Verbrauch im Rahmen bleibt, wird der bisher niedrigste Kostenwert
    # zwischengespeichert
    erste_kosten = 0
    # Hier wird hochgezaehlt, jeweils der naechste Buchstabeist der Minimalwert fuer die naechste Taste
    for i_1 in xrange(a,a+26):
        for i_2 in xrange(i_1+1,a+26):
            for i_3 in xrange(i_2+1,a+26):
                for i_4 in xrange(i_3+1,a+26):
                    for i_5 in xrange(i_4+1,a+26):
                        for i_6 in xrange(i_5+1,a+26):
                            for i_7 in xrange(i_6+1,a+26):
                                belegung = {}
                                belegung["taste 1"] = [" "]
                                belegung["taste 2"] = []
                                belegung["taste 3"] = []
                                belegung["taste 4"] = []
                                belegung["taste 5"] = []
                                belegung["taste 6"] = []
                                belegung["taste 7"] = []
                                belegung["taste 8"] = []
                                belegung["taste 9"] = []
                                for b in xrange(a,   i_1+1):
                                    belegung[b] = b - a
                                    belegung["taste 2"].append(chr(b))
                                for b in xrange(i_1+1, i_2+1):
                                    belegung[b] = b - i_1
                                    belegung["taste 3"].append(chr(b))
                                for b in xrange(i_2+1, i_3+1):
                                    belegung[b] = b - i_2
                                    belegung["taste 4"].append(chr(b))
                                for b in xrange(i_3+1, i_4+1):
                                    belegung[b] = b - i_3
                                    belegung["taste 5"].append(chr(b))
                                for b in xrange(i_4+1, i_5+1):
                                    belegung[b] = b - i_4
                                    belegung["taste 6"].append(chr(b))
                                for b in xrange(i_5+1, i_6+1):
                                    belegung[b] = b - i_5
                                    belegung["taste 7"].append(chr(b))
                                for b in xrange(i_6+1, i_7+1):
                                    belegung[b] = b - i_6
                                    belegung["taste 8"].append(chr(b))
                                for b in xrange(i_7+1, a+26):
                                    belegung[b] = b - i_7
                                    belegung["taste 9"].append(chr(b))

                                kosten = 0
                                for buchstabe in xrange(a,a+26):
                                    kosten += belegung[buchstabe] * buchstabe_zu_haeufigkeit[buchstabe]

                                if erste_kosten == 0 or kosten < erste_kosten:
                                    print "Neue kleinste Belegung gefunden: Kosten = ", kosten
                                    erste_kosten = kosten
                                    try:
                                        kosten_zu_belegungen[kosten]
                                    except KeyError:
                                        kosten_zu_belegungen[kosten] = []
                                    kosten_zu_belegungen[kosten].append(belegung)
    keys = kosten_zu_belegungen.keys()
    keys.sort()
    print "Die niedrigste moegliche Anzahl an zu drueckenden Tasten ist:", keys[0]
    print "Die passenden Belegungen sind:"
    for belegung in kosten_zu_belegungen[keys[0]]:
        zeichne_belegung(belegung)

try:
    einlesen(sys.argv[1])
except IndexError:
    abort()
erstelle_belegungen()
