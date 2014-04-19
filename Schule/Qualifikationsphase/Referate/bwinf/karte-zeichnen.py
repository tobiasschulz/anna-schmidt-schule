import sys
import os
import math
import Image, ImageDraw


# Abbrechen der Applikation
def abort():
    sys.exit(1)

# Einlesen der Bilddatei mit Hilfe von PIL (Python Imaging Library)
def bild_einlesen(file):
    bild = None
    try:
        bild = Image.open(file)
    except IOError:
        print "Bilddatei ungueltig."
        abort()
    print "Bilddatei erfolgreich geladen."
    return bild

# Einlesen des GPS-Logs
def gps_einlesen(file):
    gpsLog = []
    try:
        logDatei = open(file, 'r')
        # erste Zeile verwerfen, da Beschriftung
        logDatei.readline()
        for line in logDatei.readlines():
            parts = line.split(",")
            parts[1], parts[2] = float(parts[1]), float(parts[2])
            gpsLog.append(parts)
        logDatei.close()
    except IOError:
        print "GPS-Log ungueltig."
        abort()
    print "GPS-Log erfolgreich geladen."
    return gpsLog

# Abspeichern eines Bildes mit PIL (Python Imaging Library)
def bild_speichern(bild, old_file, nr):
    try:
        f, e = os.path.splitext(old_file)
        if nr:
            bild.save(f + " mit Weg " + str(nr) + e)
        else:
            bild.save(f + " mit Weg" + e)
    except IOError:
        print "Bild konnte nicht gespeichert werden."
        abort()
    print "Bild gespeichert."

def aehnliche_richtung(s1, s2):
    if (s1-s2 > 0 and s1-s2 < 0.3):
        return True
    if (s1-s2 < 0 and s1-s2 > -0.3):
        return True
    return False

# Einzeichnen des Wegs in die Karte "bild"
def gps_verabeiten(bild, log, oben_links, unten_rechts):
    print "Beginne mit der Verarbeitung."
    # Die Breite und Hoehe des Bildes in Pixel
    (breite_px,  hoehe_px) = bild.size
    # Die Breite und Hoehe des Bildes in Breiten- und Laengengrad-Differenzen
    (breite_grade, hoehe_grade) = (unten_rechts["long"] - oben_links["long"], oben_links["lat"] - unten_rechts["lat"])
    
    koordinaten = []
    # Iteriere durch das Log
    for entry in log:
        (time, lat, long) = entry
        # Bilde die Differenz, relativ zum Bildrand
        long -= oben_links["long"]
        lat -= unten_rechts["lat"]
        
        # Bilde die Koordinaten
        x = int(breite_px / breite_grade * long)
        y = hoehe_px - int(hoehe_px  / hoehe_grade * lat)
        neue_koordinaten = [x, y]
        koordinaten.append(neue_koordinaten)
    
    # Anzahl der Koordinaten, die miteinander abgeglaettet werden sollen
    index_differenz = 10
    for i in range(0, len(koordinaten)-index_differenz):
        neue_koordinaten = koordinaten[i]
        alte_koordinaten = koordinaten[i+index_differenz]

        differenz = alte_koordinaten[0]/alte_koordinaten[1] - neue_koordinaten[0]/neue_koordinaten[1]
        if differenz < 0:
            differenz = 0 - differenz
        if differenz < 0.15:
            # Koordinaten gleichsetzen
            for k in range(0, index_differenz):
                koordinaten[i+k] = koordinaten[i+index_differenz]


    # Zaehlvariable fuer die Bilder
    nr = 1
    for i in range(0, len(koordinaten)):
        neue_koordinaten = koordinaten[i]
        
        if i:
            print "Zeichne den Weg von", koordinaten[i-0], "nach", neue_koordinaten
            
            # Zeichne eine Linie von den letzten Koordinaten zu diesen Koordinaten
            zeichnen = ImageDraw.Draw(bild)
            zeichnen.line(koordinaten[i-1] + neue_koordinaten, fill=128)
            del zeichnen

            nr = nr + 1


    print "Verarbeitung abgeschlossen."
    return bild

# !!!
# Ecken der Karte - Hier eintragen falls andere Karte!!!
# !!!

oben_links = { "lat": 50.7820, "long": 6.0711 }
unten_rechts = { "lat": 50.7716, "long": 6.0918 }

try:
    gpsLog = gps_einlesen(sys.argv[2])
    bild   = bild_einlesen(sys.argv[1])
except IndexError:
    print "Bitte geben Sie eine gueltige Bilddatei als ersten Parameter und einen GPS-Log als zweiten Parameter an."
    abort()

bild = gps_verabeiten(bild, gpsLog, oben_links, unten_rechts)
bild_speichern(bild, sys.argv[1], None)
bild.show()
