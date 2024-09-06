## Animated Attendance Figure 
## NOTE : code here is just for reference!!! 
## Please see markdown files (/docs) for code supporting the web-published figure

# PACKAGES
library(tidyverse)
library(scales)
library(grid)
library(plotly)
library(zoo)

# DATA
dailyCount <- read.csv("StateFairMN/StateFairMN/data/dailyCounts.csv")%>%
  na.omit()

# SETUP
## 30 year average
avg <- dailyCount %>%
  filter(year >= 1994)%>%
  filter(year != 2020)%>%
  group_by(numberDay, weekDay)%>%
  summarise(mean = mean(attendance),
            sd = sd(attendance)) %>%
  mutate(low = mean-sd,
         high = mean + sd)

## Add columns for records and weather 
recordCurrent <- dailyCount %>%
  mutate(shape = case_when(attendance == recordDailyAttendAllTime2024 ~ "A",
                           attendance != recordDailyAttendAllTime2024 ~ "B"), 
         highF = paste0(tempHigh, "°F"),
         lowF = paste0(tempLow),
         rain = case_when(precip == "yes" ~ "Rain",
                          precip == "no" ~ "No rain"),
         tempRange = paste0(lowF, " - ", highF, "\n", rain))%>%
  filter(year != 2020)%>%
  
  group_by(numberDay) %>%
  arrange(year) %>% 
  mutate(
    pastMax = lag(cummax(attendance), default = NA),
    rollingHigh = if_else(is.na(pastMax) | attendance > pastMax, 'yes', 'no'),
    maxYear = if_else(is.na(pastMax) | attendance > pastMax, year, NA_integer_),
    maxYear = zoo::na.locf(maxYear, na.rm = FALSE)
  ) %>%
  ungroup()%>%
  mutate(currentHigh = case_when(rollingHigh == "yes" ~ attendance,
                                 rollingHigh == "no" ~ pastMax),
         attendDisp = format(attendance, big.mark  =","),
         recordText = paste0(maxYear, ":\n", attendDisp))


## subset for labels
labs <- recordCurrent %>%
  filter(year == 2024)


## text for labeling
subtitle <- "Daily attendance data for all 12-day fairs (1975 to 2024)"
subsubtitle <- "Move the slider along the bottom to explore daily attendance patterns by year.\nGrey zones represent a 30-year attendance average (from 1994-2024). Light blue points depict\nthe rolling attendance highs with gold stars indicating the all-time record." 
tempPrompt <- "Hover your cursor to see weather data and rolling attendance records"



# PLOT
plot<- ggplot(recordCurrent, aes(numberDay, attendance))+
  
  # shade weekends
  annotate("rect", xmin = 2.5, xmax = 4.5, ymin = -18000, ymax = 310000, 
           alpha = 0.3, fill = "grey85")+
  annotate("rect", xmin = 9.5, xmax = 12.5, ymin = -18000, ymax = 310000, 
           alpha = 0.3, fill = "grey85")+
  
  #add 30 year average
  geom_segment(data = avg, aes(x = numberDay, y = low, xend = numberDay, yend = high), 
               color = "grey85", size = 7)+
  geom_point(data = avg, aes(numberDay, high), color = "grey85", size = 6.2)+
  geom_point(data = avg, aes(numberDay, low), color = "grey85", size = 6.2)+
  
  #add points
  geom_point(size = 3, color = "#8ab4d1", alpha=0.4, aes(y = currentHigh, frame = year, text = recordText))+
  geom_point(size = 4, color = "#5383b5", aes(frame = year, text = tempRange))+
  geom_line(size = 1.2, color = "#5383b5", aes(frame = year))+
  geom_point(aes(y= attendance + 15000, frame = year, fill = shape, color = shape, alpha=shape), 
             size = 2.5, shape = 8)+
  
  #add weekdays
  geom_text(data = labs, aes(y= -10000, label = weekDay),
            size = 2.6)+
  
  #annotate weekend blocks
  annotate("text", x = 3.5, y = 10000, label = "WEEKEND",
           hjust = 0.5,
           family = "Open Sans",
           fontface = "bold",
           size = 3,
           color = "grey50")+
  annotate("text", x = 11, y = 10000, label = "LABOR DAY WEEKEND",
           hjust = 0.5,
           family = "Open Sans",
           fontface = "bold",
           size = 3,
           color = "grey50")+
  
  #titles
  annotate("rect", xmin = 0, xmax = 12.5, ymin = 298000, ymax = 401000, fill = "white")+
  annotate("text", x = 6, y = 370000, label = "MINNESOTA STATE FAIR DAILY ATTENDANCE",
           hjust = 0.5,
           family = "Open Sans",
           fontface = "bold",
           size = 7,
           color = "grey20")+
  annotate("text", x = 6, y = 348000, label = subtitle,
           hjust = 0.5,
           family = "Open Sans",
           size = 4,
           color = "grey30")+
  annotate("text", x = 6, y = 318000, label = subsubtitle,
           hjust = 0.5,
           family = "Open Sans",
           size = 2.75,
           color = "grey50")+
  annotate("text", x = 6, y = 280500, label = tempPrompt,
           hjust = 0.5,
           family = "Open Sans",
           size = 3,
           fontface = "bold",
           color = "#5383b5")+
  
  #plot aesthetics 
  coord_cartesian(clip = "off",
                  xlim = c(1,12),
                  ylim= c(-8000, 380000))+
  scale_x_continuous(n.breaks = 12)+
  scale_y_continuous(breaks = c(100000, 200000), labels = comma)+
  scale_fill_manual(values = c("#debe57", "white"))+
  scale_color_manual(values = c("#debe57", "white"))+
  scale_alpha_manual(values = c(0.75, 0))+
  theme_minimal()+
  theme(plot.margin = unit(c(0.2,0.1,0.3,0.1), "in"),
        panel.grid.minor = element_blank(),
        legend.position = "none")+
  labs(x = "",
       y = "")

plot


# ANIMATE

traceHide <- c(0:5, 7:17)

p<- ggplotly(plot,
         tooltip="text")%>%
  animation_slider(currentvalue = list(prefix = "YEAR ", 
                                       font = list(color="#707070", size = 12)),
                   font = list(size = 10, family = "Open Sans", color = "#707070"))%>%
  animation_button(visible = F)%>%
  animation_opts(
    easing = "elastic",
    redraw = F)%>%
   style(hoverinfo = "none", traces = traceHide)

p

#fin