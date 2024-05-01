# Sonntagsfrage

Hans W. Borchers\
Copyright © Heidelberg 2024

## Umfragen 2020-2024


### Einführung

In Deutschland finden mehrfach jede Woche Wahlumfragen zur Bundestagswahl statt. Die Frage an wahlberechtigte Bürger ist: “Wenn am nächsten Sonntag Bundestagswahl wäre, welche Partei würden Sie wählen?” Die wichtigsten beteiligten Umfrageinstitute sind wohl Allensbach, Verian (Emnid), Forsa, Forschungsgruppe Wahlen, GMS, Infratest Dimap, INSA und Yougov.

Die Daten aller dieser Institute werden auf der Plattform Wahlrecht veröffentlicht. Für die letzten aktuellen Umfragen siehe Umfragen. Die Art der Umfrage (Telefon, Online, …) und die Anzahl der befragten Personen wird ebenfalls angegeben. Die Häufigkeit der Umfrage ist sehr unterschiedlich, zum Beispiel Allensbach nur einmal im Monat, INSA teilweise mehrfach pro Woche.


### Aktuelle Graphik




### Erläuterungen

Jeder Punkt (kleiner Kreis) ist ein Umfrageergebnis für eine Partei; zu jeder Umfrage gehören also sechs Punkte zum gleichen Datum. Die durchgezogene Linie ist eine Glättung der Daten zu einer Partei, hier generiert mit Friedman’s SuperSmoother (eine Glättung mit der Lowess Glättungsmethode würde eine fast identische Kurve erzeugen). Die Farben sind den Farben der jeweiligen Parteien angepasst.

Die gestrichelte, senkrechte Linie ist der Zeitpunkt der Bundestagswahl am 26.9.2021. Die darauf abgebildeten kleinen Quadrate markieren die offiziellen Endergebnisse der jeweiligen Parteien. Unten ist die “5-Prozent Hürde” eingezeichnet. Die letzten Umfragen vor dem Wahltag haben das Endergebnis der Bundestagswahl 2021 (im Mittel aller Umfragen) relativ gut vorausgesagt.


### Auswertung

Die Ergebnisse der letzten Umfragen pro Institut ergeben

```
       Datum CDUCSU  SPD Gruene FDP LINKE  AfD   Institut
1 2024-02-06   32.0 16.0   13.0   4   2.0 18.0        GMS
2 2024-04-04   30.0 15.0   15.0   4   3.0 18.0  Infratest
3 2024-04-11   29.0 14.0   15.0   5   4.0 19.0     Yougov
4 2024-04-19   30.0 16.0   14.0   5   3.0 18.0      Emnid
5 2024-04-26   30.0 15.0   15.0   4   4.0 17.0  ForWahlen
6 2024-04-26   32.5 16.0   15.0   6   3.0 16.0 Allensbach
7 2024-04-30   30.0 17.0   12.0   5   3.0 16.0      Forsa
8 2024-04-30   29.5 16.5   12.5   5   3.5 18.5       INSA
```

Der Median der Umfragen aus den letzten vier Wochen ergibt eine gute Übereinstimmung mit dem letzten geglätteten Wert (dem Ende der geglätteten Linien in der Abbildung oben).

```
CDUCSU    SPD Gruene    FDP  LINKE    AfD 
  30.0   16.0   14.5    5.0    3.0   18.0 
  30.4   15.7   13.9    4.8    3.2   17.6 
```

Die Anzahl der Umfragen pro Institut weist grosse Unterschiede zwischen den einzelnen Instituten auf: Allensbach zum Beispiel hat wahlberechtigte Bürger im Jahr 2023 nur einmal im Monat befragt, INSA dagegen zweimal (!) jede Woche.

```
Allensbach  Emnid  Forsa  ForWahlen  GMS  Infratest  INSA  Yougov 
        12     50     50         18    8         24   104      12
```

Der Einfluss dieser Institute auf die Glättung der Kurve und auf den aktuellen Median der Umfragen ist damit sehr unterschiedlich.
