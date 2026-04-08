#!/usr/bin/env bash
set -euo pipefail

# Claude Harness Installer
# Usage: curl -fsSL https://raw.githubusercontent.com/Thoumar/claude-harness/main/install.sh | bash

REPO="Thoumar/claude-harness"
BRANCH="main"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo "  Claude Harness Installer"
echo "  ========================"
echo ""

# Check if .claude/ already exists
if [ -d ".claude" ]; then
  echo -e "${YELLOW}Warning:${NC} .claude/ already exists in this directory."
  read -p "Overwrite? (y/N) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
  fi
  rm -rf .claude
fi

# Download and extract .claude/ from the repo
echo "Downloading harness from github.com/${REPO}..."

if command -v curl >/dev/null 2>&1; then
  curl -fsSL "https://github.com/${REPO}/archive/${BRANCH}.tar.gz" \
    | tar xz --strip-components=1 "claude-harness-${BRANCH}/.claude"
elif command -v wget >/dev/null 2>&1; then
  wget -qO- "https://github.com/${REPO}/archive/${BRANCH}.tar.gz" \
    | tar xz --strip-components=1 "claude-harness-${BRANCH}/.claude"
else
  echo -e "${RED}Error:${NC} curl or wget required."
  exit 1
fi

# Copy template CLAUDE.md if none exists
if [ ! -f "CLAUDE.md" ]; then
  curl -fsSL "https://raw.githubusercontent.com/${REPO}/${BRANCH}/CLAUDE.md" -o CLAUDE.md 2>/dev/null || true
fi

echo ""
echo -e "${GREEN}Done!${NC} .claude/ installed."
echo ""
echo "  Next steps:"
echo "  1. Start Claude Code:  claude"
echo "  2. Run:                /install-harness"
echo ""
echo "  This detects your stack and generates a project-specific CLAUDE.md."
echo ""
