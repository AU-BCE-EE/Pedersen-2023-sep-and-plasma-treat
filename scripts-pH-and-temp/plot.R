
# surface pH

ggplot(dp.summ, aes(elapsed.time, pH.mn, color = treat, fill = treat)) + 
  scale_color_brewer(palette = "Set1") + 
  scale_fill_brewer(palette = 'Set1') +
  geom_point() + 
  geom_line() + 
  geom_ribbon (aes (ymax = pH.mn + pH.sd, ymin = pH.mn - pH.sd, group = treat), alpha = 0.1, color = NA) +
  facet_grid( ~ exp) + 
  theme_bw() + 
  ylab('pH') + xlab('Time from application (h)') + 
  theme(legend.position = 'bottom') + theme(legend.title = element_blank()) 
ggsave2x('../plots/surface_pH', height = 3, width = 7)


# ambient temperature

ggplot(dw, aes(elapsed.time, temp)) + 
  geom_line() + 
  facet_wrap( ~ exp, ncol = 4) + 
  theme_bw() + 
  ylab(expression(paste("Temperature (",degree,"C)"))) + xlab('Time from application (h)') +
  theme(legend.title = element_blank()) +
  theme(legend.position = 'bottom') +
  xlim(0, 160)
ggsave2x('../plots/ambient_temp', height = 4, width = 7)
