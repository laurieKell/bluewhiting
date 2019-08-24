lFig   <-"Time series estimates of catch, recruitment, spawning stock biomass and fishing mortality from the 2018 stock assessment; shown with median with 10th, 33th, 66th and 90th percentiles."
lFig[2]<-"Stock mass, catch mass, maturity, natural mortality and selection pattern at-age"
lFig[3]<-"Stock mass, catch mass, maturity, natural mortality and selection pattern at-age"
lFig[4]<-"Relative stock numbers-at-age, i.e. numbers at an age scaled by mean numbers"
lFig[5]<-"Relative  catch numbers-at-age, i.e. numbers at an age scaled by mean numbers"
lFig[6]<-"Plot of relative spawning recruitment potential (bubbles) and recruitment (line)." 
lFig[7]<-"Cross correlations between SSB and recruitment at age 1, a positive lag of 1 would indicate the presence of a stock recruitment relationship, while a negative lag indicates that SSB is determined by past recruitment"
lFig[8]<-"Cross correlations between exploitable biomass and recruitment at age 1, a positive lag of 1 would indicate the prescence of a stock recruitment relationship, while a negative lag indicates that SSB is determined by past recruitment"
lFig[9]<-"Estimates of SSB and recruitment with fitted segmented regression stock recruitment relationship"
lFig[10]<-"Estimates of SSB and recruitment with fitted Beverton and Holt stock recruitment relationship."
lFig[11]<-"Estimates of SSB and recruitment with fitted Beverton and Holt stock recruitment relationship with a fixed steepness of 0.9"
lFig[12]<-"Recruitment deviates for Beverton and Holt stock recruitment relationship, with regimes estimated by STARS algorithm showing changes in mean and variance."
lFig[13]<-"Recruitment deviates for segmented regression stock recruitment relationship, with regimes estimated by STARS algorithm showing changes in mean and variance."
lFig[14]<-"Recruitment deviates for Beverton and Holt stock recruitment relationship with steepness fixed at 0.9, with regimes estimated by STARS algorithm showing changes in mean and variance."
lFig[15]<-"Autocorrelation in recruitment deviates."
lFig[16]<-"An example of simulated recruitment deviates with autocorrelation."
lFig[17]<-"Biological reference points based on the Beverton and Holt stock recruitment relationship."
lFig[18]<-"Biological reference points based on the fitted segmented regression stock recruitment relationship."
lFig[19]<-"Biological reference points based on the Beverton and Holt stock recruitment relationship with steepness fixed at 0.9."
lFig[20]<-"F0.1 reference point calculated with a five year moving window"
lFig[21]<-"Retrospective estimates of time series of catch, recruitment, spawning stock biomass and fishing mortality from the 2018 stock assessment."
lFig[22]<-"Assessment error in SSB and F derived from the retrospective runs."

lFig[23]<-"Comparison between historical assessment estimates, and a single Monte Carlo realisation for a projection at Fmsy, and HCR1 without assessment error."

lFig[24]<-"HCR with and without assessment error compared to historical estimates; with median and 10 and 90 percentiles, the hatched line is a single Monte Carlo realisation."

lFig[25]<-"Comparison between HCR I & II with assessment error; shown with median and 10 and 90 percentiles, the hatched line is a single Monte Carlo realisation."

lFig[26]<-"Comparison between HCR I without and with bounds; shown with median and 10 and 90 percentiles, the hatched line is a single Monte Carlo realisation."
lFig[27]<-"Comparison between HCR II without and with bounds; shown with median and 10 and 90 percentiles, the hatched line is a single Monte Carlo realisation."

lFig[28]<-"Summary of HCR performance."

lFig[29]<-"Values of F for assessed SSB from the HCR, as a check that the HCR is working as expected"

lFig[30]<-"Plot of F v SSB for HCR I without assessment error."
lFig[31]<-"Plot of F v SSB for HCR I."
lFig[32]<-"Plot of F v SSB for HCR II."

lFig[33]<-"HCR I plot of F v SSB for 2012 with marginal densities"
lFig[34]<-"HCR II plot of F v SSB for 2012 with marginal densities"

lFig[35]<-"Catch summary, total catch and AAV by iteration over simulated period"
lFig[36]<-"Mean Interannual Annual Absolute Variation over time series by iteration."
lFig[37]<-"The percentage by year when the stability mechanism was applied."
lFig[38]<-"Probability that SSB falls below Bpa"
lFig[39]<-"Probability that SSBa falls below BLim."

lFig[40]<-"Simulation of HCR I for a single Monte Carlo run without assessment error with and without bounds. The horizontal line shows the Bpa level and the vertical line the year when the bounds are turned off."
lFig[40]<-"Annual change in catch and SSB from simulation of HCR I for a single Monte Carlo run without assessment error with and without bounds. The horizontal line shows the Bpa level and the vertical line the year when the bounds are turned off."
lFig[41]<-"Comparison of historical stock trends and an escapement harvesting strategy (take all biomass>Bpa) and an F cap of 0.6"

eFig=c("Blue whiting SSB as estimated by the last 18 assessments of the stock (conducted in 1999-2015, plus IBPBLW 2016). Time series include forecasted values for y+1 (except for IBPBLW). Prior to 2006 SSB was not estimated for Jan 1. Dotted line = forecasted SSB values from each assessment (i.e. what advice was based on); Red line = IBPLW_2016 assessment (i.e. current 'best' estimate; ICES, 2016a).",
       "From Skagen (2012), who evaluated a two tier HCR and found it to be precautionary with roughly these parameters: Trigger B1 = 4 Mt, Trigger B2 = 5 Mt and Upper bound F = 0.12 or TAC of about 500 thousand tonnes.",
       "Default ICES HCR",
       "Alternative HCRs evaluated as part of MSE of long term management plans in 2016 (WKBMS 2016).")

lFig=c(eFig,lFig)