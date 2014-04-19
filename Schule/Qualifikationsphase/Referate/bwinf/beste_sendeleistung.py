import sys, os, math
import Image

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
        for position_hoehe in range(0, hoehe):
            zeile = []
            for position_breite in range(0, breite):
                zeile.append(0)
            for position_breite in range(0, breite):
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

def bewertung_standort(flaeche, kreis_flaeche):
    flaeche_abdeckung = 0.0
    flaeche_abzudecken = 0.0
    flaeche_ganz = 0.0
    
    spalten = len(flaeche[0])
    zeilen = len(flaeche)
    
    zeile_nummer = 0
    for zeile in flaeche:
        zeile_nummer += 1
        spalte_nummer = 0
        for zelle in zeile:
            spalte_nummer += 1
            #print zeile_nummer-1, spalte_nummer-1
            if kreis_flaeche[zeile_nummer-1][spalte_nummer-1]:
                # "Zelle" wird abgedeckt
                flaeche_abdeckung += 1
                if zelle == 1:
                    # "Zelle" muss abgedeckt werden
                    flaeche_abzudecken += 1
                if zelle >= 2:
                    # "Zelle" wurde bereits abgedeckt => an Punkten abziehen
                    flaeche_abzudecken -= zelle - 1
                
            flaeche_ganz += 1
    
    if not flaeche_ganz:
        flaeche_ganz = 1
    quotient_abzudeckflaeche = flaeche_abzudecken / flaeche_ganz
    print "Quotient Abzudecken/Alles:", quotient_abzudeckflaeche
    quotient_abdeckflaeche = flaeche_abdeckung / flaeche_ganz
    print "Quotient Abdeckung/Alles:", quotient_abdeckflaeche
    if quotient_abzudeckflaeche > 0:
        print "Quotient Abdeckung/Abzudecken:", quotient_abdeckflaeche / quotient_abzudeckflaeche
#        return quotient_abdeckflaeche / quotient_abzudeckflaeche
        return quotient_abzudeckflaeche
    else:
        print "Quotient Abdeckung/Abzudecken:", 0
        return 0

def teilbild(bild_flaeche, breite_teil, hoehe_teil, breite_position, hoehe_position):
    teilbild = []

    for position_y in range(hoehe_position, hoehe_teil + hoehe_position):
        zeile = []
        for position_x in range(breite_position, breite_teil + breite_position):
            try:
                zeile.append(bild_flaeche [position_y] [position_x])
            except IndexError:
                pass # print position_x, position_y
        teilbild.append(zeile)

    return teilbild

def rechts_unten_erweitern(flaeche_karte, breite_kreis, hoehe_kreis):
    for dummy in range(0, hoehe_kreis):
        list_ = []
        for dummy in range(0, len(flaeche_karte[0])):
            list_.append(0)
        flaeche_karte.append(list_)
    for list_ in flaeche_karte:
        for dummy in range(0, breite_kreis):
            list_.append(0)
    return flaeche_karte 

[ breite_kreis, hoehe_kreis, flaeche_kreis ] = flaeche_einlesen("circle.pbm")
[ breite_karte, hoehe_karte, flaeche_karte ] = flaeche_einlesen("map.pbm")
karte_als_bild = bild_einlesen("map.png").convert("RGB")
pix = karte_als_bild.load()
flaeche_karte = rechts_unten_erweitern(flaeche_karte, breite_kreis, hoehe_kreis)

for position_x in range(0, breite_karte):
    for position_y in range(0, hoehe_karte):
        teil = teilbild (flaeche_karte, breite_kreis, hoehe_kreis, position_x-breite_kreis/2, position_y-hoehe_kreis/2)


        wert = bewertung_standort(teil, flaeche_kreis)
        wert = 5*wert
        if wert > 5:
            wert = 5
        if wert <= 0:
            wert = 0
        pixelwert = 255-255.0/5*wert
        print "Pixel:", pixelwert
        if flaeche_karte[position_y][position_x]:
            pix[position_x, position_y] = (255, pixelwert, pixelwert)
        else:
            pix[position_x, position_y] = (pixelwert, pixelwert, 255)
    bild_speichern(karte_als_bild, "map_2.png")



