#!/usr/bin/env bash

user=$(git config --local --get remote.origin.url | sed -e "s/^.*\:\(.*\)\/\(.*\)\.git/\1/")
repo=$(git config --local --get remote.origin.url | sed -e "s/^.*\:\(.*\)\/\(.*\)\.git/\2/")

branch_now=$(git branch --list | grep '*' | awk '{print $2}')
branch_ghpages=gh-pages
dest=dist

# Check branch status
if [ $(git status -s | wc -l) -ne 0 ]
then
  echo "$branch_now is changed. Resolve it before push Github Pages."
  exit 0
fi

# If there is not $dest folder, run `gulp build`
if [ ! -d $dest ]
then
  gulp build
fi

# Check gh-pages beanch exist
if [ $(git branch --list $branch_ghpages) ]
then
  # update commit
  commit_message="Update $branch_ghpages"
  git checkout $branch_ghpages
else
  # initial commit
  commit_message="Initial commit"
  git checkout --orphan $branch_ghpages
  git ls | grep -v gitignore | xargs git rm -rf
fi

# Copy source files
cp -R $dest/ .
rm -rf $dest

# Add content and push
git add .
git commit -m "$commit_message"
git push origin $branch_ghpages
git checkout $branch_now

if [ -n $user -a -n $repo ]
then
  echo ""
  echo "Your site is published at http://$user.github.io/$repo"
fi
