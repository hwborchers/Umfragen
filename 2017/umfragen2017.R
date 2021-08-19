umfragen = read.table("umfragen2017.txt", header=TRUE, sep="\t")

M = as.matrix(umfragen[, 2:7])
md = dist(M)
cmd = cmdscale(md)

#-- pdf("Rplot.pdf", 8, 6)
plot(cmd, pch=20, col="darkgrey",
     xlab="Jan=1, Feb=2, ..., Aug=8, Sept=9", ylab="",
     main="Wahlumfragen DE 2017", sub="Abstand In Prozentpunkten")
grid()

cls = rainbow(14)
for (i in 1:7) {
  m = (9*(i-1)+1):(9*(i-1)+9)
  points(cmd[m, 1], cmd[m, 2], pch=20, col=i)
}

for (i in 1:7) {
  for (j in 1:9) {
    m = 9*i + 1
    text(cmd[m-j, 1]+0.2, cmd[m-j, 2], as.character(j))
  }
}

text(-3, 3, "Januar 2017", col="darkgray")
text(-2, 1, "September 2017", col="darkgray")
text(6, 2, "Der Schulz Hype", col="darkgray")
text(6.5, -2.1, "Feb.-April 2017", col="darkgray")

points(cmd[64, 1], cmd[64, 2], pch=20, cex=4, col="grey")
points(cmd[65:66, 1], cmd[65:66, 2], col="red")   # ARD
text(-5.6, 6, "ARD", col="red")
points(cmd[67:68, 1], cmd[67:68, 2], col="blue")  # ZDF
text(-5.0, 5.0, "ZDF", col="blue")

legend(0, 6, legend=c("Allensbach", "Emnid", "Forsa", "FGWahlen", "GMS", "Infratest", "INSA"), col=1:7, pch=20, cex=0.75, ncol=2)
#-- dev.off()


#-- Nachtrag 2021 ------------------------------------------------------
library(ggplot2)
library(GauPro)

# U = read.csv("umfragen2017.cvs", header=TRUE,
#                dec = ',', sep="\t")

U = umfragen2017[1:63,]
U1 = cbind(Datum = as.Date(U$Zeitpunkt, format="%d.%m.%Y"),
           Institut = U$Institut,
           U[, c(2:7)])
o = order(U1$Datum)
U2 = U1[o, ]

t0 = as.Date("2016-12-31")
U3 = U2
U3$Tage = as.numeric(U3$Datum - t0)

gp = GauPro(U3$Tage, U3$CDU.CSU)
U3$z1  = predict(gp, c(U3$Tage))
gp = GauPro(U3$Tage, U3$SPD)
U3$z2 = predict(gp, c(U3$Tage))
gp = GauPro(U3$Tage, U3$GRÜNE)
U3$z3  = predict(gp, c(U3$Tage))
gp = GauPro(U3$Tage, U3$FDP)
U3$z4  = predict(gp, c(U3$Tage))
gp = GauPro(U3$Tage, U3$LINKE)
z5 = predict(gp, c(U3$Tage))
gp = GauPro(U3$Tage, U3$AfD)
U3$z6  = predict(gp, c(U3$Tage))

colors = c("CDU.CSU" = "black", "SPD" = "red", "Gruene" = "green4", 
           "FDP" = "blue", "Linke" = "magenta", "AfD" = "sienna")

ggplot2::ggplot(data = U3) + # theme_bw() +
  geom_point(aes(x = Datum, y = CDU.CSU), color = "gray") +
  geom_line(aes(x = Datum, y = z1, color = "CDU.CSU")) + 
  geom_line(aes(x = Datum, y = z2, color = "SPD")) + 
  geom_point(aes(x = Datum, y = SPD), color = "indianred1") +
  geom_line(aes(x = Datum, y = z3, color = "Gruene")) + 
  geom_line(aes(x = Datum, y = z4, color = "FDP")) + 
  geom_line(aes(x = Datum, y = z5, color = "Linke")) + 
  geom_line(aes(x = Datum, y = z6, color = "AfD")) + 
  scale_color_manual(values = colors) +
  theme(legend.title = element_blank()) +
  ylim(c(5, 40)) +
  labs(x = "Zeitraum: Jan. - Sept. 2017", y = "Prozente",
       title = "Glättung der Umfrageergebnisse")
