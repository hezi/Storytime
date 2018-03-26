#!/bin/bash
base_git=`git rev-parse --show-toplevel`

files=()
for file in `git diff --cached --name-only --diff-filter=ACMRT | grep -E "\.(m|h)$"`; do
  echo "fixing format for file: ${file}"
  clang-format ${base_git}/${file} -i
done