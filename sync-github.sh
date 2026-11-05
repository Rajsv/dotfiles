#!/usr/bin/env bash
# ==============================================================================
# GitHub Sync & Repository Creation Helper
# ==============================================================================
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

echo "==> Checking GitHub authentication..."
if ! gh auth status >/dev/null 2>&1; then
    echo "You are not logged into GitHub CLI yet."
    echo "Running 'gh auth login' to authenticate with your GitHub account..."
    gh auth login -w -p https
fi

echo "==> Ensuring remote repository exists on GitHub..."
if ! gh repo view Rajsv/dotfiles >/dev/null 2>&1; then
    echo "Creating repository Rajsv/dotfiles on GitHub..."
    gh repo create dotfiles --public --source=. --remote=origin --push
    echo "✔ Repository created and initial commit pushed to GitHub!"
else
    echo "Repository exists. Pushing changes..."
    git push -u origin main
    echo "✔ Changes successfully pushed to https://github.com/Rajsv/dotfiles!"
fi
