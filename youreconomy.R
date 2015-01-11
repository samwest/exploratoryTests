library(RCurl)
library(XML)

theurl <- "http://en.wikipedia.org/wiki/Brazil_national_football_team"
theurl <- "http://www.youreconomy.org/?year1=2012&year2=2013&state=MI&msa=90001&county=&custom=undefined"
webpage <- getURL(theurl)
webpage <- readLines(tc <- textConnection(webpage)); close(tc)

pagetree <- htmlTreeParse(webpage, error=function(...){}, useInternalNodes = TRUE)


#8th piece of this 
#foo=xpathSApply(pagetree,"//script[@type = 'text/javascript']", xmlValue)

bar=strsplit(foo,"Data\n\t") # not the best split but it will split it so that the title is shortly after the beginning



# Extract table header and contents
tablehead <- xpathSApply(pagetree, "//*/table[@class='wikitable sortable']/tr/th", xmlValue)
results <- xpathSApply(pagetree, "//*/table[@class='wikitable sortable']/tr/td", xmlValue)

# Convert character vector to dataframe
content <- as.data.frame(matrix(results, ncol = 8, byrow = TRUE))

# Clean up the results
content[,1] <- gsub("Â ", "", content[,1])
tablehead <- gsub("Â ", "", tablehead)
names(content) <- tablehead