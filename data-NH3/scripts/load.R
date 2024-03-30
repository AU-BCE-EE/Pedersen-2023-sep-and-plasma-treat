

# Set release tag for download
ghpath <- 'https://github.com/sashahafner/ALFAM2-data/raw/adb3b8c6a745dc91062cf0f0020d63492b604b27/'
rtag <- ''

p <- paste0(ghpath, rtag)
idat <- fread(paste0(p, '/data-output/03/ALFAM2_interval.csv.gz'))
pdat <- fread(paste0(p, '/data-output/03/ALFAM2_plot.csv.gz'))
