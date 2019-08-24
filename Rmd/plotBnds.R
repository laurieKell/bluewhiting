library(FLCore)
library(ggplotFL)
library(FLBRP)
library(plyr)
library(kobe)
library(grid)
library(png)
library(reshape)

dirDat="/home/laurence/Desktop/Dropbox/bluewhiting/data"   
#load(file.path(dirDat,"sims.RData"))

plot(FLStocks("No Bound"=window(iter(sims[["sim1_noass"]][[1]],2),start=2000),
              "Bound"   =window(iter(sims[["sim1_bnd_noass"]][[1]],2),start=2000)))+
  geom_hline(aes(yintercept=y),col="red",data=data.frame(qname="SSB",y=2.25e6))+
  theme_bw(16)+theme(legend.position="bottom")+
  scale_color_manual("",values=rainbow(10)[c(4,9)])+
  xlab("Year")

ssb(window(iter(sims[["sim1_bnd_noass"]][[1]],2),start=2000))<2.25e6

ctc=catch(window(iter(sims[["sim1_noass"]][[1]],2),start=2000))

ctb=catch(window(iter(sims[["sim1_bnd_noass"]][[1]],2),start=2000))

dat=as.data.frame(FLQuants(
              "SSB"      =ssb(window(iter(sims[["sim1_noass"]][[1]],2),start=2000,end=2017)),
              "SSB Bound"=ssb(window(iter(sims[["sim1_bnd_noass"]][[1]],2),start=2000,end=2017)),
              "No Bound" =(ctc[,-1]-ctc[,-dim(ctc)[2]])/ctc[,-dim(ctc)[2]],
              "Bound"    =(ctb[,-1]-ctb[,-dim(ctb)[2]])/ctb[,-dim(ctb)[2]]))

dat=transform(dat,Quantity=ifelse(qname%in%c("SSB","SSB Bound"),"SSB","Catch in Catch"))
dat=transform(dat,Bound   =qname%in%c("SSB","No Bound"))

ggplot(dat)+
  geom_line(aes(year,data,col=Bound))+
  facet_grid(Quantity~.,scale="free")+
  theme_bw(16)+xlab("Year")+ylab("")+
  geom_hline(aes(yintercept=y),col="red",
           data=data.frame(y=c(2.25e6,0),
           Quantity=c("SSB","Change in Catch")))+
  scale_color_manual("",values=rainbow(10)[c(4,9)])
  
  
source('/home/laurence/Desktop/flr/kobe/R/kobe-phase.R')
source('/home/laurence/Desktop/flr/kobe/R/kobe-phaseMar.R')  



fn1<-function(yr) {
  ymax=max(c(ldply(sims[c("sim1")], function(x)
    as.data.frame(quantile(c(catch(x[[1]])[,ac(2001:2018)]),0.95),drop=T))[,2]))
  
  fourth=ggplot(ldply(sims[c("sim1")], function(x)
    as.data.frame(catch(x[[1]])[,ac(yr)],drop=T)))+geom_violin(aes(.id,data,fill=.id))+
    theme(legend.position="none")+
    scale_fill_manual(values=colorRampPalette(c("orange","blue"),space="Lab")(2))+
    scale_y_continuous(limits=c(0,ymax))
  
  kobePhaseMar2(subset(pts,year==yr&run=="sim1"),xlim=c(0,1e7),ylim=c(0,1),
                quadcol=rep(c("white"),4),
                bref=2250000,fref=0.32,
                layer=geom_point(aes(ssb,f),col="red",size=.2,
                                 data=subset(chk,.id%in%c("sim1","sim1_bnd"))), 
                xlab="SSB",ylab="F",fourth=fourth)}   

fnBnd<-function(yr) {  
  ymax=max(c(ldply(sims[c("sim1","sim1_bnd")], function(x)
    as.data.frame(quantile(c(catch(x[[1]])[,ac(2001:2018)]),0.95),drop=T))[,2]))
  
  fourth=ggplot(ldply(sims[c("sim1","sim1_bnd")], function(x)
    as.data.frame(catch(x[[1]])[,ac(yr)],drop=T)))+geom_violin(aes(.id,data,fill=.id))+
    theme(legend.position="none")+
    scale_fill_manual(values=colorRampPalette(c("orange","blue"),space="Lab")(2))+
    scale_y_continuous(limits=c(0,ymax))
  
  kobePhaseMar2(subset(pts,year==yr&
                         run%in%c("sim1","sim1_bnd")),
                xlim=c(0,1e7),ylim=c(0,1),
                quadcol=rep(c("white"),4),
                bref=2250000,fref=0.32,layer=
                  geom_point(aes(ssb,f),col="red",size=.2,
                             data=subset(chk,.id%in%c("sim1","sim1_bnd"))), 
                xlab="SSB",ylab="F",fourth=fourth)}  
```

# Simulations
## HCR I:   2001 
```{r}
fn1(2001)    
