
dn1 <- rbind(digA.A, digB.A, pigA.A, pigB.A)
dn1 <- full_join(dn1, ds, by = 'exp')

dn2 <- rbind(digA.B, digB.B, pigA.B, pigB.B)
dn2 <- full_join(dn2, ds, by = 'exp')

dn3 <- rbind(digA.C, digB.C, pigA.C, pigB.C)
dn3 <- full_join(dn3, ds, by = 'exp')
