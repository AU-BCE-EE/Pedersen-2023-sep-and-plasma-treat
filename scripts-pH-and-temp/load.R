
# surface pH data 
dp <- read.xlsx('../data/surface_pH.xlsx')

# ambient temperature 
dw1 <- read.csv('../data/w22H.csv')
dw1$exp <- 'Digestate A'
dw2 <- read.csv('../data/w22I.csv')
dw2$exp <- 'Pig A'
dw3 <- read.csv('../data/w22J.csv')
dw3$exp <- 'Digestate B'
dw4 <- read.csv('../data/w22K.csv')
dw4$exp <- 'Pig B'

dw <- rbind(dw1, dw2, dw3, dw4)
