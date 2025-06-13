##
##  S o n n t a g s f r a g e , version 0.3, October 2024
##

#-- Libraries ----------------------------------------------------------
library(rvest)
library(stringr)
library(lubridate)

#-- Define the data frame ----------------------------------------------
partei <- c("CDUCSU", "SPD", "Gruene", "FDP", "LINKE",
            "AfD", "FW", "BSW")
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

#-- Empty structured data frame ----------------------------------------
Umfragen <- data.frame(Datum = as.Date(character()),
                       CDUCSU = double(), SPD = double(), Gruene = double(),
                       FDP = double(), Linke = double(), AfD = double(),
                       FW = double(), BSW = double(), Institut = character())

#-- Set the parameters -------------------------------------------------
today = lubridate::as_date(lubridate::now())
from = "2019-12-31"
to = today              # as.Date("2025-02-24")

smoothing <- "super"    # "lowess" "super" "gauss"
stand = c()

#-- Load data from website ---------------------------------------------
for (inst in names(weblinks)) {
    cat(inst, '\n')
    if (inst == "GMS") next  # inst == "INSA" || 

    # Read data from Wahlrecht.de
    content <- read_html(weblinks[inst])
    tables <- content |> html_table()
    df <- as.data.frame(tables[[2]])
    n <- nrow(df)
    
    # Dates after 'from'
    dtm <- as.Date(df[4:n, 1], format="%d.%m.%Y")
    m <- which(dtm > from)
    Umfr <- dtm[m]

    # Correct different formats
    if (!(inst %in% c('GMS', 'INSA'))) {
        perc <- df[3+m, 3:10]
    } else if (inst == "GMS") {
        perc <- df[3+m, c(3:8)]
    } else if (inst == "INSA") {
        perc <- df[3+m, c(3:7, 9,8,10)]
    } # else send warning
    
    # Remove "" and %, change decimal ',' to '.'
    for (i in 1:8) {
        p <- perc[, i]
        p <- str_remove(p, '%')
        p <- as.numeric(str_replace(p, ',', '.'))
        perc[, i] <- p
        colnames(perc) <- partei
    }
    
    # Add to the data frame
    Umfragen <- 
        rbind(Umfragen,
              data.frame(Datum = dtm[m], perc,
                         Institut = rep(inst, length(m))))
}

#-- Sort according to date ---------------------------------------------
o <- order(Umfragen$Datum)
Umfragen <- Umfragen[o, ]
rownames(Umfragen) <- NULL

Umfragen <- Umfragen[Umfragen$Datum < to, ]
# write.table(Umfragen, "Umfragen.csv", sep = "\t", row.names = FALSE)

#-- Darstellung der Umfragewerte ---------------------------------------

opar = par(mar = c(2,2,2,1))
plot(c(as.Date(from), as.Date(to)), c(0, 40), type = 'n',
     ylim = c(2, 40), main = "Umfragen 2020-25 (Sonntagsfrage)")
grid()
axis(1, at=as.Date("2021-01-01"), labels="2021")
axis(1, at=as.Date("2023-01-01"), labels="2023")
axis(1, at=as.Date("2025-01-01"), labels="2025")

points(Umfragen$Datum, Umfragen$CDUCSU, pch = 20, col = "gray")
points(Umfragen$Datum, Umfragen$Gruene, pch = 20, col = "lightgreen")
points(Umfragen$Datum, Umfragen$SPD, pch = 20, col = "orange")
points(Umfragen$Datum, Umfragen$LINKE, pch = 20, col = "peachpuff")
points(Umfragen$Datum, Umfragen$FDP, pch = 20, col = "yellow")
points(Umfragen$Datum, Umfragen$AfD, pch = 20, col = "lightblue")
points(Umfragen$Datum, Umfragen$BSW, pch = 20, col = "cyan")

