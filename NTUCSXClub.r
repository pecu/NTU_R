rm(list=ls(all.names=TRUE))
library(httr)
library(rjson)
library(httpuv)
library(Rfacebook)
token = "EAACEdEose0cBAF3CZBZCl0iTmsdU4Pu0SFtqNmkFsZAxQZCq3S4CKUFiNdnpi4VE6uAdZCN7RLqddTMehDNmwSHTsRVxV5UhytdSRmb34fzAqYvFbmxjdEz6bhSThuiYFKvHZCZCX6gZBdX05ZBf5tQ9Bi463vVOW1ChrPdfE8ZCZAiZAwZDZD"

preText = "https://graph.facebook.com/v2.8/"
fbAPI = "620483011457064/memberslimit=500"
url = paste0(preText, fbAPI)
content <- callAPI(url=url, token=token)
out = matrix(unlist(content(content)))

my <- getUsers("me", token, private_info = TRUE)
my$name
my$hometown
my_like <- getLikes(user="me",token=token)
fix(my_like)

groupName = "NTU CS+X Club"

groupid = searchGroup(groupName, token)
NTUCSX = getGroup(groupid$id[1], token)
write.table(NTUCSX$message, "./post.txt")

pagen = length(NTUCSX$message)

n = 10
url <- paste0('https://graph.facebook.com/', groupid$id[1],
                '/members?limit=', n)
content <- callAPI(url=url, token=token)

for( i in c(5:n) )
{
  accessID = content$data[[i]]$id
  userData = getUsers(accessID, token, private_info = TRUE)
  write.table(userData, "./members.txt", append=T, col.names=T)
}

