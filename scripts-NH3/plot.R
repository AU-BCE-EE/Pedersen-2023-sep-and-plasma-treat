
dn3$treat <- sub('NEO', 'LP', dn3$treat)
dn3$treat <- sub('Raw', 'UN', dn3$treat)
dn3$treat <- sub('Separated', 'LF', dn3$treat)


# N flux over time
ggplot(dn3, aes(elapsed.time, flux.mn.perc, color = treat, fill = treat)) + 
  geom_point(size = 0.5) + geom_line(aes(group = treat)) +
  facet_wrap( ~ exp, ncol = 2, scales = 'free_y') +
  geom_ribbon(aes (ymax = flux.mn.perc + flux.sd.perc, ymin = flux.mn.perc - flux.sd.perc, group = treat), alpha = 0.3, color = NA) + 
  theme_bw() + 
  ylab(expression(paste('Flux (% applied TAN  ', h^-1,')'))) + xlab('Time from application (h)') +
  theme(legend.title = element_blank()) + 
  theme(legend.position = 'bottom') + 
  xlim(0, 160) + 
  scale_color_brewer(palette = 'Set1') + 
  scale_fill_brewer(palette = 'Set1')
ggsave2x('../plots/flux01', height = 4, width = 7)

ggplot(dn3, aes(elapsed.time, flux.mn.perc, color = treat, fill = treat)) + 
  geom_point(size = 0.5) + geom_line(aes(group = treat)) +
  facet_wrap( ~ exp, ncol = 2, scales = 'free_y') +
  geom_ribbon(aes (ymax = flux.mn.perc + flux.sd.perc, ymin = flux.mn.perc - flux.sd.perc, group = treat), alpha = 0.3, color = NA) + 
  theme_bw() + 
  ylab(expression(paste('Flux (% applied TAN  ', h^-1,')'))) + xlab('Time from application (h)') +
  theme(legend.title = element_blank()) + 
  theme(legend.position = 'bottom') + 
  xlim(0, 160) + 
  scale_color_brewer(palette = 'Set1') + 
  scale_fill_brewer(palette = 'Set1') + 
  xlim(0, 50)
ggsave2x('../plots/flux02', height = 4, width = 7)
