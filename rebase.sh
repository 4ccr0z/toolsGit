if [ $# -eq 0 ]
  then
    branchrebase="master"
else
  branchrebase=$1
fi
branch=$(git rev-parse --abbrev-ref HEAD)
git checkout -b temp
git merge $branchrebase
while [ $(git diff --name-only --diff-filter=U | wc -l) != "0" ]; do
    read  -n 1 -p "il y'a des conflits" mainmenuinput
done
git merge --continue
git checkout $branch
git rebase $branchrebase
while [ $(git diff --name-only --diff-filter=U | wc -l) != "0" ]; do
  git diff --name-only --diff-filter=U | xargs git checkout $branchrebase
  git add .
  git rebase --continue
done;
git merge --ff $(git commit-tree temp^{tree} -m "Fix after rebase" -p HEAD)
git branch -D temp