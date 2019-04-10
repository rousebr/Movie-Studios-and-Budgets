###Project to get a general visualization of movie expenditures for specific genres.
##An exercise in visually sorting data for presentation
getwd()
setwd("~.\\R Tutorial")
mov <- read.csv("Movie Studio Data.csv")

#Data Exploration
head(mov) #top rows
colnames(mov) #column summaries
str(mov) #structure of the dataset

#Activate GGPlot2
#install.packages("ggplot2")
library("ggplot2")

#{Offtopic} This Is A Cool Insight:
ggplot(data=mov, aes(x=Day.of.Week)) + geom_bar()
#Notice? No movies are released on a Monday. Ever.

#Filter dataset to leave only the 
#Genres and Studios that we are interested in
filt <- (mov$Genre == "action") | (mov$Genre == "adventure") | (mov$Genre == "animation") | (mov$Genre == "comedy") | (mov$Genre == "drama")

#Same for the Studio filter:
filt2 <- (mov$Studio == "Buena Vista Studios") | (mov$Studio == "WB") | (mov$Studio == "Fox") | (mov$Studio == "Universal") | (mov$Studio == "Sony") | (mov$Studio == "Paramount Pictures")
  
#Apply the row filters to the dataframe
mov2 <- mov[filt & filt2,]

#Prepare the plot's data and aes layers
p <- ggplot(data=mov2, aes(x=Genre, y=Gross...US))

#Add a Point Geom Layer
p + geom_point()

#Add a boxplot instead of the points
p + geom_boxplot()

#Add points
p + 
  geom_point() + 
  geom_boxplot()
#Not what we are after

#Replace points with jitter
p + 
  geom_boxplot() + 
  geom_jitter()

#Place boxplot on top of jitter
p + 
  geom_jitter() + 
  geom_boxplot() 

#Add boxplot transparency
p + 
  geom_jitter() + 
  geom_boxplot(alpha=0.7) 

#Good. Now add size and colour to the points:
p + 
  geom_jitter(aes(size=Budget...mill., color=Studio)) + 
  geom_boxplot(alpha=0.7) 
#See the remaining black points? Where are they from?
#They are part of the boxplot - Refer to our observation (*) above 

#Let's remove them:
p + 
  geom_jitter(aes(size=Budget...mill., color=Studio)) + 
  geom_boxplot(alpha = 0.7, outlier.colour = NA) 

#Let's "Save" our progress by placing it into a new object:
q <- p + 
  geom_jitter(aes(size=Budget...mill., color=Studio)) + 
  geom_boxplot(alpha = 0.7, outlier.colour = NA) 
q +facet_grid(Studio~., scales="free")

#Non-data ink
q <- q +
  xlab("Genre") + #x axis title
  ylab("Gross % US") + #y axis title
  ggtitle("Domestic Gross % by Genre") #plot title
q

#Theme
q <- q + 
  theme(
    #this is a shortcut to alter ALL text elements at once:
    text = element_text(family="Times"),
    
    #Axes titles:
    axis.title.x = element_text(colour="Blue", size=20),
    axis.title.y = element_text(colour="Blue", size=20),
    
    #Axes texts:
    axis.text.x = element_text(size=10),
    axis.text.y = element_text(size=10),  
    
    #Plot title:
    plot.title = element_text(colour="Black",
                              size=20),
    
    #Legend title:
    legend.title = element_text(size=15),
    
    #Legend text
    legend.text = element_text(size=12)
  )
q

#Final touch, changing individual title
q$labels$size = "Budget $M"
q
