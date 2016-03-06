# Location aliases
alias workingCopies='cd ${WORKINGCOPIES}'
alias code='cd ${CODE}'
alias github='cd ${GITHUB}'
alias gitlab='cd ${GITLAB}'

alias chef-roles='cd ${CHEF_ROLES}'
alias chef-environments='cd ${CHEF_ENVIRONMENTS}'
alias chef-handlers='cd ${CHEF_HANDLERS}'

# alias chef-data-bags='cd ~/workingCopies/code/gitlab/chef-data-bags'
function chef-data-bags (){
  cd ${CHEF_DATA_BAGS}/$1
}
alias chef-data-bags=chef-data-bags

#alias chef-cookbooks='cd ~/workingCopies/code/gitlab/chef-cookbooks'
function chef-cookbooks (){
  cd ${CHEF_COOKBOOKS}/$1
}
alias chef-cookbooks=chef-cookbooks

#alias dockerfiles='cd ~/workingCopies/code/gitlab/dockerfiles'
function dockerfiles (){
  cd ${DOCKERFILES}/$1
}
alias dockerfiles=dockerfiles

# Vim aliases
alias vim-geeknote='vi -c Geeknote'
alias geeknote-vim='vi -c Geeknote'

# Json aliases
function json-diff () {
  opts=$(echo $@ | grep -Po '(( |^)-\w+)+' | tr '\n' ' ')
#  while getopts {a..z} opt; do :; done
#  shift $(($OPTIND-1))
  for o in $opts; do shift; done
  section=$3
  if [ -z $section ]; then
    section='.'
  fi
  colordiff $opts <(cat ${1} | jq -S "$section") <(cat ${2} | jq -S "$section")
}
alias json-diff=json-diff

function json-merge (){
  jq -s '.[0] * .[1]' $1 $2
}
alias json-merge=json-merge

alias json-prettify-all='for f in *.json; do cat ${f} | jq -S . > ${f}.fixed; mv ${f}.fixed ${f}; done'

# Git aliases
function git-pull-all (){
  cdir=$(pwd)
  if [ ! -z $1 ]; then
    cd $1
  fi
  for d in $(ls -d */); do echo $d; cd $d; git pull; cd ..; done
  cd $cdir
}
alias git-pull-all=git-pull-all

function git-status (){
  UNCOMMITED=$(git status -s)
  LOCAL=$(git rev-parse @)
  REMOTE=$(git rev-parse @{u})
  BASE=$(git merge-base @ @{u})

  if [ "$UNCOMMITED" != "" ]; then
    echo "Need to commit"
  elif [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date"
  elif [ $LOCAL = $BASE ]; then
    echo "Need to pull"
  elif [ $REMOTE = $BASE ]; then
    echo "Need to push"
  else
    echo "Diverged"
  fi
}
alias git-status=git-status
alias git-info='git remote show origin'
alias git-status-sb='git status -sb'
alias git-logbranches='git for-each-ref --sort=-committerdate refs/heads/ --format="%(color:red)%(refname:short)%(color:reset)   %(subject)"'
alias git-unpushed-commits='git for-each-ref --format="%(push:track)" refs/heads'
alias git-prune-branches='git remote prune origin'
alias git-prune-merged='git branch -r --merged | grep -v master | sed '\''s/origin\///'\'' | xargs -n 1 git push --delete origin'
alias git-purge-branches='git fetch --all -p; git branch -vv | grep "\[.*: gone\]" | awk '\''{ print $1 }'\'' | xargs -n 1 git branch -d'
alias git-current-tag='git name-rev --tags --name-only $(git rev-parse HEAD)'

function git-compare () {
  git rev-list --left-right --count $1...$2
}
alias git-compare=git-compare

function git-branch-status (){
  git for-each-ref --format="%(refname:short) %(upstream:short)" refs/heads | \
  while read local remote
  do
    [ -z "$remote" ] && continue
    git rev-list --left-right ${local}...${remote} -- 2>/dev/null >/tmp/git_upstream_status_delta || continue
    LEFT_AHEAD=$(grep -c '^<' /tmp/git_upstream_status_delta)
    RIGHT_AHEAD=$(grep -c '^>' /tmp/git_upstream_status_delta)
    echo "$local (ahead $LEFT_AHEAD) | (behind $RIGHT_AHEAD) $remote"
  done
}
alias git-branch-status=git-branch-status

#Knife and chef aliases
function chef-env-list-versions () {
  cdir=$(pwd)
  chef-environments
  grep -P '".*":\s*"= .*"' * | tr -s " " | tr -d ','| cut -d ':' -f2,3 | sort -u
  cd $cdir
}
alias chef-env-list-versions=chef-env-list-versions

# Compares tow environments in terms of pinned cookbook versions
# Usage: chef-env-compare-versions env-a env-b
function chef-env-compare-versions () {
  cdir=$(pwd)
  chef-environments
  json-diff -y ${1}.json ${2}.json ".cookbook_versions"
  cd $cdir
}
alias chef-env-compare-versions=chef-env-compare-versions

# Promotes a specific version of a cookbook to all environments that have a version of that cookbok pinned to a different version
# Usage: chef-promot-all <cookbook> <version>
function chef-promote-all () {
  cdir=$(pwd)
  chef-environments
  grep $1 * | grep -v "= $2" | cut -d'.' -f1 | xargs -n1 -I{} knife spork promote {} $1 -v $2 --remote --yes
  cd $cdir
}
alias chef-promote-all=chef-promote-all

# Promotes a specific version of a cookbook to all environments that have a version of that cookbok pinned to an older version
# Usage: chef-promot-lt <cookbook> <version>
function chef-promote-lt () {
  cdir=$(pwd)
  chef-environments
  for environment in $(grep -P '".*":\s*"= .*"' * | grep $1 | tr -d ' '| grep -v "$2"); do
    version=$(echo $environment | cut -d \" -f4 | tr -d '=')
    environment=$(echo $environment | cut -d \. -f1)
    if [ "$version" = "$(echo -e "$version\n$2" | sort -V | head -n1)" ]; then
      echo "Promoting $1 from $version to $2 on $environment"
      knife spork promote $environment $1 -v $2 --remote --yes
    fi
  done
  cd $cdir
}
alias chef-promote-lt=chef-promote-lt

function knife-ciphertext () {
  sed -e "s/knife\[\:secret_file\]/\#knife\[\:secret_file\]/" -i.bak ~/.chef/knife.rb
  knife $@ --format=json
  mv ~/.chef/knife.rb.bak ~/.chef/knife.rb
}
alias knife-ciphertext=knife-ciphertext

# Docker aliases
alias docker-killall='docker kill $(docker ps -a -q)'
alias docker-rm-all='docker rm $(docker ps -a -q)'
alias docker-rmi-all='docker rmi $(docker images -q)'
alias docker-cleanup='docker-killall; docker-rm-all; docker-rmi-all'

# apt aliases
alias dist-upgrade='sudo aptitude update ; sudo aptitude dist-upgrade'

function apt-cleanup () {
ls /boot/ | grep vmlinuz | sed 's@vmlinuz-@linux-image-@g' | grep -v $(uname -r) | sort -Vr | tail -n +2 | xargs -r sudo aptitude purge -y
sudo aptitude autoclean
sudo apt-get autoremove
sudo apt-get clean
dpkg --list | grep "^rc" | cut -d " " -f 3 | xargs -r sudo dpkg --purge
}
alias apt-cleanup=apt-cleanup

