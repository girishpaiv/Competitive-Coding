#!/bin/bash

# Range of commits to verify
commits_range="$1..$2"

# Get commit SHAs within the range
commit_shas=$(git log --no-merges --format="%H" $commits_range)

declare -a commit_msgs

pass=1
failed_commmits=()
failed_commmits_errors=()
for sha in $commit_shas; do
  
  commit_msg=$(git log --format="%B" -n 1 $sha)  # Fetch the commit message for the current SHA
  title=$(echo "$commit_msg" | awk 'NR==1{print; exit}')
  printf "\nChecking commit $sha:\n$commit_msg\n"

  if ! echo "$commit_msg" | grep -qE '^(FEAT|IMPR|BUG|DEPLOY)\((SIG|HYC)-[0-9]{4,5}\): .'; then
    failed_commits+=("$sha: $title")
    failed_commmits_errors+=("Incorrect title format")
    pass=0
  fi
  
  if ! echo "$commit_msg" | grep -qE '^.{1,71}$'; then
    failed_commits+=("$sha: $title")
    failed_commmits_errors+=("Incorrect length of title (Max 72 characters)")
    pass=0
  fi

  # If a 2nd line exist in commit message, confirm it is a blank line
  if ! echo "$commit_msg" | awk 'NR==2 { exit ($0 != "" ? 1 : 0) }'; then
    failed_commits+=("$sha: $title")
    failed_commmits_errors+=("Second line is not blank")
    pass=0
  fi

  # If a body exist, ensure it is wrapped in 72 characters
  body=$(echo "$commit_msg" | sed -n '3,$p')
  echo "$body"
  if [ ! -z "$body" ]; then
    echo "$body exists!"
    echo "$body" | while IFS= read -r line; do
      echo "line: $line"
      if ! [ ${#line} -lt 72 ]; then
        failed_commits+=("$sha: $title")
        failed_commmits_errors+=("Body is not wrapped at 72 characters")
        pass=0
        break;
      fi
    done
  fi
done

if [ "$pass" -eq 1 ]; then
  printf "\n=======\n  PASS!!!\n=======\n"
else
  printf "\n=======\n  FAIL!!!\n=======\n"
  printf "\nCommits with errors:\n"
  length=${#failed_commits[@]}
  for ((i=0; i<$length; i++)); do
    echo "${failed_commits[$i]}:         ${failed_commmits_errors[$i]}"
  done
  exit 1
fi