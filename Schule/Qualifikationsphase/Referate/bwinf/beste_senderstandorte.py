# Optimierung mit Psyco?
#import psyco
#psyco.full()


import sys, os, math
import Image, ImageDraw

# Abbrechen
def abort():
    exit(0)

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

# Abspeichern eines Bildes mit PIL (Python Imaging Library)
def bild_speichern(bild, file):
    try:
        bild.save(file)
    except IOError:
        print "Bild konnte nicht gespeichert werden."
        abort()
    print "Bild gespeichert."

def flaeche_einlesen(dateiname):
    flaeche = []
    
    try:
        datei = open(dateiname, "r")
        datei.readline() # erste Zeile ist immer "P1"
        breite_hoehe = datei.readline()
        while True:
            try:
                (breite, hoehe) = breite_hoehe.split(" ")
                break
            except ValueError:
                breite_hoehe = datei.readline()
        
        breite = int(breite)
        hoehe = int(hoehe)
        daten = "".join(datei.readlines())
        daten = daten.replace("\r", "")
        daten = daten.replace("\n", "")
        for position_hoehe in xrange(0, hoehe):
            zeile = []
            for position_breite in xrange(0, breite):
                zeile.append(0)
            for position_breite in xrange(0, breite):
                zahl = daten[position_hoehe*breite+position_breite]
                try:
                    zeile[position_breite] = int(zahl)
                except ValueError:
                    print "no int: #"+str(zahl)+"#"
                    pass
            flaeche.append(zeile)
        return [breite, hoehe, flaeche]
    except IOError:
        print "Fehler beim Einlesen..."
        sys.exit(1)

# Hier wird der Standort bewertet
# flaeche: Die Karte als zweidimensionales Array
# breite_karte, hoehe_karte: Die Groesse der Karte
# kreis_punkte: Die relativen Koordinaten, die durch den Kreis abgedeckt werden
# breite_position, hoehe_position: Die Position des Standortes auf der Karte
def bewertung_standort(flaeche, breite_karte, hoehe_karte, kreis_punkte, breite_position, hoehe_position):
    flaeche_abdeckung = 0.0
    flaeche_abzudecken = 0.0
    
    # Fuer alle von dem Kreis abgedeckten Punkte
    for (x, y) in kreis_punkte:
        flaeche_abdeckung += 1
        # Wenn der Punkt, relativ zum Standort, auf der Karte liegt und aus noch nicht abgedecktem Land besteht
        if (y+hoehe_position >= 0 and y+hoehe_position < hoehe_karte) and (x+breite_position >= 0 and x+breite_position < breite_karte) and flaeche[y+hoehe_position][x+breite_position] == 1:
            flaeche_abzudecken += 1
    
    quotient_abdeckflaeche = flaeche_abdeckung
    quotient_abzudeckflaeche = flaeche_abzudecken / quotient_abdeckflaeche
    if quotient_abzudeckflaeche > 0:
        return {"wird_abgedeckt": quotient_abdeckflaeche, "soll_abgedeckt_werden": quotient_abzudeckflaeche}
    else:
        return None

# Zeichne ein Raster
def zeichne_raster(karte_als_bild, breite_karte, hoehe_karte):
    print "Breite der Karte:", breite_karte
    print "Hoehe der Karte:", hoehe_karte
    for position_x in xrange(0, breite_karte):
        if position_x % 5 == 0:
            zeichnen = ImageDraw.Draw(karte_als_bild)
            zeichnen.line((position_x, 0) + (position_x, hoehe_karte), fill=128)
            del zeichnen
    for position_y in xrange(0, hoehe_karte):
        if position_y % 5 == 0:
            zeichnen = ImageDraw.Draw(karte_als_bild)
            zeichnen.line((0, position_y) + (breite_karte, position_y), fill=128)
            del zeichnen

# Lese die Bilddateien ein
[ breite_karte, hoehe_karte, flaeche_karte ] = flaeche_einlesen("map.pbm")
[ breite_kreis, hoehe_kreis, flaeche_kreis ] = flaeche_einlesen("circle.pbm")
# Bestimme die Punkte, die vom Kreis (bzw. von der Schablone) abgedeckt werden
kreis_punkte = []
for y in xrange(0, hoehe_kreis):
    for x in xrange(0, breite_kreis):
        if flaeche_kreis[y][x]:
            kreis_punkte.append((x, y))

# Karte als Bild einlesen, um das Ergebnis eintragen und abspeichern zu koennen
karte_als_bild = bild_einlesen("map.png").convert("RGB")
# Das Raster zeichnen
zeichne_raster(karte_als_bild, breite_karte, hoehe_karte)

pix = karte_als_bild.load()

