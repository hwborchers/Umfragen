# Umfragen zur Bundestagswahl 2021

Hans W. Borchers  
*September 2021*

### Institute und letzte Umfragen

Eine Auswertung der Umfragen zur Bundestagswahl am 26. September 2021.

Stand: **Wed., 15. Sept. 2021**
*(Die Graphik wird in etwa jede Woche aktualisiert)*

Für die Umfragen der Wahlforschungs-Institute nutzen wir die veröffentlichten Daten auf [wahlrecht.de](https://www.wahlrecht.de/) ab Januar 2021.\
Die acht beteiligten Institute sind:

| Institut                 | Auftraggeber                    | # Umfragen |
|:-------------------------|:--------------------------------|-----------:|
| Allensbach               | FAZ                             |         11 |
| Kantar Emnid             | BamS                            |         35 |
| Forsa                    | stern-RTL                       |         39 |
| Forschungsgruppe Wahlen  | ZDF Politbarometer              |         15 |
| GMS                      | SAT1                            |          8 |
| Infratest Dimap          | ARD Deutschlandtrend            |         17 |
| INSA                     | Bild                            |         60 |
| YouGov                   | Redaktionsnetzwerk Deutschland  |         11 |

Die letzten Umfragen pro Institut haben zu folgenden Ergebnissen geführt:

|      Datum | CDUCSU |  SPD | Gruene |  FDP  | LINKE |  AfD |   Institut |
|:-----------|-------:|-----:|-------:|------:|------:|-----:|-----------:|
| 2021-09-02 |  20.0  | 25.0 |  16.0  |  13.0 |  6.0  | 12.0 |  Infratest |
| 2021-09-08 |  25.0  | 27.0 |  15.5  |   9.5 |  6.0  | 11.0 | Allensbach |
| 2021-09-09 |  21.0  | 25.0 |  17.0  |  12.0 |  6.0  | 12.0 |      Emnid |
| 2021-09-10 |  22.0  | 25.0 |  17.0  |  11.0 |  6.0  | 11.0 |  ForWahlen |
| 2021-09-10 |  21.0  | 26.0 |  15.0  |  10.0 |  6.0  | 12.0 |     Yougov |
| 2021-09-13 |  20.5  | 26.0 |  15.0  |  12.5 |  6.5  | 11.5 |       INSA |
| 2021-09-14 |  23.0  | 25.0 |  16.0  |  13.0 |  6.0  | 11.0 |        GMS |
| 2021-09-14 |  21.0  | 25.0 |  17.0  |  11.0 |  6.0  | 11.0 |      Forsa |

Die Daten werden jeweils aktuell und online aus den Tabellen auf 'wahlrecht.de' gezogen und mit R weiter verarbeitet. Die Grahik wird mit Base R Plot Routinen erzeugt (eine interaktive Version mit 'ggplo2' und 'plotly' könnte folgen).

### Glättung der Umfrage-Ergebnisse

Die folgende Grafik zeigt Ergebnisse der einzelnen Umfragen für die Parteien und Gättungskurven für den Verlauf. Die durchgezogenen Linien folgen Friedman's *Supersmoother* (in R als Funktion `supsmu`), die gestrichelten Linien durch *Gauss'sche Prozesse* berechnete Approximationen (die besonders am Ende unterschiedlich sein können).

![](Umfragen.png)

(Die Einzelergebnisse für AfD und DieLinke sind nicht eingezeichnet, um die Grafik im unteren Bereich nicht zu überlasten.)


### Stimmen und Koalitionen

Aus diesen letzten Ergebnissen ergibt sich folgende Schätzung der prozentualen Stimmen und der Stimmenverteilung.

| Partei    | Anteil Stimmen | Sitze Bundestag|
|----------:|---------------:|---------------:|
| CDU/CSU   | 21.5 % | 162 |
| SPD       | 25.5 % | 192 |
| B90/Grüne | 16   % | 121 |
| FDP       | 12   % |  90 |
| DieLinke  |  6   % |  45 |
| AfD       | 11.5 % |  90 |
| Sonstige  |  6.5 % |   - |

Die Sitzverteilung ist dabei gerechnet mit etwa 700 Plätzen im Bundestag und 6.5% abgegebener Stimmen für Parteien, die wegen der 5%-Hürde *nicht* in den Bundestag kommen. Die wahrscheinlich hohe Zahl an Überhangmandaten für die CDU/CSU wird nicht berücksichtigt.

Die "grosse Koalition" hat keine Mehrheit mehr (343/700), ebenso hätte eine Linkskoalition von SPD, Grünen und Linken nur knapp eine Mehrheit (368/700) -- aber: siehe Überhangmandate. Am wahrscheinlichsten erscheint eine Jamaica- oder Deutschland-Koalition.

| Koalition | Parteien | Anzahl stimmen | Bemerkung |
|:----------|:---------|:---------------|:----------|
| Ampel Koalition | SPD, Grüne, FDP | 404 |  |
| Jamaica Koalition (*) | CDU/CSU, Grüne, FDP | 374 |  |
| Deutschland Koalition | CDU/CSU, SPD, FDP | 445 |  |
| Kenia Koalition | CDU/CSU, SPD, Grüne | 471 | unwahrscheinlich |
| Linkskoalition | SPD, Grüne, DieLinke | 358 | knappe Mehrheit |
| Grosse Koalition | CDU/CSU, SPD | 354 | knappe Mehrheit |
| Rot-Grün | SPD, Grüne | 313 | keine Mehrheit |

(*) auch "schwarze Ampel" oder kurz "Schwampel" genannt.



