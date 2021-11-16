## Git Help
https://www.nobledesktop.com/learn/git/git-branches
https://jigarius.com/blog/multiple-git-remote-repositories

Working with multiple repositories
### Github
```
# List all remotes
git remote -v
# Add remote
git remote add origin git@github.com:brain-os/brain-proto.git
# Configure branch to point to origin
git fetch
git branch -u origin/main
git branch -u origin/k8s
# remove origin
git remote remove origin
```
### Jio
```
# List all remotes
git remote -v
# Add remote
git remote add origin https://devops.jio.com/AICOE/BrainOS/_git/brain-proto
git config http.sslVerify false

# Configure branch to point to origin
git pull
git branch -u origin/main
# remove origin
git remote remove origin
```

```
git remote add origin git@github.com:brain-os/brain-ui.git
git remote add origin https://devops.jio.com/AICOE/BrainOS/_git/brain-ui
git remote add origin https://devops.jio.com/AICOE/BrainOS/_git/brain-proto
git remote remove origin
git config http.sslVerify false
git branch -u origin/main
```