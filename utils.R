##  Hilfen

# Stimmen in Anteilen
votes = c(21.5, 25.5, 16.0, 12.0, 12.0, 6.0) / 100
sonst = 1 - sum(votes)

# Umrechnung in Sitze
seats = 700 * votes * (2 - sum(votes))
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
