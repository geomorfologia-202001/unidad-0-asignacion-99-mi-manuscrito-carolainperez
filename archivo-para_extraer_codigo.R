todo <- jsonlite::fromJSON('cantometria_ultimo.json', flatten = TRUE)
playacarlopinto <- todo %>% filter(grepl('^AV.*$', codigomuestra)) %>%
	  unnest(clastos) %>% mutate(playa='p. Carlos Pinto')
  playadelospescadores <- todo %>% filter(grepl('^0.*CPU', codigomuestra)) %>%
	    unnest(clastos) %>% filter(a>=10)  %>%  mutate(playa='p. Los Pescadores')
    ambasplayas <- bind_rows(playacarlopinto, playadelospescadores)
    ambasplayas %>% dplyr::select(a, b, playa) %>% gather(dimension, valor, -playa) %>%
	      ggplot() + aes(x=playa, y=valor) + geom_boxplot() + facet_grid(~dimension) +
	        theme_bw() + theme(text = element_text(size = 16)) + ylab('valor (en mm)')
