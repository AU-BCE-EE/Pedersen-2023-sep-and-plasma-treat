
# calculating mass flux (g min-1 m-2) from (mol min-1 m-2)
dv$flux.m <- dv$flux * dv$nn

# calculating cumulative loss of the different compounds 
# time resolution = 104 min 
dv$flux.mt <- dv$flux.m * 104
dv <- mutate(group_by(dv, exp, id, mass), cum = cumsum(flux.mt))

dv.summ <- summarise(group_by(dv, exp, treat, comp, mass, elapsed.time), flux.mn = mean(flux.m), flux.sd = sd(flux.m), cum.mn = mean(cum), cum.sd = sd(cum))

colnames(dv.summ) <- c('exp', 'treat', 'compound', 'mass', 'elapsed.time', 'flux.mn', 'flux.sd', 'cum.mn', 'cum.sd')

# from (g m-2) to (mg m-2)
dv.summ$cum.mn <- dv.summ$cum.mn * 1000
dv.summ$cum.sd <- dv.summ$cum.sd * 1000
# from g min-1 m-2) to (mg min-1 m-2)
dv.summ$flux.mn <- dv.summ$flux.mn * 1000
dv.summ$flux.sd <- dv.summ$flux.sd * 1000


# calculating OAV over time 
# OTV: odor threshold value (ppb)
# conc.corr: background corrected concentration (ppb) 

############################# WORK FROM HERE 
#############################
#############################
dv$oav <- dv$conc.corr / dv$OTV
