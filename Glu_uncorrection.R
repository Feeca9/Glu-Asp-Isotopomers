setwd('C:/Data2/R')
library(readxl); library(xlsx); library(glmnet);
#read uncorrected matrix of Asp
asp_uncor<- read_excel("Input Matrices Glu Asp.xlsx", 
                       sheet = "Asp No Correction", range = "B2:Q53", 
                       col_names = FALSE)
asp_uncor <- as.matrix(asp_uncor)
#read data of Asp
rawdata<- read_excel("Input Data Glu Asp.xlsx", 
                     sheet = "H460 Data", range = "M99:M150", col_names = FALSE)
View(rawdata)
rawdata <- as.matrix(rawdata)
# number of samples in input file
nt=1
result <- matrix(nrow=16, ncol=nt, 0)
for(i in 1:ncol(rawdata)) {
  Asp <- rawdata[,c(i)] 
  calasp.iso <-coef(glmnet(asp_uncor, Asp, lambda = 0, lower.limits = 0, intercept = FALSE,thresh = 1e-31,upper.limits = 1))[-1]
  
  temp_res<-calasp.iso
  result[,i]<-temp_res
  
}
write.xlsx(
  result,
  "AspUncorrection.xlsx",
  sheetName = "Sheet1",
  col.names = TRUE,  row.names = TRUE, append =FALSE)
