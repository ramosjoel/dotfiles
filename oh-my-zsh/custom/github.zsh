#!/bin/bash

# List PRs for an author.
#
# Default to ME! But... might wanna find
# another person's PRs on occasion.
#
# @param author (string): - PR author's GitHub handle
function prs() {
  author=${1:-ramosjoel}
  gh pr list -A $author
}
