# Get data from google mobility pdfs (prob have better ways to get this...)
# 4/6/2019

library(XML) # HTML processing
library(pdftools)

options(stringsAsFactors = FALSE)

setwd("~/gitlocal/covid_mobility_map/")

# Base URL
base.url = 'http://www.educationcounts.govt.nz/find-a-school/school/national?school='
download.folder = '~/Downloads/schools/'

st <- read.table("data/states.txt")

urls <- sprintf("https://www.gstatic.com/covid19/mobility/2020-03-29_US_%s_Mobility_Report_en.pdf", st$V1)

# make data frame
df <- data.frame(states=st$V1, 
                 retail=NA, 
                 grocery=NA,
                 parks=NA,
                 transit=NA,
                 workplace=NA,
                 residence=NA)

for(i in 1:length(st$V1)){

  txt <- pdf_text(urls[i]) # state pdf
  
  pg1 <- strsplit(txt[1], split = "\n")
  pg2 <- strsplit(txt[2], split = "\n")
  
  p1 <- pg1[[1]][sapply(pg1, nchar) < 6]
  p2 <- pg2[[1]][sapply(pg2, nchar) < 6]
  
  df[i,2:4] <- p1[c(1,2,4)]
  df[i,5:7] <- p2
}

write.csv(df, "./data/state_mobility_google_map_3_29.csv", row.names = F)
