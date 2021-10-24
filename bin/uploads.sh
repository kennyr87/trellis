#!/usr/bin/env bash

# Enable xtrace if the DEBUG environment variable is set
if [[ ${DEBUG-} =~ ^1|yes|true$ ]]; then
    set -o xtrace       # Trace the execution of the script (debug)
fi

# Enable some options
set -o errexit          # Exit on most errors (see the manual)
set -o errtrace         # Make sure any error trap is inherited
set -o nounset          # Disallow expansion of unset variables
set -o pipefail         # Use last non-zero exit code in a pipeline

ENVIRONMENTS=( hosts/* )
ENVIRONMENTS=( "${ENVIRONMENTS[@]##*/}" )

show_usage() {
  echo -e "Usage: uploads <environment> <mode> <site name> [options]

<environment> is the environment to deploy to ("staging", "production", etc)\n
Available <mode> options for uploads task: push, pull\n
<site name> is the WordPress site to deploy (name defined in "wordpress_sites")\n
[options] is any number of parameters that will be passed to ansible-playbook

Available environments:
`( IFS=$'\n'; echo "${ENVIRONMENTS[*]}" )`

Examples:
  uploads staging example.com push -vv -T 60
"
}

[[ $# -lt 3 ]] && { show_usage; exit 127; }

ENV="$1"; shift
MODE="$1"; shift
SITE="$1"; shift
EXTRA_PARAMS=$@
DEPLOY_CMD="ansible-playbook deploy.yml -e env=$ENV -e mode=$MODE -e site=$SITE $EXTRA_PARAMS --tags uploads"
HOSTS_FILE="hosts/$ENV"

if [[ ! -e $HOSTS_FILE ]]; then
  echo "Error: $ENV is not a valid environment ($HOSTS_FILE does not exist)."
  echo
  echo "Available environments:"
  ( IFS=$'\n'; echo "${ENVIRONMENTS[*]}" )
  exit 1
fi

$DEPLOY_CMD