if (smoothing == "lowess") {
    mdl <- lowess(Umfragen$Datum, Umfragen$CDUCSU, f = 1/12)
    lines(Umfragen$Datum, mdl$y, col = "black", lwd = 1.25, lty = 1)
    mdl <- lowess(Umfragen$Datum, Umfragen$SPD, f = 1/12)
    lines(Umfragen$Datum, mdl$y, col = "red", lwd = 1.25, lty = 1)
    mdl <- lowess(Umfragen$Datum, Umfragen$Gruene, f = 1/12)
    lines(Umfragen$Datum, mdl$y, col = "darkgreen", lwd = 1.25, lty = 1)
    mdl <- lowess(Umfragen$Datum, Umfragen$FDP, f = 1/12)
    lines(Umfragen$Datum, mdl$y, col = "goldenrod", lwd = 1.75, lty = 1)
    mdl <- lowess(Umfragen$Datum, Umfragen$LINKE, f = 1/12)
    lines(Umfragen$Datum, mdl$y, col = "magenta", lwd = 1.25, lty = 1)
    mdl <- lowess(Umfragen$Datum, Umfragen$AfD, f = 1/24)
    lines(Umfragen$Datum, mdl$y, col = "blue", lwd = 1.25, lty = 1)
    mdl <- lowess(Umfragen$Datum, Umfragen$BSW, f = 1/12)
    lines(Umfragen$Datum, mdl$y, col = "steelblue", lwd = 1.25, lty = 1)
    
    
} else if (smoothing == "super") {
    # Friedman's supersmoother
    fss <- supsmu(Umfragen$Datum, Umfragen$CDUCSU, span = 1/24, bass = 0)
    lines(fss$x, fss$y, lwd = 1.25, lty = 1)
    stand = c(stand, CDUCSU = round(fss$y[length(fss$y)], 1))
    fss <- supsmu(Umfragen$Datum, Umfragen$Gruene, span = 1/24, bass = 0)
    lines(fss$x, fss$y, col = "darkgreen", lwd = 1.25, lty =1)
    stand = c(stand, Gruene = round(fss$y[length(fss$y)], 1))
    fss <- supsmu(Umfragen$Datum, Umfragen$SPD, span = 1/24, bass = 0)
    lines(fss$x, fss$y, col = "red", lwd = 1.25, lty = 1)
    stand = c(stand, SPD = round(fss$y[length(fss$y)], 1))
    fss <- supsmu(Umfragen$Datum, Umfragen$LINKE, span = 1/24, bass = 0)
    lines(fss$x, fss$y, col = "magenta", lwd = 1.25, lty = 1)
    stand = c(stand, LINKE = round(fss$y[length(fss$y)], 1))
    fss <- supsmu(Umfragen$Datum, Umfragen$FDP, span = 1/24, bass = 0)
    lines(fss$x, fss$y, col = "goldenrod", lwd = 1.75, lty = 1)
    stand = c(stand, FDP = round(fss$y[length(fss$y)], 1))
    fss <- supsmu(Umfragen$Datum, Umfragen$AfD, span = 1/24, bass = 0)
    lines(fss$x, fss$y, col = "blue", lwd = 1.0, lty = 1)
    stand = c(stand, AfD = round(fss$y[length(fss$y)], 1))
    fss <- supsmu(Umfragen$Datum, Umfragen$BSW, span = 1/6, bass = 0)
    lines(fss$x, fss$y, col = "steelblue", lwd = 1.6, lty = 1)
    stand = c(stand, BSW = round(fss$y[length(fss$y)], 1))
} else if (smoothing == "gaupro") {
    # Gaussian Processes
    library(GauPro)
    fss = GauPro(X = Umfragen$Datum, Z = Umfragen$CDUCSU)
    lss = predict(fss, Umfragen$Datum)
    lines(Umfragen$Datum, lss, col = "black",lwd = 1.25, lty = 1)
    fss = GauPro(X = Umfragen$Datum, Z = Umfragen$Gruene)
    lss = predict(fss, Umfragen$Datum)
    lines(Umfragen$Datum, lss, col = "darkgreen",lwd = 1.25, lty = 1)
    fss = GauPro(X = Umfragen$Datum, Z = Umfragen$SPD)
    lss = predict(fss, Umfragen$Datum)
    lines(Umfragen$Datum, lss, col = "red",lwd = 1.25, lty = 1)
    fss = GauPro(X = Umfragen$Datum, Z = Umfragen$LINKE)
    lss = predict(fss, Umfragen$Datum)
    lines(Umfragen$Datum, lss, col = "magenta",lwd = 1.25, lty = 1)
    fss = GauPro(X = Umfragen$Datum, Z = Umfragen$AfD)
    lss = predict(fss, Umfragen$Datum)
    lines(Umfragen$Datum, lss, col = "blue",lwd = 1.25, lty = 2)
    
    fss = GauPro(X = Umfragen$Datum, Z = Umfragen$fdp)
} else {
    cat("Unknown smoothing operation!\n")
}

