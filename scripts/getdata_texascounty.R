# Get data from google mobility pdfs (prob have better ways to get this...)
# 4/7/2019

library(XML) # HTML processing
library(pdftools)
library(stringr)

options(stringsAsFactors = FALSE)

setwd("~/gitlocal/covid_mobility_map/")

# Base URL
base.url = 'http://www.educationcounts.govt.nz/find-a-school/school/national?school='
download.folder = '~/Downloads/schools/'

st <- read.table("data/states.txt")

urls <- sprintf("https://www.gstatic.com/covid19/mobility/2020-03-29_US_%s_Mobility_Report_en.pdf", st$V1)

tx_url <- urls[grep("Texas", urls)]

txt <- textreadr::read_pdf(tx_url)

cnames <- NA
for(i in 3:length(txt$text)){
  pg <- strsplit(txt$text[i], split="\n") # for each page after 2nd page
  i_count <- grep("County", pg[[1]]) # grep countyu
  cnames <- append(cnames, pg[[1]][i_count])
}
cnames <- cnames[2:length(cnames)]

# make data frame
df <- data.frame(county=cnames, 
                 retail=NA, 
                 grocery=NA,
                 parks=NA,
                 transit=NA,
                 workplace=NA,
                 residence=NA)

ii <- 1
for(i in 3:length(txt$text)){
  pg <- strsplit(txt$text[[i]], "\n")
  plottitles <- strsplit(pg[[1]][grepl("compare|enough", pg[[1]])], "           ")
  plottitles <- plottitles[1:4] # remove last line
  nums <- sapply(plottitles, function(x){gsub("[^0-9\\+\\-]", "", x)})
  
  df[ii,2:ncol(df)] <- c(nums[,1], nums[,2])
  ii <- ii+1
  df[ii,2:ncol(df)] <- c(nums[,3], nums[,4])
  ii <- ii+1
}



# for(i in 1:)){
# 
#   txt <- pdf_text(urls[i]) # state pdf
#   
#   pg1 <- strsplit(txt[1], split = "\n")
#   pg2 <- strsplit(txt[2], split = "\n")
#   
#   p1 <- pg1[[1]][sapply(pg1, nchar) < 6]
#   p2 <- pg2[[1]][sapply(pg2, nchar) < 6]
#   
#   df[i,2:4] <- p1[c(1,2,4)]
#   df[i,5:7] <- p2
# }

write.csv(df, "./data/state_mobility_google_map_3_29.csv", row.names = F)
