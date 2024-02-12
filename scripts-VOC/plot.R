
# flux over time

ggplot(dv.summ[dv.summ$exp == 'Pig A', ], aes(elapsed.time, flux.mn, color = treat)) + 
  geom_line() + 
  facet_wrap(~ compound, ncol = 6, scales = 'free_y') + 
  ylab('Average flux (mg min-1 m-2)') + 
  xlab('Time after slurry application (h)')
ggsave2x('../plots/NMVOC_PigA', height = 8, width = 14)


ggplot(dv.summ[dv.summ$exp == 'Pig B', ], aes(elapsed.time, flux.mn, color = treat)) + 
  geom_line() + 
  facet_wrap(~ compound, ncol = 6, scales = 'free_y') + 
  ylab('Average flux (mg min-1 m-2)') + 
  xlab('Time after slurry application (h)')
ggsave2x('../plots/NMVOC_PigB', height = 8, width = 14)


ggplot(dv.summ[dv.summ$exp == 'Digestate A', ], aes(elapsed.time, flux.mn, color = treat)) + 
  geom_line() + 
  facet_wrap(~ compound, ncol = 6, scales = 'free_y') + 
  ylab('Average flux (mg min-1 m-2)') + 
  xlab('Time after slurry application (h)')
ggsave2x('../plots/NMVOC_DigA', height = 8, width = 14)


ggplot(dv.summ[dv.summ$exp == 'Digestate B', ], aes(elapsed.time, flux.mn, color = treat)) + 
  geom_line() + 
  facet_wrap(~ compound, ncol = 6, scales = 'free_y') + 
  ylab('Average flux (mg min-1 m-2)') + 
  xlab('Time after slurry application (h)')
ggsave2x('../plots/NMVOC_DigB', height = 8, width = 14)
