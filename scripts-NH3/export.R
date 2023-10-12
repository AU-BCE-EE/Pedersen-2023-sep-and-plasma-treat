

# subsetting data needed for export and plotting
dn11 <- dn1[, c('exp', 'treat', 'cum.per')]
dn22 <- dn2[, c('exp', 'treat', 'cum.mn.perc', 'cum.sd.perc')]

write.csv(dn11, '../output/dn11.csv')
write.csv(dn22, '../output/dn22.csv')
