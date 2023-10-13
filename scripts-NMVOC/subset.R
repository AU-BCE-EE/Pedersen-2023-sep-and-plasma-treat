
# subsetting data for tables for supporting 

dv.dA <- dv.summ[dv.summ$exp == 'Digestate A' & dv.summ$elapsed.time == 161, ]
dv.dB <- dv.summ[dv.summ$exp == 'Digestate B' & dv.summ$elapsed.time == 132, ]
dv.pA <- dv.summ[dv.summ$exp == 'Pig A' & dv.summ$elapsed.time == 118, ]
dv.pB <- dv.summ[dv.summ$exp == 'Pig B' & dv.summ$elapsed.time == 88.3, ]
