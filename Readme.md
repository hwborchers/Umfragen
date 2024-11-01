
## Umfragen 2020-2024


### Aktuelle Graphik

![Abb. Sonntagsfrage](umfrage_aktuell.png)

(*Diese Grafik wird hier zum Ende eines jeden Monats aktualisiert*)

### Auswertung

Die Ergebnisse der letzten Umfragen pro Institut ergeben

```
     Datum  CDUCSU  SPD  Gruene  FDP  LINKE  AfD  BSW     Institut
------------------------------------------------------------------
2024-09-17     34    14   11.0   4.0    2.0   18    7          GMS
2024-10-04     31    16   11.0   4.0    3.0   17    7        Emnid
2024-10-10     32    16   11.0   5.0    3.0   18    8       Yougov
2024-10-18     31    16   11.0   3.0    4.0   18    8    ForWahlen
2024-10-18     36    15   10.5   4.5     NA   16    9   Allensbach
2024-10-28     31    15   11.0   4.0    2.5   19    9         INSA
2024-10-29     32    16    9.0   4.0    3.0   17    7        Forsa
2024-10-31     34    16   11.0   4.0     NA   17    6    Infratest
```

Der Median der Umfragen aus den letzten vier Wochen ergibt eine gute Übereinstimmung 
mit dem letzten geglätteten Wert (dem Ende der geglätteten Linien in der Abbildung oben).

```
CDUCSU    SPD  Gruene   FDP  LINKE    AfD   BSW
----------------------------------------------
  32.0   16.0    11.0   4.0    3.0   17.0   8.0   (median)
  32.4   15.7    10.6   4.1    3.1   17.4   7.7     (mean)
```

Die Anzahl der Umfragen pro Institut weist grosse Unterschiede zwischen den einzelnen 
Instituten auf: Allensbach zum Beispiel hat wahlberechtigte Bürger im Jahr 2023 nur 
einmal im Monat befragt, INSA dagegen zweimal (!) jede Woche.


### Erläuterungen

In Deutschland finden mehrfach jede Woche Wahlumfragen zur Bundestagswahl statt. Die Frage an wahlberechtigte Bürger ist: "Wenn am nächsten Sonntag Bundestagswahl wäre, welche Partei würden Sie wählen?" Die wichtigsten beteiligten Umfrageinstitute sind wohl Allensbach, Verian (Emnid), Forsa, Forschungsgruppe Wahlen, GMS, Infratest Dimap, INSA und Yougov.

Die Daten aller dieser Institute werden auf der Plattform [Wahlrecht](https://www.wahlrecht.de/) veröffentlicht. Für die letzten aktuellen Umfragen siehe [Umfragen](https://www.wahlrecht.de/umfragen/). Die Art der Umfrage (Telefon, Online, ...) und die Anzahl der befragten Personen wird ebenfalls angegeben. Die Häufigkeit der Umfrage ist sehr unterschiedlich, zum Beispiel Allensbach nur einmal im Monat, INSA teilweise mehrfach pro Woche.

Jeder Punkt (kleiner Kreis) ist *ein* Umfrageergebnis für *eine* Partei; zu jeder Umfrage gehören also acht Punkte zum gleichen Datum. Die durchgezogene Linie ist eine **Glättung** der Daten zu einer Partei, hier generiert mit Friedman's *SuperSmoother* (eine Glättung mit der *Lowess* Glättungsmethode würde eine fast identische Kurve erzeugen). Die Farben sind den Farben der jeweiligen Parteien angepasst.

Die gestrichelte, senkrechte Linie ist der Zeitpunkt der Bundestagswahl am 26.9.2021. Die darauf abgebildeten kleinen Quadrate markieren die offiziellen Endergebnisse der jeweiligen Parteien. Unten ist die "5-Prozent Hürde" eingezeichnet. Die letzten Umfragen vor dem Wahltag haben das Endergebnis der Bundestagswahl 2021 (im Mittel aller Umfragen) relativ gut vorausgesagt.
