rm(list=ls(all.names=TRUE))
library(httr)
library(rjson)
library(httpuv)
library(Rfacebook)

prefex = "https://graph.facebook.com/v2.8/"
token  = "EAACEdEose0cBAPYOmYppkkWmWPECgHCSIizknNaks92dSzLUttiMA2j4gKUHBuYl0O7OmLZBBp5XyIIQNnp4BbYJUZCYN01I1ZCa4TkpGfo68xFAsV45VZBdiRbTOsvdTq2eGLJC3AKMdcVLbm1j5Psy578PJ7v9E3B4ZBxxOMAZDZD"

# ================================================
number = 2
attrs  = paste0("me/groups?limit=", 
                number, "&access_token=")

url    = paste0(prefex, attrs, token)
res    = GET(url)
data   = content(res)
groups = matrix(unlist(data$data))
after  = data$paging$cursors$after
nextflg= data$paging[2]
  
while( nextflg != "" )
{
  nexturl= paste0(url, "&after=", after)
  nextres= GET(nexturl)
  ndata  = content(nextres)
  ngroups= matrix(unlist(ndata$data))
  after  = ndata$paging$cursors$after
  nextflg= data$paging[2]
}
