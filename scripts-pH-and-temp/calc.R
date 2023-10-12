
# surface pH

dp$date.time <- paste(dp$date, dp$time)
dp$date.time <- ymd_hm(dp$date.time)

dp$treat.ex <- paste(dp$exp, dp$treat)

# Making elapsed.time fit with the first measurement of each barrel = 0
splitdat <- split(dp, f = dp$treat.ex)
new.names <- c('Araw', 'Aseparated', 'NEO', 
               'Braw', 'Bseparated', 'BNEO')

for (i in 1:6){
  assign(new.names[i], splitdat[[i]])
}
z = list(Araw, Aseparated, NEO, 
         Braw, Bseparated, BNEO)
new.dat = NULL
for(i in z){
  i$elapsed.time <- difftime(i$date.time, min(i$date.time), units='hour')
  new.dat <- rbind(new.dat,i)
}
dp <- new.dat 
dp$elapsed.time <- signif(dp$elapsed.time, digits = 3)

dp.summ <- ddply(dp, c('exp', 'treat', 'covered', 'elapsed.time'), summarise, pH.mn = mean(pH), pH.sd = sd(pH))

dp.summ <- dp.summ[! dp.summ$covered == 'no', ]
