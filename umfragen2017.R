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