#-- 5% Hurdle and Legend
abline(h = 5, col=1, lty = 2, lwd = 1.0)
text(as.Date("2020-01-01"), 3.5, "5 Prozent Hürde", cex = 0.75, pos = 4)

# Legend and Election 2021
legend(x = as.Date("2020-05-01"), y = 35.0,
       legend = c("CDU/CSU", "SPD", "Gruene", "FDP", "LINKE", "AfD", "BSW"),
       col = c("black", "red", "darkgreen", "goldenrod",
               "magenta", "blue", "cyan"),
       cex = 0.80, lty = 1, lwd = 2)

lines(as.Date(c("2021-09-26", "2021-09-26")),
      c(4, 33), col = "firebrick", lty = 2, lwd = 2.0)
lines(as.Date(c("2025-02-23", "2025-02-23")),
      c(4, 33), col = "firebrick", lty = 2, lwd = 2.0)
text(as.Date("2021-08-15"), 34, "Bundestagswahl 2021", pos = 4)
text(as.Date("2024-07-09"), 34.5, "Europa 2024", pos=2)
text(as.Date("2025-02-23"), 32.0, "Bund\n2025", pos = 3)
text(as.Date(today), 40, paste("Aktuelles Datum: ", today),
     col = "darkred", pos = 2)

points(rep(as.Date("2021-09-26"), 6), c(24.1, 25.7, 14.8, 11.5, 10.3, 4.9),
       pch = 22,
       col = c("black", "red", "darkgreen", "goldenrod", "blue", "magenta"),
       bg  = c("black", "red", "darkgreen", "goldenrod", "blue", "magenta"))

lines(as.Date(c("2024-06-09", "2024-06-09")),
      c(4, 33), col = "firebrick", lty = 2, lwd = 1.0)
points(rep(as.Date("2024-06-09"), 6), c(30.2, 14.4, 12.0, 5.0, 15.9, 2.7),
       pch = 22, cex = 0.7,
       col = c("black", "red", "darkgreen", "goldenrod", "blue", "magenta"),
       bg  = c("black", "red", "darkgreen", "goldenrod", "blue", "magenta"))
points(as.Date("2024-06-09"), 6.17, pch = 22, cex = 0.7,
       col = "grey", bg = "cyan")
text(as.Date("2024-06-09"), 6.5, "BSW", cex = 0.75, pos = 2)

lines(as.Date(c("2025-02-23", "2025-02-23")),
      c(4, 33), col = "firebrick", lty = 2, lwd = 1.0)
points(rep(as.Date("2025-02-23"), 6),
       c(28.52, 16.41, 11.61, 4.33, 20.80, 8.77),
       pch = 22, 
       col = c("black", "red", "darkgreen", "goldenrod", "blue", "magenta"),
       bg  = c("black", "red", "darkgreen", "goldenrod", "blue", "magenta"))
points(as.Date("2024-06-09"), 6.17, pch = 22, cex = 0.7,
       col = "grey", bg = "cyan")
text(as.Date("2024-06-09"), 6.5, "BSW", cex = 0.75, pos = 2)


par(opar)
#dev.off()

Umf00 = tail(Umfragen, n = 0)
for (inst in unique(Umfragen$Institut)) {
    Umf00 = rbind(Umf00, tail(Umfragen[Umfragen$Institut == inst, ], n=1))
}
u = order(Umf00$Datum)
Umf00 = Umf00[u, ]
row.names(Umf00) <- NULL
Umf00

round(apply(Umf00[, 2:9], 2, median, na.rm = TRUE), 1)
round(apply(Umf00[, 2:9], 2, mean,   na.rm = TRUE), 1)
