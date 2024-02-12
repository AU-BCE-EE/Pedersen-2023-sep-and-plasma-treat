# dataframe for supporting with cumulative mass of each compund for each treatment x trial combo
# copying dataframe so we have all digests for further calculations
dv.summ1 <- dv.summ

dv.summ1 <- rounddf(dv.summ1, 3, fun = signif)

dv.summ1$cum <- paste(dv.summ1$cum.mn, ' ± ', dv.summ1$cum.sd)

dv.summ1 <- dv.summ1[ , c('exp', 'elapsed.time', 'treat', 'compound', 'cum')]

# subsetting data for tables for supporting 
dv.dA <- dv.summ1[dv.summ1$exp == 'Digestate A' & dv.summ1$elapsed.time == 161, ]
dv.dB <- dv.summ1[dv.summ1$exp == 'Digestate B' & dv.summ1$elapsed.time == 132, ]
dv.pA <- dv.summ1[dv.summ1$exp == 'Pig A' & dv.summ1$elapsed.time == 118, ]
dv.pB <- dv.summ1[dv.summ1$exp == 'Pig B' & dv.summ1$elapsed.time == 88.3, ]
