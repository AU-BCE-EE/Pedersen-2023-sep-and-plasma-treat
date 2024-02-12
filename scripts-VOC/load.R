
# NMVOC emission data 
digA.A <- read.csv('../data-NMVOC/digA.VOC.A.csv')
digA.A$exp <- 'Digestate A'

digB.A <- read.csv('../data-NMVOC/digB.VOC.A.csv')
digB.A$exp <- 'Digestate B'

pigA.A <- read.csv('../data-NMVOC/pigA.VOC.A.csv')
pigA.A$exp <- 'Pig A'

pigB.A <- read.csv('../data-NMVOC/pigB.VOC.A.csv')
pigB.A$exp <- 'Pig B'

dv <- rbind(digA.A, digB.A, pigA.A, pigB.A)
