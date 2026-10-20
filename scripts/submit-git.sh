#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
project_dir="$repo_root/projects/git-cpp"
checkout="$HOME/.cache/systems-lab/codecrafters-git-cpp"
remote="https://git.codecrafters.io/8793339d2f17579b"

command -v codecrafters >/dev/null
command -v rsync >/dev/null
test -f "$project_dir/codecrafters.yml"

mkdir -p "$(dirname "$checkout")"

if [ ! -d "$checkout/.git" ]; then
    git clone "$remote" "$checkout"
fi

git -C "$checkout" switch master

# Replace challenge files while preserving the submission repository.
rsync -a --delete \
    --exclude='.git' \
    --exclude='.idea/' \
    --exclude='cmake-build-*/' \
    --exclude='build/' \
    "$project_dir/" "$checkout/"

cd "$checkout"
codecrafters submit
