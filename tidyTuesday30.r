## MY FIRST CONTRIBUTION TO TIDY TUESDAY!
## DROUGHT IN NC

library(ggplot2)
library(dplyr)

drought <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-07-20/drought.csv')
nc.drought <- filter(drought, state_abb=="NC")

#Data from the last 10 years
nc10 <- filter(nc.drought, valid_start > as.Date("2011-01-01"))
# Add year column
nc10$year = format(nc10$valid_start, "%Y")
# Turn drought_lvl into a factor
nc10$drought_lvl <- factor(nc10$drought_lvl, levels=c("None","D0","D1","D2","D3","D4"))
# Labels for the legend
#legendLabs <- c("None", "Dry", "Moderate", "Severe", "Extreme", "Exceptional")
legendLabs2 <- c("None"="None","D0"="Dry","D1"="Moderate","D2"="Severe","D3"="Extreme","D4"="Exceptional")

# PLOT

ggplot(nc10, aes(x=valid_start, y=area_pct, color=drought_lvl)) + 
    geom_area(aes(fill=drought_lvl), position="identity", alpha=0.1) + 
    facet_wrap(vars(year), scales="free_x") + 
    scale_color_viridis_d(name="Drought Level", labels=legendLabs2, direction=-1) + 
    scale_fill_viridis_d(name="Drought Level", labels=legendLabs2,direction=-1) +
    scale_x_date(date_breaks="3 months", date_labels="%b") + 
    theme_light(base_family="Poppins", base_size=8) + 
    guides(col=guide_legend(nrow=1)) +
    labs(title="Percentage of area in each level of drought", 
         subtitle="In North Carolina in the last 10 years (2011-present)",
         caption="#TidyTuesday\nAuthor: @TheDataInkLab\nData: US Drought Monitor") +
    theme(legend.position="bottom",
          strip.text=element_text(face="bold", color="black", size=10),
          strip.background=element_blank(),
          panel.grid = element_blank(),
          plot.title = element_text(size=15, face="bold", margin=margin(b=10,t=10)),
          plot.subtitle = element_text(size=12, margin=margin(b=20)),
          legend.margin = margin(t=20),
          axis.title = element_blank()) 
		  
ggsave("tidytuesday30.pdf", height=6, width=6, device=cairo_pdf)
