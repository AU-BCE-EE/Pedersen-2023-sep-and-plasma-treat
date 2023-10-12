########################################################################################
#### READING IN AND ORDERING DATA ######################################################
########################################################################################

org <- read.table('BLANK', header = TRUE, fill = TRUE) # Raw data from PTR-tof-MS instrument not uploaded to GitHub, can be obtained by contacting Johanna Pedersen

dt <- rbind(org)

dt <- dt[ , c(1, 5, 9, 44:83)]

dt$date.time<- as.POSIXct(as.Date(dt$AbsTime, origin = as.Date('1900-01-01 00:00:00')))
# subtracting two days as the line above adds to days.... 
dt$date.time <- dt$date.time - 60 * 60 * 24 * 2

header <- c('AbsTime', 'm21.cps', 'm37.cps', 'm18', 'm21', 'm29', 'm33', 'm35', 'm37', 'm39', 'm41', 'm43A', 
            'm43B', 'm45', 'm46', 'm47', 'm48', 'm49', 'm55', 'm57', 'm59', 'm60', 'm61', 'm63A', 'm63B',
            'm69', 'm71', 'm73', 'm75', 'm79', 'm83', 'm85', 'm87', 'm89', 'm95', 'm101', 'm103', 'm109', 
            'm115', 'm123', 'm132', 'm135', 'm153', 'date.time')
colnames(dt) <- header

# Adding fragment mass to mass: 
dt$m61 <- dt$m61 + dt$m43A
dt$m75 <- dt$m75 + dt$m57
dt$m89 <- dt$m89 + dt$m71
dt$m103 <- dt$m103 + dt$m85

# Correction of hydrogen sulfur. 
dt$cps3721 <- dt$m37.cps / dt$m21.cps
dt$corr.factor <- dt$cps3721 * 2.8984 - 18.284

dt$m35 <- dt$m35 * dt$corr.factor

########################################################################################
#### VALVE NO FROM PICARRO DATA ########################################################
########################################################################################
# reading in data, ordering and adding elapse.time 
org <- read.table('BLANK', header = TRUE, fill = TRUE) # Raw data from Picarro instrument not uploaded to GitHub, can be obtained by contacting Johanna Pedersen

data <- rbind(org)
dn$date.time <- paste(dn$DATE, dn$TIME)
dn$date.time<-ymd_hms(dn$date.time)
dn$date.time <- dn$date.time
dn <- dn[-c(0:3474), ]

# getting time and valve no from NH3 data 
dn <- dn[, c(15, 26)]

# rounding times so it match in the two data frames
dt$date.time <- ceiling_date(dt$date.time, 'seconds')
dn$date.time <- ceiling_date(dn$date.time, 'seconds')

# slight ofset in data between PTR-MS and Picarro due to tubing into PTR-MS is longer. Adding time to make them fit
dt$date.time <- dt$date.time + 60 * 2

# adding the valve no to dt data
dt <- left_join(dt, dn, by = 'date.time')

dt <- dt[! is.na(dt$MPVPosition), ]

dt$elapsed.time <- difftime(dt$date.time, min(dt$date.time), units='hour')
dt$id <- as.character(dt$MPVPosition)

# Selecting points with whole numbers (when the valve change there is a measurement where the valve position
# is in between two valves, these are removed)
dt <- dt[dt$id == '1' | dt$id == '2' | dt$id == '3' | dt$id == '4' | dt$id == '5' | dt$id == '6' | dt$id == '7' | 
             dt$id == '8' | dt$id == '9' | dt$id == '10' | dt$id == '11' | dt$id == '12' | dt$id == '13', ]

########################################################################################
#### ORDERING AND CROPING DATA #########################################################
########################################################################################

# adding a column with treatment names
dt$treat <- dt$id
dt$treat <- mapvalues(dt$treat, from = c('2', '6', '9'), to = c(rep('Raw', 3)))
dt$treat <- mapvalues(dt$treat, from = c('4', '8', '12'), to = c(rep('Separated', 3)))
dt$treat <- mapvalues(dt$treat, from = c('1', '5', '10'), to = c(rep('NEO', 3)))

dt$treat <- mapvalues(dt$treat, from = c('3'), to = c('bg tunnel 2')); 
dt$treat <- mapvalues(dt$treat, from = c('7'), to = c('bg tunnel 5'))
dt$treat <- mapvalues(dt$treat, from = c('11'), to = c('bg tunnel 8'));

