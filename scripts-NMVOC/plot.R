
# flux over time

ggplot(dv.summ[dv.summ$exp == 'Pig A', ], aes(elapsed.time, flux.mn, color = treat)) + 
  geom_line() + 
  theme_bw() + 
  facet_wrap( ~ compound, ncol = 6, scales = 'free_y')
