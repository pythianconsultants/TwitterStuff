library(ROAuth)
library(twitteR)
requestURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumerKey <- "NvKdKGJffu1CWxSj2w0QBZCCL"
consumerSecret <- "1GoxZ4f1LMdCl4SRVdY8DFOsHsTB2NetpK1Jl1ucGQzcnBltK0"

my_oauth <- OAuthFactory$new(consumerKey = consumerKey, consumerSecret = consumerSecret, 
                             requestURL = requestURL, accessURL = accessURL, authURL = authURL)
my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
save(my_oauth, file = "my_oauth.Rdata")


library(streamR)

load("my_oauth.Rdata")
filterStream("tweets.json", track = c("euro2016"), timeout = 21600, 
             oauth = my_oauth)



tweets.df <- parseTweets("tweets.json", simplify = TRUE)


searchword <- "dhaka"
tweets <- searchTwitter(searchword, n=100000)
vccvdf <- twListToDF(tweets)

