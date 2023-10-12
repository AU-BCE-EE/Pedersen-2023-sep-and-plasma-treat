########################################################################################
#### READING IN AND ORDERING DATA ######################################################
########################################################################################

org <- read.table('BLANK', header = TRUE, fill = TRUE) # Raw data from Picarro instrument not uploaded to GitHub, can be obtained by contacting Johanna Pedersen

data <- rbind(org)
data$date.time <- paste(data$DATE, data$TIME)
data$date.time<-ymd_hms(data$date.time)
data$date.time <- data$date.time
dat <- data

dat <- dat[-c(0:50), ]

########################################################################################
#### ORDERING AND CROPING DATA #########################################################
########################################################################################

dat$id <- dat$MPVPosition

# taking the last point of each measurent from each valve 
dat <- filter(dat, !(dat$id == lead(dat$id)))

# Selecting points with whole numbers (when the valve change there is a measurement where the valve position
# is in between two valves, these are removed)
dat <- dat[dat$id == '1' | dat$id == '2' | dat$id == '3' | dat$id == '4' | dat$id == '5' | dat$id == '6' | dat$id == '7' | 
             dat$id == '8' | dat$id == '9' | dat$id == '10' | dat$id == '11' | dat$id == '12' | dat$id == '13', ]

# Making elapsed.time fit with the first measurement of each valve = 0
dat$Vid <- 0
dat$Vid[1:13] <- c('V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'V7', 'V8', 'V9', 'V10', 'V11', 'V12', 'V13')

splitdat <- split(dat, f = dat$id)
new.names <- dat$Vid[1:13]

for (i in 1:13){
  assign(new.names[i], splitdat[[i]])
}

z = list(V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13)
new.dat = NULL
for(i in z){
  i$elapsed.time <- difftime(i$date.time, min(i$date.time), units='hour')
  new.dat <- rbind(new.dat,i)
}

# cropping data: 
dat <- new.dat[,c(19, 26:27, 29)]
dat$elapsed.time <- signif(dat$elapsed.time, digits = 3)

# adding a column with treatment names
dat$treat <- dat$id
dat$treat <- mapvalues(dat$treat, from = c('2', '5', '9'), to = c(rep('Raw', 3)))
dat$treat <- mapvalues(dat$treat, from = c('4', '6', '10'), to = c(rep('Separated', 3)))
dat$treat <- mapvalues(dat$treat, from = c('1', '8', '12'), to = c(rep('NEO', 3)))

dat$treat <- mapvalues(dat$treat, from = c('3'), to = c('bg tunnel 2')); 
dat$treat <- mapvalues(dat$treat, from = c('7'), to = c('bg tunnel 5'))
dat$treat <- mapvalues(dat$treat, from = c('11'), to = c('bg tunnel 8'));

# # Fixing a time-bug: 
dat$elapsed.time[dat$elapsed.time == '3.46'] <- 3.47
# # removing times were we are missing data: 
dat <- dat[! dat$elapsed.time == '44.2', ]; dat <- dat[! dat$elapsed.time == '68.8', ]; dat <- dat[! dat$elapsed.time == '89.8', ];
dat <- dat[! dat$elapsed.time == '29.4', ]; dat <- dat[! dat$elapsed.time == '34.6', ];

# background data: 
dat.bg <- dat[dat$treat == 'bg tunnel 2' | dat$treat == 'bg tunnel 5'| dat$treat == 'bg tunnel 8', ]

# outlet data 
dat <- dat[dat$treat == 'Raw' | dat$treat == 'Separated'| dat$treat == 'NEO', ]

########################################################################################
#### TREATMENT OF BACKGROUNDS ##########################################################
########################################################################################
# plotting all background datapoints (NH3 [ppb] vs time [h])
ggplot(dat.bg, aes(elapsed.time, NH3_30s, colour = treat)) + geom_point() 

# As the backgrounds are very similar an average of the background tube for tunnel 2, 5 and 8 is used as the back
# ground value. 
# Picking out the data
dat.bg <- dat.bg[dat.bg$treat == 'bg tunnel 2' | dat.bg$treat == 'bg tunnel 5'| dat.bg$treat == 'bg tunnel 8', ]

# calculating the average and sd 
dat.bg.summ <- ddply(dat.bg, c('elapsed.time'), summarise, NH3.bg.mn = mean(NH3_30s), NH3.bg.sd = sd(NH3_30s))

# joining the datasets: 
dat <- full_join(dat.bg.summ, dat, by = 'elapsed.time')
# Subtracting the background values from the 30 second average values 
dat$NH3.corr <- dat$NH3_30s - dat$NH3.bg.mn

dat[!complete.cases(dat),]

########################################################################################
#### FLUX CALCULATIONS #################################################################
# ########################################################################################
# reading in temperature data
header <- c('date', 'time', 'temp')
weather <- read.table('BLANK', fill = TRUE, col.names = header) # Raw weather data not uploaded to GitHub, can be obtained by contacting Johanna Pedersen
weather <- weather[-1, ]

weather$date.time.weather <- paste(weather$date, weather$time)

# round date.time in data to fit with weather
dat$date.time.weather <- round_date(dat$date.time, '1 hour')
dat$date.time.weather <- as.character(format(dat$date.time.weather, format='%d-%m-%Y %H:%M:%S'))

dat <- left_join(dat, weather, by = 'date.time.weather')

# constants:
p.con <- 1 # atm
R.con <- 0.082057338 # [L * atm * K^-1 * mol^-1]
A.frame <- 0.293 * 0.674 #m^2
M.N <- 14 # g * mol^-1
air.flow <- 20.16 * 60 # L min^-1

dat$temp <- as.numeric(dat$temp)
dat$air.temp.K <- dat$temp + 273.15

weather.22J <- dat[, c(1, 12)]
weather.22J$experiment <- '22J'

# calculation of a concentration from ppb to mol * L^-1
dat$n <- p.con / (R.con * dat$air.temp.K) * dat$NH3.corr * 10^-9  # mol * L^-1        
# calculation of flux, from mol * L^-1 to gN * min^-1 * m^-2
dat$flux <- (dat$n * M.N * air.flow) / A.frame

# rearanging data by tunnel 
dat <- arrange(dat, by = id)

# calculation of total flux over time
# Average ammonia flux in measurement interval
dat$flux.tr <- rollapplyr(dat$flux, 2, mean, fill = NA)
dat$flux.tr[dat$elapsed.time == 0] <- 0
dat$flux.tr[dat$flux.tr < 0 ] <- 0

# calculation of total flux over time, last point * 104 min (time from start to start 8 x 10 min) 
dat$flux.time <- dat$flux.tr * 104

###### CUMULATIVE EMISSION
# cum.emis is calculated for the boxplots 
dat <- mutate(group_by(dat, id, treat), cum = cumsum(flux.time))

###### FLUX 
# Table for plotting flux 
dat.summ <- summarise(group_by(dat, treat, elapsed.time), flux.mn = mean(flux), flux.sd = sd(flux),
                      cum.mn = mean(cum), cum.sd = sd(cum))

dat.fluxtime <- dat[dat$id == '2', c(1:2)]

# # DATA FRAMES
dat.22J <- dat[dat$elapsed.time == 161, ] # for statistics
dat.22J.end <- dat.summ[dat.summ$elapsed.time == 161, ] # cum emis
dat.22J.summ <- left_join(dat.summ, dat.fluxtime, by = 'elapsed.time') # flux

# # data frames for GitHub use
# write.csv(dat.22J, '../data-NH3/digB.A.csv')
# write.csv(dat.22J.end, '../data-NH3/digB.B.csv')
# write.csv(dat.22J.summ, '../data-NH3/digB.C.csv')
