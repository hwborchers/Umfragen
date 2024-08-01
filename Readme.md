
## Umfragen 2020-2024


### Aktuelle Graphik

![Abb. Sonntagsfrage](umfrage_aktuell.png)

(*Diese Grafik wird hier zum Ende eines jeden Monats aktualisiert*)


### Einführung

In Deutschland finden mehrfach jede Woche Wahlumfragen zur Bundestagswahl statt. Die Frage an wahlberechtigte Bürger ist: "Wenn am nächsten Sonntag Bundestagswahl wäre, welche Partei würden Sie wählen?" Die wichtigsten beteiligten Umfrageinstitute sind wohl Allensbach, Verian (Emnid), Forsa, Forschungsgruppe Wahlen, GMS, Infratest Dimap, INSA und Yougov.

Die Daten aller dieser Institute werden auf der Plattform [Wahlrecht](https://www.wahlrecht.de/) veröffentlicht. Für die letzten aktuellen Umfragen siehe [Umfragen](https://www.wahlrecht.de/umfragen/). Die Art der Umfrage (Telefon, Online, ...) und die Anzahl der befragten Personen wird ebenfalls angegeben. Die Häufigkeit der Umfrage ist sehr unterschiedlich, zum Beispiel Allensbach nur einmal im Monat, INSA teilweise mehrfach pro Woche.

Seit July 24 sind die Ergebnisse der Europawahl in Deutschland eingetragen, auch das Ergebnis des BSW. Die Umfragewerte des BSW werden noch nicht von allen Instituten erhoben bzw. publiziert und werden deshalb erst in den kommenden Monaten Eingang in die Graphik finden.


### Erläuterungen

Jeder Punkt (kleiner Kreis) ist *ein* Umfrageergebnis für *eine* Partei; zu jeder Umfrage gehören also sechs Punkte zum gleichen Datum. Die durchgezogene Linie ist eine **Glättung** der Daten zu einer Partei, hier generiert mit Friedman's *SuperSmoother* (eine Glättung mit der *Lowess* Glättungsmethode würde eine fast identische Kurve erzeugen). Die Farben sind den Farben der jeweiligen Parteien angepasst.

Die gestrichelte, senkrechte Linie ist der Zeitpunkt der Bundestagswahl am 26.9.2021. Die darauf abgebildeten kleinen Quadrate markieren die offiziellen Endergebnisse der jeweiligen Parteien. Unten ist die "5-Prozent Hürde" eingezeichnet. Die letzten Umfragen vor dem Wahltag haben das Endergebnis der Bundestagswahl 2021 (im Mittel aller Umfragen) relativ gut vorausgesagt.


### Auswertung

Die Ergebnisse der letzten Umfragen pro Institut ergeben

```
     Datum CDUCSU  SPD Gruene  FDP LINKE   AfD   BSW     Institut
------------------------------------------------------------------
2024-06-18   31.0 14.0   14.0  5.0   3.0  18.0   6.0          GMS
2024-07-04   31.0 14.0   13.0  5.0   3.0  17.0   8.0    Infratest
2024-07-05   30.0 14.0   12.0  6.0   3.0  19.0   9.0       Yougov
2024-07-12   31.0 15.0   13.0  5.0   3.0  16.0   7.0        Emnid
2024-07-12   32.0 14.0   13.0  4.0   3.0  17.0   7.0    ForWahlen
2024-07-25   32.0 16.5   11.5  6.0    NA  17.0   8.0   Allensbach
2024-07-29   30.0 15.0   10.0  5.0   3.5  18.0   9.5         INSA
2024-07-30   30.0 15.0   11.0  4.0   3.0  17.0   7.0        Forsa
```

Der Median der Umfragen aus den letzten vier Wochen ergibt eine gute Übereinstimmung mit dem letzten geglätteten Wert (dem Ende der geglätteten Linien in der Abbildung oben).

```
CDU/CSU    SPD  Gruene   FDP  LINKE    AfD   BSW
------------------------------------------------------------------
   31.0   14.5   12.5    5.0    3.0   17.0    --   (median)
   30.9   14.7   12.2    5.0    3.1   17.4    --   (mean)
   30.0   13.9   11.9    5.2    2.7   15.9   6.2   (Europawahl)
```

Die Anzahl der Umfragen pro Institut weist grosse Unterschiede zwischen den einzelnen Instituten auf: Allensbach zum Beispiel hat wahlberechtigte Bürger im Jahr 2023 nur einmal im Monat befragt, INSA dagegen zweimal (!) jede Woche.

```
Allensbach  Emnid  Forsa  ForWahlen  GMS  Infratest  INSA  Yougov 
        12     50     50         18    8         24   104      12
```

Der Einfluss dieser Institute auf die Glättung der Kurve und auf den aktuellen Median der Umfragen ist damit sehr unterschiedlich.


## Europawahl 2024

Speziell auf die Europawahl ausgerichtete Umfragen gibt es nicht viele, das sind 15 Umfragen in diesem Jahr, davon die Hälfte durch INSA. Eine Grafik wie oben macht daher nicht viel Sinn. Stattdessen verwenden wir eine gewichtete Mittelbildung, die neueren Umfragen werden dabei höher gewichtet als solche, die mehrere Monate alt sind.

```
            CDU/CSU     SPD   Grüne     FDP   Linke     BSW     AfD  Sonstige
Prognose       29.6    14.9    14.2     4.0     3.5     6.1    15.9      11.8
Endergebnis    30.2    14.0    12.0     5.0     2.7     6.0    15.9      14.2
```

![](europawahl.png)

In der Grafik werden die Prognose ('gestrichelt'), wenige Tage vor der Wahl, und das Endergebnis ('gefüllt') der Europawahl 2024 für die wichtigsten Parteien nebeneinander dargestellt.
(CDU meint das aufsummierte Ergebnis von CDU und CSU.)

Für CDU/CSU, BSW und AfD stimmen Prognose und Endergebnis recht gut überein. SPD und Grüne sind unter dem vorausgesagten Ergebnis geblieben.
