###############################################################
## Runs the blue whiting HCR simulations ######################
###############################################################

# This should be loaded as part of an Rstudio project based om
# github project https://github.com/laurieKell/bluewhiting

##### Libraries
library(FLasher)
library(FLBRP)
library(FLAssess)
library(ggplotFL)
library(reshape)
library(plyr)

library(magrittr)
library(rdrop2)

if (FALSE){
  ##### Data are saved in dropbox ###########################
  ## You need to save locally in the /data folder
  ## access dropbox with data files
  token<-drop_auth()
  saveRDS(token, "token.RDS")
  
  ## Data objects 
  ## Operating Model
  ## this has stock, srr and FLBRP objects
  drop_download(path='bluewhiting/data/om.RData',local_path="data",overwrite=TRUE)
  ## stock recruitment deviates
  drop_download(path='bluewhiting/data/srDev.RData',local_path="data",overwrite=TRUE)
  }

load("data/om.RData")
load("data/srDev.RData")

## Recruitment deviates change to log scale 
srDev=exp(srDev)

# Number of Monte Carlo replicates
nits  =dim(stock.n(om))[6]
# make sure all slots have same number of iterations
object=propagate(iter(om,seq(nits)),nits)

#### Function to run MSE #####################################
source("R/hcrICES.R")

### ICES reference points
refpts=FLPar(c(
  blim    =1500000,
  bpa     =2250000,
  flim    =0.88,
  fpa     =0.53,
  msytrig =2250000,
  fmsy    =0.32,
  bmgtlow =1500000,
  bmgt    =2250000,
  fmgstlow=0.05,
  fmgt    =0.32),units="NA")

### Parameters for HCRs ##########################
#### This is a HCR to project at FMSY
par0=array(c(ftar=refpts["fmsy"],btrig=refpts["msytrig"],fmin=refpts["fmsy"],blim=refpts["blim"]),
           dim=c(4),
           dimnames=list(c("ftar","btrig","fmin","blim")))

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

#### Assessment error
set.seed(3456)
err =rlnorm(nits,FLQuant(0,dimnames=list(year=start:end)),0.3)

#### Reference cases
sims=list("Historical"=list(object,NULL))
## projection for FMSY
sims[["fmsy"]]=list(fwd(om,fbar=FLQuant(1,dimnames=list(year=2001:2018))%=%0.32,
                        sr=eql9,residuals=srDev),
                    NULL)
## projection for F=0.6
sims[["0.6"]]=list(fwd(om,fbar=FLQuant(1,dimnames=list(year=2001:2018))%=%0.6,
                       sr=eql9,residuals=srDev),
                   NULL)

## HCR for FMSY without assessment error
sims[["sim0.0"]]=hcrICES(object,eql9,srDev,
                      par0,
                      start=start,end=end,interval=interval)
## HCR for FMSY with assessment error
sims[["sim0"]]=hcrICES(object,eql9,srDev,
                      par0,
                      start,end,interval,
                      err=err,
                      bndTac=c(0,Inf))
##### HCRs
sims[["sim1"]]=hcrICES(object,eql9,srDev,
                      par1,
                      start,end,interval,
                      err=err,
                      bndTac=c(0,Inf))
sims[["sim2"]]=hcrICES(object,eql9,srDev,
                      par2,
                      start,end,interval,
                      err=err,
                      bndTac=c(0,Inf))
# HCRs with bounds 
sims[["sim0_bnd"]]=hcrICES(object,eql9,srDev,
                      par0,
                      start,end,interval,  
                      err=err,
                      bndTac=c(0.8,1.25))
sims[["sim1_bnd"]]=hcrICES(object,eql9,srDev,
                      par1,
                      start,end,interval,
                      err=err,
                      bndTac=c(0.80,1.25))
sims[["sim2_bnd"]]=hcrICES(object,eql9,srDev,
                      par2,
                      start,end,interval,
                      err=err,
                      bndTac=c(0.80,1.25))

## With perfect short-term projection
sims[["sim1_short-term"]]=hcrICES(object,eql9,srDev,
                                par1,
                                start,end,interval,
                                err=err,
                                bndTac=c(0,Inf),
                                perfect=TRUE)

## With perfect short-term projection
sims[["sim1_perfect"]]=hcrICES(object,eql9,srDev,
                               par1,
                               start,end,interval,
                               bndTac=c(0,Inf),
                               perfect=TRUE)


sims[["sim1_noass"]]=hcrICES(object,eql9,srDev,
                             par1,
                             start,end,interval,
                             err=NULL,
                             bndTac=c(0,Inf))
sims[["sim2_noass"]]=hcrICES(object,eql9,srDev,
                             par2,
                             start,end,interval,
                             err=NULL,
                             bndTac=c(0,Inf))

sims[["sim1_bnd_noass"]]=hcrICES(object,eql9,srDev,
                           par1,
                           start,end,interval,
                           err=NULL,
                           bndTac=c(0.80,1.25))
sims[["sim2_bnd_noass"]]=hcrICES(object,eql9,srDev,
                           par2,
                           start,end,interval,
                           err=NULL,
                           bndTac=c(0.80,1.25))


## With perfect short-term projection
set.seed(3456)
err =rlnoise(nits,FLQuant(0,dimnames=list(year=start:end)),0.3,0.75)

sims[["sim1_ar"]]=hcrICES(object,eql9,srDev,
                                  par1,
                                  start,end,interval,
                                  err=err,
                                  bndTac=c(0,Inf),
                                  perfect=TRUE)

save(sims,refpts, par0, par1, par2, file="data/sims.RData",compress="xz")

### Alternative #################################

alt=fwd(om,ssb_flash=ssb(om1)[,ac(2001:2017)]%=%2.25e6,sr=eql9,deviates=exp(ev),maxF=0.5)
escape=window(alt,end=2017)
save(escape,file=file.path(dirDat,"escape.RData"))