# Hier beginnt die Senderbestimmung
anzahl_sender = 0
sender = []
schon_abgedeckt_durch_sender = {}
while True:
    etwas_veraendert = 0
    abdeckung_noetig = {}
    schon_zum_abdecken_vorgemerkt = {}
    fertig = 0
    # Die "Spalte" auf der Karte
    for position_x in xrange(-breite_kreis, breite_karte):
        if fertig:
            break
        if position_x % 10 == 0:
            print "Spalte:", position_x
        # Die "Zeile" auf der Karte
        for position_y in xrange(-hoehe_kreis, hoehe_karte):
            
            # Steht hier schon ein Sender?
            try:
                schon_abgedeckt_durch_sender[str(position_x)+","+str(position_y)]
                continue
            except KeyError:
                pass

            # Wenn der Punkt auf der Karte liegt:
            if (position_y+hoehe_kreis/2 >= 0 and position_y+hoehe_kreis/2 < hoehe_karte) and (position_x+breite_kreis/2 >= 0 and position_x+breite_kreis/2 < breite_karte) and flaeche_karte[position_y+hoehe_kreis/2][position_x+breite_kreis/2] == 1:
                # Bestimme den Wert des Standortes, wenn dort ein Sender steht
                werte = bewertung_standort(flaeche_karte, breite_karte, hoehe_karte, kreis_punkte, position_x, position_y)
                # Kein Wert, bspw. im Meer:
                if not werte:
                    schon_abgedeckt_durch_sender[str(position_x)+","+str(position_y)] = 1
                    continue
                if werte["soll_abgedeckt_werden"] <= 0:
                    schon_abgedeckt_durch_sender[str(position_x)+","+str(position_y)] = 1
                    continue
               
                # Eintragen in den Hash
                try:
                    abdeckung_noetig[werte["soll_abgedeckt_werden"]]
                except KeyError:
                    key = str(position_x)+","+str(position_y)
                    abdeckung_noetig[werte["soll_abgedeckt_werden"]] = (position_x, position_y, werte, key)
                if werte["soll_abgedeckt_werden"] == 1:
                    fertig = 1
                    break

    # Sind wir fertig?
    if not len(abdeckung_noetig):
        break
    
    # Den besten noch uebrigen Senderstandort bestimmen...
    item = abdeckung_noetig[max(abdeckung_noetig.keys())]
    while item in sender:
        abdeckung_noetig.remove(item)
        item = abdeckung_noetig[max(abdeckung_noetig.keys())]
    
    if not item in sender:
        # ... eintragen ...
        sender.append(item)
        (position_x, position_y, werte, key) = item
        anzahl_sender += 1
        print "Installierte Sender: ", anzahl_sender, "(dieser: Abdeckung: ", werte["soll_abgedeckt_werden"]*100, "%)"
        schon_abgedeckt_durch_sender[key] = 1
        # ... und zeichnen
        for position_x_kreis in xrange(0, breite_kreis):
            for position_y_kreis in xrange(0, hoehe_kreis):
                if flaeche_kreis[position_y_kreis][position_x_kreis]:
                    # Hier werden die Pixel auf der Karte eingetragen
                    try:
                        if flaeche_karte[position_y+position_y_kreis][position_x+position_x_kreis] > 0:
                            # Hier wird eingetragen, das der Punkt im EInflussbereich eines Senders liegt, und aus Land besteht
                            flaeche_karte[position_y+position_y_kreis][position_x+position_x_kreis] += 1
                            
                            pixeltupel = pix[position_x+position_x_kreis, position_y+position_y_kreis]
                            if pixeltupel[0] == 255 and pixeltupel[1] % 20 == 0:
                                pixeltupel = (pixeltupel[0], pixeltupel[1]-20, pixeltupel[2]-20)
                            else:
                                pixeltupel = (255, 160, 160)
                            pix[position_x+position_x_kreis, position_y+position_y_kreis] = pixeltupel
                        else:
                            # Hier wird eingetragen, das der Punkt im EInflussbereich eines Senders liegt, und aus Meer besteht
                            flaeche_karte[position_y+position_y_kreis][position_x+position_x_kreis] -= 1
                            
                            pixeltupel = pix[position_x+position_x_kreis, position_y+position_y_kreis]
                            if pixeltupel[2] == 255 and pixeltupel[0] % 20 == 0:
                                pixeltupel = (pixeltupel[0]-20, pixeltupel[1]-20, pixeltupel[2])
                            else:
                                pixeltupel = (160, 160, 255)
                            pix[position_x+position_x_kreis, position_y+position_y_kreis] = pixeltupel
                        etwas_veraendert = 1
                    except IndexError:
                        pass
        # Ein Fehler ist aufgetreten
        if not etwas_veraendert:
            anzahl_sender -= 1
            print "Es war ein ungueltiger Sender."
            print "Installierte Sender: ", anzahl_sender
    else:
        # Es wurde nichts veraendert, wir sind wohl fertig
        if not etwas_veraendert:
            break
        
    # Karte abspeichern
    if etwas_veraendert:
        bild_speichern(karte_als_bild, "map_2.png")
                            



