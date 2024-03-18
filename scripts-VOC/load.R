
# NMVOC emission data 
digA.A <- read.csv('../data-VOC/digA.VOC.A.csv')
digA.A$exp <- 'Digestate A'

digB.A <- read.csv('../data-VOC/digB.VOC.A.csv')
digB.A$exp <- 'Digestate B'

pigA.A <- read.csv('../data-VOC/pigA.VOC.A.csv')
pigA.A$exp <- 'Pig A'

pigB.A <- read.csv('../data-VOC/pigB.VOC.A.csv')
pigB.A$exp <- 'Pig B'

dv <- rbind(digA.A, digB.A, pigA.A, pigB.A)
