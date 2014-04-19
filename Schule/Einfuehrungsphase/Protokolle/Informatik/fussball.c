#include <stdlib.h> 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
// werden benoetigt

int main()
 { 
	printf("Willkommen bei dem Fussballtipper!\n"); // Einleitung für den Benutzer
	
	// die Punkte und Credits für die beiden Benutzer werden auf jeweils Null gesetzt, damit
    // spaeter korrekt Punkte vergeben werden koennen
	  int Punkte_Spieler1;
	  Punkte_Spieler1 = 0;

	  int Punkte_Spieler2;
	  Punkte_Spieler2 = 0;

	  int Credits_Spieler1;
	  Credits_Spieler1 = 0;

	  int Credits_Spieler2;
	  Credits_Spieler2 = 0;

    while (1) 
	{
        // der Text fuer den Benutzer zur Auswahl der Mannschaften wird ausgegeben
        printf("\nWaehlen Sie eine der folgenden Mannschaften durch \nEingeben der vorhergehenden Nummer:\n\n");
        printf("1.Eintracht Frankfurt\n2.Schalke 04\n3.Hoffenheim\n4.Bayern Muenchen\n");
        // der Benutzer wird informiert, dass er eine Nummer eingeben muss, um eine Mannschaft auszuwaehlen
        printf("Nummer eingeben:");
        int Mannschaft1;
            scanf("%d", &Mannschaft1); // Eingabe der Mannschaft durch den Benutzer
        
        int atk1; // Festlegen der Variablen
        int def1; // Festlegen der Variablen
		if (Mannschaft1 > 4) // die Mannschaftsnummern gehen nur bis 4, daher ist eine Nummer ueber 4 nicht möglich
		{
			printf("Diese Mannschaft gibt es nicht - bitte waehlen Sie eine Mannschaft von 1 bis 4 aus.\n"); // Ausgabe der Unmoeglichkeit
			continue;
		}
		// es wird nun jeweils ausgegeben, welche Mannschaft gewaehlt wurde
        if (Mannschaft1 == 1)
        {
                          atk1=2; // Variablen werden auf eine Zahl festgelegt
                          def1=4; // Variablen werden auf eine Zahl festgelegt
                          printf("Sie haben Eintracht Frankfurt gewaehlt!\n\n");
        }
        if (Mannschaft1 == 2)
        {
                          atk1=2; // Variablen werden auf eine Zahl festgelegt
                          def1=4; // Variablen werden auf eine Zahl festgelegt
                          printf("Sie haben Schalke 04 gewaehlt!\n\n");
        }
        if (Mannschaft1 == 3)
        {
                          atk1=2; // Variablen werden auf eine Zahl festgelegt
                          def1=4; // Variablen werden auf eine Zahl festgelegt
                          printf("Sie haben Hoffenheim gewaehlt!\n\n");
        }
        if (Mannschaft1 == 4)
        {
                          atk1=2; // Variablen werden auf eine Zahl festgelegt
                          def1=4; // Variablen werden auf eine Zahl festgelegt
                          printf("Sie haben Bayern Muenchen gewaehlt!\n\n");
        }
        
        // nun muss der Benutzer einen Gegner auswaehlen und wird darueber informiert
        printf("\nWaehlen sie eine der folgenden Mannschaften als Gegner durch \neingeben der vorhergehenden Nummer:\n\n");
        printf("1.Eintracht Frankfurt\n2.Schalke 04\n3.Hoffenheim\n4.Bayern Muenchen\n");
        printf("Nummer eingeben:");
        int Mannschaft2;
            scanf("%d", &Mannschaft2); // der Benutzer gibt einen Gegner ein
        int atk2; // Festlegen der Variablen
        int def2; // Festlegen der Variablen
		
		if (Mannschaft2 > 4) // gleiches Problem wie oben, es gibt nur 4 Mannschaften
		{
			printf("Diese Mannschaft gibt es nicht, bitte waehle eine Mannschaft von 1 bis 4 aus.\n");
			continue;
		}
		// es wird nun jeweils ausgegeben, welche Mannschaft als Gegner gewaehlt wurde
        if (Mannschaft2 == 1)
        {
                          atk2=2; // Variablen werden auf eine Zahl festgelegt
                          def2=4; // Variablen werden auf eine Zahl festgelegt
                          printf("Sie haben Eintracht Frankfurt gewaehlt!\n\n");
        }
        if (Mannschaft2 == 2)
        {
                          atk2=2; // Variablen werden auf eine Zahl festgelegt
                          def2=4; // Variablen werden auf eine Zahl festgelegt
                          printf("Sie haben Schalke 04 gewaehlt!\n\n");
        }
        if (Mannschaft2 == 3)
        {
                          atk2=2; // Variablen werden auf eine Zahl festgelegt
                          def2=4; // Variablen werden auf eine Zahl festgelegt
                          printf("Sie haben Hoffenheim gewaehlt!\n\n");
        }
        if (Mannschaft2 == 4)
        {
                          atk2=2; // Variablen werden auf eine Zahl festgelegt
                          def2=4; // Variablen werden auf eine Zahl festgelegt
                          printf("Sie haben Bayern Muenchen gewaehlt!\n\n");
        }                 
        
        if (Mannschaft1 == Mannschaft2) // funktioniert nicht, da man nicht gegen sich selbst antreten kann
        {
                      printf("Das geht nicht!\n\n");
                      continue;
        }
                
        
        // Wettannahme; die Variablen werden festgelegt
		int Stand1;
		int Stand2;
        int Ergebnis1_Spieler1;
        int Ergebnis2_Spieler1;
        int Ergebnis1_Spieler2;
        int Ergebnis2_Spieler2;
		int Variable1;
        int Variable2;
        int Variable_Spielerausfall1;
        int Variable_Spielerausfall2;
		int Endergebnis1;
		int Endergebnis2;
		int Spielerabzug1;
		int Spielerabzug2;
		int Regen;
		int Regenabzug;
		int Regenstaerkevariable;
		int Dopingplus_Mannschaft1_Spieler1;
		int Dopingplus_Mannschaft2_Spieler1;
		int Dopingplus_Mannschaft1_Spieler2;
		int Dopingplus_Mannschaft2_Spieler2;
		int Sabotageminus_Mannschaft1_Spieler1;
		int Sabotageminus_Mannschaft2_Spieler1;
		int Sabotageminus_Mannschaft1_Spieler2;
		int Sabotageminus_Mannschaft2_Spieler2;
		char Antwort1[999];
		int Antwort2;
		int Aktionswahl_Spieler1;
		int Aktionswahl_Spieler2;
		int domansp1;
		int domansp2;
		int manmansp1;
		int manmansp2;
        printf ("Spieler1:Setzen sie ihre Wette:\n\n"); // der Spieler wird aufgefordert, ein Ergebnis zu tippen
        scanf ("%d", &Ergebnis1_Spieler1); // die Tore von Mannschaft 1 werden eingetippt
		printf(":"); // das Zeichen fuer "zu" wird ausgegeben, damit die Tore der gegnerischen Mannschaft getippt werden koennen
		scanf("%d", &Ergebnis2_Spieler1); // die Tore von Mannschaft 2 werden eingetippt
        
        printf ("Spieler2:Setzen sie ihre Wette:\n\n"); // der Spieler wird aufgefordert, ein Ergebnis zu tippen
        scanf ("%d", &Ergebnis1_Spieler2); // die Tore von Mannschaft 1 werden eingetippt
		printf(":"); // das Zeichen fuer "zu" wird ausgegeben, damit die Tore der gegnerischen Mannschaft getippt werden koennen
		scanf("%d", &Ergebnis2_Spieler2); // die Tore von Mannschaft 2 werden eingetippt
        
		Stand1 = def2-atk1;
        if (Stand1 < 0)
        {
                      Stand1 = 0;
        }
        // Ergebnis1 = def2-atk1 < 0 ? 0 : def2-atk1;
        Stand2 = def1-atk2;
        if (Stand2 < 0)
        {
                      Stand2 = 0;
        }

		if(Credits_Spieler1 > 0) // eine Manipulation des Spiels kostet Geld, daher ist sie nur moeglich, wenn der Spieler Credits hat
		{
		printf ("Spieler1: Wollen Sie das Spiel manipulieren?\nja oder nein?\n\n"); // die Frage nach der Manipulation wird ausgegeben
		scanf ("%d", &Antwort1); 

		if (0 == strcmp(Antwort1, "ja"))
		{
			printf ("Was wollen Sie machen? Geben sie die Nummer der Aktion ein:\n1. Dopen (Kosten: 500 Credits)\n2. Sabotieren (Kosten: 500 Credits)\n");
			// die jeweiligen Moeglichkeiten werden aufgelistet und die Moeglichkeit zur Auswahl gegeben
			scanf ("%d", &Aktionswahl_Spieler1); // Spieler 1 waehlt die Manipulationsmethode
			
			if (Aktionswahl_Spieler1 == 1) // wenn Doping gewaehlt wurde
			{
				printf ("Moechten Sie 1. Mannschaft1 oder 2. Mannschaft2 dopen??\n"); // Frage nach der Mannschaft, die gedopt werden soll
				scanf ("%d", &domansp1); // Eingabe des Spielers

				if (domansp1 == 1)
				{
					Dopingplus_Mannschaft1_Spieler1 =  1; // die Mannschaft 1 wird gedopt
					Credits_Spieler1 = Credits_Spieler1 - 500; // die Credits werden vom Spieler bezahlt
					printf ("Mannschaft1 wurde gedopt!!\n"); // Ausgabe auf dem Bildschirm
				}

				if (domansp1 == 2)
				{
					Dopingplus_Mannschaft2_Spieler1 = 1; // die Mannschaft 2 wird gedopt
					Credits_Spieler1 = Credits_Spieler1 - 500; // die Credits werden vom Spieler bezahlt
					printf ("Mannschaft2 wurde gedopt!!\n"); // Ausgabe auf dem Bildschirm
				}
			}

			if ( Aktionswahl_Spieler1 == 2) // wenn Sabotage gewaehlt wurde
			{
			printf ("Welche Mannschaft wollen sie manipulieren??\n1. Mannschaft1\n2. Mannschaft2"); // die Frage nach der zu sabotierenden Mannschaft wird gestellt
			scanf ("%d", &manmansp1); // die Mannschaft wird vom Spieler eingegeben
			if ( manmansp1 == 1) // wenn Mannschaft 1 gewaehlt wurde
				{
					Sabotageminus_Mannschaft1_Spieler1 = 1; // Mannschaft 1 erhaelt ein Sabotageminus
					Credits_Spieler1 = Credits_Spieler1 - 500; // die Credits werden vom Spieler bezahlt
					printf ("Mannschaft1 wurde manupuliert!\n"); // Ausgabe der Manipulation auf dem Bildschirm
				}
			if ( manmansp1 == 2) // wenn Mannschaft 2 gewaehlt wurde
				{
					Sabotageminus_Mannschaft2_Spieler1 = 1; // Mannschaft 2 erhaelt ein Sabotageminus
					Credits_Spieler1 = Credits_Spieler1 - 500; // die Credits werden vom Spieler bezahlt
					printf ("Mannschaft2 wurde manupuliert!\n"); // Ausgabe der Manipulation auf dem Bildschirm
				}
			}
			else // wenn keine Manipulation fuer keine Mannschaft gewaehlt wurde, gibt es kein Sabotageminus und kein Dopingplus
				{
					printf ("Ungueltige Eingabe!"); // es koennen nur 2 Mannschaften ausgewaehlt werden
                    Sabotageminus_Mannschaft1_Spieler1 = 0;
					Sabotageminus_Mannschaft2_Spieler1 = 0;
					Dopingplus_Mannschaft1_Spieler1 = 0;
					Dopingplus_Mannschaft2_Spieler1 = 0;
				}
		}

		if (strcmp(Antwort1, "ja"))
		{
			printf ("Sie haben Nein gewaehlt.\n");
			Sabotageminus_Mannschaft1_Spieler1 = 0;
			Sabotageminus_Mannschaft2_Spieler1 = 0;
			Dopingplus_Mannschaft1_Spieler1 = 0;
			Dopingplus_Mannschaft2_Spieler1 = 0;
		}
		}
		else
		{
			Sabotageminus_Mannschaft1_Spieler1 = 0;
			Sabotageminus_Mannschaft2_Spieler1 = 0;
			Dopingplus_Mannschaft1_Spieler1 = 0;
			Dopingplus_Mannschaft2_Spieler1 = 0;
		}
		if ( Credits_Spieler2 > 0) // genau die gleichen Funktionen wie bei Spieler 1, nur werden diese jetzt für Spieler 2 und dessen Mannschaften ausgefuehrt
		{
		printf ("Spieler2: Wollen sie das Spiel manipulieren?\nja oder nein?\n\n");
		scanf ("%d", &Antwort2);

		if (Antwort2 == 1)
		{
			printf ("Was wollen sie machen? Geben sie die Nummer der Aktion ein:\n1. Dopen (kosten: 500 Credits)\n2. Sabotieren (kosten: 500 Credits)\n");
			scanf ("%d", &Aktionswahl_Spieler2);
			if (Aktionswahl_Spieler2 == 1)
			{
				printf ("Moechten sie Mannschaft1 oder Mannschaft2 dopen??\n");
				scanf ("%d", &domansp2);

				if (domansp2 == 1)
				{
					Dopingplus_Mannschaft1_Spieler2 = 1;
					Credits_Spieler2 = Credits_Spieler2 - 500;
					printf ("Mannschaft1 wurde gedopt!!\n");
				}

				if (domansp2 == 2)
				{
					Dopingplus_Mannschaft2_Spieler2 = 1;
					Credits_Spieler2 = Credits_Spieler2 - 500;
					printf ("Mannschaft2 wurde gedopt!!\n");
				}
				else
				{
					printf ("Ungueltige Eningabe!!!");
					Sabotageminus_Mannschaft1_Spieler1 = 0;
					Sabotageminus_Mannschaft2_Spieler1 = 0;
					Dopingplus_Mannschaft1_Spieler1 = 0;
					Dopingplus_Mannschaft2_Spieler1 = 0;
				}
					
				if (Aktionswahl_Spieler2)
				{
					printf ("Moechten sie 1. Mannschaft1 oder 2. Mannschaft2 dopen??\n");
					scanf ("%d", &manmansp2);
					if ( manmansp2 == 1)
					{
						Sabotageminus_Mannschaft1_Spieler2 = 1;
						Credits_Spieler2 = Credits_Spieler2 - 500;
						printf ("Sie haben Mannschaft1 manipuliert!\n");
					}
					if ( manmansp2 == 2)
					{
						printf ("Sie haben Mannschaft2 manipuliert!\n");
						Sabotageminus_Mannschaft2_Spieler2 = 1;
						Credits_Spieler2 = Credits_Spieler2 - 500;
					}
					else
					{
						printf ("Ungueltige Eingabe!!!");
						Sabotageminus_Mannschaft1_Spieler1 = 0;
						Sabotageminus_Mannschaft2_Spieler1 = 0;
						Dopingplus_Mannschaft1_Spieler1 = 0;
						Dopingplus_Mannschaft2_Spieler1 = 0;
					}
				}
			}
		}
		if (Antwort2 != 1) // wenn kein Doping und keine Sabotage gewaehlt wurden, veraendern sich die Werte nicht
		{
			printf ("Sie haben Nein gewaelt!\n");
			Sabotageminus_Mannschaft1_Spieler2 = 0;
			Sabotageminus_Mannschaft2_Spieler2 = 0;
			Dopingplus_Mannschaft1_Spieler2 = 0;
			Dopingplus_Mannschaft2_Spieler2 = 0;
		}
		}
		else
		{
			Sabotageminus_Mannschaft1_Spieler2 = 0;
			Sabotageminus_Mannschaft2_Spieler2 = 0;
			Dopingplus_Mannschaft1_Spieler2 = 0;
			Dopingplus_Mannschaft2_Spieler2 = 0;
		}
		srand(time(NULL));
        Variable1 = rand()%3;
		Variable2 = rand()%3;
        Variable_Spielerausfall1 = rand()%8;
        Variable_Spielerausfall2 = rand()%8;
		Regen = rand()%17;
		Regenstaerkevariable = rand()%2 + 1;

        // nun wird der Spielerausfall berechnet
		if (Variable_Spielerausfall1 > 4)
        {
                                     Spielerabzug1 = 1;
									  if (Mannschaft1 == 1)
									{
										printf("Es gab einen Ausfall fuer Eintracht Frankfurt\n\n"); // der Ausfall der Spieler der jeweiligen Mannschaft wird ausgegeben
									}
									else if (Mannschaft1 == 2)
									{
										printf("Es gab einen Ausfall fuer Schalke 04\n\n"); // der Ausfall der Spieler der jeweiligen Mannschaft wird ausgegeben
									}
									else if (Mannschaft1 ==3)
									{
										printf("Es gab einen Ausfall fuer Hoffenheim\n\n"); // der Ausfall der Spieler der jeweiligen Mannschaft wird ausgegeben
									}
									else
									{
										printf("Es gab einen Ausfall fuer Bayern Muenchen\n\n"); // der Ausfall der Spieler der jeweiligen Mannschaft wird ausgegeben
									}
        }
        else // ansonsten kein Spielerausfall
        {
             Spielerabzug1 = 0;
        }
        

        if (Variable_Spielerausfall2 > 4) // das gleiche fuer Spieler 2
        {
               Spielerabzug2 = 1;
                                     if (Mannschaft2 == 1)
									{
										printf("Es gab einen Ausfall fuer Eintracht Frankfurt\n\n");
									}
									else if (Mannschaft2 == 2)
									{
										printf("Es gab einen Ausfall fuer Schalke 04\n\n");
									}
									else if (Mannschaft2 ==3)
									{
										printf("Es gab einen Ausfall fuer Hoffenheim\n\n");
									}
									else
									{
										printf("Es gab einen Ausfall fuer Bayern Muenchen\n\n");
									}
		}
		else
		{
			Spielerabzug2 = 0;
		}
		
        // nun wird der Regen berechnet
		if (Regen > 10)
		{
			Regenabzug = Regenstaerkevariable;
			if (Regenstaerkevariable == 1)
			{
				printf("Es regnete schwach.\n"); // Ausgabe bei schwachem Regen
			}
			else
			{
				printf("Es regnete stark!\n"); // Ausgabe bei starkem Regen
			}
		}
		else
		{
			Regenabzug = 0; // Ausgabe bei keinem Regen
		}

        // nun wird das Endergebis mit Sabotageminus und Dopingplus ausgerechnet
		Endergebnis1 = ((((Stand1) * (Variable1) - Variable2 - Spielerabzug1 - Regenabzug) - Sabotageminus_Mannschaft1_Spieler1) - Sabotageminus_Mannschaft1_Spieler2) + Dopingplus_Mannschaft1_Spieler1 + Dopingplus_Mannschaft1_Spieler2;
		Endergebnis2 = ((((Stand2) * (Variable2) - Variable1 - Spielerabzug2 - Regenabzug) - Sabotageminus_Mannschaft2_Spieler1) - Sabotageminus_Mannschaft2_Spieler2) + Dopingplus_Mannschaft2_Spieler1 + Dopingplus_Mannschaft2_Spieler2;

        if (Endergebnis1 < 0)
        {
                      Endergebnis1 = 0;
        }
		
        if (Endergebnis2 < 0)
        {
                      Endergebnis2 = 0;
        }


		if (Endergebnis1 >5)
		{
			Endergebnis1 -= 2;
		}

		if (Endergebnis2 >5)
		{
			Endergebnis2 = Endergebnis2 - 2;
		}

		if (Endergebnis1 >4)
		{
			Endergebnis1 = Endergebnis1 - 1;
		}
		if (Endergebnis2 >4)
		{
			Endergebnis2 = Endergebnis2 - 1;
		}
		
        int Differenzergebnis;
		int Differenz_sp1;
		int Differenz_sp2;
		int Gewinner;

        // nun werden die Punkte und Credits fuer die beiden Spieler errechnet
		Differenzergebnis = Endergebnis1 - Endergebnis2; // Definition des Differenzergebnisses
		Differenz_sp1 = Ergebnis1_Spieler1 - Ergebnis2_Spieler1; // Definition
		Differenz_sp2 = Ergebnis1_Spieler2 - Ergebnis2_Spieler2; // Definition
		if ( Differenzergebnis > 0) // wenn das Differenzergebis groesser als 0 ist...
		{
			if ( Differenz_sp1 > 0)
			{
				Punkte_Spieler1 = Punkte_Spieler1 + 1; // ...bekommt der Spieler 1 Punkt
				Credits_Spieler1 = Credits_Spieler1 + 200; // und 200 Credits
			}
			else
			{
				Punkte_Spieler1 = Punkte_Spieler1 - 1; // ansonsten gibt es einen Punkt Abzug
			}
		}

		if ( Differenzergebnis < 0) // das gleiche wie im ersten Fall, nur hier bei einem Differenzergebis kleiner 0
		{
			if ( Differenz_sp1 < 0)
			{
				Punkte_Spieler1 = Punkte_Spieler1 + 1;
				Credits_Spieler1 = Credits_Spieler1 + 200;
			}
			else
			{
				Punkte_Spieler1 = Punkte_Spieler1 - 1;
			}
		}

		if ( Differenzergebnis == 0) // as gleiche wie im ersten Fall, nur hier bei einem Differenzergebis gleich 0
		{
			if ( Differenz_sp1 == 0)
			{
				Punkte_Spieler1 = Punkte_Spieler1 + 1; 
				Credits_Spieler1 = Credits_Spieler1 + 200;
			}
			else
			{
				Punkte_Spieler1 = Punkte_Spieler1 - 1;
			}
		}


		if ( Differenzergebnis > 0) // das gleiche wie bei Spieler 1 für Spieler 2
		{
			if ( Differenz_sp2 > 0)
			{
				Punkte_Spieler2 = Punkte_Spieler2 + 1;
				Credits_Spieler2 = Credits_Spieler2 + 200;
			}
			else
			{
				Punkte_Spieler2 = Punkte_Spieler2 - 1;
			}
		}

		if ( Differenzergebnis < 0)
		{
			if ( Differenz_sp2 < 0)
			{
				Punkte_Spieler2 = Punkte_Spieler2 + 1;
				Credits_Spieler2 = Credits_Spieler2 + 200;
			}
			else
			{
				Punkte_Spieler2 = Punkte_Spieler2 - 1;
			}
		}

		if ( Differenzergebnis == 0)
		{
			if ( Differenz_sp2 == 0)
			{
				Punkte_Spieler2 = Punkte_Spieler2 + 1;
				Credits_Spieler2 = Credits_Spieler2 + 200;
			}
			else
			{
				Punkte_Spieler2 = Punkte_Spieler2 - 1;
			}
		}

		if (Ergebnis1_Spieler1 == Endergebnis1) // falls das Ergebnis von Spieler 1 genau mit dem Ergebnis uebereinstimmt...
		{
			if (Ergebnis2_Spieler1 == Endergebnis2)
			{
				Punkte_Spieler1 = Punkte_Spieler1 + 2; // ...erhaelt er zwei Punkte
				Credits_Spieler1 = Credits_Spieler1 + 1000; // und 1000 Credits
			}
		}

		if (Ergebnis1_Spieler2 == Endergebnis1) // das gleiche fuer Spieler 2
		{
			if (Ergebnis2_Spieler2 == Endergebnis2)
			{
				Punkte_Spieler2 = Punkte_Spieler2 + 2;
				Credits_Spieler2 = Credits_Spieler2 + 1000;
			}
		}
        
        // die gewinnenden Mannschaften werden errechnet
		if (Endergebnis1 > Endergebnis2)
		{
			if (Endergebnis1 > Endergebnis2) // wenn das Ergebnis 1 groesser ist als Ergebnis 2 , gewinnt Mannschaft 1, sonst Mannschaft 2
			{
				Gewinner = Mannschaft1;
			}
			else 
			{
				Gewinner = Mannschaft2;
			}
		}
		else if(Endergebnis1 == Endergebnis2) // bei einem Gleichstand gewinnt keine Mannschaft
		{
			Gewinner = 0;
		}
		else
		{
			Gewinner = 0;
		}
            // die Mannschaftsgewinner und Ergebnisse werden ausgegeben
			if (Gewinner == 0) // Ergebnis bei Gleichstand
			{
				printf("Das Spiel endete: %i:%i\n\n", Endergebnis1, Endergebnis2);
			}
			else if (Gewinner ==1) // Ergebnis bei Sieg der Eintracht
			{
				printf("Das Spiel endete: %i:%i fuer Eintracht Frankfurt\n\n", Endergebnis1, Endergebnis2);
			}
			else if (Gewinner == 2) // Ergebnis bei Sieg fuer Schalke
			{
				printf("Das Spiel endete: %i:%i fuer Schalke 04\n\n", Endergebnis1, Endergebnis2);
			}
			else if (Gewinner ==3) // Ergebnis bei Sieg fuer Hoffenheim
			{
				printf("Das Spiel endete: %i:%i fuer Hoffenheim\n\n", Endergebnis1, Endergebnis2);
			}
			else // Ergebnis bei Sieg fuer Bayern
			{
				printf("Das Spiel endete: %i:%i fuer Bayern Muenchen\n\n", Endergebnis1, Endergebnis2);
			}
		// Spielerpunkte und Credits werden ausgegeben	
		printf("Spielerpunkte:\nSpieler1:%i\nSpieler2:%i\n\n", Punkte_Spieler1, Punkte_Spieler2); 
		printf("Spielercredits:\nSpieler1:%i\nSpieler2:%i\n\n", Credits_Spieler1, Credits_Spieler2);
		int beenden; // Funktion zum Beenden des Programms
		printf("Wollen Sie das Spiel beenden? Dann druecken Sie die 1.\nWenn nicht, druecken Sie irgendeine Taste.\n\n");
		scanf ("%d", &beenden);
		if ( beenden == 1)
		{
			break;
		}
		else
		{}
        system("PAUSE");
    }	
	return 0;
}
