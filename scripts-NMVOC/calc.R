
# calculating mass flux (g min-1 m-2) from (mol min-1 m-2)
dv$flux.m <- dv$flux * dv$nn

# calculating cumulative loss of the different compounds 
# time resolution = 104 min 
dv$flux.mt <- dv$flux.m * 104
dv <- mutate(group_by(dv, exp, id, mass), cum = cumsum(flux.mt))

dv.summ <- summarise(group_by(dv, exp, treat, mass, elapsed.time), cum.mn = mean(cum), cum.sd = sd(cum))

colnames(dv.summ) <- c('exp', 'treat', 'mass', 'elapsed.time', 'cum.mn', 'cum.sd')

# calculating OAV over time 
# OTV: odor threshold value (ppb)
# conc.corr: background corrected concentration (ppb) 



############################# WORK FROM HERE 
#############################
#############################
dv$oav <- dv$conc.corr / dv$OTV
