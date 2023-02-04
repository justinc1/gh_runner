#!/bin/bash

set -eu
set -x

# ubuntu:22.04 - is missing libssl1.1 (has libssl3 only)
# docker run -it --name ghr -w /code -v $PWD:/code  ubuntu:22.04 bash

GITHUB_ORG=ScaleComputing
GITHUB_REPO=HyperCoreAnsibleCollection
GITHUB_RUNNER_IND=1
# RUNNER_RUNNER_LABELS=self-hosted,Linux,X64
GITHUB_RUNNER_LABELS=temp-runner,Linux,X64
echo GITHUB_PERSONAL_TOKEN=$(echo $GITHUB_PERSONAL_TOKEN | head -c8)...

#mkdir /opt/ghr-$GITHUB_RUNNER_IND
cd /opt/ghr-$GITHUB_RUNNER_IND
#apt update
#apt install -y curl libssl3 jq
#curl -o actions-runner-linux-x64-2.301.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.301.1/actions-runner-linux-x64-2.301.1.tar.gz
## echo "3ee9c3b83de642f919912e0594ee2601835518827da785d034c1163f8efdf907  actions-runner-linux-x64-2.301.1.tar.gz" | shasum -a 256 -c
#tar xzf ./actions-runner-linux-x64-2.301.1.tar.gz

#./bin/installdependencies.sh

# RUNNER_ALLOW_RUNASROOT=1  # non-empty value -> 0 is same as 1

# https://docs.github.com/en/rest/actions/self-hosted-runners?apiVersion=2022-11-28#create-a-registration-token-for-a-repository
# reg_url=https://api.github.com/orgs/$GITHUB_ORG/actions/runners/registration-token
# reg_url=https://api.github.com/repos/$GITHUB_ORG/$GITHUB_REPO/actions/runners/registration-token
# reg_token=$(curl -sS -X POST -H "Authorization: Bearer $GITHUB_PERSONAL_TOKEN" $reg_url | jq -r .token)
reg_token=$GITHUB_PERSONAL_TOKEN

# RUNNER_ALLOW_RUNASROOT=1 ./config.sh --url https://github.com/ScaleComputing/HyperCoreAnsibleCollection --token $TOKEN
# RUNNER_ALLOW_RUNASROOT=1 ./run.sh
RUNNER_ALLOW_RUNASROOT=1 ./config.sh --unattended --url https://github.com/$GITHUB_ORG/$GITHUB_REPO --name gh-runner-$GITHUB_RUNNER_IND --labels $GITHUB_RUNNER_LABELS --token $reg_token
# RUNNER_ALLOW_RUNASROOT=1 ./run.sh

RUNNER_ALLOW_RUNASROOT=1 ./config.sh remove --token $reg_token
