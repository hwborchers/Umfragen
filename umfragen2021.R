# Umfragen von Dez. 2020 bis Sept. 2021
#
# Institute:
# Allensbach, KantarEmnid, Forsa, FGWahlen, GMS, InfratestDimap, INSA, YouGov
institute = c("Allensbach", "KantarEmnid", "Forsa", "FGWahlen",
              "GMS", "InfratestDimap", "INSA", "YouGov")
#
# Spalten:
#   1  Datum
#
#   2  CDUCSU      5  FDP  
#   3  SPD         6  Linke
#   4  Gruene      7  AfD  
#   8  Sonstige
#
#   9  Institut
#   10 Befragte
#   11 Zeitraum
#
# Endergebnis 2013 und 2017
#      CDUCSU    SPD  GRÜNE    FDP  DieLINKE    AfD  
ee13 = c(41.5,  25.7,	  8.4,	 4.8,	     8.6,	  4.7)
ee17 = c(32.9,	20.5,	  9.2,	 8.9,	    10.7,	 12.6)

U = read.table("umfragen2021.cvs", header=TRUE,
               dec = ',', sep="\t")
# Forsa vom 20.04 ist ein Ausreisser (Zeile 19)
N = nrow(U)  # Anzahl Umfragen


## Bestimmung der Distanzmatrix
M = as.matrix(U[, 2:7])
M = rbind(M[1:18, ], M[20:N, ])
N = N - 1
# M = rbind(M, ee13, ee17)
md = dist(M)
cmd = cmdscale(md)
## Plot MDS
opar = par(mar = c(3,3,3,2))
plot(cmd[, 1], cmd[, 2], pch = 20, col = 4,
     main = "Umfragen 2021 (MDS Plot)")
grid()


clr = 0
for (inst in U$Institut) {
  clr = clr + 1
  i = which(U[, 9] == inst)
  points(cmd[i, 1], cmd[i, 2], pch = 20, col = clr)
  lines(cmd[i, 1], cmd[i, 2], col = clr)
}

# display CDUCSU figures
for (i in 1:N) text(cmd[i,1], cmd[i,2], U[i, 2])

legend("topright",
       legend = c("Allensbach", "KantarEmnid", "Forsa", "FGWahlen",
                  "GMS", "InfratestDimap", "INSA", "YouGov"),
       pch = 20, col = 1:8)

#-- --------------------------------------------------------------------
library(ggplot2)

U1 = cbind(Datum = as.Date(U$Datum, format="%d.%m.%Y"),
           Institut = U$Institut,
           U[, c(2:7)])

o = order(U1$Datum)
U2 = U1[o, ]

ggplot(U2, aes(x = Datum, y = CDUCSU, group=Institut, col = Institut)) + 
    geom_point() + geom_line() +
    theme_gray()
