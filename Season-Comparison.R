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

#create filters

pdx <- stats_all$Team == 'Portland'
season_2022 <- stats_all$Year == 2021
season_2021 <- stats_all$Year == 2022

#grab averages

mean_offense_2021 <- round(mean(stats_all[season_2021,]$Offense),1)
mean_offense_2022 <- round(mean(stats_all[season_2022,]$Offense),1)

#plot data

a <- ggplot(data=stats_all,aes(x=Offense,y=Defense,shape=Year))
a + geom_point(data=stats_all[!pdx,],color="Black",size=3) + 
  geom_point(data=stats_all[pdx,],alpha=0.7,color="Red",size=3) + 
  geom_label(data=stats_all[pdx,],aes(label=paste('O Rtg:',Offense)),nudge_y=0.8) +
  geom_vline(xintercept=mean_offense_2021,color="Gray") +
  geom_label(aes(x=mean_offense_2021,y=117,label = paste('2021 Avg O Rtg:',mean_offense_2021))) +
  geom_vline(xintercept=mean_offense_2022,color="Gray") +
  geom_label(aes(x=mean_offense_2022,y=118.7,label = paste('2022 Avg O Rtg:',mean_offense_2022))) +
  xlab('Offensive Rating') +
  ylab('Defensive Rating') +
  ggtitle('Team Ratings', subtitle = 'Portland highlighted')
