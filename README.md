# GoogleTrend

1.We supply users search stock which they are interest in and notify them whether this stock safe or not. 

2.You can weight the pros and cons according to the Indicator we supply, and decide  whether to search more detail information of the stock 


## Overview

- 1.We get popular value from Google Trend API.
- 2.We calculate a moving average of the last three weekly data volumes:
  - MA3 = (n(t-1) + n(t-2)) + n(t-3))/3, where n(t-1) is the volume for the last available week, n(t-2) is the volume for the second-last available week, and n(t-3) is the volume for the third-last available week.
- 3.We calculate a moving average MA18 of the data volumes over the last 18 weeks:
 - MA18 = (n(t-1) + n(t-2) + ……… + n(t-18))/18
- 4.For falling search volume, MA3 < MA18 or the volume of last available week < 80, we define it as safe stock
  - if   MA3 < MA18 or n(t-1) < 80    =>   Safe stock
  - else   =>  unsafe stock


## Short-term usability goals

-Provide investors with risk assessment indicators,and protect them from risk.

## Long-term goals

- Add charts to visualize risks.
- Add more indicators to improve performance.

