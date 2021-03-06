library(tidyverse)
library(ggplot2)
library(lubridate)
library(stringr)

#Importing dataset
etsyset<-read.csv(choose.files(), stringsAsFactors = FALSE)

#Cleaning Dates
etsyset$Sale.Date<- mdy(etsyset$Sale.Date)

#Removing unesscary data columns
etsy.clean<- etsyset[,c(1:2,4:12)]

#Month avagery data
etsymonth<- etsyset%>%
  filter(str_detect(str_to_lower(Item.Name), "shirt"))%>%
  filter(Price < 50)%>%
  filter(str_detect(str_to_lower(Item.Name), "back")==FALSE)%>%
  filter(str_detect(str_to_lower(Item.Name), "add-on")==FALSE)%>%
  filter(Order.Shipping <=5.5)%>%
  mutate(Final.Price = Price - Discount.Amount - Shipping.Discount + Order.Shipping)

etsymonth$month<-format(as.Date(etsymonth$Sale.Date), "%Y-%m")

etsymonth<- etsymonth%>%
  group_by(month)%>%
  summarise(MeanPrice = mean(Final.Price),
            TotalQuantity = sum(Quantity),
            TotalCost= (TotalQuantity*9),
            TotalRevenue= sum(Final.Price))

etsymonth<-  etsymonth[c(1:9),-1]
etsymonth<- etsymonth[order(etsymonth$MeanPrice),]%>%
  mutate(MR = TotalRevenue - lag(TotalRevenue, default = first(TotalRevenue)))

#Ploting the data
ggplot(etsymonth,aes(x=MeanPrice,y=TotalQuantity))+
  geom_jitter(size=5,color="#33658A")+
  geom_smooth(method='lm',se=FALSE, size=3, colour="#F56476")

#building the model
monthmodel<-lm(TotalQuantity~MeanPrice, data=etsymonth)
month.coef<-monthmodel$coefficients[[2]]
month.constant<- monthmodel$coefficients[[1]]
summary(monthmodel)

#New price suggestion
new.price<- seq(9,35,1)
new.quantity<- new.price* month.coef + month.constant
new.revune<- (new.quantity*new.price)
new.cost<- 9*new.quantity
new.profit<- new.revune-new.cost

#Profit table for best price
profitdf<- cbind.data.frame(new.price,
                            new.quantity,
                            new.revune,
                            new.cost,
                            new.profit)
View(profitdf)

#plot for all the numbers  
ggplot(profitdf,aes(x=new.price))+
  geom_line(size=6, aes(y=new.quantity), color = "#33658a")+  
  geom_line(size=3, aes(y=new.revune), color = "#2c4251")+
  geom_line(size=2, aes(y=new.cost), color = "#a38560")+
  geom_line(size=1, aes(y=new.profit), color="#f56476")+
  ylim(0,10000)+
  xlim(9,25)
