## MN State Fair Data Daily Attendance
## 2024 snapshot

# PACKAGES 
library(tidyverse)
library(scales)
library(grid)
library(ggstar)
library(plotly)


# DATA
dailyCount <- read.csv("data/dailyCounts.csv")%>%
  na.omit()

# SETUP
##30 year average
avg <- dailyCount %>%
  filter(year >= 1994)%>%
  filter(year != 2020)%>% #remove covid year from average
  group_by(numberDay, weekDay)%>%
  summarise(mean = mean(attendance),
         sd = sd(attendance)) %>%
  mutate(low = mean-sd,
         high = mean + sd)

##subset 2024
sub24 <- dailyCount %>%
  filter(year == 2024)%>%
  mutate(shape = case_when(attendance == recordDailyAttendAllTime2024 ~ "A",
                           attendance != recordDailyAttendAllTime2024 ~ "B"),
         highF = paste0(tempHigh, "°F"))


#PLOT: static 2024 figure

ggplot(sub24, aes(numberDay, attendance))+

  #shade weekends
  annotate("rect", xmin = 2.5, xmax = 4.5, ymin = -40000, ymax = 320000, 
           alpha = 0.3, fill = "grey85")+
  annotate("rect", xmin = 9.5, xmax = 12.5, ymin = -40000, ymax = 320000, 
           alpha = 0.3, fill = "grey85")+
  
  #add averages
  geom_segment(data = avg, aes(x = numberDay, y = low, xend = numberDay, yend = high), 
               color = "grey85", size = 7)+
  geom_point(data = avg, aes(numberDay, high), color = "grey85", size = 6)+
  geom_point(data = avg, aes(numberDay, low), color = "grey85", size = 6)+
  
  #add points & stars for records 
  geom_point(size = 4, color = "#5383b5")+
  geom_line(size = 1.2, color = "#5383b5")+
  geom_star(aes(numberDay, attendance + 20000, starshape = shape), 
            color = "#deaf43", fill = "#deaf43", size = 2.5, alpha=0.75)+
  
  #add labels
  annotate("text", x = 3.5, y = 310000, label = "WEEKEND",
           hjust = 0.5,
           family = "Open Sans",
           fontface = "bold",
           size = 3,
           color = "grey50")+
  annotate("text", x = 11, y = 310000, label = "LABOR DAY WEEKEND",
           hjust = 0.5,
           family = "Open Sans",
           fontface = "bold",
           size = 3,
           color = "grey50")+
  geom_text(data = labs, aes(y= -18000, label = weekDay),
            size = 2.5,
            family = "Open Sans",
            color = "grey50")+
  geom_text(data = sub24, aes(y= -30000, label = highF),
            size = 2.75,
            family = "Open Sans",
            color = "#5383b5")+
  annotate("text", x = 8.6, y = 60000, label = "severe storms\nand flooding",
           hjust = 0,
           family = "Open Sans",
           size = 2.5,
           color = "#5383b5",
           lineheight = 0.9)+
  geom_curve(aes(x = 8.5, y = 60000, xend = 8.1, yend = 70000),
             curvature = -0.2, 
             arrow = arrow(length = unit(0.015, "npc"), type = "closed"),
             color = "#5383b5", size = 0.08)+
  
 
  #Create Key
  annotate("rect", xmin = 0.5, xmax = 2.5, ymin = 250000, ymax = 300000, fill = "white", alpha=0.9)+
  annotate("text", x = 0.5, y = 310000, color = "grey50", family = "Open Sans", hjust = 0, size = 3,
           label = "all-time record")+
  annotate("text", x = 0.5, y = 278000, color = "grey50", family = "Open Sans", hjust = 0, size = 3,
           label = "past 30-year\naverage")+
  geom_star(aes(x = 0.2, y = 310000), color = "#deaf43", fill = "#deaf43", starshape = 1, size= 2.5)+
  annotate("rect", xmin = 0.08, xmax = 0.32, ymin = 265000, ymax = 290000,fill = "grey85")+
  annotate("point", x = 0.2, y = 265000, color = "grey85", size = 4)+
  annotate("point", x = 0.2, y = 290000, color = "grey85", size = 4)+
  
  #Add titles
  annotate("text", x = 12.5, y = -60000, color = "grey50", family = "Open Sans", hjust = 1, size = 2,
           label = "Data sourced from the Minnesota State Fair Society and the MN DNR | Graphic created by Molly Kuhs, 2024")+
  annotate("text", x = 0, y = 375000, color = "grey20", family = "Open Sans", hjust = 0, size = 6.5, fontface = "bold", label = "2024 MINNESOTA STATE FAIR ATTENDANCE")+
  annotate("text", x = 0, y = 353000, color = "grey45", family = "Open Sans", hjust = 0, size = 3, label = "Daily attendance numbers and high temperatures referenced against attendance averages of the past 30 years of the fairs (grey zones)")+
  
  #Plot aesthetics
  coord_cartesian(clip = "off",
                  xlim = c(1,12),
                  ylim= c(0, 280000))+
  scale_x_continuous(n.breaks = 12)+
  scale_y_continuous(labels = comma)+
  scale_starshape_manual(values = c(1, NA))+
  theme_minimal()+
  theme(plot.margin = unit(c(1.3,0.2,0.5,0.1), "in"),
        panel.grid.minor = element_blank(),
        legend.position = "none",
        axis.text.x = element_blank(),
        axis.text.y = element_text(color = "grey50",
                                   family = "Open Sans"))+
  labs(x = "",
       y = "")


## FINAL 
ggsave("staticFigs/dailyAttendance.jpeg", width = 8.5, height = 5.5, units = "in")

#fin
