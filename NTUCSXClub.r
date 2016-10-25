rm(list=ls(all.names=TRUE))
library(httr)
library(rjson)
library(httpuv)
library(Rfacebook)
token = "EAACEdEose0cBANhbD2girb1qtZCRbybx1t9BNDHCAZCZCD1q0HdVcN63vFPe9s2azvEHtJNsXzh5GyLqdiuLfsP9ztElxiZC19RzxBAS2RocySz3kGCYgbfxtkdjQFKPVbUJ1qMuwRwJHURVLtWQo9tZAKuJVhdJtk0RmcmZAUVwZDZD"

"curl -i -X GET \
https://graph.facebook.com/v2.8/620483011457064/members?access_token=EAACEdEose0cBANhbD2girb1qtZCRbybx1t9BNDHCAZCZCD1q0HdVcN63vFPe9s2azvEHtJNsXzh5GyLqdiuLfsP9ztElxiZC19RzxBAS2RocySz3kGCYgbfxtkdjQFKPVbUJ1qMuwRwJHURVLtWQo9tZAKuJVhdJtk0RmcmZAUVwZDZD"

preText = "https://graph.facebook.com/v2.8/"
fbAPI = "me?fields=name,age_range,about,currency&access_token="
url = paste0(preText, fbAPI, token)
res = GET(url)
out = matrix(unlist(content(res)))

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

