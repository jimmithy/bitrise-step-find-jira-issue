#!/bin/bash
set -o pipefail

echo "Extracting JIRA Issue number from: '${FIND_ISSUE_INPUT}'"

# Identify Jira Issue, if multiple use | as delimiter
JIRA_ISSUE="$(echo "${FIND_ISSUE_INPUT}" | egrep -o '[a-zA-Z]+-[0-9]+' | sort -uf | tr '\n' '|' | sed 's/.$//')"

# If no issue, abort
if [ -z "${JIRA_ISSUE}" ]; then
    echo "Failure: Input doesn't contain JIRA issue"
    exit -1
fi

# Set as enviornment variable
if command -v envman 2>/dev/null; then
    echo "Adding \"${JIRA_ISSUE}\" to env. vars"
    envman add --key JIRA_ISSUE --value "${JIRA_ISSUE}"
fi
