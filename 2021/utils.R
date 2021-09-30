##  Hilfen

# Stimmen in Anteilen
votes = c(24.1, 25.7, 14.8, 11.5, 10.3, 4.9) / 100
sonst = 1 - sum(votes)

# Umrechnung in Sitze
seats = 735 * votes * (2 - sum(votes))
seats = round(seats) + c(1,1,1,1,0,0)
sum(seats)
names(seats) = c("CDU/CSU", "SPD", "Gruene", "FDP", "AfD", "Linke")
seats

# Stimmenzahl der Koalitionen
cat(" Ampel Koalition:   ", sum(seats[c(2,3,4)]), '\n',
    "Jamaica Koalition: ", sum(seats[c(1,3,4)]), '\n',
    "DeutschlandK:      ", sum(seats[c(1,2,4)]), '\n',
    "Kenia Koalition:   ", sum(seats[c(1,2,3)]), '\n',
    "Linkskoalition:    ", sum(seats[c(2,3,6)]), '\n',
    "Grosse Koalition:  ", sum(seats[c(1,2)]), '\n')

# Multi-dimensional Scaling
U = read.table("Umfragen2021ext.csv", header = TRUE, sep = ',')
M = as.matrix(U[, 2:7])
md = dist(M)
cmd = cmdscale(md)

# Plotten
# pdf("Umfragen-MDS.pdf", 8, 6)  # png: 800, 450

par(mar = c(2,2,2,1))
plot(cmd[1:208, 1:2], pch = 20, col = "gray",
     main = "MDS Darstellung der Umfragen")
grid()

# Umfragen plotten
the_month = lubridate::month(lubridate::ymd(U[, 1]))
institute = U[1:208, 8]
inst_names = sort(unique(institute))
cmd0 = cmd[1:208, ]

points(cmd0[institute == "Allensbach", ], pch = 20, col = 1)
points(cmd0[institute == "Emnid", ], pch = 20, col = 2)
points(cmd0[institute == "Forsa", ], pch = 20, col = 3)
points(cmd0[institute == "ForWahlen", ], pch = 20, col = 4)
points(cmd0[institute == "GMS", ], pch = 20, col = 5)
points(cmd0[institute == "Infratest", ], pch = 20, col = 6)
points(cmd0[institute == "INSA", ], pch = 20, col = 7)
points(cmd0[institute == "Yougov", ], pch = 20, col = 8)

# Monate einfügen
month_names = c("Jan", "Feb", "Mar", "Apr",
                "May", "Jun", "Jul", "Aug", "Sep")
for(i in 1:9){
    p = apply(cmd[the_month==i,], 2, mean)
    if (i == 2 | i == 7) p[1] = p[1] + 1.0
    text(p[1], p[2], month_names[i], adj = 0.0)
}

# Umfragen und Endergebnis
points(cmd[217,1], cmd[217,2], pch = 22, col = "white", bg = "red")  # Endergebnis
arrows(6,-2.5,8.2,-4.9, col = "red", length=0.1, lwd=2)

points(cmd[209,1], cmd[209,2], col = "darkgreen", pch = '*')
points(cmd[210:212,1], cmd[210:212,2], col = "darkgreen", pch = '+')
points(cmd[213,1], cmd[213,2], col = "blue", pch = '*')
points(cmd[214:216,1], cmd[214:216,2], col = "blue", pch = '+')

text(x = c(6.0, 10.0), y = c(-5,-5.5), labels = c("ARD", "ZDF"),
     cex = 1.0, col = c("darkgreen", "blue"), adj = 0.5)

# Legende
legend(x = -10.5, y = 10.5,  cex = 0.9,
       col = c(1:8), pch = 20, legend = inst_names)

# dev.off()
