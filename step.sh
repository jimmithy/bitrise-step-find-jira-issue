#!/bin/bash
set -o pipefail

echo "Extracting JIRA Issue number from: '${find_issue_content}'"

# Identify Jira Issue, if multiple use | as delimiter
JIRA_ISSUE_LIST="$(echo "${find_issue_content}" | egrep -o '[a-zA-Z0-9]+-[0-9]+' | sort -uf | tr '\n' '|' | sed 's/.$//')"

# If no issue, abort
if [ -z "${JIRA_ISSUE_LIST}" ]; then
    echo "Failure: Input doesn't contain JIRA issue"
    exit -1
fi

# Set as enviornment variable
if command -v envman 2>/dev/null; then
    echo "Adding \"${JIRA_ISSUE_LIST}\" to env. vars"
    envman add --key JIRA_ISSUE_LIST --value "${JIRA_ISSUE_LIST}"
fi
