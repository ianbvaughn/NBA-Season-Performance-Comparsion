#import gg plot

library(ggplot2)

#import datasets

stats_2021 <- read.csv('2021-League-Stats.csv')
stats_2022 <- read.csv('2022-League-Stats.csv')

#add year column for both datasets

stats_2021$Year <- 2021
stats_2022$Year <- 2022

#merge datasets

stats_all <- rbind(stats_2021,stats_2022)

#convert team name to factor

stats_all$Team <- factor(stats_all$Team)
stats_all$Year <- as.factor(stats_all$Year)

#filter PDX

pdx <- stats_all$Team == 'Portland'

#plot data

a <- ggplot(data=stats_all,aes(x=Offense,y=Defense,shape=Year))
a + geom_point(data=stats_all[!pdx,],color="Black",size=3) + 
  geom_point(data=stats_all[pdx,],alpha=0.7,color="Red",size=3) + 
  geom_label(data=stats_all[pdx,],aes(label=paste('O Rtg:',Offense)),nudge_y=0.8) +
  xlab('Offensive Rating') +
  ylab('Defensive Rating') +
  ggtitle('Team Ratings', subtitle = 'Portland highlighted')
