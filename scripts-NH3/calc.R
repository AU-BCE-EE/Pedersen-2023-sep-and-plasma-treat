
# calculating flux and cum losses as a fraction of applied TAN 

# cum: cumulative emission (gN m^-1)
# application.rate: TAN application rate (kg ha^-1)
dn1$cum.per <- dn1$cum / (dn1$application.rate / 10)  * 100
dn2$cum.mn.perc <- dn2$cum.mn / (dn2$application.rate / 10) * 100
dn2$cum.sd.perc <- dn2$cum.sd / (dn2$application.rate / 10) * 100
dn3$flux.mn.perc <- dn3$flux.mn / (dn3$application.rate / 10) * 100
dn3$flux.sd.perc <- dn3$flux.sd / (dn3$application.rate / 10) * 100

# changing flux from (TAN min^-1 m^-2) to (TAN h^-1 m^-2)
dn3$flux.mn.perc <- dn3$flux.mn.perc * 60
dn3$flux.sd.perc <- dn3$flux.sd.perc * 60
