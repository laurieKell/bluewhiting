library(FLasher)
library(FLBRP)
library(FLAssess)
library(ggplotFL)
library(reshape)
library(plyr)

load("data/om.RData")
load("data/srDev.RData")

## Recruitment deviates change to log scale 
srDev=exp(srDev)

# Number of Monte Carlo replicates
nits  =10

#### Function to run MSE #####################################
source("R/hcrICES.R")


#### HCR I:
par1=array(c(ftar=refpts["fmsy"],btrig=refpts["msytrig"],fmin=FLPar(0.05),blim=refpts["blim"]),
           dim=c(4),
           dimnames=list(c("ftar","btrig","fmin","blim")))

#### HCR II:
par2=array(c(0.20,2250000,
             0.05,1500000,
             0.32,5200000,
             0.20,4000000),
           dim=c(4,2),
           dimnames=list(c("ftar","btrig","fmin","blim"),c("lower","upper")))[c(1,3,2,4),1:2]


## Start Simulations ################################################
#### years for simulations
start   =2001
end     =2018
interval=1
bndTac=c(0.8,1.25)

# make sure all slots have same number of iterations
nits=10
object=propagate(iter(om,seq(nits)),nits)

object=iter(object,seq(nits))
srDev =iter(srDev ,seq(nits))
err   =rlnorm(nits,FLQuant(0,dimnames=list(year=start:end)),0.3)
eql9  =iter(eql9  ,seq(nits))
sims=list("Historical"=om)

sims[["sim1.0"]]=hcrICES(object,eql9,srDev,
                            par1,
                            start,end,interval,
                            err=NULL)

sims[["sim1.0.10"]]=hcrICES(object,eql9,srDev,
                         par1,
                         start,end,interval,
                         err=err%=%1,
                         bndTac=c(0.9,1.1))

names(sims[["sim1.0"]][[2]])[2:3]=c("year","ssb")
sims[[2]][[2]]$year=sims[[2]][[2]]$year-1

dat=merge(as.data.frame(ssb(sims[["sim1.0"]][[1]]),drop=TRUE),
          sims[["sim1.0"]][[2]],by=c("iter","year"))
ggplot(dat)+geom_point(aes(data,ssb,col=iter))

plot(FLStocks(list("None"=sims[["sim1.0"]][[1]],"10%"=sims[["sim1.0.10"]][[1]])))

ssb=ssb(sims[["sim1.0.10"]][[1]])[,ac(2010:2015)]
(ssb<2.25e6)[,,,,,1]

((ctc[,-19]-ctc[,-1])%/%ctc[,-19])[,ac(2010:2015),,,,1]



