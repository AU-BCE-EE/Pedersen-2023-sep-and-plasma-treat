
# subsetting data from the MAG project
pdat <- subset(pdat, proj == 'MAG')
# excluding data from fall 2022 where chambers where tested
pdat <- subset(pdat, t.start.p > '2023-01-01 00:00:00')

# Drop non-relevant obs from emis interval data
idat <- subset(idat, pmid %in% unique(pdat$pmid))

