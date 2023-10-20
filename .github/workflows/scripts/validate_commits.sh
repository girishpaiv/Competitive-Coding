#!/bin/bash

PR_BASE_BRANCH_COMMIT=$1
PR_LAST_COMMIT=$2

commits=$(git log --no-merges --format=%B $PR_BASE_BRANCH_COMMIT..$PR_LAST_COMMIT)

echo "PR has ${#commits[@]} commit(s)"

pass=1
failed_commmit_titles=()
failed_commmit_error=()
for commit in "$commits"; do
  printf "Handling commit: \n$commit\n"

  title=$(echo "$commit" | awk 'NR==1{print; exit}')

  if ! echo "$commit" | grep -qE '^(FEAT|IMPR|BUG|DEPLOY)\((SIG|HYC)-[0-9]{4,5}\): .'; then
    echo "Commit title format is incorrect!"
    failed_commit_titles+=($title)
    failed_commmit_error+=("Incorrect title format")
    pass=0
  fi
  
  if ! echo "$commit" | grep -qE '^.{1,71}$'; then
    echo "Commit title must be at max 72 characters"
    failed_commit_titles+=($title)
    failed_commmit_error+=("Incorrect length of title (Max 72 characters)")
    pass=0
  fi

  # If a 2nd line exist in commit message, confirm it is a blank line
  if ! echo "$commit" | awk 'NR==2 { exit ($0 != "" ? 1 : 0) }'; then
    echo "Commit message must have a blank like between title and body"
    failed_commit_titles+=($title)
    failed_commmit_error+=("Second line is not blank")
    pass=0
  fi

  # If a body exist, ensure it is wrapped in 72 characters
  body=$(echo "$commit" | sed -n '3,$p')
  if [ ! -z "$body" ]; then
    echo "$body" | while IFS= read -r line; do
      if ! [ ${#line} -lt 72 ]; then
        echo "Body is not wrapped at 72 characters: $line"
        failed_commit_titles+=($title)
        failed_commmit_error+=("Body is not wrapped at 72 characters")
        pass=0
        break;
      fi
    done
  fi
done

if [ "$pass" -eq 1 ]; then
  printf "\nPASS!!!\n"
else
  printf "Failed! Commits with errors:\n"
  length=${#failed_commit_titles[@]}
  for ((i=0; i<$length; i++)); do
    echo "${failed_commit_titles[$i]} ${failed_commmit_error[$i]}"
  done
  exit 1
fi