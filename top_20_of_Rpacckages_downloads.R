library(cranlogs)
library(ggplot2)
library(ggthemes)
library(tidyverse)

data <- cran_top_downloads("last-month",count=20)
col <- rep(c("#999999","#E69F00","#56B4E9"),7)[-1]
ggplot(data,aes(x=reorder(package,count),y=count))+geom_bar(stat='identity',fill=col)+labs(x='',y="download",title='last month download number top20',subtitle=R.version.string)+scale_y_continuous(breaks=seq(260000,560700,length=5),labels=seq(26000,560700,length=5))+coord_flip()+theme_pander()
