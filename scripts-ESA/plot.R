
dfsumm$treat <- sub('NEO', 'LP', dfsumm$treat)
dfsumm$treat <- sub('Raw', 'UN', dfsumm$treat)
dfsumm$treat <- sub('Separated', 'LF', dfsumm$treat)

# ESA over time
ggplot(dfsumm, aes(time, ESA.mn, color = treat, fill = treat)) + 
  geom_point(size = 0.5) + geom_line(aes(group = treat)) +
  facet_wrap( ~ exp, ncol = 2, scales = 'free_y') +
  geom_ribbon(aes (ymax = ESA.mn + ESA.sd, ymin = ESA.mn - ESA.sd, group = treat), alpha = 0.3, color = NA) + 
  theme_bw() + 
  ylab('Exposed surface area (%)') + xlab('Time from application (h)') +
  theme(legend.title = element_blank()) + 
  theme(legend.position = 'bottom') + 
  scale_color_brewer(palette = 'Set1') + 
  scale_fill_brewer(palette = 'Set1')
ggsave2x('../plots/ESA01', height = 4, width = 7)