# removing unrelevant data
dt <- dt[, !names(dt) %in% c('m21.cps', 'm37.cps', 'm18', 'm21', 'm29', 'm37', 'm39', 'm46', 'm48', 'm55', 'm63B')]
# removing fragments: 
dt <- dt[, !names(dt) %in% c('m43A', 'm57', 'm71', 'm85')]

########################################################################################
#### DATAFRAME FOR SULFUR PLoTS ########################################################
########################################################################################

dt$elapsed.time <- difftime(dt$date.time, min(dt$date.time), units = 'mins')

ds <- dt[dt$elapsed.time <= 100, ]

ds <- subset(ds, select = c('date.time', 'elapsed.time', 'id', 'treat', 'm35', 'm49', 'm63A'))

ds <- gather(ds, mass, conc, m35:m63A)

# Making elapsed.time fit with the first measurement of each valve = 0
ds$Vid <- 0
ds$Vid[1:13] <- c('V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'V7', 'V8', 'V9', 'V10', 'V11', 'V12', 'V13')

splitdat <- split(ds, f = ds$id)
new.names <- ds$Vid[1:13]

for (i in 1:13){
  assign(new.names[i], splitdat[[i]])
}

z = list(V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13)
new.dat = NULL
for(i in z){
  i$elapsed.time <- difftime(i$date.time, min(i$date.time), units='mins')
  new.dat <- rbind(new.dat,i)
}

ds <- new.dat 
ds$elapsed.time <- signif(ds$elapsed.time, digits = 3)

ds$exp <- c('22K')
ds$slurry <- c('pig')

########################################################################################
#### ORDERING AND CROPING DATA CONT ####################################################
########################################################################################

# a measurement every 6 seconds, so we need 5 points for 30 second average
dt <- gather(dt, mass, conc, m33:m153)
dt$conc <- rollapplyr(dt$conc, 5, mean, fill = NA)

# removing NA's introduced by rollapply
dt <- na.omit(dt)

# taking the last point of each measurent from each valve 
dt <- filter(dt, !(dt$id == lead(dt$id)))

# Making elapsed.time fit with the first measurement of each valve = 0
dt$Vid <- 0
dt$Vid[1:13] <- c('V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'V7', 'V8', 'V9', 'V10', 'V11', 'V12', 'V13')

splitdat <- split(dt, f = dt$id)
new.names <- dt$Vid[1:13]

for (i in 1:13){
  assign(new.names[i], splitdat[[i]])
}

z = list(V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13)
new.dat = NULL
for(i in z){
  i$elapsed.time <- difftime(i$date.time, min(i$date.time), units='hour')
  new.dat <- rbind(new.dat,i)
}

dt <- new.dat 
dt$elapsed.time <- signif(dt$elapsed.time, digits = 3)

# background data: 
dt.bg <- dt[dt$treat == 'bg tunnel 2' | dt$treat == 'bg tunnel 5'| dt$treat == 'bg tunnel 8' | dt$treat == 'bg overall', ]

# outlet data 
dt <- dt[dt$treat == 'Raw' | dt$treat == 'Separated'| dt$treat == 'NEO',]

# Removing bad times (found by looking at the plots in the bottom)
dt <- dt[! dt$elapsed.time == 20.8, ]
dt <- dt[! dt$elapsed.time == 22.5, ]
dt <- dt[! dt$elapsed.time == 45.0, ]
dt <- dt[! dt$elapsed.time == 46.8, ]
dt <- dt[! dt$elapsed.time == 67.5, ]
dt <- dt[! dt$elapsed.time == 69.3, ]
dt <- dt[! dt$elapsed.time == 71.0, ]

########################################################################################
#### TREATMENT OF BACKGROUNDS ##########################################################
########################################################################################

# ggplot(dt.bg, aes(elapsed.time, conc, color = id)) + geom_point() +
#   facet_wrap(~ mass, scales = 'free_y')

# As the backgrounds are very similar an average of the background tube for tunnel 2, 5 and 8 is used as the back
# ground value. 
# Picking out the data
dt.bg <- dt.bg[dt.bg$treat == 'bg tunnel 2' | dt.bg$treat == 'bg tunnel 5'| dt.bg$treat == 'bg tunnel 8', ]
dt.bg$mearging.id <- paste(dt.bg$mass, dt.bg$elapsed.time)

dt.bg.summ <- ddply(dt.bg, c('mearging.id'), summarise, conc.bg.mn = mean(conc), conc.bg.sd = sd(conc))
dt$mearging.id <- paste(dt$mass, dt$elapsed.time)

# calculating the average and sd 
dt <- left_join(dt, dt.bg.summ, by = 'mearging.id')

# subtracting the background values from the 30 second average values and making the negative values equal 0
dt$conc.corr <- dt$conc - dt$conc.bg.mn

dt[!complete.cases(dt),]
dt <- na.omit(dt)

########################################################################################
#### DIVIDING M/Z 41 INTO 2-PROPANOL AND 2-BUTANOL #####################################
########################################################################################

# The fraction from 2-butanol:
dt.ex <- dt[dt$mass == 'm41', ]
dt.ex$mass <- mapvalues(dt.ex$mass, from = 'm41', to = 'm41bu')
dt.ex$conc.corr <- dt.ex$conc.corr * 0.35

# The fraction from 2-propanol: 
dt$mass <- mapvalues(dt$mass, from = 'm41', to = 'm41pro')
dt[dt$mass == 'm41pro', ]$conc.corr <- dt[dt$mass == 'm41pro', ]$conc.corr * 0.65

# Putting the correct amount for m43 (0.3 * amount of m41pro)
dt[dt$mass == 'm43B', ]$conc.corr <- dt[dt$mass == 'm41pro', ]$conc.corr * 0.3

# Binding together:
dt <- rbind(dt, dt.ex)

########################################################################################
#### FLUX CALCULATIONS #################################################################
########################################################################################

# correcting rate constant (2 was used for calculations in PTR-MS viewer)
dfi <- read.xlsx('BLANK') # K-rates can be found in the supporting material

dt <- left_join(dt, dfi, by = 'mass')
dt[ , c('conc', 'conc.bg.mn', 'conc.corr', 'conc.bg.sd')] <- dt[ , c('conc', 'conc.bg.mn', 'conc.corr', 'conc.bg.sd')] / 2 * dt$K

# reading in temperature data
header <- c('date', 'time', 'temp')
weather <- read.table('BLANK', fill = TRUE, col.names = header) # Raw weather data not uploaded to GitHub, can be obtained by contacting Johanna Pedersen
weather <- weather[-1, ]

weather$date.time.weather <- paste(weather$date, weather$time)
weather$temp.K <- as.numeric(weather$temp) + 273.15

# round date.time in data to fit with weather
dt$date.time.weather <- round_date(dt$date.time, '1 hour')
dt$date.time.weather <- as.character(format(dt$date.time.weather, format='%d-%m-%Y %H:%M:%S'))

dt <- left_join(dt, weather, by = 'date.time.weather')

# # constants:
p.con <- 1 # atm
R.con <- 0.082057338 # [L * atm * K^-1 * mol^-1]
A.frame <- 0.293 * 0.674 #m^2
air.flow <- 20.16 * 60 # L min^-1

# calculation of a concentration from ppb to mol * L^-1
dt$n <- p.con / (R.con * dt$temp.K) * dt$conc.corr * 10^-9  # mol * L^-1

# calculation of flux, from mol * L^-1 to mol * min^-1 * m^-2
dt$flux <- (dt$n * air.flow) / A.frame

# calculation of total flux over time
# Average flux in measurement interval
dt$flux <- rollapplyr(dt$flux, 2, mean, fill = NA)
dt$flux[dt$elapsed.time == 0] <- 0
dt$flux[dt$flux < 0 ] <- 0

# calculation of total flux over time, last point * 104 min (time from start to start 8 x 10 min) 
dt$flux.time <- dt$flux * 104

# cum.emis. 104min is calculated for the boxplots 
dt <- mutate(group_by(dt, id, mass), cum = cumsum(flux.time))

dt.summ <- summarise(group_by(dt, treat, mass, elapsed.time), cum.mn = mean(cum), cum.sd = sd(cum))

colnames(dt.summ) <- c('treat', 'mass', 'elapsed.time', 'cum.mn', 'cum.sd')

