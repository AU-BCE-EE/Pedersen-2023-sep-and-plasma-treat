# calculating means and sd

df <- as.data.table(df)

dfsumm <- df[ , . ( 
  ESA.mn = mean(ESA), ESA.sd = sd(ESA)
), by = list(exp, treat, time)]

