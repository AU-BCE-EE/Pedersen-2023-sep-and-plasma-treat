
# chaning treatment names in slurry prop data file to match emis data file
ds$treat <- mapvalues(ds$treat, from = 'separated', to = 'Separated')
ds$treat <- mapvalues(ds$treat, from = 'untreated', to = 'Raw')

# combining emis data files with slurry prop data files 
dn1 <- rbind(digA.A, digB.A, pigA.A, pigB.A)
dn1 <- merge(dn1, ds, by = c('exp', 'treat'))

dn2 <- rbind(digA.B, digB.B, pigA.B, pigB.B)
dn2 <- full_join(dn2, ds, by = c('exp', 'treat'))

dn3 <- rbind(digA.C, digB.C, pigA.C, pigB.C)
dn3 <- full_join(dn3, ds, by = c('exp', 'treat'))
