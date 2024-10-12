#!/bin/bash

organization=$GITHUB_ORGANIZATION
token=$GITHUB_TOKEN

response=$(curl -X POST \
  -H "Authorization: token ${token}" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/orgs/"${organization}"/actions/runners/generate-jitconfig \
  -d '{"name":"runner-'"$(date +%s)"'","runner_group_id":1,"labels":["self-hosted","ubuntu-latest"],"work_folder":"_work"}')
  
encoded_jit_config=$(echo "$response" | jq --raw-output '.encoded_jit_config')
  
unset GITHUB_TOKEN

echo 'starting runner'
./run.sh --jitconfig "${encoded_jit_config}" & wait $!

echo 'cleaning _work'
rm -rf _work