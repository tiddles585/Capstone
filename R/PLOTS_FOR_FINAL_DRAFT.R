library(fpp)
library(ggplot2)
library(ggthemes)
library(datasets)

df = ausair

#########################################################
horizon = 5

ses5.df = data.frame(ses(df, h=horizon))
ses5.dates <- seq(end(df)[1] + 1, length.out = horizon, by = 1)

df %>% 
  ggplot(aes(x=start(df)[1]:end(df)[1],
             y=df#,
             #color=Domain
             )) +
  geom_line(size=1.2) +
  geom_line(data = data.frame(ses5.df$Point.Forecast), 
            aes(x = ses5.dates, y = ses5.df$Point.Forecast), 
            color = "red", linetype = "solid", size = 1.2) +
  geom_line(data = data.frame(ses5.df$Hi.95), 
            aes(x = ses5.dates, y = ses5.df$Hi.95), 
            color = "pink", linetype = "solid", size = 1.2) +
  geom_line(data = data.frame(ses5.df$Lo.95), 
            aes(x = ses5.dates, y = ses5.df$Lo.95), 
            color = "pink", linetype = "solid", size = 1.2) +
  ylab("Passengers (millions)") +
  xlab("Year") +
  theme_clean() + 
  theme(axis.title = element_text(face="bold",size=30),
        axis.text = element_text(face="bold",size=20)) +
  ggtitle("Australian Annual Air Transport Passengers (1970-2009)") + 
  theme(plot.title = element_text(hjust=.5,size=30)) 

#########################################################
horizon = 15

ses15.df = data.frame(ses(df, h=horizon))
ses15.dates <- seq(end(df)[1] + 1, length.out = horizon, by = 1)
holt15.df = holt(df, h=horizon)
holt15.dates <- seq(end(df)[1] + 1, length.out = horizon, by = 1)
damped.holt.df = holt(df, damped=TRUE, phi = 0.9, h=15)
damped.holt.dates <- seq(end(df)[1] + 1, length.out = horizon, by = 1)

df %>% 
  ggplot(aes(x=start(df)[1]:end(df)[1],
             y=df#,
             #color=Domain
  )) +
  geom_line(size=1.2) +
  geom_line(data = data.frame(ses15.df$Point.Forecast), 
            aes(x = ses15.dates, y = ses15.df$Point.Forecast), 
            color = "red", linetype = "solid", size = 1.2) +
  geom_line(data = data.frame(data.frame(holt15.df$mean)), 
            aes(x = holt15.dates, y = holt15.df$mean), 
            color = "green", linetype = "solid", size = 1.2) +
  geom_line(data = data.frame(damped.holt.df$mean), 
            aes(x = damped.holt.dates, y = damped.holt.df$mean), 
            color = "blue", linetype = "solid", size = 1.2) +
  ylab("Passengers (millions)") +
  xlab("Year") +
  theme_clean() + 
  theme(axis.title = element_text(face="bold",size=30),
        axis.text = element_text(face="bold",size=20)) +
  ggtitle("Australian Annual Air Transport Passengers (1970-2009)") + 
  theme(plot.title = element_text(hjust=.5,size=30)) 

#########################################################
df = austourists

horizon = 4

hw.addi.df = data.frame(hw(df, seasonal="additive"))
hw.addi.dates <- seq(end(df)[1] + 1, length.out = (horizon*2), by = .25)
hw.multi.df = data.frame(hw(df, seasonal="multiplicative"))
hw.multi.dates <- seq(end(df)[1] + 1, length.out = (horizon*2), by = .25)

df %>% 
  ggplot(aes(x=seq(start(df)[1], length.out = length(austourists), by = .25),
             y=df#,
             #color=Domain
  )) +
  geom_line(size=1.2) +
  geom_line(data = data.frame(hw.addi.df$Point.Forecast),
            aes(x = hw.addi.dates, y = hw.addi.df$Point.Forecast),
            color = "red", linetype = "solid", size = 1.2) +
  geom_line(data = data.frame(hw.addi.df$Hi.95),
            aes(x = hw.addi.dates, y = hw.addi.df$Hi.95),
            color = "pink", linetype = "solid", size = 1.2) +
  geom_line(data = data.frame(hw.addi.df$Lo.95),
            aes(x = hw.addi.dates, y = hw.addi.df$Lo.95),
            color = "pink", linetype = "solid", size = 1.2) +
  ylab("Visitors (millions)") +
  xlab("Year") +
  theme_clean() + 
  theme(axis.title = element_text(face="bold",size=30),
        axis.text = element_text(face="bold",size=20)) +
  ggtitle("Australian Quarterly Tourist Visitor Nights (1999-2010)") + 
  theme(plot.title = element_text(hjust=.5,size=30)) 

#########################################################
df = AirPassengers

horizon = 12
hw.multi.df = data.frame(hw(df, seasonal="multiplicative"))
hw.multi.dates <- seq(end(df)[1] + 1, length.out = (horizon*2), by = (1/12))

df %>% 
  ggplot(aes(x=seq(start(df)[1], length.out = length(AirPassengers), by = (1/12)),
             y=df#,
             #color=Domain
  )) +
  geom_line(size=1.2) +
  geom_line(data = data.frame(hw.multi.df$Point.Forecast),
            aes(x = hw.multi.dates, y = hw.multi.df$Point.Forecast),
            color = "red", linetype = "solid", size = 1.2) +
  geom_line(data = data.frame(hw.multi.df$Hi.95),
            aes(x = hw.multi.dates, y = hw.multi.df$Hi.95),
            color = "pink", linetype = "solid", size = 1.2) +
  geom_line(data = data.frame(hw.multi.df$Lo.95),
            aes(x = hw.multi.dates, y = hw.multi.df$Lo.95),
            color = "pink", linetype = "solid", size = 1.2) +
  ylab("Passengers (thousands)") +
  xlab("Year") +
  theme_clean() + 
  theme(axis.title = element_text(face="bold",size=30),
        axis.text = element_text(face="bold",size=20)) +
  ggtitle("Monthly Airline Passengers (1949-1960)") + 
  theme(plot.title = element_text(hjust=.5,size=30)) 



