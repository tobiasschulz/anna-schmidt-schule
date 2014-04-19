missverstaendliche_ziffern = [ "1", "2", "5", "6", "8", "9", "0" ]

def ist_missverstaendlich(nummer):
    for ziffer in nummer:
        if not ziffer in missverstaendliche_ziffern:
            return False
    return True

while True:
    nummer = raw_input("Zimmernummer eingeben: ").strip()
    if ist_missverstaendlich(nummer):
        print "Die Nummer ist missverstaendlich."
    else:
        print "Die Nummer ist nicht missverstaendlich."