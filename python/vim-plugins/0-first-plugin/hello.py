# the vim module contains everything we need to interface with vim from
# python. We need urllib2 for the web service consumer.
import vim, praw

try:
    reddit = praw.Reddit(client_id='p40lUximMvKa8Q',
                         client_secret='NjnqGFpasVZdUaLRLEf_9WMGgpU',
                         user_agent='personal use script')

    # vim.current.buffer is the current buffer. It's list-like object.
    # each line is an item in the list. We can loop through them delete
    # them, alter them etc.
    # Here we delete all lines in the current buffer
    del vim.current.buffer[:]

    # Here we append some lines above. Aesthetics.
    vim.current.buffer[0] = 80*"-"
    hottest=reddit.front.hot(limit=10)
    for submission in hottest:
        vim.current.buffer.append('score: %s'%submission.score)
        vim.current.buffer.append('   %s [%s]'%(submission.title, submission.url))
        vim.current.buffer.append('comments: %s [%s]'%(len(submission.comments), submission.shortlink))
        vim.current.buffer.append(80*"-")

except Exception as e:
  print(e)
