#import vim
import praw
import urllib.request

# we define a timeout that we'll use in the API call. We don't want
# users to wait much.
TIMEOUT = 20
URL = "https://reddit.com/.json"

reddit = praw.Reddit(client_id='p40lUximMvKa8Q',
                     client_secret='NjnqGFpasVZdUaLRLEf_9WMGgpU',
                     user_agent='personal use script')

for submission in reddit.front.hot(limit=10):
    print('score: %s'%submission.score)
    print('title: %s [%s]'%(submission.title, submission.url))
    print('comments: %s'%(len(submission.comments)))
    print(80*"-"), submission.url))
