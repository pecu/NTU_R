rm(list=ls(all.names=TRUE))
library(XML)
library(RCurl)
library(httr)
Sys.setlocale(category = "LC_ALL", locale = "cht")
startNo = 4637
endNo   = 4641 
subPath <- "https://www.ptt.cc/bbs/movie/index"
for( pid in startNo:endNo )
{
  urlPath <- paste(subPath, pid, ".html", sep='')
  temp    <- getURL(urlPath, encoding = "big5")
  xmldoc  <- htmlParse(temp)
  title   <- xpathSApply(xmldoc, "//div[@class=\"title\"]", xmlValue)
  title   <- gsub("\n", "", title)
  title   <- gsub("\t", "", title)
  skipid  <- grep("(本文已被刪除)", title)
  if( length(skipid) != 0 )
  {
    title   <- title[-skipid]
  }
  path    <- xpathSApply(xmldoc, "//div[@class='title']/a//@href")
  alldata <- data.frame(title, path)
  write.table(alldata, file = "movie.csv")
}
suburlPath <- "https://www.ptt.cc"
for( i in 1:length(alldata[,1]) )
{
  ipath   <- paste(suburlPath, path[i], sep='')
  content <- getURL(ipath, encoding = "big5")
  xmldoc  <- htmlParse(content)
  article <- xpathSApply(xmldoc, "//div[@id=\"main-content\"]", xmlValue)
  filename<- paste("./data/", i, ".csv", sep='')
  write.csv(article, filename)
}