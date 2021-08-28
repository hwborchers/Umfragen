seats <- function(s) {
    # s Stimmen in Pozent
    s = s/100; sonstige = 1.0 - sum(s)
    S = 700*s + 700*sonstige*s
    S = 700 * s * (1 + sonstige)
}

S = seats(c(23, 23, 17.5, 12, 6.5, 11))
round(S, digits=1)
ceiling(S)
sum(ceiling(S))
