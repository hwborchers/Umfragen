# install.packages("rvest")
# install.packages("stringr)

library(rvest)
library(stringr)
# library(GauPro)

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

# Darstellung der Umfragewerte

par(mar = c(2,2,2,1))
plot(Umfragen$Datum, Umfragen$CDUCSU, pch = 20, col = "gray",
     ylim = c(5, 40), main = "Umfragen zur Bundestagswahl 2021")
grid()

# Friedman's supersmoother
fss <- supsmu(Umfragen$Datum, Umfragen$CDUCSU, bass = 0)
lines(fss$x, fss$y, lwd = 1.25)
# gp <- GauPro(Umfragen$Datum, Umfragen$CDUCSU)
# lines(Umfragen$Datum, predict(gp, Umfragen$Datum), lty = 2)

points(Umfragen$Datum, Umfragen$Gruene, pch = 20, col = "lightgreen")
fss <- supsmu(Umfragen$Datum, Umfragen$Gruene, bass = 0)
lines(fss$x, fss$y, col = "darkgreen", lwd = 1.25)

points(Umfragen$Datum, Umfragen$SPD, pch = 20, col = "orange")
fss <- supsmu(Umfragen$Datum, Umfragen$SPD, bass = 0)
lines(fss$x, fss$y, col = "red", lwd = 1.25)

fss <- supsmu(Umfragen$Datum, Umfragen$FDP, bass = 0)
lines(fss$x, fss$y, col = "blue", lwd = 1.25)

fss <- supsmu(Umfragen$Datum, Umfragen$AfD, bass = 0)
lines(fss$x, fss$y, col = "brown", lwd = 1.25)

fss <- supsmu(Umfragen$Datum, Umfragen$LINKE, bass = 0)
lines(fss$x, fss$y, col = "magenta", lwd = 1.25)

legend(x = as.Date("2021-01-15"), y = 32,
       legend = c("CDU/CSU", "SPD", "Gruene", "FDP", "LINKE", "AfD"),
       col = c("black", "red", "darkgreen", "blue", "magenta", "brown"),
       lty = 1)

print(tail(Umfragen))
