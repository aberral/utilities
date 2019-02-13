# How to upload things to GitHub:
#  1) Save the script, select it in the Git tab (right).
#  2) Click commit, enter a identifuing message in Commit message. (Maybe branches)
#  3) Push it to Github. Tools > Shell
#    |-- git remote add origin https://github.com/aberral/'nombre del repo'.git
#        git config remote.origin.url git@github.com:aberral/'nombre del repo'.git
#        git pull -u origin master
#        git push -u origin master