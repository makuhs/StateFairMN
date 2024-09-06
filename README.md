# Minnesota State Fair Attendance Data 

Explore daily attendance, weather, and all-time records for the last 50 years of the MN State Fair (1975-2024)

## [CLICK HERE!](https://makuhs.github.io/StateFairMN/)

---
### Overview

This repository contains two attendance-based datasets I compiled to build some static figures and an iteractive/animated plot. Datasets were last updated September 4th, 2024. I will try to make sure they get updated post-fair in 2025. 

The Minnesota State Fair is one of the largest and highest-attended fairs in the nation with well over 2 million visitors across 12 days. You can learn more about the 'Great Minnesota Get Together' [here](https://en.wikipedia.org/wiki/Minnesota_State_Fair) 

---
### Data

**Daily Attendance Counts**
Daily attendance counts along with high and low temperature. Data spans 1975 - 2024 (all years since the fair begain it's 12-day length)

|variable            |description         |
|:-------------------|:-------------------|
|numberDay           | Day of dair count (integer 1-12)
|weekDay             | Day of week (Monday - Sunday)        
|year                | Year   
|attendance          | Daily attendance count
|annualTot           | Annual attendance count (summed daily counts by year)
|tempHigh            | Daily high temperature (F)
|tempLow             | Daily low temperature (L)
|precip              | Presence of rail > 0.05in total (y/n)
|ticketPrice         | Day-of ticket price ($)
|recordDai...        | Record daily attendance count of all-time (updated in 2024)


**Total Attendance Counts** 
Total attendance count at the end of the fair. Data spans 1887 - 2024. 

|variable            |description         |
|:-------------------|:-------------------|
|year                | Year
|totalAttend         | Annual attendance total count  
|dayLength           | Length of fair in days (6-12)
|notable             | Notable events

Feel free to use for fun but please see [Minnesota State Fair Foundation and Archieves](https://corp.arcasearch.com/usmnmsf/) website for data use policies. 

Data sourcing and reference information can be found [here](https://github.com/makuhs/StateFairMN/blob/main/data/readme.txt)

---
### Figures

#### Minnesota State Fair All-Time Attendance (1887-2024)
<img src="https://github.com/makuhs/StateFairMN/blob/main/staticFigs/totalAttendance.jpeg" width="1000">

#### 2024 Daily Attendance 
<img src="https://github.com/makuhs/StateFairMN/blob/main/staticFigs/dailyAttendance.jpeg" width="850">

### [Explore this data across other years here](https://makuhs.github.io/StateFairMN/)


<h1 align="center">[Explore this data across other years here](https://makuhs.github.io/StateFairMN/)</h1>
