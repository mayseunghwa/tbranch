#!/bin/bash

# Check if a CSV file is provided as an argument
if [ $# -ne 1 ]; then
  echo "Usage: $0 <csv_file>"
  exit 1
fi

csv_file="$1"

# Check if the CSV file exists
if [ ! -f "$csv_file" ]; then
  echo "Error: CSV file not found: $csv_file"
  exit 1
fi

# Read the CSV file and create branches
while IFS=, read -r branch_name; do
  # Remove leading and trailing whitespace (if any)
  branch_name=$(echo "$branch_name" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

  # Check if the branch name is empty after trimming whitespace
  if [ -z "$branch_name" ]; then
    continue
  fi

  # Create the Git branch
  git checkout part1
  git checkout -b part1-"$branch_name"
  git push origin part1-"$branch_name"
  git branch --set-upstream-to origin/part1-"$branch_name"
  git checkout part1
  echo "Created branch: $branch_name"
done < "$csv_file"

# Optionally, switch back to the original branch
# git checkout <original_branch_name>
