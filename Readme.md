
## Umfragen 2020-2024


### Aktuelle Graphik



(*Diese Grafik wird hier zum Ende eines jeden Monats aktualisiert*)

### Auswertung

Die Ergebnisse der letzten Umfragen pro Institut ergeben

```
     Datum CDUCSU  SPD Gruene  FDP LINKE   AfD   FW   BSW     Institut
----------------------------------------------------------------------
2024-09-19   35.5   16     10    4    NA    17   NA     9   Allensbach
2024-09-27   31.0   16     12    4     4    17   NA     8    ForWahlen
2024-10-04   31.0   16     11    4     3    17    3     7        Emnid
2024-10-08   31.0   17     11    3     3    17   NA     6        Forsa
2024-10-10   31.0   16     13    3     3    17    3     8    Infratest
2024-10-10   32.0   16     11    5     3    18    1     8       Yougov
2024-10-12   31.0   16     11    4     3    19   NA    9         INSA
```

Der Median der Umfragen aus den letzten vier Wochen ergibt eine gute Übereinstimmung 
mit dem letzten geglätteten Wert (dem Ende der geglätteten Linien in der Abbildung oben).

```
CDUCSU    SPD  Gruene    FDP  LINKE    AfD     FW    BSW
--------------------------------------------------------------------
  31.0   16.0    11.0    4.0    3.0   17.0    3.0    8.0    (median)
  31.8   16.1    11.3    3.9    3.2   17.4    2.3    7.9    (mean)
```

Die Anzahl der Umfragen pro Institut weist grosse Unterschiede zwischen den einzelnen 
Instituten auf: Allensbach zum Beispiel hat wahlberechtigte Bürger im Jahr 2023 nur 
einmal im Monat befragt, INSA dagegen zweimal (!) jede Woche.

```
Allensbach  Emnid  Forsa  ForWahlen  GMS  Infratest  INSA  Yougov
-----------------------------------------------------------------
        12     50     50         18    8         24   104      12
```

Der Einfluss dieser Institute auf die Glättung der Kurve und auf den aktuellen Median 
der Umfragen ist damit sehr unterschiedlich.


### Erläuterungen

In Deutschland finden mehrfach jede Woche Wahlumfragen zur Bundestagswahl statt. Die Frage an wahlberechtigte Bürger ist: "Wenn am nächsten Sonntag Bundestagswahl wäre, welche Partei würden Sie wählen?" Die wichtigsten beteiligten Umfrageinstitute sind wohl Allensbach, Verian (Emnid), Forsa, Forschungsgruppe Wahlen, GMS, Infratest Dimap, INSA und Yougov.

Die Daten aller dieser Institute werden auf der Plattform [Wahlrecht](https://www.wahlrecht.de/) veröffentlicht. Für die letzten aktuellen Umfragen siehe [Umfragen](https://www.wahlrecht.de/umfragen/). Die Art der Umfrage (Telefon, Online, ...) und die Anzahl der befragten Personen wird ebenfalls angegeben. Die Häufigkeit der Umfrage ist sehr unterschiedlich, zum Beispiel Allensbach nur einmal im Monat, INSA teilweise mehrfach pro Woche.

Jeder Punkt (kleiner Kreis) ist *ein* Umfrageergebnis für *eine* Partei; zu jeder Umfrage gehören also sechs Punkte zum gleichen Datum. Die durchgezogene Linie ist eine **Glättung** der Daten zu einer Partei, hier generiert mit Friedman's *SuperSmoother* (eine Glättung mit der *Lowess* Glättungsmethode würde eine fast identische Kurve erzeugen). Die Farben sind den Farben der jeweiligen Parteien angepasst.

Die gestrichelte, senkrechte Linie ist der Zeitpunkt der Bundestagswahl am 26.9.2021. Die darauf abgebildeten kleinen Quadrate markieren die offiziellen Endergebnisse der jeweiligen Parteien. Unten ist die "5-Prozent Hürde" eingezeichnet. Die letzten Umfragen vor dem Wahltag haben das Endergebnis der Bundestagswahl 2021 (im Mittel aller Umfragen) relativ gut vorausgesagt.
