#!/bin/bash
#1 $1 = group git
#2 $2 = token gitlab
DOMAIN=gitlab.forgapp.com
URL=https://$DOMAIN
JQ_PATH=/C/softs/jq
for repo in $(curl -s --header "PRIVATE-TOKEN: $2" $URL/api/v4/groups/$1 | $JQ_PATH -r ".projects[].path_with_namespace"); do
  git clone "https://$2@$DOMAIN$repo";
done;
