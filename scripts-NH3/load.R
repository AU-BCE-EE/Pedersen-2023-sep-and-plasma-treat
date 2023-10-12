
# NH3 emission data 
digA.A <- read.csv('../data-NH3/digA.A.csv')
digA.A$exp <- 'Digestate A'
digA.B <- read.csv('../data-NH3/digA.B.csv')
digA.B$exp <- 'Digestate A'
digA.C <- read.csv('../data-NH3/digA.C.csv')
digA.C$exp <- 'Digestate A'

digB.A <- read.csv('../data-NH3/digB.A.csv')
digB.A$exp <- 'Digestate B'
digB.B <- read.csv('../data-NH3/digB.B.csv')
digB.B$exp <- 'Digestate B'
digB.C <- read.csv('../data-NH3/digB.C.csv')
digB.C$exp <- 'Digestate B'

pigA.A <- read.csv('../data-NH3/pigA.A.csv')
pigA.A$exp <- 'Pig A'
pigA.B <- read.csv('../data-NH3/pigA.B.csv')
pigA.B$exp <- 'Pig A'
pigA.C <- read.csv('../data-NH3/pigA.C.csv')
pigA.C$exp <- 'Pig A'

pigB.A <- read.csv('../data-NH3/pigB.A.csv')
pigB.A$exp <- 'Pig B'
pigB.B <- read.csv('../data-NH3/pigB.B.csv')
pigB.B$exp <- 'Pig B'
pigB.C <- read.csv('../data-NH3/pigB.C.csv')
pigB.C$exp <- 'Pig B'

# slurry data 
ds <- read.table('../data/slurry.summ.txt')
ds$exp <- ds$experiment
ds$exp <- mapvalues(ds$exp, from = '22H', to = 'Digestate A')
ds$exp <- mapvalues(ds$exp, from = '22J', to = 'Digestate B')
ds$exp <- mapvalues(ds$exp, from = '22I', to = 'Pig A')
ds$exp <- mapvalues(ds$exp, from = '22K', to = 'Pig B')
