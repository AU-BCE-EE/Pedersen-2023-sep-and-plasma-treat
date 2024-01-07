
 
df <- read.csv('../data-ESA/ESAdata.csv', sep = ';')

df$exp <- sub('22H', 'Digestate A', df$exp)
df$exp <- sub('22I', 'Pig A', df$exp)
df$exp <- sub('22J', 'Digestate B', df$exp)
df$exp <- sub('22K', 'Pig B', df$exp)


