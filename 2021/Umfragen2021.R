# install.packages("rvest")
# install.packages("stringr)

library(rvest)
library(stringr)
# library(GauPro)

#-- --------------------------------------------------------------------

partei <- c("CDUCSU", "SPD", "Gruene", "FDP", "LINKE", "AfD")
weblinks <- c("https://www.wahlrecht.de/umfragen/allensbach.htm",
             "https://www.wahlrecht.de/umfragen/emnid.htm",
             "https://www.wahlrecht.de/umfragen/forsa.htm",
             "https://www.wahlrecht.de/umfragen/politbarometer.htm",
             "https://www.wahlrecht.de/umfragen/gms.htm",
             "https://www.wahlrecht.de/umfragen/dimap.htm",
             "https://www.wahlrecht.de/umfragen/insa.htm",
             "https://www.wahlrecht.de/umfragen/yougov.htm")
names(weblinks) <- c("Allensbach", "Emnid", "Forsa", "ForWahlen",
                     "GMS", "Infratest", "INSA", "Yougov")
Umfragen <- data.frame(Datum = as.Date(character()),
                       CDUCSU = double(), SPD = double(), Gruene = double(),
                       FDP = double(), Linke = double(), AfD = double(),
                       Institut = character())

#-- --------------------------------------------------------------------

# Umfragedaten pro Institut
for (inst in names(weblinks)) {
    cat(inst, ': ')
    content <- read_html(weblinks[inst])
    tables <- content %>% html_table()
    df <- as.data.frame(tables[[2]])
    n <- nrow(df)
    # Dates after 2020-12-31
    dtm <- as.Date(df[4:n, 1], format="%d.%m.%Y")
    m <- which(dtm > "2020-12-31")
    cat(length(m), "Umfragen in 2021", '\n')
    Umfr <- dtm[m]
    # Remove "" and %, change decimal ',' to '.'
    if (inst != "INSA") {
        perc <- df[3+m, 3:8]
    } else {
        perc <- df[3+m, c(3:7, 10)]
    }
    for (i in 1:6) {
        p <- perc[, i]
        p <- str_remove(p, ' %')
        p <- as.numeric(str_replace(p, ',', '.'))
        perc[, i] <- p
        colnames(perc) <- partei
    }
    Umfragen <- rbind(Umfragen,
        data.frame(Datum = dtm[m], perc, Institut = rep(inst, length(m))))
}

# Sortierung nach Datum
o <- order(Umfragen$Datum)
Umfragen <- Umfragen[o, ]
rownames(Umfragen) <- NULL

#-- --------------------------------------------------------------------

# Darstellung der Umfragewerte

# png("Umfragen.png", 800, 450)

par(mar = c(2,2,2,1))
plot(Umfragen$Datum, Umfragen$CDUCSU, pch = 20, col = "gray",
     xlim = as.Date(c("2021-01-01", "2021-10-01")),
     ylim = c(5, 40), 
     main = "Umfragen zur Bundestagswahl 2021")
grid()

# Friedman's supersmoother
fss <- supsmu(Umfragen$Datum, Umfragen$CDUCSU, bass = 0)
lines(fss$x, fss$y, lwd = 2.0)

points(Umfragen$Datum, Umfragen$Gruene, pch = 20, col = "greenyellow")
fss <- supsmu(Umfragen$Datum, Umfragen$Gruene, bass = 0)
lines(fss$x, fss$y, col = "green3", lwd = 2.0)

points(Umfragen$Datum, Umfragen$SPD, pch = 20, col = "orange")
fss <- supsmu(Umfragen$Datum, Umfragen$SPD, bass = 0)
lines(fss$x, fss$y, col = "red", lwd = 2.0)

points(Umfragen$Datum, Umfragen$FDP, pch = 20, col = "lightblue")
fss <- supsmu(Umfragen$Datum, Umfragen$FDP, bass = 0)
lines(fss$x, fss$y, col = "blue", lwd = 2.0)

fss <- supsmu(Umfragen$Datum, Umfragen$AfD, bass = 0)
lines(fss$x, fss$y, col = "brown", lwd = 2.0)

fss <- supsmu(Umfragen$Datum, Umfragen$LINKE, bass = 0)
lines(fss$x, fss$y, col = "magenta", lwd = 2.0)

nr <- nrow(Umfragen); now <- Umfragen$Datum[nr]
text(as.Date("2021-06-01"), 38, paste("Aktuelles Datum:", now), adj = 0)
# text(as.Date("2021-04-01"), 38,
#      paste("Letzte Umfrage:", Umfragen$Institut[nr], Umfragen$Datum[nr]),
#      adj = 0)

library(GauPro)
gp <- GauPro(Umfragen$Datum, Umfragen$CDUCSU)
lines(Umfragen$Datum, predict(gp, Umfragen$Datum), lty = 2)
pr_CDUCSU <- round(predict(gp, as.Date("2021-09-26")), 1)
cat("\nCDUCSU", '\t', pr_CDUCSU, '\n')

gp <- GauPro(Umfragen$Datum, Umfragen$Gruene)
lines(Umfragen$Datum, predict(gp, Umfragen$Datum), lty = 2)
pr_Gruene <- round(predict(gp, as.Date("2021-09-26")), 1)
cat("Gruene", '\t', pr_Gruene, '\n')

gp <- GauPro(Umfragen$Datum, Umfragen$SPD)
lines(Umfragen$Datum, predict(gp, Umfragen$Datum), lty = 2)
pr_SPD <- round(predict(gp, as.Date("2021-09-26")), 1)
cat("SPD", '\t', pr_SPD, '\n')

gp <- GauPro(Umfragen$Datum, Umfragen$FDP)
lines(Umfragen$Datum, predict(gp, Umfragen$Datum), lty = 2)
pr_FDP <- round(predict(gp, as.Date("2021-09-26")), 1)
cat("FDP", '\t', pr_FDP, '\n')

gp <- GauPro(Umfragen$Datum, Umfragen$LINKE)
lines(Umfragen$Datum, predict(gp, Umfragen$Datum), lty = 2)
pr_LINKE <- round(predict(gp, as.Date("2021-09-26")), 1)
cat("LINKE", '\t', pr_LINKE, '\n')

gp <- GauPro(Umfragen$Datum, Umfragen$AfD)
lines(Umfragen$Datum, predict(gp, Umfragen$Datum), lty = 2)
pr_AfD <- round(predict(gp, as.Date("2021-09-26")), 1)
cat("AfD", '\t', pr_AfD, '\n')


legend(x = as.Date("2021-01-01"), y = 33,
       legend = c("CDU/CSU", "SPD", "Gruene", "FDP", "LINKE", "AfD"),
       col = c("black", "red", "darkgreen", "blue", "magenta", "brown"),
       lty = 1, bty = 'n')

# E = data.frame(Jahr = c(2017, 2021), CDU.CSU = c('32.9', '--'),
#                SPD = c('20.5', '--'), Gruene = c('8.9', '--'),
#                FDP = c('10.7', '--'), AfD = c('12.6', '--'),
#                DieLinke = c('9.2', '--'), Sonstige = c('5.0', '--'))
#
# plotrix::addtable2plot(x = as.Date("2021-04-01"), y = 33, E,
#                        cex = 1.0, text.col = "darkblue",
#                        xpad = 0.20, ypad = 0.80, title = "Endergebnis")

# dev.off()

# split(Umfragen, Umfragen$Institut)
cat('\n')
print(tail(Umfragen))

#-- --------------------------------------------------------------------
