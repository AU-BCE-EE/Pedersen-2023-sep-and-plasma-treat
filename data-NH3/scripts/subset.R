
# subsetting data from the MAG project
pdat <- subset(pdat, proj == 'MAG')

# subsetting the four relevant experiments
ppdat <- subset(pdat, exper == c('22H', '22I', '22J', '22K'))

# Drop non-relevant obs from emis interval data
idat <- subset(idat, pmid %in% unique(pdat$pmid))

